import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_tokens/cloudscape_tokens.dart';
import 'package:flutter/widgets.dart';

/// The font family bundled with this package (upstream global-styles).
const String csBundledFontFamily = 'Open Sans';

const String _package = 'cloudscape_flutter';

/// Splits a CSS font-family list into Flutter's family + fallbacks. The
/// bundled Open Sans is addressed through this package
/// (`packages/cloudscape_flutter/Open Sans`); the plain name follows it as a
/// fallback because Flutter registers a package's fonts without the prefix
/// when that package is the root app (its own tests and previews).
({String? family, List<String> fallback}) csFontFamily(List<String> families) {
  if (families.isEmpty) return (family: null, fallback: const []);
  List<String> flutterNames(String f) =>
      f == csBundledFontFamily ? ['packages/$_package/$f', f] : [f];
  final all = [for (final f in families) ...flutterNames(f)];
  return (family: all.first, fallback: all.skip(1).toList());
}

/// Text styles for the Cloudscape type scale, built from tokens.
///
/// Line heights use CSS half-leading ([TextLeadingDistribution.even]).
class CsTypography {
  /// Creates the type scale for [tokens].
  const CsTypography(this.tokens);

  /// The tokens to read.
  final CsTokens tokens;

  TextStyle _style({
    required List<String> family,
    required double fontSize,
    required double lineHeight,
    CsFontWeight? weight,
    CsLength? letterSpacing,
  }) {
    final f = csFontFamily(family);
    return TextStyle(
      fontFamily: f.family,
      fontFamilyFallback: f.fallback,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      leadingDistribution: TextLeadingDistribution.even,
      fontWeight: weight?.toFontWeight(),
      letterSpacing: letterSpacing?.resolve(fontSize: fontSize),
      fontStyle: FontStyle.normal,
    );
  }

  /// The upstream component root reset: body M in the base family with the
  /// default body color. Every component starts from this.
  TextStyle get reset => bodyM.copyWith(
    color: tokens.colorTextBodyDefault.toColor(),
    fontWeight: tokens.fontWeightNormal.toFontWeight(),
  );

  /// Body M (default body text).
  TextStyle get bodyM => _style(
    family: tokens.fontFamilyBase,
    fontSize: tokens.fontSizeBodyM,
    lineHeight: tokens.lineHeightBodyM,
    weight: tokens.fontWeightNormal,
  );

  /// Body S (small text).
  TextStyle get bodyS => _style(
    family: tokens.fontFamilyBase,
    fontSize: tokens.fontSizeBodyS,
    lineHeight: tokens.lineHeightBodyS,
    weight: tokens.fontWeightNormal,
    letterSpacing: tokens.letterSpacingBodyS,
  );

  /// Heading XL.
  TextStyle get headingXl => _style(
    family: tokens.fontFamilyHeading,
    fontSize: tokens.fontSizeHeadingXl,
    lineHeight: tokens.lineHeightHeadingXl,
    weight: tokens.fontWeightHeadingXl,
    letterSpacing: tokens.letterSpacingHeadingXl,
  );

  /// Heading L.
  TextStyle get headingL => _style(
    family: tokens.fontFamilyHeading,
    fontSize: tokens.fontSizeHeadingL,
    lineHeight: tokens.lineHeightHeadingL,
    weight: tokens.fontWeightHeadingL,
    letterSpacing: tokens.letterSpacingHeadingL,
  );

  /// Heading M.
  TextStyle get headingM => _style(
    family: tokens.fontFamilyHeading,
    fontSize: tokens.fontSizeHeadingM,
    lineHeight: tokens.lineHeightHeadingM,
    weight: tokens.fontWeightHeadingM,
    letterSpacing: tokens.letterSpacingHeadingM,
  );

  /// Heading S.
  TextStyle get headingS => _style(
    family: tokens.fontFamilyHeading,
    fontSize: tokens.fontSizeHeadingS,
    lineHeight: tokens.lineHeightHeadingS,
    weight: tokens.fontWeightHeadingS,
    letterSpacing: tokens.letterSpacingHeadingS,
  );

  /// Heading XS.
  TextStyle get headingXs => _style(
    family: tokens.fontFamilyHeading,
    fontSize: tokens.fontSizeHeadingXs,
    lineHeight: tokens.lineHeightHeadingXs,
    weight: tokens.fontWeightHeadingXs,
    letterSpacing: tokens.letterSpacingHeadingXs,
  );

  /// Display L.
  TextStyle get displayL => _style(
    family: tokens.fontFamilyDisplay,
    fontSize: tokens.fontSizeDisplayL,
    lineHeight: tokens.lineHeightDisplayL,
    weight: tokens.fontWeightDisplayL,
    letterSpacing: tokens.letterSpacingDisplayL,
  );

  /// Display XL.
  TextStyle get displayXl => _style(
    family: tokens.fontFamilyDisplay,
    fontSize: tokens.fontSizeDisplayXl,
    lineHeight: tokens.lineHeightDisplayXl,
    weight: tokens.fontWeightDisplayXl,
    letterSpacing: tokens.letterSpacingDisplayXl,
  );

  /// [style] in the monospace family (code).
  TextStyle monospace(TextStyle style) {
    final f = csFontFamily(tokens.fontFamilyMonospace);
    return style.copyWith(fontFamily: f.family, fontFamilyFallback: f.fallback);
  }
}
