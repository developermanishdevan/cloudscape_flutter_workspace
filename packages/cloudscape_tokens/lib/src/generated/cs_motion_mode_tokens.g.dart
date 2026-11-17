// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Source: @cloudscape-design/components 3.0.1416 (theme: visual-refresh),
// descriptions from @cloudscape-design/design-tokens 3.0.118.
// Regenerate with: dart run melos run tokens:generate
//
// Cloudscape is Copyright Amazon.com, Inc. or its affiliates, Apache-2.0.

import 'package:cloudscape_tokens/src/values.dart';

/// Tokens whose values depend on the motion mode (normal or disabled).
final class CsMotionModeTokens {
  /// Creates a token set. Prefer the predefined instances.
  const CsMotionModeTokens({
    required this.motionDurationExtraFast,
    required this.motionDurationExtraSlow,
    required this.motionDurationFast,
    required this.motionDurationModerate,
    required this.motionDurationRefreshOnlyAmbient,
    required this.motionDurationRefreshOnlyFast,
    required this.motionDurationRefreshOnlyMedium,
    required this.motionDurationRefreshOnlySlow,
    required this.motionDurationAvatarGenAiGradient,
    required this.motionDurationAvatarLoadingDots,
    required this.motionDurationRotate180,
    required this.motionDurationRotate90,
    required this.motionDurationShowPaced,
    required this.motionDurationShowQuick,
    required this.motionDurationSlow,
    required this.motionDurationTransitionQuick,
    required this.motionDurationTransitionShowPaced,
    required this.motionDurationTransitionShowQuick,
    required this.motionEasingEaseOutQuart,
    required this.motionEasingRefreshOnlyA,
    required this.motionEasingRefreshOnlyB,
    required this.motionEasingRefreshOnlyC,
    required this.motionEasingRefreshOnlyD,
    required this.motionEasingAvatarGenAiGradient,
    required this.motionEasingRotate180,
    required this.motionEasingRotate90,
    required this.motionEasingShowPaced,
    required this.motionEasingShowQuick,
    required this.motionEasingTransitionQuick,
    required this.motionEasingTransitionShowPaced,
    required this.motionEasingTransitionShowQuick,
    required this.motionEasingResponsive,
    required this.motionEasingSticky,
    required this.motionEasingExpressive,
    required this.motionDurationResponsive,
    required this.motionDurationExpressive,
    required this.motionDurationComplex,
    required this.motionDurationTooltipEnter,
    required this.motionEasingTooltipEnter,
    required this.motionDurationExpandableContentEnter,
    required this.motionEasingExpandableContentEnter,
    required this.motionDurationSideNavigationContentEnterFade,
    required this.motionDurationSideNavigationContentExit,
    required this.motionDurationSideNavigationContentExitFade,
    required this.motionEasingSideNavigationContentExit,
    required this.motionKeyframesFadeIn,
    required this.motionKeyframesFadeOut,
    required this.motionKeyframesStatusIconError,
    required this.motionKeyframesScalePopup,
  });

