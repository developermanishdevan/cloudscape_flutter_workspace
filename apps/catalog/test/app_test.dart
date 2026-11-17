import 'dart:io';

import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cloudscape_flutter/preview.dart';
import 'package:cs_catalog/main.dart';
import 'package:cs_catalog/src/generated/catalog_data.g.dart';
import 'package:cs_catalog/src/pages.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pumpCatalog(
  WidgetTester tester,
  Widget app, {
  Size size = const Size(1400, 1000),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
  await tester.pumpAndSettle();
}

/// Loads the bundled Open Sans faces so previews are measured with the real
/// font (as in the golden matrix), not the test font: previews declare sizes
/// that fit Open Sans.
Future<void> _loadFonts() async {
  final dir = Directory(
    '../../packages/cloudscape_flutter/assets/fonts/open_sans',
  );
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(_loadFonts);

  test('every preview group has a catalog page with every preview', () {
    final groups = csPreviewRegistry.map((p) => p.group).toSet();
    expect(catalogEntries.map((e) => e.name).toSet(), containsAll(groups));
    for (final e in catalogEntries) {
      final registered = previewsOf(e);
      expect(registered, isNotEmpty, reason: '${e.name} has no previews');
      expect(
        registered.map((p) => p.$2),
        everyElement(isNotNull),
        reason: '${e.name}: a registered preview has no @CsPreview',
      );
      expect(e.classes, isNotEmpty, reason: '${e.name} has no API');
    }
    expect(
      catalogEntries.fold(0, (n, e) => n + previewsOf(e).length),
      csPreviewRegistry.length,
    );
  });

  test('guideline links point at cloudscape.design', () {
    for (final e in catalogEntries.where((e) => e.planNumber != null)) {
      expect(
        e.guidelineUrl.toString(),
        matches(r'^https://cloudscape\.design/components/[a-z-]+/$'),
        reason: e.name,
      );
    }
  });

  testWidgets('app shell renders the overview without Material', (
    tester,
  ) async {
    await _pumpCatalog(tester, const App());
    expect(find.text('Cloudscape Catalog'), findsOneWidget);
    expect(find.text('Cloudscape for Flutter'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  // Every page × light/dark × comfortable/compact × LTR/RTL.
  for (final entry in catalogEntries) {
    for (final mode in CsColorMode.values) {
      for (final density in CsDensity.values) {
        for (final dir in TextDirection.values) {
          testWidgets(
            '${entry.name} page renders · ${mode.name} ${density.name} '
            '${dir.name}',
            (tester) async {
              await _pumpCatalog(
                tester,
                CatalogApp(
                  initialPage: entry.id,
                  colorMode: mode,
                  density: density,
                  direction: dir,
                ),
              );
              expect(tester.takeException(), isNull);
              expect(find.text('Examples'), findsOneWidget);
              expect(find.text('API'), findsOneWidget);
              for (final (preview, _) in previewsOf(entry)) {
                expect(
                  find.byKey(
                    ValueKey('preview:${preview.group}/${preview.name}'),
                  ),
                  findsOneWidget,
                );
              }
              for (final c in entry.classes) {
                expect(find.text(c.name), findsWidgets);
              }
            },
          );
        }
      }
    }
  }

  testWidgets('navigation opens pages and the overview links work', (
    tester,
  ) async {
    await _pumpCatalog(tester, const CatalogApp());
    await tester.tap(find.text('Space between').first);
    await tester.pumpAndSettle();
    expect(find.text('Examples'), findsOneWidget);
    expect(find.text('CsSpaceBetween'), findsWidgets);
    await tester.tap(find.text('Overview'));
    await tester.pumpAndSettle();
    expect(find.text('Cloudscape for Flutter'), findsOneWidget);
  });

  testWidgets('global toggles switch mode, density and direction', (
    tester,
  ) async {
    await _pumpCatalog(
      tester,
      const CatalogApp(initialPage: 'box', colorMode: CsColorMode.light),
    );
    CsThemeData theme() => tester.widget<CsApp>(find.byType(CsApp)).theme;
    TextDirection dirOf(Finder f) => tester
        .widget<Directionality>(
          find.ancestor(of: f, matching: find.byType(Directionality)).first,
        )
        .textDirection;
    final preview = find.byKey(const ValueKey('preview:Box/Variants'));
    TextDirection dir() => dirOf(preview);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();
    expect(theme().colorMode, CsColorMode.dark);

    await tester.tap(find.text('Compact'));
    await tester.pumpAndSettle();
    expect(theme().density, CsDensity.compact);

    expect(dir(), TextDirection.ltr);
    await tester.tap(find.text('RTL'));
    await tester.pumpAndSettle();
    expect(dir(), TextDirection.rtl);
    // The shell and docs stay LTR.
    expect(dirOf(find.text('Examples')), TextDirection.ltr);
    expect(tester.takeException(), isNull);
  });

  testWidgets('guideline link opens the Cloudscape page', (tester) async {
    final opened = <Uri>[];
    await _pumpCatalog(
      tester,
      CatalogApp(initialPage: 'navigable-group', onOpenUrl: opened.add),
    );
    await tester.tap(find.text('Cloudscape guideline'));
    expect(opened, [
      Uri.parse('https://cloudscape.design/components/navigable-group/'),
    ]);
  });

  testWidgets('internal primitives have no guideline link', (tester) async {
    await _pumpCatalog(tester, const CatalogApp(initialPage: 'pressable'));
    expect(find.text('Cloudscape guideline'), findsNothing);
  });

  testWidgets('narrow widths collapse the navigation behind a menu', (
    tester,
  ) async {
    await _pumpCatalog(
      tester,
      const CatalogApp(initialPage: 'icon'),
      size: const Size(390, 844),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('Overview'), findsNothing);
    await tester.tap(find.bySemanticsLabel('Open navigation'));
    await tester.pumpAndSettle();
    expect(find.text('Overview'), findsOneWidget);
    await tester.tap(find.text('Dropdown'));
    await tester.pumpAndSettle();
    expect(find.text('Overview'), findsNothing);
    expect(find.text('CsDropdown'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
