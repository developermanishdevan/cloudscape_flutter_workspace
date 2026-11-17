// Fails when any workspace package depends on Material or Cupertino.
//
// Cloudscape for Flutter is built on `package:flutter/widgets.dart` only.
// Since Flutter 3.50 Material and Cupertino also ship as the separate
// `material_ui` and `cupertino_ui` packages, so both forms are banned.
//
// Usage: dart run tool/check_no_material.dart
import 'dart:io';

final _bannedImports = RegExp(
  r'''^\s*(import|export)\s+['"]package:('''
  r'''flutter/material\.dart|flutter/cupertino\.dart|'''
  r'''material_ui/|cupertino_ui/)''',
  multiLine: true,
);

final _bannedPubspec = RegExp(
  r'^\s*(material_ui|cupertino_ui|cupertino_icons)\s*:|uses-material-design:\s*true',
  multiLine: true,
);

const _roots = ['packages', 'apps', 'tool'];
const _skipDirs = {'build', '.dart_tool', 'ephemeral', '.symlinks'};

void main() {
  final violations = <String>[];

  for (final root in _roots) {
    final dir = Directory(root);
    if (!dir.existsSync()) continue;
    for (final entity in dir.listSync(recursive: true, followLinks: false)) {
      if (entity is! File) continue;
      if (entity.uri.pathSegments.any(_skipDirs.contains)) continue;
      final path = entity.path;
      if (path.endsWith('.dart') && !path.endsWith('check_no_material.dart')) {
        _scan(entity, _bannedImports, violations);
      } else if (path.endsWith('pubspec.yaml')) {
        _scan(entity, _bannedPubspec, violations);
      }
    }
  }

  if (violations.isEmpty) {
    stdout.writeln('No Material or Cupertino usage found.');
    return;
  }
  stderr
    ..writeln('Material/Cupertino usage is not allowed:')
    ..writeAll(violations.map((v) => '  $v\n'));
  exitCode = 1;
}

void _scan(File file, RegExp pattern, List<String> violations) {
  final lines = file.readAsLinesSync();
  for (var i = 0; i < lines.length; i++) {
    if (pattern.hasMatch(lines[i])) {
      violations.add('${file.path}:${i + 1}: ${lines[i].trim()}');
    }
  }
}
