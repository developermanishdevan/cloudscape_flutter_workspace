// Value types for Cloudscape design tokens.
//
// This library is pure Dart (no Flutter dependency) so the generator and
// non-Flutter tools can use it. The Flutter theme layer converts these values
// to `Color`, `BoxShadow`, `Cubic`, `Duration` and friends.

/// Light or dark visual mode (Cloudscape "color" mode).
enum CsColorMode {
  /// Default mode.
  light,

  /// Dark mode (`.awsui-dark-mode` upstream).
  dark,
}

/// Content density (Cloudscape "density" mode).
enum CsDensity {
  /// Default density.
  comfortable,

  /// Compact density (`.awsui-compact-mode` upstream).
  compact,
}

/// Motion mode (Cloudscape "motion" mode).
enum CsMotionMode {
  /// Default motion (upstream state name: `default`).
  normal,

  /// Motion disabled (`.awsui-motion-disabled` upstream). Durations become 0.
  disabled,
}

/// Which mode axis a token's value depends on.
enum CsTokenAxis {
  /// Value differs between [CsColorMode.light] and [CsColorMode.dark].
  color,

  /// Value differs between [CsDensity.comfortable] and [CsDensity.compact].
  density,

  /// Value differs between [CsMotionMode.normal] and [CsMotionMode.disabled].
  motion,

  /// Value is the same in every mode.
  none,
}

/// Any token value used to paint: a solid color, `currentColor`, or a
/// gradient.
sealed class CsColorValue {
  const CsColorValue();
}

/// A solid sRGB color stored as 32-bit ARGB (`0xAARRGGBB`).
final class CsColor extends CsColorValue {
  /// Creates a color from a 32-bit ARGB value.
  const CsColor(this.argb);

  /// The fully transparent color (CSS `transparent`).
  static const CsColor transparent = CsColor(0x00000000);

  /// The color as `0xAARRGGBB`.
  final int argb;

  /// Alpha channel, 0–255.
  int get alpha => (argb >> 24) & 0xFF;

  /// Red channel, 0–255.
  int get red => (argb >> 16) & 0xFF;

  /// Green channel, 0–255.
  int get green => (argb >> 8) & 0xFF;

  /// Blue channel, 0–255.
  int get blue => argb & 0xFF;

  @override
  bool operator ==(Object other) => other is CsColor && other.argb == argb;

  @override
  int get hashCode => argb.hashCode;

  @override
  String toString() =>
      'CsColor(0x${argb.toRadixString(16).padLeft(8, '0').toUpperCase()})';
}

/// CSS `currentColor`: use the current text color.
final class CsCurrentColor extends CsColorValue {
  /// The `currentColor` value.
  const CsCurrentColor();

  @override
  bool operator ==(Object other) => other is CsCurrentColor;

  @override
  int get hashCode => (CsCurrentColor).hashCode;

  @override
  String toString() => 'CsCurrentColor()';
}

/// One color stop of a gradient.
final class CsGradientStop {
  /// Creates a stop. [position] is 0–1, or null when unspecified.
  const CsGradientStop(this.color, [this.position]);

  /// Stop color.
  final CsColor color;

  /// Stop position from 0 to 1, or null to distribute evenly.
  final double? position;

  @override
  bool operator ==(Object other) =>
      other is CsGradientStop &&
      other.color == color &&
      other.position == position;

  @override
  int get hashCode => Object.hash(color, position);

  @override
  String toString() => 'CsGradientStop($color, $position)';
}

/// CSS `linear-gradient(<angle>deg, ...)`.
final class CsLinearGradient extends CsColorValue {
  /// Creates a linear gradient.
  const CsLinearGradient({required this.angleDegrees, required this.stops});

  /// CSS angle in degrees (0 = to top, 90 = to right).
  final double angleDegrees;

  /// Color stops.
  final List<CsGradientStop> stops;

  @override
  bool operator ==(Object other) =>
      other is CsLinearGradient &&
      other.angleDegrees == angleDegrees &&
      _listEquals(other.stops, stops);

  @override
  int get hashCode => Object.hash(angleDegrees, Object.hashAll(stops));

  @override
  String toString() => 'CsLinearGradient($angleDegrees, $stops)';
}

/// CSS `radial-gradient(<shape> <extent> at <position>, ...)`.
final class CsRadialGradient extends CsColorValue {
  /// Creates a radial gradient.
  const CsRadialGradient({
    required this.circle,
    required this.extent,
    required this.centerX,
    required this.centerY,
    required this.stops,
  });

  /// True for `circle`, false for `ellipse`.
  final bool circle;

  /// CSS extent keyword, e.g. `farthest-corner`.
  final String extent;

  /// Horizontal center from 0 (left) to 1 (right).
  final double centerX;

  /// Vertical center from 0 (top) to 1 (bottom).
  final double centerY;

  /// Color stops.
  final List<CsGradientStop> stops;

  @override
  bool operator ==(Object other) =>
      other is CsRadialGradient &&
      other.circle == circle &&
      other.extent == extent &&
      other.centerX == centerX &&
      other.centerY == centerY &&
      _listEquals(other.stops, stops);

  @override
  int get hashCode =>
      Object.hash(circle, extent, centerX, centerY, Object.hashAll(stops));

  @override
  String toString() =>
      'CsRadialGradient($circle, $extent, $centerX, $centerY, $stops)';
}

/// A length that is not a plain pixel value.
///
/// Tokens whose values are always pixels are typed as `double` instead.
sealed class CsLength {
  const CsLength();
}

/// A length in logical pixels (CSS `px`).
final class CsPx extends CsLength {
  /// Creates a pixel length.
  const CsPx(this.value);

