import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Captures the resolved theme and default text style at a point in the tree.
class _Probe extends StatelessWidget {
  const _Probe(this.onBuild);

  final void Function(CsResolvedTheme theme, TextStyle style) onBuild;

  @override
  Widget build(BuildContext context) {
    onBuild(CsTheme.of(context), DefaultTextStyle.of(context).style);
    return const SizedBox();
  }
}

void main() {
  group('CsApp', () {
    testWidgets('applies the component text reset and layout background', (
      tester,
    ) async {
      late CsResolvedTheme theme;
      late TextStyle style;
      await tester.pumpWidget(
        CsApp(
          home: _Probe((t, s) {
            theme = t;
            style = s;
          }),
        ),
      );
      final tokens = theme.tokens;
      expect(style.fontFamily, 'packages/cloudscape_flutter/Open Sans');
      expect(style.fontFamilyFallback, [
        'Open Sans', // the root-package registration (tests, previews)
        'Helvetica Neue',
        'Roboto',
        'Arial',
        'sans-serif',
      ]);
      expect(style.fontSize, tokens.fontSizeBodyM);
      expect(
        style.height! * style.fontSize!,
        closeTo(tokens.lineHeightBodyM, 1e-9),
      );
      expect(style.color, tokens.colorTextBodyDefault.toColor());
      expect(style.fontWeight, FontWeight.w400);
      final box = tester.widget<ColoredBox>(find.byType(ColoredBox).first);
      expect(box.color, tokens.colorBackgroundLayoutMain.toColor());
    });

    testWidgets('follows platform brightness and reduced motion by default', (
      tester,
    ) async {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(tester.platformDispatcher.clearAllTestValues);
      late CsResolvedTheme theme;
      await tester.pumpWidget(CsApp(home: _Probe((t, _) => theme = t)));
      expect(theme.colorMode, CsColorMode.dark);
      expect(theme.motion, CsMotionMode.disabled);
      expect(theme.tokens.motionDurationExtraFast, Duration.zero);
    });

    testWidgets('explicit settings win over the platform', (tester) async {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      addTearDown(tester.platformDispatcher.clearAllTestValues);
      late CsResolvedTheme theme;
      await tester.pumpWidget(
        CsApp(
          theme: const CsThemeData(
            colorMode: CsColorMode.light,
            density: CsDensity.compact,
          ),
          home: _Probe((t, _) => theme = t),
        ),
      );
      expect(theme.colorMode, CsColorMode.light);
      expect(
        theme.tokens.spaceScaledXs,
        CsTokens.resolve(density: CsDensity.compact).spaceScaledXs,
      );
    });

    testWidgets('a theme override reaches the text reset', (tester) async {
      late TextStyle style;
      await tester.pumpWidget(
        CsApp(
          theme: const CsThemeData(
            themeOverride: CsThemeOverride(
              tokens: {'colorTextBodyDefault': '#010203'},
            ),
          ),
          home: _Probe((_, s) => style = s),
        ),
      );
      expect(style.color, const Color(0xFF010203));
    });
  });

  group('nesting', () {
    testWidgets('nested CsTheme inherits unspecified settings', (tester) async {
      late CsResolvedTheme inner;
      await tester.pumpWidget(
        CsApp(
          theme: const CsThemeData(colorMode: CsColorMode.dark),
          home: CsTheme(
            data: const CsThemeData(density: CsDensity.compact),
            child: _Probe((t, _) => inner = t),
          ),
        ),
      );
      expect(inner.colorMode, CsColorMode.dark);
      expect(inner.density, CsDensity.compact);
    });

    testWidgets(
      'CsVisualContext applies context tokens; alert in header adds alert-header',
      (tester) async {
        late CsResolvedTheme nav;
        late CsResolvedTheme alertInHeader;
        await tester.pumpWidget(
          CsApp(
            home: Column(
              children: [
                CsVisualContext(
                  id: CsVisualContextId.topNavigation,
                  child: _Probe((t, _) => nav = t),
                ),
                CsVisualContext(
                  id: CsVisualContextId.header,
                  child: CsVisualContext(
                    id: CsVisualContextId.alert,
                    child: _Probe((t, _) => alertInHeader = t),
                  ),
                ),
              ],
            ),
          ),
        );
        expect(
          nav.tokens.colorBackgroundContainerContent,
          CsTokens.resolve()
              .inContext(CsVisualContextId.topNavigation)
              .colorBackgroundContainerContent,
        );
        expect(alertInHeader.contexts, [
          CsVisualContextId.header,
          CsVisualContextId.alert,
        ]);
        final expected = CsThemeResolver().resolve(
          contexts: [
            CsVisualContextId.header,
            CsVisualContextId.alert,
            CsVisualContextId.alertHeader,
          ],
        );
        for (final name
            in csVisualContexts[CsVisualContextId.alertHeader]!.tokenNames) {
          expect(alertInHeader.tokens[name], expected[name], reason: name);
        }
      },
    );
  });

  testWidgets('dark-mode utilities', (tester) async {
    Widget app(CsColorMode mode) => CsApp(
      theme: CsThemeData(colorMode: mode),
      home: const Column(
        children: [
          CsShowInDarkMode(child: Text('dark only')),
          CsHideInDarkMode(child: Text('light only')),
        ],
      ),
    );
    await tester.pumpWidget(app(CsColorMode.dark));
    expect(find.text('dark only'), findsOneWidget);
    expect(find.text('light only'), findsNothing);
    await tester.pumpWidget(app(CsColorMode.light));
    expect(find.text('dark only'), findsNothing);
    expect(find.text('light only'), findsOneWidget);
  });

  group('conversions', () {
    test('shadows use CSS blur (sigma = blur / 2)', () {
      final shadows = const [
        CsShadow(
          offsetX: 0,
          offsetY: 4,
          blur: 20,
          spread: 1,
          color: CsColor(0x1A000716),
        ),
      ].toBoxShadows();
      expect(shadows.single.blurSigma, 10);
      expect(shadows.single.offset, const Offset(0, 4));
      expect(shadows.single.spreadRadius, 1);
    });

    test('gradients build shaders with CSS stop positions', () {
      final linear = CsTokens.resolve().colorBackgroundLoadingBarGenAi
          .toGradient()!;
      expect(linear.stops!.first, 0);
      expect(linear.stops!.last, 1);
      expect(
        () => linear.createShader(const Rect.fromLTWH(0, 0, 200, 4)),
        returnsNormally,
      );
      final radial = CsTokens.resolve().colorBackgroundAvatarGenAi
          .toGradient()!;
      expect(
        () => radial.createShader(const Rect.fromLTWH(0, 0, 28, 28)),
        returnsNormally,
      );
      const missing = CsLinearGradient(
        angleDegrees: 90,
        stops: [
          CsGradientStop(CsColor(0xFF000000)),
          CsGradientStop(CsColor(0xFF000000)),
          CsGradientStop(CsColor(0xFF000000), 0.8),
          CsGradientStop(CsColor(0xFF000000)),
        ],
      );
      expect(missing.toGradient()!.stops, [0, 0.4, 0.8, 1]);
    });

    test('lengths, weights and curves', () {
      expect(const CsEm(-0.02).resolve(fontSize: 20), closeTo(-0.4, 1e-12));
      expect(const CsPercent(0.5).resolve(reference: 40), 20);
      expect(CsLengthKeyword.normal.resolve(), isNull);
      expect(const CsFontWeight(700).toFontWeight(), FontWeight.w700);
      expect(CsFontWeight.inherit.toFontWeight(), isNull);
      final curve = const CsCubicBezier(0.1, 0.2, 0.58, 1).toCurve();
      expect([curve.a, curve.b, curve.c, curve.d], [0.1, 0.2, 0.58, 1]);
    });
  });

  group('typography and spacing', () {
    test('type scale comes from tokens', () {
      final t = CsTokens.resolve();
      final type = CsTypography(t);
      expect(type.headingXl.fontSize, t.fontSizeHeadingXl);
      expect(
        type.headingXl.height! * t.fontSizeHeadingXl,
        closeTo(t.lineHeightHeadingXl, 1e-9),
      );
      expect(type.headingXl.fontWeight, FontWeight.w700);
      expect(type.headingXs.letterSpacing, isNull); // letter-spacing: normal
      expect(type.monospace(type.bodyM).fontFamily, 'Monaco');
    });

    test('scaled spacing shrinks in compact mode, static does not', () {
      final comfortable = CsTokens.resolve();
      final compact = CsTokens.resolve(density: CsDensity.compact);
      expect(
        CsSpacing.xs.scaled(compact),
        lessThan(CsSpacing.xs.scaled(comfortable)),
      );
      expect(CsSpacing.xs.static(compact), CsSpacing.xs.static(comfortable));
      for (final s in CsSpacing.values) {
        expect(s.of(comfortable), greaterThanOrEqualTo(0));
      }
    });
  });
}
