// Generates cloudscape_flutter i18n messages (Dart libraries + ARB files).
//
//   dart run i18n_gen:generate          write the files
//   dart run i18n_gen:generate --check  fail if they are out of date
import 'dart:convert';
import 'dart:io';

import 'package:i18n_gen/i18n_gen.dart';

Future<void> main(List<String> args) async {
  final root = findWorkspaceRoot();
  final lock = jsonDecode(
    File('${root.path}/$lockFile').readAsStringSync(),
  ) as Map<String, Object?>;
  final version = (lock['components']! as Map)['version']! as String;
  final bundles = loadBundles(root);
  final cldrVersion = (lock['cldr']! as Map)['version']! as String;
  final files = emitAll(
    bundles,
    version,
    cardinal: loadPluralRules(root, ordinal: false),
    ordinal: loadPluralRules(root, ordinal: true),
    cldrVersion: cldrVersion,
    cldrData: emitCldrData(
      root,
      ((lock['cldr']! as Map)['dateLocales']! as Map).cast<String, String>(),
      cldrVersion,
    ),
  );
  final managed = [messagesLibDir, arbDir, dateLibDir];

  if (!args.contains('--check')) {
    for (final d in managed) {
      final dir = Directory('${root.path}/$d');
      if (dir.existsSync()) {
        for (final f in dir.listSync().whereType<File>()) {
          if (!files.containsKey('$d/${f.uri.pathSegments.last}')) {
            f.deleteSync();
          }
        }
      }
    }
    await writeAll(root, files);
    final count = bundles.fold<int>(
      0,
      (n, b) => n + b.components.values.fold(0, (m, c) => m + c.length),
    );
    stdout.writeln(
      'Generated ${bundles.length} locales ($count messages): Dart libraries + ARB files.',
    );
    return;
  }

  final tmp = Directory.systemTemp.createTempSync('i18n_gen_check');
  try {
    await writeAll(tmp, files);
    final problems = <String>[];
    for (final path in files.keys) {
      final want = File('${tmp.path}/$path').readAsStringSync();
      final have = File('${root.path}/$path');
      if (!have.existsSync()) {
        problems.add('missing $path');
      } else if (have.readAsStringSync() != want) {
        problems.add('out of date $path');
      }
    }
    for (final d in managed) {
      final dir = Directory('${root.path}/$d');
      if (!dir.existsSync()) continue;
      for (final f in dir.listSync().whereType<File>()) {
        final rel = '$d/${f.uri.pathSegments.last}';
        if (!files.containsKey(rel)) problems.add('extra $rel');
      }
    }
    if (problems.isEmpty) {
      stdout.writeln('Generated i18n messages are up to date.');
    } else {
      stderr
        ..writeln(
          'Generated i18n messages are stale. Run: dart run melos run i18n:generate',
        )
        ..writeAll(problems.map((p) => '  $p\n'));
      exitCode = 1;
    }
  } finally {
    tmp.deleteSync(recursive: true);
  }
}
