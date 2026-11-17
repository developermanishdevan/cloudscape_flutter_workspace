import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_tokens/cloudscape_tokens.dart';
import 'package:flutter/widgets.dart';

/// Motion helpers built from tokens.
///
/// Durations come from motion tokens, which are already zero when motion is
/// disabled ([CsMotionMode.disabled], e.g. from
/// [MediaQueryData.disableAnimations]).
class CsMotion {
  /// Creates motion helpers for [tokens].
  const CsMotion(this.tokens);

  /// The tokens to read.
  final CsTokens tokens;

  /// Converts an easing token to a [Curve].
  Curve curve(CsCubicBezier easing) => easing.toCurve();

  /// Upstream `awsui-fade-in`: opacity 0 → 1.
  Animatable<double> get fadeIn => Tween<double>(begin: 0, end: 1);

  /// Upstream `awsui-fade-out`: opacity 1 → 0.
  Animatable<double> get fadeOut => Tween<double>(begin: 1, end: 0);

  /// Upstream `awsui-scale-popup`: scale 0.95 → 1.
  Animatable<double> get scalePopup => Tween<double>(begin: 0.95, end: 1);

  /// Upstream `awsui-status-icon-error`: horizontal shake in logical pixels
  /// (-5 → 5 linear, then 5 → 0 with `motion-easing-refresh-only-a`).
  Animatable<double> get statusIconError => TweenSequence<double>([
    TweenSequenceItem(tween: Tween<double>(begin: -5, end: 5), weight: 50),
    TweenSequenceItem(
      tween: Tween<double>(
        begin: 5,
        end: 0,
      ).chain(CurveTween(curve: tokens.motionEasingRefreshOnlyA.toCurve())),
      weight: 50,
    ),
  ]);
}
