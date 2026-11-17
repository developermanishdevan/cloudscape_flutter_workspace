import 'package:cloudscape_tokens/cloudscape_tokens.dart';

/// The Cloudscape spacing scale.
enum CsSpacing {
  /// 0.
  none,

  /// xxxs.
  xxxs,

  /// xxs.
  xxs,

  /// xs.
  xs,

  /// s.
  s,

  /// m.
  m,

  /// l.
  l,

  /// xl.
  xl,

  /// xxl.
  xxl,

  /// xxxl.
  xxxl;

  /// The base size (`space-*` tokens).
  double of(CsTokens t) => switch (this) {
    none => t.spaceNone,
    xxxs => t.spaceXxxs,
    xxs => t.spaceXxs,
    xs => t.spaceXs,
    s => t.spaceS,
    m => t.spaceM,
    l => t.spaceL,
    xl => t.spaceXl,
    xxl => t.spaceXxl,
    xxxl => t.spaceXxxl,
  };

  /// The density-scaled size (`space-scaled-*`): smaller in compact mode.
  double scaled(CsTokens t) => switch (this) {
    none => t.spaceScaledNone,
    xxxs => t.spaceScaledXxxs,
    xxs => t.spaceScaledXxs,
    xs => t.spaceScaledXs,
    s => t.spaceScaledS,
    m => t.spaceScaledM,
    l => t.spaceScaledL,
    xl => t.spaceScaledXl,
    xxl => t.spaceScaledXxl,
    xxxl => t.spaceScaledXxxl,
  };

  /// The density-independent size (`space-static-*`).
  double static(CsTokens t) => switch (this) {
    none => t.spaceNone,
    xxxs => t.spaceStaticXxxs,
    xxs => t.spaceStaticXxs,
    xs => t.spaceStaticXs,
    s => t.spaceStaticS,
    m => t.spaceStaticM,
    l => t.spaceStaticL,
    xl => t.spaceStaticXl,
    xxl => t.spaceStaticXxl,
    xxxl => t.spaceStaticXxxl,
  };
}
