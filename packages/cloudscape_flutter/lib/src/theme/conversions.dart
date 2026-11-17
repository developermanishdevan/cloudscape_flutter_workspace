// Converts cloudscape_tokens values to Flutter painting types with CSS
// semantics, so widgets render like the browser does.
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:cloudscape_tokens/cloudscape_tokens.dart';
import 'package:flutter/widgets.dart';

/// Converts a [CsColor] to a Flutter [Color].
extension CsColorToFlutter on CsColor {
  /// This color as a Flutter [Color].
  Color toColor() => Color(argb);
}

/// Converts any paint token value to Flutter.
extension CsColorValueToFlutter on CsColorValue {
  /// A solid color, or [currentColor] for `currentColor`.
  ///
  /// Throws for gradients; use [toGradient] for those.
  Color toColor({required Color currentColor}) => switch (this) {
    final CsColor c => c.toColor(),
    CsCurrentColor() => currentColor,
    CsLinearGradient() || CsRadialGradient() => throw StateError(
      'Gradient token used as a color; use toGradient()',
    ),
  };

  /// A gradient with CSS geometry, or null for solid colors.
  Gradient? toGradient() => switch (this) {
    final CsLinearGradient g => CsCssLinearGradient(g),
    final CsRadialGradient g => CsCssRadialGradient(g),
    CsColor() || CsCurrentColor() => null,
  };
}

/// Converts a pixel token to [EdgeInsets] and friends.
extension CsLengthToFlutter on CsLength {
  /// Resolves this length in logical pixels.
  ///
  /// [fontSize] resolves `em`; [reference] resolves `%`. Returns null for
  /// `inherit` and `normal`, meaning "use the inherited/default value".
  double? resolve({double? fontSize, double? reference}) => switch (this) {
    final CsPx p => p.value,
    final CsEm e =>
      fontSize == null
          ? throw ArgumentError('fontSize is required to resolve $this')
          : e.value * fontSize,
    final CsPercent p =>
      reference == null
          ? throw ArgumentError('reference is required to resolve $this')
          : p.fraction * reference,
    CsLengthKeyword() => null,
  };
}

/// Converts a font weight token.
extension CsFontWeightToFlutter on CsFontWeight {
  /// The Flutter [FontWeight], or null for `inherit`.
  FontWeight? toFontWeight() => isInherit ? null : FontWeight(value!);
}

/// Converts an easing token.
extension CsCubicBezierToFlutter on CsCubicBezier {
  /// The equivalent Flutter [Cubic] curve.
  Cubic toCurve() => Cubic(x1, y1, x2, y2);
}

/// Converts shadow tokens.
extension CsShadowsToFlutter on List<CsShadow> {
  /// Flutter shadows with CSS blur semantics. Throws for inset shadows,
  /// which [BoxDecoration] cannot paint.
  List<BoxShadow> toBoxShadows() => [
    for (final s in this)
      if (s.inset)
        throw UnsupportedError(
          'Inset shadows are not supported by BoxDecoration',
        )
      else
        CsCssBoxShadow(
          color: s.color.toColor(),
          offset: Offset(s.offsetX, s.offsetY),
          blurRadius: s.blur,
          spreadRadius: s.spread,
        ),
  ];
}

/// A [BoxShadow] whose [blurRadius] follows CSS `box-shadow`: the Gaussian
/// standard deviation is half the blur radius.
class CsCssBoxShadow extends BoxShadow {
  /// Creates a CSS-style shadow.
  const CsCssBoxShadow({
    super.color,
    super.offset,
    super.blurRadius,
    super.spreadRadius,
  });

  @override
  double get blurSigma => blurRadius / 2;

  @override
  CsCssBoxShadow scale(double factor) => CsCssBoxShadow(
    color: color,
    offset: offset * factor,
    blurRadius: blurRadius * factor,
    spreadRadius: spreadRadius * factor,
  );
}

List<CsGradientStop> _fade(List<CsGradientStop> stops, double opacity) => [
  for (final s in stops)
    CsGradientStop(
      CsColor(
        (((s.color.alpha * opacity.clamp(0, 1)).round()) << 24) |
            (s.color.argb & 0xFFFFFF),
      ),
      s.position,
    ),
];

List<double> _cssStops(List<CsGradientStop> stops) {
  // CSS: missing first/last positions are 0/1; runs of missing positions are
  // spread evenly; positions never decrease.
  final n = stops.length;
  final out = List<double?>.generate(n, (i) => stops[i].position);
  out[0] ??= 0;
  out[n - 1] ??= 1;
  var maxSoFar = out[0]!;
  for (var i = 1; i < n; i++) {
    if (out[i] != null) {
      out[i] = math.max(out[i]!, maxSoFar);
      maxSoFar = out[i]!;
    }
  }
  var i = 1;
  while (i < n) {
    if (out[i] == null) {
      final start = i - 1;
      var end = i;
      while (out[end] == null) {
        end++;
      }
      for (var k = start + 1; k < end; k++) {
        out[k] =
            out[start]! +
            (out[end]! - out[start]!) * (k - start) / (end - start);
      }
      i = end;
    }
    i++;
  }
  return [for (final s in out) s!];
}

