import 'package:cloudscape_tokens/values.dart';
import 'package:test/test.dart';
import 'package:token_gen/token_gen.dart';

void main() {
  group('parseColor', () {
    test('hex forms', () {
      expect(parseColor('#006ce0'), const CsColor(0xFF006CE0));
      expect(parseColor('#fff'), const CsColor(0xFFFFFFFF));
      expect(parseColor('#0007161a'), const CsColor(0x1A000716));
    });
    test('rgba and transparent', () {
      expect(parseColor('rgba(0, 7, 22, 0.12)'), const CsColor(0x1F000716));
      expect(parseColor('rgba(0, 7, 22, 1)'), const CsColor(0xFF000716));
      expect(parseColor('rgb(255, 0, 0)'), const CsColor(0xFFFF0000));
      expect(parseColor('transparent'), CsColor.transparent);
    });
    test('rejects unknown input', () {
      expect(() => parseColor('hsl(0, 0%, 0%)'), throwsFormatException);
      expect(() => parseColor('#12345'), throwsFormatException);
      expect(() => parseColor('rgba(300, 0, 0, 1)'), throwsFormatException);
    });
  });

  test('parseShadows handles layers, negatives, unitless zero and none', () {
    expect(parseShadows('none'), isEmpty);
    expect(
      parseShadows('-4px 0 8px 1px rgba(0, 28, 36, 0.1), 0px 6px 36px #00040c'),
      const [
        CsShadow(
          offsetX: -4,
          offsetY: 0,
          blur: 8,
          spread: 1,
          color: CsColor(0x1A001C24),
        ),
        CsShadow(offsetX: 0, offsetY: 6, blur: 36, color: CsColor(0xFF00040C)),
      ],
    );
    expect(() => parseShadows('1px red'), throwsFormatException);
  });

  test('parseEasing maps keywords to cubic-bezier', () {
    expect(parseEasing('ease-out'), const CsCubicBezier(0, 0, 0.58, 1));
    expect(parseEasing('linear'), const CsCubicBezier(0, 0, 1, 1));
    expect(
      parseEasing('cubic-bezier(0.165, 0.84, 0.44, 1)'),
      const CsCubicBezier(0.165, 0.84, 0.44, 1),
    );
    expect(() => parseEasing('steps(4)'), throwsFormatException);
  });

  test('parseDuration', () {
    expect(parseDuration('45ms'), const Duration(milliseconds: 45));
    expect(parseDuration('0.5s'), const Duration(milliseconds: 500));
    expect(() => parseDuration('fast'), throwsFormatException);
  });

  test('gradients', () {
    expect(
      parseRadialGradient(
        'radial-gradient(circle farthest-corner at top right, #b8e7ff 0%, #0099ff 25% , #962eff 80%)',
      ),
      const CsRadialGradient(
        circle: true,
        extent: 'farthest-corner',
        centerX: 1,
        centerY: 0,
        stops: [
          CsGradientStop(CsColor(0xFFB8E7FF), 0),
          CsGradientStop(CsColor(0xFF0099FF), 0.25),
          CsGradientStop(CsColor(0xFF962EFF), 0.8),
        ],
      ),
    );
    expect(
      parseLinearGradient('linear-gradient(90deg, #b8e7ff 0%, #0099ff 100%)'),
      const CsLinearGradient(
        angleDegrees: 90,
        stops: [
          CsGradientStop(CsColor(0xFFB8E7FF), 0),
          CsGradientStop(CsColor(0xFF0099FF), 1),
        ],
      ),
    );
  });

  group('parseToken picks the kind from name and value', () {
    test('lengths', () {
      expect(parseToken('spaceXs', '8px').value, 8.0);
      expect(
        parseToken('letterSpacingHeadingL', '-0.015em').value,
        const CsEm(-0.015),
      );
      expect(
        parseToken('letterSpacingHeadingXs', 'normal').value,
        CsLengthKeyword.normal,
      );
      expect(
        parseToken('fontSideNavigationSectionHeaderSize', 'inherit').value,
        CsLengthKeyword.inherit,
      );
      expect(
        parseToken('borderRadiusSideNavigationItemCollapsed', '50%').value,
        const CsPercent(0.5),
      );
      expect(parseToken('borderLineChartDashArray', '3 5').value, [3.0, 5.0]);
    });
    test('fonts', () {
      expect(
        parseToken('fontWeightHeadingL', '700').value,
        const CsFontWeight(700),
      );
      expect(
        parseToken('fontWeightLinkSecondary', 'inherit').value,
        CsFontWeight.inherit,
      );
      expect(
        parseToken(
          'fontFamilyBase',
          "'Open Sans', 'Helvetica Neue', Roboto, Arial, sans-serif",
        ).value,
        ['Open Sans', 'Helvetica Neue', 'Roboto', 'Arial', 'sans-serif'],
      );
    });
    test('unknown formats fail loudly', () {
      expect(
        () => parseToken('spaceXs', 'calc(1px + 2px)'),
        throwsFormatException,
      );
      expect(
        () => parseToken('colorTextBodyDefault', 'red'),
        throwsFormatException,
      );
    });
  });
}