  /// Values for [CsMotionMode.normal].
  static const CsMotionModeTokens normal = CsMotionModeTokens(
    motionDurationExtraFast: Duration(milliseconds: 45),
    motionDurationExtraSlow: Duration(milliseconds: 270),
    motionDurationFast: Duration(milliseconds: 90),
    motionDurationModerate: Duration(milliseconds: 135),
    motionDurationRefreshOnlyAmbient: Duration(milliseconds: 2000),
    motionDurationRefreshOnlyFast: Duration(milliseconds: 115),
    motionDurationRefreshOnlyMedium: Duration(milliseconds: 165),
    motionDurationRefreshOnlySlow: Duration(milliseconds: 250),
    motionDurationAvatarGenAiGradient: Duration(milliseconds: 3600),
    motionDurationAvatarLoadingDots: Duration(milliseconds: 1200),
    motionDurationRotate180: Duration(milliseconds: 135),
    motionDurationRotate90: Duration(milliseconds: 135),
    motionDurationShowPaced: Duration(milliseconds: 180),
    motionDurationShowQuick: Duration(milliseconds: 135),
    motionDurationSlow: Duration(milliseconds: 180),
    motionDurationTransitionQuick: Duration(milliseconds: 90),
    motionDurationTransitionShowPaced: Duration(milliseconds: 180),
    motionDurationTransitionShowQuick: Duration(milliseconds: 90),
    motionEasingEaseOutQuart: CsCubicBezier(0.165, 0.84, 0.44, 1.0),
    motionEasingRefreshOnlyA: CsCubicBezier(0.0, 0.0, 0.0, 1.0),
    motionEasingRefreshOnlyB: CsCubicBezier(1.0, 0.0, 0.83, 1.0),
    motionEasingRefreshOnlyC: CsCubicBezier(0.84, 0.0, 0.16, 1.0),
    motionEasingRefreshOnlyD: CsCubicBezier(0.33, 0.0, 0.67, 1.0),
    motionEasingAvatarGenAiGradient: CsCubicBezier(0.7, 0.0, 0.3, 1.0),
    motionEasingRotate180: CsCubicBezier(0.165, 0.84, 0.44, 1.0),
    motionEasingRotate90: CsCubicBezier(0.165, 0.84, 0.44, 1.0),
    motionEasingShowPaced: CsCubicBezier(0.0, 0.0, 0.58, 1.0),
    motionEasingShowQuick: CsCubicBezier(0.0, 0.0, 0.58, 1.0),
    motionEasingTransitionQuick: CsCubicBezier(0.0, 0.0, 1.0, 1.0),
    motionEasingTransitionShowPaced: CsCubicBezier(0.0, 0.0, 0.58, 1.0),
    motionEasingTransitionShowQuick: CsCubicBezier(0.0, 0.0, 1.0, 1.0),
    motionEasingResponsive: CsCubicBezier(0.0, 0.0, 0.0, 1.0),
    motionEasingSticky: CsCubicBezier(1.0, 0.0, 0.83, 1.0),
    motionEasingExpressive: CsCubicBezier(0.84, 0.0, 0.16, 1.0),
    motionDurationResponsive: Duration(milliseconds: 115),
    motionDurationExpressive: Duration(milliseconds: 165),
    motionDurationComplex: Duration(milliseconds: 250),
    motionDurationTooltipEnter: Duration(milliseconds: 115),
    motionEasingTooltipEnter: CsCubicBezier(0.0, 0.0, 0.0, 1.0),
    motionDurationExpandableContentEnter: Duration(milliseconds: 180),
    motionEasingExpandableContentEnter: CsCubicBezier(0.0, 0.0, 0.58, 1.0),
    motionDurationSideNavigationContentEnterFade: Duration(milliseconds: 0),
    motionDurationSideNavigationContentExit: Duration(milliseconds: 0),
    motionDurationSideNavigationContentExitFade: Duration(milliseconds: 0),
    motionEasingSideNavigationContentExit: CsCubicBezier(0.0, 0.0, 0.58, 1.0),
    motionKeyframesFadeIn: 'awsui-fade-in-jiml2r',
    motionKeyframesFadeOut: 'awsui-fade-out-au27m5',
    motionKeyframesStatusIconError: 'awsui-status-icon-error-mjjk3s',
    motionKeyframesScalePopup: 'awsui-scale-popup-2m9987',
  );

