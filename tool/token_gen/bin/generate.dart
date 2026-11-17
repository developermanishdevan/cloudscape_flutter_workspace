// Generates packages/cloudscape_tokens/lib/src/generated from the vendored
// upstream preset.
//
//   dart run token_gen:generate          write the generated files
//   dart run token_gen:generate --check  fail if they are out of date
import 'dart:io';

import 'package:token_gen/token_gen.dart';

Future<void> main(List<String> args) async {
  final check = args.contains('--check');
  final root = findWorkspaceRoot();
  final upstream = loadUpstream(root);
  final out = Directory('${root.path}/$outputDir');

  if (!check) {
    final stale = out.existsSync()
        ? out
              .listSync()
              .whereType<File>()
              .where((f) => f.path.endsWith('.g.dart'))
              .toList()
        : <File>[];
    final written = await writeGenerated(upstream, out);
    final writtenPaths = written.map((f) => f.path).toSet();
    for (final f in stale) {
      if (!writtenPaths.contains(f.path)) f.deleteSync();
    }
    final t = upstream.theme;
    stdout.writeln(
      'Generated ${written.length} files: ${t.tokens.length} tokens, '
      '${t.contexts.length} visual contexts (${upstream.provenance.package} '
      '${upstream.provenance.version}, theme ${t.id}).',
    );
    return;
  }

  final tmp = Directory.systemTemp.createTempSync('token_gen_check');
  try {
    final written = await writeGenerated(upstream, tmp);
    final problems = <String>[];
    final expected = <String>{};
    for (final f in written) {
      final name = f.uri.pathSegments.last;
      expected.add(name);
      final current = File('${out.path}/$name');
      if (!current.existsSync()) {
        problems.add('missing $name');
      } else if (current.readAsStringSync() != f.readAsStringSync()) {
        problems.add('out of date $name');
      }
    }
    if (out.existsSync()) {
      for (final f in out.listSync().whereType<File>()) {
        final name = f.uri.pathSegments.last;
        if (name.endsWith('.g.dart') && !expected.contains(name)) {
          problems.add('extra $name');
        }
      }
    }
    if (problems.isEmpty) {
      stdout.writeln('Generated tokens are up to date.');
    } else {
      stderr
        ..writeln(
          'Generated tokens are stale. Run: dart run melos run tokens:generate',
        )
        ..writeAll(problems.map((p) => '  $p\n'));
      exitCode = 1;
    }
  } finally {
    tmp.deleteSync(recursive: true);
  }
}
