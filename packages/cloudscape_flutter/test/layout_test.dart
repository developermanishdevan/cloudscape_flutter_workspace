import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(
  Widget child, {
  CsDensity density = CsDensity.comfortable,
  TextDirection dir = TextDirection.ltr,
}) => CsApp(
  theme: CsThemeData(density: density, colorMode: CsColorMode.light),
  home: Directionality(
    textDirection: dir,
    child: Align(
      alignment: Alignment.topLeft,
      child: SizedBox(width: 300, child: child),
    ),
  ),
);

Widget _block(double w, double h, [String? label]) =>
    SizedBox(width: w, height: h, child: label == null ? null : Text(label));

void main() {
  final t = CsTokens.resolve();

  group('CsFlex', () {
    testWidgets('column: block width, stretch, gaps, alignment', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          CsFlex(
            direction: Axis.vertical,
            mainGap: 10,
            children: [
              const SizedBox(height: 20, key: ValueKey('a')),
              _block(50, 30),
            ],
          ),
        ),
      );
      expect(tester.getSize(find.byType(CsFlex)), const Size(300, 60));
      expect(
        tester.getSize(find.byKey(const ValueKey('a'))).width,
        300,
      ); // stretched
      await tester.pumpWidget(
        _app(
          CsFlex(
            direction: Axis.vertical,
            alignItems: CsFlexAlign.end,
            children: [_block(50, 30, 'x')],
          ),
        ),
      );
      expect(tester.getTopLeft(find.text('x')).dx, 250);
    });

    testWidgets(
      'row: wraps with gaps, stretches items to the line height, mirrors in RTL',
      (tester) async {
        Widget row(TextDirection dir) => _app(
          CsFlex(
            direction: Axis.horizontal,
            wrap: true,
            mainGap: 10,
            crossGap: 5,
            children: [
              SizedBox(
                key: const ValueKey('a'),
                width: 120,
                child: Container(height: 10),
              ),
              _block(120, 40),
              _block(120, 20, 'c'),
            ],
          ),
          dir: dir,
        );
        await tester.pumpWidget(row(TextDirection.ltr));
        expect(
          tester.getSize(find.byType(CsFlex)),
          const Size(300, 40 + 5 + 20),
        );
        expect(
          tester.getSize(find.byKey(const ValueKey('a'))).height,
          40,
        ); // stretched to line
        expect(tester.getTopLeft(find.text('c')), const Offset(0, 45));
        await tester.pumpWidget(row(TextDirection.rtl));
        expect(
          tester.getTopLeft(find.byKey(const ValueKey('a'))).dx,
          300 - 120,
        );
      },
    );

    testWidgets('works with unbounded width (sizes to content)', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: CsFlex(
              direction: Axis.vertical,
              children: [_block(80, 10), _block(40, 10)],
            ),
          ),
        ),
      );
      expect(tester.getSize(find.byType(CsFlex)).width, 80);
    });
  });

  group('CsBox', () {
    TextStyle styleOf(WidgetTester tester, String text) =>
        DefaultTextStyle.of(tester.element(find.text(text))).style;

    testWidgets('h1: heading typography, padding, semantics, focusable', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _app(CsBox.text('Title', variant: CsBoxVariant.h1)),
      );
      final s = styleOf(tester, 'Title');
      expect(s.fontSize, t.fontSizeHeadingXl);
      expect(s.height! * s.fontSize!, closeTo(t.lineHeightHeadingXl, 1e-9));
      expect(s.fontWeight, t.fontWeightHeadingXl.toFontWeight());
      expect(s.color, t.colorTextHeadingDefault.toColor());
      expect(
        tester.getSize(find.byType(CsBox)).height,
        closeTo(t.lineHeightHeadingXl + 2 * t.spaceXxs, 0.01),
      );
      expect(
        tester.getSemantics(find.text('Title')),
        isSemantics(label: 'Title', isHeader: true, isFocusable: true),
      );
      expect(
        tester.getSemantics(find.text('Title')).getSemanticsData().headingLevel,
        1,
      );
      handle.dispose();
    });

    testWidgets('variant defaults and prop overrides', (tester) async {
      await tester.pumpWidget(
        _app(
          Column(
            children: [
              CsBox.text('small', variant: CsBoxVariant.small),
              CsBox.text('code', variant: CsBoxVariant.code),
              CsBox.text('label', variant: CsBoxVariant.awsuiKeyLabel),
              CsBox.text('gen', variant: CsBoxVariant.awsuiGenAiLabel),
              CsBox.text(
                'err',
                variant: CsBoxVariant.h2,
                color: CsBoxColor.textStatusError,
                fontSize: CsBoxFontSize.bodyS,
              ),
              DefaultTextStyle(
                style: const TextStyle(color: Color(0xFF112233)),
                child: Column(
                  children: [
                    CsBox.text('inh', color: CsBoxColor.inherit),
                    CsBox.text('big', variant: CsBoxVariant.awsuiValueLarge),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      expect(styleOf(tester, 'small').color, t.colorTextSmall.toColor());
      expect(styleOf(tester, 'small').fontSize, t.fontSizeBodyS);
      expect(styleOf(tester, 'code').fontFamily, 'Monaco');
      expect(
        styleOf(tester, 'label').fontWeight,
        t.fontDisplayLabelWeight.toFontWeight(),
      );
      expect(styleOf(tester, 'gen').fontStyle, FontStyle.italic);
      expect(styleOf(tester, 'err').color, t.colorTextStatusError.toColor());
      expect(styleOf(tester, 'err').fontSize, t.fontSizeBodyS);
      expect(
        styleOf(tester, 'err').fontWeight,
        t.fontWeightHeadingL.toFontWeight(),
      );
      expect(styleOf(tester, 'inh').color, const Color(0xFF112233));
      expect(
        styleOf(tester, 'big').color,
        const Color(0xFF112233),
      ); // value-large inherits
      expect(styleOf(tester, 'big').fontSize, t.fontSizeDisplayL);
    });

    testWidgets('spacing: vertical scaled, horizontal base; later size wins', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          CsBox(
            key: const ValueKey('box'),
            display: CsBoxDisplay.inlineBlock,
            padding: const CsBoxSpacing(
              vertical: CsSpacing.m,
              top: CsSpacing.s,
              horizontal: CsSpacing.l,
            ),
            child: _block(10, 10),
          ),
          density: CsDensity.compact,
        ),
      );
      final c = CsTokens.resolve(density: CsDensity.compact);
      expect(
        tester.getSize(
          find
              .descendant(
                of: find.byKey(const ValueKey('box')),
                matching: find.byType(Padding),
              )
              .first,
        ),
        Size(10 + 2 * c.spaceL, 10 + 2 * c.spaceScaledM), // top: m beats s
      );
    });

    testWidgets(
      'display: block fills, inline sizes to content, none hides; textAlign',
      (tester) async {
        await tester.pumpWidget(
          _app(
            Column(
              children: [
                CsBox(child: _block(10, 10)),
                CsBox(variant: CsBoxVariant.span, child: _block(10, 10)),
              ],
            ),
          ),
        );
        expect(tester.getSize(find.byType(CsBox).first).width, 300);
        expect(tester.getSize(find.byType(CsBox).last).width, 10);
        await tester.pumpWidget(
          _app(CsBox.text('gone', display: CsBoxDisplay.none)),
        );
        expect(find.text('gone'), findsNothing);
        await tester.pumpWidget(
          _app(CsBox.text('mid', textAlign: CsBoxTextAlign.center)),
        );
        expect(
          DefaultTextStyle.of(tester.element(find.text('mid'))).textAlign,
          TextAlign.center,
        );
      },
    );

    testWidgets('inline code and visual accent backgrounds', (tester) async {
      await tester.pumpWidget(
        _app(
          Column(
            children: [
              CsBox.text('x', variant: CsBoxVariant.awsuiInlineCode),
              CsBox.text(
                'A',
                visualAccent: const CsVisualAccent(
                  color: CsVisualAccentColor.teal,
                  borderRadius: CsVisualAccentRadius.s,
                ),
              ),
              CsBox.text(
                'B',
                visualAccent: const CsVisualAccent(
                  color: CsVisualAccentColor.red,
                  borderRadius: CsVisualAccentRadius.full,
                ),
              ),
            ],
          ),
        ),
      );
      final decorations = tester
          .widgetList<DecoratedBox>(find.byType(DecoratedBox))
          .map((d) => d.decoration as BoxDecoration)
          .toList();
      expect(
        decorations.map((d) => d.color),
        containsAll([
          t.colorBackgroundInlineCode.toColor(),
          t.colorBackgroundVisualAccentTeal.toColor(),
        ]),
      );
      expect(
        decorations
            .firstWhere(
              (d) => d.color == t.colorBackgroundVisualAccentTeal.toColor(),
            )
            .borderRadius,
        BorderRadius.circular(t.spaceS),
      );
      expect(find.byType(ClipOval), findsOneWidget);
      expect(styleOf(tester, 'A').color, t.colorTextVisualAccentTeal.toColor());
    });

    testWidgets('tagOverride changes heading semantics only', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_app(CsBox.text('Sub', tagOverride: 'h2')));
      expect(
        tester.getSemantics(find.text('Sub')),
        isSemantics(label: 'Sub', isHeader: true),
      );
      expect(
        tester.getSemantics(find.text('Sub')).getSemanticsData().headingLevel,
        2,
      );
      expect(styleOf(tester, 'Sub').fontSize, t.fontSizeBodyM);
      handle.dispose();
    });
  });

  group('CsSpaceBetween', () {
    testWidgets('vertical gaps: base up to xs, scaled from s', (tester) async {
      final comfortable = CsTokens.resolve();
      final compact = CsTokens.resolve(density: CsDensity.compact);
      for (final (density, tokens) in [
        (CsDensity.comfortable, comfortable),
        (CsDensity.compact, compact),
      ]) {
        await tester.pumpWidget(
          _app(
            CsSpaceBetween(
              size: CsSpaceBetweenSize.m,
              children: [_block(10, 10, 'a'), null, _block(10, 10, 'b')],
            ),
            density: density,
          ),
        );
        expect(
          tester.getTopLeft(find.text('b')).dy -
              tester.getTopLeft(find.text('a')).dy,
          10 + tokens.spaceScaledM,
        );
      }
      await tester.pumpWidget(
        _app(
          CsSpaceBetween(
            size: CsSpaceBetweenSize.xs,
            children: [_block(10, 10, 'a'), _block(10, 10, 'b')],
          ),
          density: CsDensity.compact,
        ),
      );
      expect(
        tester.getTopLeft(find.text('b')).dy -
            tester.getTopLeft(find.text('a')).dy,
        10 + compact.spaceXs,
      );
    });

    testWidgets('horizontal wraps with base gaps; alignItems', (tester) async {
      await tester.pumpWidget(
        _app(
          CsSpaceBetween(
            direction: CsSpaceBetweenDirection.horizontal,
            size: CsSpaceBetweenSize.s,
            alignItems: CsSpaceBetweenAlign.end,
            children: [
              _block(140, 30, 'a'),
              _block(140, 10, 'b'),
              _block(140, 10, 'c'),
            ],
          ),
        ),
      );
      expect(
        tester.getTopLeft(find.text('b')),
        Offset(140 + t.spaceS, 20),
      ); // end-aligned in the line
      expect(tester.getTopLeft(find.text('c')), Offset(0, 30 + t.spaceS));
    });
  });
}