  /// Values for [CsMotionMode.disabled].
  static const CsMotionModeTokens disabled = CsMotionModeTokens(
    motionDurationExtraFast: Duration(milliseconds: 0),
    motionDurationExtraSlow: Duration(milliseconds: 0),
    motionDurationFast: Duration(milliseconds: 0),
    motionDurationModerate: Duration(milliseconds: 0),
    motionDurationRefreshOnlyAmbient: Duration(milliseconds: 0),
    motionDurationRefreshOnlyFast: Duration(milliseconds: 0),
    motionDurationRefreshOnlyMedium: Duration(milliseconds: 0),
    motionDurationRefreshOnlySlow: Duration(milliseconds: 0),
    motionDurationAvatarGenAiGradient: Duration(milliseconds: 0),
    motionDurationAvatarLoadingDots: Duration(milliseconds: 0),
    motionDurationRotate180: Duration(milliseconds: 0),
    motionDurationRotate90: Duration(milliseconds: 0),
    motionDurationShowPaced: Duration(milliseconds: 0),
    motionDurationShowQuick: Duration(milliseconds: 0),
    motionDurationSlow: Duration(milliseconds: 0),
    motionDurationTransitionQuick: Duration(milliseconds: 0),
    motionDurationTransitionShowPaced: Duration(milliseconds: 0),
    motionDurationTransitionShowQuick: Duration(milliseconds: 0),
    motionEasingEaseOutQuart: CsCubicBezier(0.165, 0.84, 0.44, 1.0),
    motionEasingRefreshOnlyA: CsCubicBezier(0.0, 0.0, 0.0, 1.0),
    motionEasingRefreshOnlyB: CsCubicBezier(1.0, 0.0, 0.83, 1.0),
    motionEasingRefreshOnlyC: CsCubicBezier(0.84, 0.0, 0.16, 1.0),
    motionEasingRefreshOnlyD: CsCubicBezier(0.33, 0.0, 0.67, 1.0),
    motionEasingAvatarGenAiGradient: CsCubicBezier(0.7, 0.0, 0.3, 1.0),
    motionEasingRotate180: CsCubicBezier(0.165, 0.84, 0.44, 1.0),
    motionEasingRotate90: CsCubicBezier(0.165, 0.84, 0.44, 1.0),
    motionEasingShowPaced: CsCubicBezier(0.0, 0.0, 0.58, 1.0),
    motionEasingShowQuick: CsCubicBezier(0.0, 0.0, 0.58, 1.0),
    motionEasingTransitionQuick: CsCubicBezier(0.0, 0.0, 1.0, 1.0),
    motionEasingTransitionShowPaced: CsCubicBezier(0.0, 0.0, 0.58, 1.0),
    motionEasingTransitionShowQuick: CsCubicBezier(0.0, 0.0, 1.0, 1.0),
    motionEasingResponsive: CsCubicBezier(0.0, 0.0, 0.0, 1.0),
    motionEasingSticky: CsCubicBezier(1.0, 0.0, 0.83, 1.0),
    motionEasingExpressive: CsCubicBezier(0.84, 0.0, 0.16, 1.0),
    motionDurationResponsive: Duration(milliseconds: 0),
    motionDurationExpressive: Duration(milliseconds: 0),
    motionDurationComplex: Duration(milliseconds: 0),
    motionDurationTooltipEnter: Duration(milliseconds: 0),
    motionEasingTooltipEnter: CsCubicBezier(0.0, 0.0, 0.0, 1.0),
    motionDurationExpandableContentEnter: Duration(milliseconds: 0),
    motionEasingExpandableContentEnter: CsCubicBezier(0.0, 0.0, 0.58, 1.0),
    motionDurationSideNavigationContentEnterFade: Duration(milliseconds: 0),
    motionDurationSideNavigationContentExit: Duration(milliseconds: 0),
    motionDurationSideNavigationContentExitFade: Duration(milliseconds: 0),
    motionEasingSideNavigationContentExit: CsCubicBezier(0.0, 0.0, 0.58, 1.0),
    motionKeyframesFadeIn: 'awsui-fade-in-jiml2r',
    motionKeyframesFadeOut: 'awsui-fade-out-au27m5',
    motionKeyframesStatusIconError: 'awsui-status-icon-error-mjjk3s',
    motionKeyframesScalePopup: 'awsui-scale-popup-2m9987',
  );

  /// Returns the predefined instance for [mode].
  static CsMotionModeTokens of(CsMotionMode mode) => switch (mode) {
    CsMotionMode.normal => normal,
    CsMotionMode.disabled => disabled,
  };

