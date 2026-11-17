// Generates packages/cloudscape_flutter/lib/src/icon/generated/icons.g.dart.
//
//   dart run icon_gen:generate          write the file
//   dart run icon_gen:generate --check  fail if it is out of date
import 'dart:convert';
import 'dart:io';

import 'package:icon_gen/icon_gen.dart';

Future<void> main(List<String> args) async {
  final root = findWorkspaceRoot();
  final lock = jsonDecode(
    File('${root.path}/$lockFile').readAsStringSync(),
  ) as Map<String, Object?>;
  final version = (lock['components']! as Map)['version']! as String;
  final set = loadIconSet(root);
  final source = emit(set, version);
  final target = File('${root.path}/$outputFile');
  if (!args.contains('--check')) {
    await writeFormatted(target, source);
    stdout.writeln(
      'Generated ${set.icons.length} icons (+ gen-ai small, ${set.rtlMirrored.length} RTL-mirrored).',
    );
    return;
  }
  final tmp = Directory.systemTemp.createTempSync('icon_gen_check');
  try {
    final f = File('${tmp.path}/icons.g.dart');
    await writeFormatted(f, source);
    if (!target.existsSync() ||
        target.readAsStringSync() != f.readAsStringSync()) {
      stderr.writeln(
        'Generated icons are stale. Run: dart run melos run icons:generate',
      );
      exitCode = 1;
    } else {
      stdout.writeln('Generated icons are up to date.');
    }
  } finally {
    tmp.deleteSync(recursive: true);
  }
}
