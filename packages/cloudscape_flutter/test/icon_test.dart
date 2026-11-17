import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {TextDirection direction = TextDirection.ltr}) =>
    CsApp(
      home: Directionality(
        textDirection: direction,
        child: Center(child: child),
      ),
    );

CsIconPainter _painter(WidgetTester tester) =>
    tester
            .widget<CustomPaint>(
              find.descendant(
                of: find.byType(CsIcon),
                matching: find.byType(CustomPaint),
              ),
            )
            .painter!
        as CsIconPainter;

void main() {
  test('every built-in icon has artwork and an enum value', () {
    expect(csBuiltInIcons.length, 148);
    expect(
      CsIconName.values.map((n) => n.id).toSet(),
      csBuiltInIcons.keys.toSet(),
    );
    for (final n in csRtlMirroredIcons) {
      expect(csBuiltInIcons, contains(n));
    }
  });

  testWidgets('sizes follow upstream metrics', (tester) async {
    final t = CsTokens.resolve();
    final expected = {
      CsIconSize.xSmall: (12.0, t.lineHeightBodyS, t.borderWidthIconXSmall),
      CsIconSize.small: (
        t.sizeIconNormal,
        t.lineHeightBodyS,
        t.borderWidthIconSmall,
      ),
      CsIconSize.normal: (
        t.sizeIconNormal,
        t.lineHeightBodyM,
        t.borderWidthIconNormal,
      ),
      CsIconSize.medium: (
        t.sizeIconMedium,
        t.lineHeightHeadingL,
        t.borderWidthIconMedium,
      ),
      CsIconSize.big: (
        t.sizeIconBig,
        t.lineHeightHeadingXl,
        t.borderWidthIconBig,
      ),
      CsIconSize.large: (
        t.sizeIconLarge,
        t.lineHeightDisplayL,
        t.borderWidthIconLarge,
      ),
    };
    for (final e in expected.entries) {
      await tester.pumpWidget(
        _app(CsIcon(name: CsIconName.settings, size: e.key)),
      );
      final box = tester.getSize(find.byType(CsIcon));
      expect(box, Size(e.value.$1, e.value.$2), reason: '${e.key}');
      expect(_painter(tester).strokeWidth, e.value.$3);
    }
  });

  test('contextual size map matches upstream iconSizeMap', () {
    expect(csContextualIconSize(null, null), CsIconSize.normal);
    expect(csContextualIconSize(50, 14), CsIconSize.large);
    expect(csContextualIconSize(36, 14), CsIconSize.big);
    expect(csContextualIconSize(24, 20), CsIconSize.medium);
    expect(csContextualIconSize(24, 18), CsIconSize.normal);
    expect(csContextualIconSize(16, 12), CsIconSize.xSmall);
    expect(csContextualIconSize(16, 14), CsIconSize.small);
    expect(csContextualIconSize(20, 14), CsIconSize.normal);
  });

  testWidgets('inherit sizes from the surrounding text', (tester) async {
    await tester.pumpWidget(
      _app(
        const DefaultTextStyle(
          style: TextStyle(fontSize: 20, height: 1.2),
          child: CsIcon(name: CsIconName.settings, size: CsIconSize.inherit),
        ),
      ),
    );
    expect(
      tester.getSize(find.byType(CsIcon)),
      Size(CsTokens.resolve().sizeIconMedium, 24),
    );
  });

  testWidgets('variants pick token colors; normal uses the text color', (
    tester,
  ) async {
    final t = CsTokens.resolve();
    await tester.pumpWidget(
      _app(const CsIcon(name: CsIconName.check, variant: CsIconVariant.error)),
    );
    expect(_painter(tester).color, t.colorTextStatusError.toColor());
    await tester.pumpWidget(
      _app(
        const DefaultTextStyle(
          style: TextStyle(color: Color(0xFF123456)),
          child: CsIcon(name: CsIconName.check),
        ),
      ),
    );
    expect(_painter(tester).color, const Color(0xFF123456));
  });

  testWidgets('gen-ai uses the dedicated glyph at small sizes', (tester) async {
    await tester.pumpWidget(
      _app(const CsIcon(name: CsIconName.genAi, size: CsIconSize.small)),
    );
    expect(_painter(tester).data, same(csGenAiSmallIcon));
    await tester.pumpWidget(_app(const CsIcon(name: CsIconName.genAi)));
    expect(_painter(tester).data, same(csBuiltInIcons['gen-ai']));
  });

  testWidgets('directional icons mirror in RTL only', (tester) async {
    Finder flip() => find.descendant(
      of: find.byType(CsIcon),
      matching: find.byType(Transform),
    );
    await tester.pumpWidget(
      _app(
        const CsIcon(name: CsIconName.angleRight),
        direction: TextDirection.rtl,
      ),
    );
    expect(flip(), findsOneWidget);
    await tester.pumpWidget(_app(const CsIcon(name: CsIconName.angleRight)));
    expect(flip(), findsNothing);
    await tester.pumpWidget(
      _app(
        const CsIcon(name: CsIconName.addPlus),
        direction: TextDirection.rtl,
      ),
    );
    expect(flip(), findsNothing);
  });

  testWidgets('badge and accessibility label', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _app(
        const CsIcon(
          name: CsIconName.notification,
          badge: true,
          ariaLabel: 'Notifications',
        ),
      ),
    );
    expect(find.bySemanticsLabel('Notifications'), findsOneWidget);
    final dot = tester.widget<Container>(
      find.descendant(
        of: find.byType(CsIcon),
        matching: find.byType(Container),
      ),
    );
    expect(
      (dot.decoration! as BoxDecoration).color,
      CsTokens.resolve().colorBackgroundBadgeIcon.toColor(),
    );
    handle.dispose();
  });

  group('CsIconProvider', () {
    testWidgets('overrides, resets and custom icons', (tester) async {
      const override = Text('X');
      const custom = Text('C');
      await tester.pumpWidget(
        _app(
          const CsIconProvider(
            icons: {'settings': override, 'my-icon': custom},
            child: Column(
              children: [
                CsIcon(name: CsIconName.settings),
                CsIcon(customName: 'my-icon'),
                CsIconProvider(
                  icons: {'settings': null, 'my-icon': null},
                  child: Row(
                    children: [
                      CsIcon(name: CsIconName.settings),
                      CsIcon(customName: 'my-icon'),
                    ],
                  ),
                ),
                CsIconProvider(
                  resetIcons: true,
                  child: CsIcon(customName: 'my-icon'),
                ),
              ],
            ),
          ),
        ),
      );
      // Outer: override + custom. Inner: settings back to built-in, custom kept. Reset: custom gone.
      expect(find.text('X'), findsOneWidget);
      expect(find.text('C'), findsNWidgets(2));
    });

    testWidgets('component icons merge per icon and can be removed', (
      tester,
    ) async {
      late CsComponentIcons inner;
      late CsComponentIcons removed;
      Widget toggle(bool e) => const SizedBox();
      Widget sort(CsSortingState s) => const SizedBox();
      await tester.pumpWidget(
        _app(
          CsIconProvider(
            componentIcons: CsComponentIcons(
              table: CsTableIcons(expandToggle: toggle),
            ),
            child: CsIconProvider(
              componentIcons: CsComponentIcons(
                table: CsTableIcons(sortingIndicator: sort),
              ),
              child: Column(
                children: [
                  Builder(
                    builder: (c) => (
                      inner = CsIconProvider.componentIconsOf(c),
                      const SizedBox(),
                    ).$2,
                  ),
                  CsIconProvider(
                    componentIcons: const CsComponentIcons(
                      remove: {CsIconComponent.table},
                    ),
                    child: Builder(
                      builder: (c) => (
                        removed = CsIconProvider.componentIconsOf(c),
                        const SizedBox(),
                      ).$2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      expect(inner.table!.expandToggle, same(toggle));
      expect(inner.table!.sortingIndicator, same(sort));
      expect(removed.table, isNull);
    });
  });

  test('dashes use pathLength units (mini-player screen line shows 75%)', () {
    final line = Path()
      ..moveTo(0, 0)
      ..lineTo(8, 0);
    final dashed = csIconDashPath(line, const [1], .25, 1);
    final length = dashed.computeMetrics().fold<double>(
      0,
      (a, m) => a + m.length,
    );
    expect(length, closeTo(6, 1e-6));
  });

  testWidgets('all icons render (golden)', (tester) async {
    tester.view.physicalSize = const Size(16 * 40 * 2, 10 * 40 * 2);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      CsApp(
        theme: const CsThemeData(colorMode: CsColorMode.light),
        home: RepaintBoundary(
          child: Wrap(
            children: [
              for (final n in CsIconName.values)
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: CsIcon(name: n, size: CsIconSize.medium),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    await expectLater(
      find.byType(Wrap),
      matchesGoldenFile('goldens/all_icons_medium.png'),
    );
  });
}