  /// Names of the tokens in this group.
  static const Set<String> names = {
    'motionDurationExtraFast',
    'motionDurationExtraSlow',
    'motionDurationFast',
    'motionDurationModerate',
    'motionDurationRefreshOnlyAmbient',
    'motionDurationRefreshOnlyFast',
    'motionDurationRefreshOnlyMedium',
    'motionDurationRefreshOnlySlow',
    'motionDurationAvatarGenAiGradient',
    'motionDurationAvatarLoadingDots',
    'motionDurationRotate180',
    'motionDurationRotate90',
    'motionDurationShowPaced',
    'motionDurationShowQuick',
    'motionDurationSlow',
    'motionDurationTransitionQuick',
    'motionDurationTransitionShowPaced',
    'motionDurationTransitionShowQuick',
    'motionEasingEaseOutQuart',
    'motionEasingRefreshOnlyA',
    'motionEasingRefreshOnlyB',
    'motionEasingRefreshOnlyC',
    'motionEasingRefreshOnlyD',
    'motionEasingAvatarGenAiGradient',
    'motionEasingRotate180',
    'motionEasingRotate90',
    'motionEasingShowPaced',
    'motionEasingShowQuick',
    'motionEasingTransitionQuick',
    'motionEasingTransitionShowPaced',
    'motionEasingTransitionShowQuick',
    'motionEasingResponsive',
    'motionEasingSticky',
    'motionEasingExpressive',
    'motionDurationResponsive',
    'motionDurationExpressive',
    'motionDurationComplex',
    'motionDurationTooltipEnter',
    'motionEasingTooltipEnter',
    'motionDurationExpandableContentEnter',
    'motionEasingExpandableContentEnter',
    'motionDurationSideNavigationContentEnterFade',
    'motionDurationSideNavigationContentExit',
    'motionDurationSideNavigationContentExitFade',
    'motionEasingSideNavigationContentExit',
    'motionKeyframesFadeIn',
    'motionKeyframesFadeOut',
    'motionKeyframesStatusIconError',
    'motionKeyframesScalePopup',
  };

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-extra-fast`
  final Duration motionDurationExtraFast;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-extra-slow`
  final Duration motionDurationExtraSlow;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-fast`
  final Duration motionDurationFast;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-moderate`
  final Duration motionDurationModerate;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-refresh-only-ambient`
  final Duration motionDurationRefreshOnlyAmbient;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-refresh-only-fast`
  final Duration motionDurationRefreshOnlyFast;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-refresh-only-medium`
  final Duration motionDurationRefreshOnlyMedium;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-refresh-only-slow`
  final Duration motionDurationRefreshOnlySlow;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-avatar-gen-ai-gradient`
  final Duration motionDurationAvatarGenAiGradient;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-avatar-loading-dots`
  final Duration motionDurationAvatarLoadingDots;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-rotate-180`
  final Duration motionDurationRotate180;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-rotate-90`
  final Duration motionDurationRotate90;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-show-paced`
  final Duration motionDurationShowPaced;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-show-quick`
  final Duration motionDurationShowQuick;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-slow`
  final Duration motionDurationSlow;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-transition-quick`
  final Duration motionDurationTransitionQuick;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-transition-show-paced`
  final Duration motionDurationTransitionShowPaced;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-transition-show-quick`
  final Duration motionDurationTransitionShowQuick;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-ease-out-quart`
  final CsCubicBezier motionEasingEaseOutQuart;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-refresh-only-a`
  final CsCubicBezier motionEasingRefreshOnlyA;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-refresh-only-b`
  final CsCubicBezier motionEasingRefreshOnlyB;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-refresh-only-c`
  final CsCubicBezier motionEasingRefreshOnlyC;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-refresh-only-d`
  final CsCubicBezier motionEasingRefreshOnlyD;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-avatar-gen-ai-gradient`
  final CsCubicBezier motionEasingAvatarGenAiGradient;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-rotate-180`
  final CsCubicBezier motionEasingRotate180;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-rotate-90`
  final CsCubicBezier motionEasingRotate90;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-show-paced`
  final CsCubicBezier motionEasingShowPaced;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-show-quick`
  final CsCubicBezier motionEasingShowQuick;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-transition-quick`
  final CsCubicBezier motionEasingTransitionQuick;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-transition-show-paced`
  final CsCubicBezier motionEasingTransitionShowPaced;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-transition-show-quick`
  final CsCubicBezier motionEasingTransitionShowQuick;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-responsive`
  final CsCubicBezier motionEasingResponsive;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-sticky`
  final CsCubicBezier motionEasingSticky;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-expressive`
  final CsCubicBezier motionEasingExpressive;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-responsive`
  final Duration motionDurationResponsive;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-expressive`
  final Duration motionDurationExpressive;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-complex`
  final Duration motionDurationComplex;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-tooltip-enter`
  final Duration motionDurationTooltipEnter;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-tooltip-enter`
  final CsCubicBezier motionEasingTooltipEnter;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-expandable-content-enter`
  final Duration motionDurationExpandableContentEnter;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-expandable-content-enter`
  final CsCubicBezier motionEasingExpandableContentEnter;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-side-navigation-content-enter-fade`
  final Duration motionDurationSideNavigationContentEnterFade;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-side-navigation-content-exit`
  final Duration motionDurationSideNavigationContentExit;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-duration-side-navigation-content-exit-fade`
  final Duration motionDurationSideNavigationContentExitFade;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-easing-side-navigation-content-exit`
  final CsCubicBezier motionEasingSideNavigationContentExit;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-keyframes-fade-in`
  final String motionKeyframesFadeIn;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-keyframes-fade-out`
  final String motionKeyframesFadeOut;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-keyframes-status-icon-error`
  final String motionKeyframesStatusIconError;