/// A CSS `linear-gradient()`: the gradient line passes through the box
/// center at [CsLinearGradient.angleDegrees] and is long enough that the
/// corners get the first and last colors.
class CsCssLinearGradient extends Gradient {
  /// Wraps a gradient token.
  CsCssLinearGradient(this.token)
    : super(
        colors: [for (final s in token.stops) s.color.toColor()],
        stops: _cssStops(token.stops),
      );

  /// The token value.
  final CsLinearGradient token;

  @override
  Shader createShader(Rect rect, {TextDirection? textDirection}) {
    final a = token.angleDegrees * math.pi / 180;
    final dir = Offset(math.sin(a), -math.cos(a));
    final length =
        (rect.width * math.sin(a)).abs() + (rect.height * math.cos(a)).abs();
    final half = dir * (length / 2);
    return ui.Gradient.linear(
      rect.center - half,
      rect.center + half,
      colors,
      stops,
    );
  }

  @override
  Gradient scale(double factor) => withOpacity(factor);

  @override
  CsCssLinearGradient withOpacity(double opacity) => CsCssLinearGradient(
    CsLinearGradient(
      angleDegrees: token.angleDegrees,
      stops: _fade(token.stops, opacity),
    ),
  );

  @override
  bool operator ==(Object other) =>
      other is CsCssLinearGradient && other.token == token;

  @override
  int get hashCode => token.hashCode;
}

/// A CSS `radial-gradient()` with `circle`/`ellipse`, an extent keyword and
/// a keyword position.
class CsCssRadialGradient extends Gradient {
  /// Wraps a gradient token.
  CsCssRadialGradient(this.token)
    : super(
        colors: [for (final s in token.stops) s.color.toColor()],
        stops: _cssStops(token.stops),
      );

  /// The token value.
  final CsRadialGradient token;

  @override
  Shader createShader(Rect rect, {TextDirection? textDirection}) {
    final c = Offset(
      rect.left + rect.width * token.centerX,
      rect.top + rect.height * token.centerY,
    );
    final dl = c.dx - rect.left, dr = rect.right - c.dx;
    final dt = c.dy - rect.top, db = rect.bottom - c.dy;
    final corners = [
      Offset(dl, dt),
      Offset(dr, dt),
      Offset(dl, db),
      Offset(dr, db),
    ];
    double rx, ry;
    final closest = token.extent.startsWith('closest');
    if (token.circle) {
      final r = switch (token.extent) {
        'closest-side' => [dl, dr, dt, db].reduce(math.min),
        'farthest-side' => [dl, dr, dt, db].reduce(math.max),
        'closest-corner' => corners.map((o) => o.distance).reduce(math.min),
        _ => corners.map((o) => o.distance).reduce(math.max),
      };
      rx = ry = r;
    } else {
      final sx = closest ? math.min(dl, dr) : math.max(dl, dr);
      final sy = closest ? math.min(dt, db) : math.max(dt, db);
      if (token.extent.endsWith('side')) {
        rx = sx;
        ry = sy;
      } else {
        // Corner extents keep the side extent's aspect ratio (CSS Images 3).
        final ratio = sy == 0 ? 1.0 : sx / sy;
        final corner = Offset(sx, sy);
        rx = math.sqrt(corner.dx * corner.dx + math.pow(corner.dy * ratio, 2));
        ry = ratio == 0 ? 0 : rx / ratio;
      }
    }
    if (rx <= 0 || ry <= 0) {
      return ui.Gradient.linear(rect.topLeft, rect.topRight, [
        colors.last,
        colors.last,
      ]);
    }
    final matrix = Matrix4.identity()
      ..translateByDouble(c.dx, c.dy, 0, 1)
      ..scaleByDouble(1, ry / rx, 1, 1)
      ..translateByDouble(-c.dx, -c.dy, 0, 1);
    return ui.Gradient.radial(
      c,
      rx,
      colors,
      stops,
      TileMode.clamp,
      matrix.storage,
    );
  }

  @override
  Gradient scale(double factor) => withOpacity(factor);

  @override
  CsCssRadialGradient withOpacity(double opacity) => CsCssRadialGradient(
    CsRadialGradient(
      circle: token.circle,
      extent: token.extent,
      centerX: token.centerX,
      centerY: token.centerY,
      stops: _fade(token.stops, opacity),
    ),
  );

  @override
  bool operator ==(Object other) =>
      other is CsCssRadialGradient && other.token == token;

  @override
  int get hashCode => token.hashCode;
}
