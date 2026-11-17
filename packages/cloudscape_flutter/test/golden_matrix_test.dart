// Golden matrix (plan: "every state × light/dark × comfortable/compact ×
// LTR/RTL"): every registered preview, rendered with the real Open Sans
// faces at its declared preview size, in all 8 mode combinations.
//
// Update:  fvm flutter test test/golden_matrix_test.dart --update-goldens
// Goldens are generated on macOS; other platforms rasterize text slightly
// differently, so the comparison allows a small pixel difference and the
// suite only runs on macOS.
@TestOn('mac-os')
library;

import 'dart:io';

import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cloudscape_flutter/preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Allowed fraction of differing pixels.
const double _tolerance = 0.002;

const Size _defaultSize = Size(480, 360);

/// Preview function name → declared `size:` of its `@CsPreview`.
Map<String, Size> _declaredSizes() {
  final out = <String, Size>{};
  for (final f in Directory(
    'lib',
  ).listSync(recursive: true).whereType<File>()) {
    if (!f.path.endsWith('.dart')) continue;
    final src = f.readAsStringSync();
    for (final m in RegExp(
      r'@CsPreview\(((?:[^()]|\([^()]*\))*)\)\s*Widget\s+(\w+)\(',
    ).allMatches(src)) {
      final size = RegExp(r'size:\s*Size\(\s*([\d.]+)\s*,\s*([\d.]+)\s*\)')
          .firstMatch(m[1]!);
      if (size != null) {
        out[m[2]!] = Size(double.parse(size[1]!), double.parse(size[2]!));
      }
    }
  }
  return out;
}

/// Function names of the registry entries, in order (from the registry
/// source, since the record only holds the closure).
List<String> _registryFunctions() => [
  for (final m in RegExp(r'build:\s*(\w+)').allMatches(
    File('lib/src/preview/preview_registry.dart').readAsStringSync(),
  ))
    m[1]!,
];

String _slug(String s) => s
    .toLowerCase()
    .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
    .replaceAll(RegExp(r'^_|_$'), '');

Future<void> _loadFonts() async {
  final dir = Directory('assets/fonts/open_sans');
  for (final family in ['packages/cloudscape_flutter/Open Sans', 'Open Sans']) {
    final loader = FontLoader(family);
    for (final f in dir.listSync().whereType<File>()) {
      if (f.path.endsWith('.ttf')) {
        loader.addFont(Future.value(ByteData.sublistView(f.readAsBytesSync())));
      }
    }
    await loader.load();
  }
}

class _TolerantComparator extends LocalFileComparator {
  _TolerantComparator(super.testFile);

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );
    if (result.passed || result.diffPercent <= _tolerance) {
      result.dispose();
      return true;
    }
    final error = await generateFailureOutput(result, golden, basedir);
    result.dispose();
    throw FlutterError(error);
  }
}

typedef _Variant = ({
  String name,
  CsColorMode mode,
  CsDensity density,
  TextDirection direction,
});

final List<_Variant> _variants = [
  for (final mode in CsColorMode.values)
    for (final density in CsDensity.values)
      for (final direction in TextDirection.values)
        (
          name: '${mode.name}_${density.name}_${direction.name}',
          mode: mode,
          density: density,
          direction: direction,
        ),
];

void main() {
  final sizes = _declaredSizes();
  final functions = _registryFunctions();

  setUpAll(() async {
    await _loadFonts();
    goldenFileComparator = _TolerantComparator(
      Uri.parse('test/golden_matrix_test.dart'),
    );
  });

  test('registry and sources agree', () {
    expect(functions.length, csPreviewRegistry.length);
  });

  for (var i = 0; i < csPreviewRegistry.length; i++) {
    final entry = csPreviewRegistry[i];
    final size = sizes[functions[i]] ?? _defaultSize;
    group('${entry.group} / ${entry.name}', () {
      for (final v in _variants) {
        testWidgets(v.name, (tester) async {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.reset);
          await tester.pumpWidget(
            RepaintBoundary(
              child: CsPreviewFrame(
                colorMode: v.mode,
                density: v.density,
                direction: v.direction,
                child: entry.build(),
              ),
            ),
          );
          await tester.pumpAndSettle();
          await expectLater(
            find.byType(RepaintBoundary).first,
            matchesGoldenFile(
              'goldens/matrix/${_slug(entry.group)}/'
              '${_slug(entry.name)}__${v.name}.png',
            ),
          );
        });
      }
    });
  }
}