  /// See [CsTokens].
  ///
  /// CSS: `--motion-keyframes-scale-popup`
  final String motionKeyframesScalePopup;

  /// Returns the value of the token called [name].
  Object operator [](String name) => switch (name) {
    'motionDurationExtraFast' => motionDurationExtraFast,
    'motionDurationExtraSlow' => motionDurationExtraSlow,
    'motionDurationFast' => motionDurationFast,
    'motionDurationModerate' => motionDurationModerate,
    'motionDurationRefreshOnlyAmbient' => motionDurationRefreshOnlyAmbient,
    'motionDurationRefreshOnlyFast' => motionDurationRefreshOnlyFast,
    'motionDurationRefreshOnlyMedium' => motionDurationRefreshOnlyMedium,
    'motionDurationRefreshOnlySlow' => motionDurationRefreshOnlySlow,
    'motionDurationAvatarGenAiGradient' => motionDurationAvatarGenAiGradient,
    'motionDurationAvatarLoadingDots' => motionDurationAvatarLoadingDots,
    'motionDurationRotate180' => motionDurationRotate180,
    'motionDurationRotate90' => motionDurationRotate90,
    'motionDurationShowPaced' => motionDurationShowPaced,
    'motionDurationShowQuick' => motionDurationShowQuick,
    'motionDurationSlow' => motionDurationSlow,
    'motionDurationTransitionQuick' => motionDurationTransitionQuick,
    'motionDurationTransitionShowPaced' => motionDurationTransitionShowPaced,
    'motionDurationTransitionShowQuick' => motionDurationTransitionShowQuick,
    'motionEasingEaseOutQuart' => motionEasingEaseOutQuart,
    'motionEasingRefreshOnlyA' => motionEasingRefreshOnlyA,
    'motionEasingRefreshOnlyB' => motionEasingRefreshOnlyB,
    'motionEasingRefreshOnlyC' => motionEasingRefreshOnlyC,
    'motionEasingRefreshOnlyD' => motionEasingRefreshOnlyD,
    'motionEasingAvatarGenAiGradient' => motionEasingAvatarGenAiGradient,
    'motionEasingRotate180' => motionEasingRotate180,
    'motionEasingRotate90' => motionEasingRotate90,
    'motionEasingShowPaced' => motionEasingShowPaced,
    'motionEasingShowQuick' => motionEasingShowQuick,
    'motionEasingTransitionQuick' => motionEasingTransitionQuick,
    'motionEasingTransitionShowPaced' => motionEasingTransitionShowPaced,
    'motionEasingTransitionShowQuick' => motionEasingTransitionShowQuick,
    'motionEasingResponsive' => motionEasingResponsive,
    'motionEasingSticky' => motionEasingSticky,
    'motionEasingExpressive' => motionEasingExpressive,
    'motionDurationResponsive' => motionDurationResponsive,
    'motionDurationExpressive' => motionDurationExpressive,
    'motionDurationComplex' => motionDurationComplex,
    'motionDurationTooltipEnter' => motionDurationTooltipEnter,
    'motionEasingTooltipEnter' => motionEasingTooltipEnter,
    'motionDurationExpandableContentEnter' =>
      motionDurationExpandableContentEnter,
    'motionEasingExpandableContentEnter' => motionEasingExpandableContentEnter,
    'motionDurationSideNavigationContentEnterFade' =>
      motionDurationSideNavigationContentEnterFade,
    'motionDurationSideNavigationContentExit' =>
      motionDurationSideNavigationContentExit,
    'motionDurationSideNavigationContentExitFade' =>
      motionDurationSideNavigationContentExitFade,
    'motionEasingSideNavigationContentExit' =>
      motionEasingSideNavigationContentExit,
    'motionKeyframesFadeIn' => motionKeyframesFadeIn,
    'motionKeyframesFadeOut' => motionKeyframesFadeOut,
    'motionKeyframesStatusIconError' => motionKeyframesStatusIconError,
    'motionKeyframesScalePopup' => motionKeyframesScalePopup,
    _ => throw ArgumentError.value(name, 'name', 'Not in CsMotionModeTokens'),
  };