  /// Logical pixels.
  final double value;

  @override
  bool operator ==(Object other) => other is CsPx && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'CsPx($value)';
}

/// A length relative to the font size (CSS `em`).
final class CsEm extends CsLength {
  /// Creates an em length.
  const CsEm(this.value);

  /// Multiple of the current font size.
  final double value;

  @override
  bool operator ==(Object other) => other is CsEm && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'CsEm($value)';
}

/// A percentage length (CSS `%`), stored as a fraction (50% = 0.5).
final class CsPercent extends CsLength {
  /// Creates a percentage length from a fraction.
  const CsPercent(this.fraction);

  /// Fraction of the reference size (0.5 = 50%).
  final double fraction;

  @override
  bool operator ==(Object other) =>
      other is CsPercent && other.fraction == fraction;

  @override
  int get hashCode => fraction.hashCode;

  @override
  String toString() => 'CsPercent($fraction)';
}

/// A CSS keyword length: `inherit` or `normal`.
final class CsLengthKeyword extends CsLength {
  const CsLengthKeyword._(this.keyword);

  /// Use the parent's value.
  static const CsLengthKeyword inherit = CsLengthKeyword._('inherit');

  /// The font's default (used for letter spacing).
  static const CsLengthKeyword normal = CsLengthKeyword._('normal');

  /// The CSS keyword.
  final String keyword;

  @override
  String toString() => 'CsLengthKeyword.$keyword';
}

/// A font weight (100–900) or `inherit`.
final class CsFontWeight {
  /// Creates a numeric font weight.
  const CsFontWeight(int this.value);

  const CsFontWeight._inherit() : value = null;

  /// Use the parent's font weight.
  static const CsFontWeight inherit = CsFontWeight._inherit();

  /// Numeric weight, or null for [inherit].
  final int? value;

  /// Whether this is [inherit].
  bool get isInherit => value == null;

  @override
  bool operator ==(Object other) =>
      other is CsFontWeight && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() =>
      isInherit ? 'CsFontWeight.inherit' : 'CsFontWeight($value)';
}

/// One layer of a CSS `box-shadow`.
final class CsShadow {
  /// Creates a shadow layer.
  const CsShadow({
    required this.offsetX,
    required this.offsetY,
    this.blur = 0,
    this.spread = 0,
    required this.color,
    this.inset = false,
  });

  /// Horizontal offset in logical pixels.
  final double offsetX;

  /// Vertical offset in logical pixels.
  final double offsetY;

  /// CSS blur radius in logical pixels.
  final double blur;

  /// Spread radius in logical pixels.
  final double spread;

  /// Shadow color.
  final CsColor color;

  /// Whether this is an inset shadow.
  final bool inset;

  @override
  bool operator ==(Object other) =>
      other is CsShadow &&
      other.offsetX == offsetX &&
      other.offsetY == offsetY &&
      other.blur == blur &&
      other.spread == spread &&
      other.color == color &&
      other.inset == inset;

  @override
  int get hashCode => Object.hash(offsetX, offsetY, blur, spread, color, inset);

  @override
  String toString() =>
      'CsShadow($offsetX, $offsetY, $blur, $spread, $color, inset: $inset)';
}

/// A CSS `cubic-bezier()` easing curve. CSS keywords (`ease-out`, `linear`,
/// ...) are converted to their cubic-bezier equivalents.
final class CsCubicBezier {
  /// Creates a cubic-bezier curve.
  const CsCubicBezier(this.x1, this.y1, this.x2, this.y2);

  /// First control point x.
  final double x1;

  /// First control point y.
  final double y1;

  /// Second control point x.
  final double x2;

  /// Second control point y.
  final double y2;

  @override
  bool operator ==(Object other) =>
      other is CsCubicBezier &&
      other.x1 == x1 &&
      other.y1 == y1 &&
      other.x2 == x2 &&
      other.y2 == y2;

  @override
  int get hashCode => Object.hash(x1, y1, x2, y2);

  @override
  String toString() => 'CsCubicBezier($x1, $y1, $x2, $y2)';
}

/// Metadata for one design token.
final class CsTokenInfo {
  /// Creates token metadata.
  const CsTokenInfo({
    required this.axis,
    required this.cssVariable,
    required this.themeable,
    required this.exposed,
    this.description,
    this.references = const {},
  });

  /// The mode axis the token's value depends on.
  final CsTokenAxis axis;

  /// Upstream CSS custom property name without the leading `--`.
  final String cssVariable;

  /// Whether upstream `applyTheme()` allows overriding this token.
  final bool themeable;

  /// Whether the token is part of the public `design-tokens` package.
  final bool exposed;

  /// Upstream description, for exposed tokens.
  final String? description;

  /// Tokens this token references, keyed by mode state name (`light`,
  /// `dark`, `comfortable`, `compact`, `default`, `disabled`) or `*` for
  /// mode-independent tokens. Used to re-resolve dependents when a theme
  /// overrides a referenced token.
  final Map<String, String> references;
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

/// An unresolved token value in one mode state: a literal value or a
/// reference to another token (upstream `"{tokenName}"`).
final class CsTokenAssignment {
  /// A literal value of the token's type.
  const CsTokenAssignment.value(Object this.value) : reference = null;

  /// A reference to the token called [reference].
  const CsTokenAssignment.reference(String this.reference) : value = null;

  /// The literal value, or null for a reference.
  final Object? value;

  /// The referenced token name, or null for a literal.
  final String? reference;

  /// Whether this is a reference.
  bool get isReference => reference != null;

  @override
  String toString() => isReference
      ? 'CsTokenAssignment.reference($reference)'
      : 'CsTokenAssignment.value($value)';
}
