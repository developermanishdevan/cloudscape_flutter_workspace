// Generates apps/catalog/lib/src/generated/catalog_data.g.dart.
//
//   dart run catalog_gen:generate          write the file
//   dart run catalog_gen:generate --check  fail if it is out of date
import 'dart:io';

import 'package:catalog_gen/catalog_gen.dart';

Future<void> main(List<String> args) async {
  final root = findWorkspaceRoot();
  final pages = buildPages(root);
  final source = emit(pages);
  final target = File('${root.path}/$outputFile');
  if (!args.contains('--check')) {
    await writeFormatted(target, source);
    final classes = pages.fold(0, (n, p) => n + p.classes.length);
    final previews = pages.fold(0, (n, p) => n + p.previews.length);
    stdout.writeln(
      'Generated ${pages.length} catalog pages '
      '($classes API classes, $previews previews).',
    );
    return;
  }
  final tmp = Directory.systemTemp.createTempSync('catalog_gen_check');
  try {
    final f = File('${tmp.path}/catalog_data.g.dart');
    await writeFormatted(f, source);
    if (!target.existsSync() ||
        target.readAsStringSync() != f.readAsStringSync()) {
      stderr.writeln(
        'Generated catalog data is stale. '
        'Run: dart run melos run catalog:generate',
      );
      exitCode = 1;
    } else {
      stdout.writeln('Generated catalog data is up to date.');
    }
  } finally {
    tmp.deleteSync(recursive: true);
  }
}