  /// Returns a copy with [overrides] applied.
  ///
  /// Every key must be in [names] and every value must have the
  /// token's type, otherwise this throws.
  CsMotionModeTokens copyWithMap(Map<String, Object> overrides) {
    if (overrides.isEmpty) return this;
    for (final key in overrides.keys) {
      if (!names.contains(key)) {
        throw ArgumentError.value(
          key,
          'overrides',
          'Not in CsMotionModeTokens',
        );
      }
    }
    return CsMotionModeTokens(
      motionDurationExtraFast:
          (overrides['motionDurationExtraFast'] ?? motionDurationExtraFast)
              as Duration,
      motionDurationExtraSlow:
          (overrides['motionDurationExtraSlow'] ?? motionDurationExtraSlow)
              as Duration,
      motionDurationFast:
          (overrides['motionDurationFast'] ?? motionDurationFast) as Duration,
      motionDurationModerate:
          (overrides['motionDurationModerate'] ?? motionDurationModerate)
              as Duration,
      motionDurationRefreshOnlyAmbient:
          (overrides['motionDurationRefreshOnlyAmbient'] ??
                  motionDurationRefreshOnlyAmbient)
              as Duration,
      motionDurationRefreshOnlyFast:
          (overrides['motionDurationRefreshOnlyFast'] ??
                  motionDurationRefreshOnlyFast)
              as Duration,
      motionDurationRefreshOnlyMedium:
          (overrides['motionDurationRefreshOnlyMedium'] ??
                  motionDurationRefreshOnlyMedium)
              as Duration,
      motionDurationRefreshOnlySlow:
          (overrides['motionDurationRefreshOnlySlow'] ??
                  motionDurationRefreshOnlySlow)
              as Duration,
      motionDurationAvatarGenAiGradient:
          (overrides['motionDurationAvatarGenAiGradient'] ??
                  motionDurationAvatarGenAiGradient)
              as Duration,
      motionDurationAvatarLoadingDots:
          (overrides['motionDurationAvatarLoadingDots'] ??
                  motionDurationAvatarLoadingDots)
              as Duration,
      motionDurationRotate180:
          (overrides['motionDurationRotate180'] ?? motionDurationRotate180)
              as Duration,
      motionDurationRotate90:
          (overrides['motionDurationRotate90'] ?? motionDurationRotate90)
              as Duration,
      motionDurationShowPaced:
          (overrides['motionDurationShowPaced'] ?? motionDurationShowPaced)
              as Duration,
      motionDurationShowQuick:
          (overrides['motionDurationShowQuick'] ?? motionDurationShowQuick)
              as Duration,
      motionDurationSlow:
          (overrides['motionDurationSlow'] ?? motionDurationSlow) as Duration,
      motionDurationTransitionQuick:
          (overrides['motionDurationTransitionQuick'] ??
                  motionDurationTransitionQuick)
              as Duration,
      motionDurationTransitionShowPaced:
          (overrides['motionDurationTransitionShowPaced'] ??
                  motionDurationTransitionShowPaced)
              as Duration,
      motionDurationTransitionShowQuick:
          (overrides['motionDurationTransitionShowQuick'] ??
                  motionDurationTransitionShowQuick)
              as Duration,
      motionEasingEaseOutQuart:
          (overrides['motionEasingEaseOutQuart'] ?? motionEasingEaseOutQuart)
              as CsCubicBezier,
      motionEasingRefreshOnlyA:
          (overrides['motionEasingRefreshOnlyA'] ?? motionEasingRefreshOnlyA)
              as CsCubicBezier,
      motionEasingRefreshOnlyB:
          (overrides['motionEasingRefreshOnlyB'] ?? motionEasingRefreshOnlyB)
              as CsCubicBezier,
      motionEasingRefreshOnlyC:
          (overrides['motionEasingRefreshOnlyC'] ?? motionEasingRefreshOnlyC)
              as CsCubicBezier,
      motionEasingRefreshOnlyD:
          (overrides['motionEasingRefreshOnlyD'] ?? motionEasingRefreshOnlyD)
              as CsCubicBezier,
      motionEasingAvatarGenAiGradient:
          (overrides['motionEasingAvatarGenAiGradient'] ??
                  motionEasingAvatarGenAiGradient)
              as CsCubicBezier,
      motionEasingRotate180:
          (overrides['motionEasingRotate180'] ?? motionEasingRotate180)
              as CsCubicBezier,
      motionEasingRotate90:
          (overrides['motionEasingRotate90'] ?? motionEasingRotate90)
              as CsCubicBezier,
      motionEasingShowPaced:
          (overrides['motionEasingShowPaced'] ?? motionEasingShowPaced)
              as CsCubicBezier,
      motionEasingShowQuick:
          (overrides['motionEasingShowQuick'] ?? motionEasingShowQuick)
              as CsCubicBezier,
      motionEasingTransitionQuick:
          (overrides['motionEasingTransitionQuick'] ??
                  motionEasingTransitionQuick)
              as CsCubicBezier,
      motionEasingTransitionShowPaced:
          (overrides['motionEasingTransitionShowPaced'] ??
                  motionEasingTransitionShowPaced)
              as CsCubicBezier,
      motionEasingTransitionShowQuick:
          (overrides['motionEasingTransitionShowQuick'] ??
                  motionEasingTransitionShowQuick)
              as CsCubicBezier,
      motionEasingResponsive:
          (overrides['motionEasingResponsive'] ?? motionEasingResponsive)
              as CsCubicBezier,
      motionEasingSticky:
          (overrides['motionEasingSticky'] ?? motionEasingSticky)
              as CsCubicBezier,
      motionEasingExpressive:
          (overrides['motionEasingExpressive'] ?? motionEasingExpressive)
              as CsCubicBezier,
      motionDurationResponsive:
          (overrides['motionDurationResponsive'] ?? motionDurationResponsive)
              as Duration,
      motionDurationExpressive:
          (overrides['motionDurationExpressive'] ?? motionDurationExpressive)
              as Duration,
      motionDurationComplex:
          (overrides['motionDurationComplex'] ?? motionDurationComplex)
              as Duration,
      motionDurationTooltipEnter:
          (overrides['motionDurationTooltipEnter'] ??
                  motionDurationTooltipEnter)
              as Duration,
      motionEasingTooltipEnter:
          (overrides['motionEasingTooltipEnter'] ?? motionEasingTooltipEnter)
              as CsCubicBezier,
      motionDurationExpandableContentEnter:
          (overrides['motionDurationExpandableContentEnter'] ??
                  motionDurationExpandableContentEnter)
              as Duration,
      motionEasingExpandableContentEnter:
          (overrides['motionEasingExpandableContentEnter'] ??
                  motionEasingExpandableContentEnter)
              as CsCubicBezier,
      motionDurationSideNavigationContentEnterFade:
          (overrides['motionDurationSideNavigationContentEnterFade'] ??
                  motionDurationSideNavigationContentEnterFade)
              as Duration,
      motionDurationSideNavigationContentExit:
          (overrides['motionDurationSideNavigationContentExit'] ??
                  motionDurationSideNavigationContentExit)
              as Duration,
      motionDurationSideNavigationContentExitFade:
          (overrides['motionDurationSideNavigationContentExitFade'] ??
                  motionDurationSideNavigationContentExitFade)
              as Duration,
      motionEasingSideNavigationContentExit:
          (overrides['motionEasingSideNavigationContentExit'] ??
                  motionEasingSideNavigationContentExit)
              as CsCubicBezier,
      motionKeyframesFadeIn:
          (overrides['motionKeyframesFadeIn'] ?? motionKeyframesFadeIn)
              as String,
      motionKeyframesFadeOut:
          (overrides['motionKeyframesFadeOut'] ?? motionKeyframesFadeOut)
              as String,
      motionKeyframesStatusIconError:
          (overrides['motionKeyframesStatusIconError'] ??
                  motionKeyframesStatusIconError)
              as String,
      motionKeyframesScalePopup:
          (overrides['motionKeyframesScalePopup'] ?? motionKeyframesScalePopup)
              as String,
    );
  }
}
