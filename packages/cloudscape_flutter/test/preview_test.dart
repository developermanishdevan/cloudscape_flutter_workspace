import 'dart:io';

import 'package:cloudscape_flutter/preview.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every @CsPreview function is registered (and nothing else)', () {
    final annotated = <String>{};
    for (final f in Directory(
      'lib',
    ).listSync(recursive: true).whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      final src = f.readAsStringSync();
      for (final m in RegExp(
        r'@CsPreview\((?:[^()]|\([^()]*\))*\)\s*Widget\s+(\w+)\(',
      ).allMatches(src)) {
        annotated.add(m[1]!);
      }
    }
    expect(annotated, isNotEmpty);
    final registered = Directory('lib/src/preview')
        .listSync()
        .whereType<File>()
        .map((f) => f.readAsStringSync())
        .expand(
          (s) => RegExp(r'build:\s*(\w+)').allMatches(s).map((m) => m[1]!),
        )
        .toSet();
    expect(registered, annotated);
    expect(csPreviewRegistry.length, annotated.length);
  });

  for (final entry in csPreviewRegistry) {
    for (final variant in CsPreviewVariant.values) {
      testWidgets('${entry.group} / ${entry.name} · ${variant.name} renders', (
        tester,
      ) async {
        tester.view.physicalSize = const Size(1000, 800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        await tester.pumpWidget(variant.wrapper(entry.build()));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    }
  }
}
