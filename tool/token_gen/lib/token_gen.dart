/// Cloudscape token generator: upstream preset → cloudscape_tokens sources.
library;

import 'dart:convert';
import 'dart:io';

import 'package:token_gen/src/emit.dart';
import 'package:token_gen/src/model.dart';

export 'package:token_gen/src/emit.dart' show Provenance, emitAll, literal;
export 'package:token_gen/src/model.dart';
export 'package:cloudscape_tokens/css.dart';

/// Finds the workspace root (the pubspec.yaml with a `workspace:` key).
Directory findWorkspaceRoot([Directory? from]) {
  var dir = (from ?? Directory.current).absolute;
  while (true) {
    final pubspec = File('${dir.path}/pubspec.yaml');
    if (pubspec.existsSync() &&
        RegExp(
          r'^workspace:',
          multiLine: true,
        ).hasMatch(pubspec.readAsStringSync())) {
      return dir;
    }
    final parent = dir.parent;
    if (parent.path == dir.path) {
      throw StateError(
        'No workspace pubspec.yaml above ${Directory.current.path}',
      );
    }
    dir = parent;
  }
}

/// Paths of the vendored upstream inputs, relative to the workspace root.
const upstreamDir = 'tool/upstream';
const lockFile = '$upstreamDir/upstream.json';
const presetFile = '$upstreamDir/visual-refresh.preset.json';
const designTokensFile = '$upstreamDir/design-tokens.visual-refresh.json';
const outputDir = 'packages/cloudscape_tokens/lib/src/generated';
const iconsFile = '$upstreamDir/icons/icons.js';
const iconStylesFile = '$upstreamDir/icons/styles.scoped.css';
const iconInternalFile = '$upstreamDir/icons/internal.js';
const i18nDir = '$upstreamDir/i18n';
const cldrPluralsFile = '$upstreamDir/cldr/plurals.json';
const cldrOrdinalsFile = '$upstreamDir/cldr/ordinals.json';

/// The vendored upstream inputs, resolved and ready to emit.
class Upstream {
  Upstream(this.theme, this.provenance);

  final ResolvedTheme theme;
  final Provenance provenance;
}

/// Loads and resolves the vendored upstream inputs under [root].
Upstream loadUpstream(Directory root) {
  Map<String, Object?> readJson(String path) =>
      (jsonDecode(File('${root.path}/$path').readAsStringSync()) as Map)
          .cast<String, Object?>();
  final lock = readJson(lockFile);
  final components = (lock['components']! as Map).cast<String, Object?>();
  final designTokens = (lock['designTokens']! as Map).cast<String, Object?>();
  final dt = readJson(designTokensFile);
  final descriptions = <String, String>{
    for (final e in (dt['tokens']! as Map).entries)
      if ((e.value as Map)[r'$description'] case final String d)
        e.key as String: d,
  };
  final theme = resolvePreset(readJson(presetFile), descriptions: descriptions);
  return Upstream(
    theme,
    Provenance(
      package: components['package']! as String,
      version: components['version']! as String,
      designTokensVersion: designTokens['version']! as String,
    ),
  );
}

/// Generates and formats all files into [dir]. Returns the written paths.
Future<List<File>> writeGenerated(Upstream upstream, Directory dir) async {
  final files = emitAll(upstream.theme, upstream.provenance);
  dir.createSync(recursive: true);
  final written = <File>[];
  for (final e in files.entries) {
    final f = File('${dir.path}/${e.key}')..writeAsStringSync(e.value);
    written.add(f);
  }
  final result = await Process.run(Platform.resolvedExecutable, [
    'format',
    ...written.map((f) => f.path),
  ]);
  if (result.exitCode != 0) {
    throw StateError('dart format failed:\n${result.stdout}\n${result.stderr}');
  }
  return written;
}
