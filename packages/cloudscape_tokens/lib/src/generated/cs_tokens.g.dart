// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Source: @cloudscape-design/components 3.0.1416 (theme: visual-refresh),
// descriptions from @cloudscape-design/design-tokens 3.0.118.
// Regenerate with: dart run melos run tokens:generate
//
// Cloudscape is Copyright Amazon.com, Inc. or its affiliates, Apache-2.0.

import 'package:cloudscape_tokens/src/generated/cs_color_mode_tokens.g.dart';
import 'package:cloudscape_tokens/src/generated/cs_density_mode_tokens.g.dart';
import 'package:cloudscape_tokens/src/generated/cs_motion_mode_tokens.g.dart';
import 'package:cloudscape_tokens/src/generated/cs_static_tokens.g.dart';
import 'package:cloudscape_tokens/src/generated/token_info.g.dart';
import 'package:cloudscape_tokens/src/generated/visual_contexts.g.dart';
import 'package:cloudscape_tokens/src/values.dart';

/// Every Cloudscape design token for one combination of modes.
///
/// Use [CsTokens.resolve] to pick modes, [inContext] for a visual
/// context, and [withOverrides] for theme overrides.
final class CsTokens {
  /// Creates tokens from explicit groups.
  const CsTokens({
    this.colorMode = CsColorMode.light,
    this.density = CsDensity.comfortable,
    this.motion = CsMotionMode.normal,
    this.colorTokens = CsColorModeTokens.light,
    this.densityTokens = CsDensityModeTokens.comfortable,
    this.motionTokens = CsMotionModeTokens.normal,
    this.staticTokens = CsStaticTokens.values,
  });

  /// Returns the base tokens for the given modes.
  factory CsTokens.resolve({
    CsColorMode colorMode = CsColorMode.light,
    CsDensity density = CsDensity.comfortable,
    CsMotionMode motion = CsMotionMode.normal,
  }) => CsTokens(
    colorMode: colorMode,
    density: density,
    motion: motion,
    colorTokens: CsColorModeTokens.of(colorMode),
    densityTokens: CsDensityModeTokens.of(density),
    motionTokens: CsMotionModeTokens.of(motion),
  );

  /// The color mode these tokens were resolved for.
  final CsColorMode colorMode;

  /// The density these tokens were resolved for.
  final CsDensity density;

  /// The motion mode these tokens were resolved for.
  final CsMotionMode motion;

  /// Color-mode dependent tokens.
  final CsColorModeTokens colorTokens;

  /// Density dependent tokens.
  final CsDensityModeTokens densityTokens;

  /// Motion dependent tokens.
  final CsMotionModeTokens motionTokens;

  /// Mode-independent tokens.
  final CsStaticTokens staticTokens;

  /// CSS: `--color-primary-50` · axis: color
  CsColor get colorPrimary50 => colorTokens.colorPrimary50;

  /// CSS: `--color-primary-100` · axis: color
  CsColor get colorPrimary100 => colorTokens.colorPrimary100;

  /// CSS: `--color-primary-200` · axis: color
  CsColor get colorPrimary200 => colorTokens.colorPrimary200;

  /// CSS: `--color-primary-300` · axis: color
  CsColor get colorPrimary300 => colorTokens.colorPrimary300;

  /// CSS: `--color-primary-400` · axis: color
  CsColor get colorPrimary400 => colorTokens.colorPrimary400;

  /// CSS: `--color-primary-500` · axis: color
  CsColor get colorPrimary500 => colorTokens.colorPrimary500;

  /// CSS: `--color-primary-600` · axis: color
  CsColor get colorPrimary600 => colorTokens.colorPrimary600;

  /// CSS: `--color-primary-700` · axis: color
  CsColor get colorPrimary700 => colorTokens.colorPrimary700;

  /// CSS: `--color-primary-800` · axis: color
  CsColor get colorPrimary800 => colorTokens.colorPrimary800;

  /// CSS: `--color-primary-900` · axis: color
  CsColor get colorPrimary900 => colorTokens.colorPrimary900;

  /// CSS: `--color-primary-950` · axis: color
  CsColor get colorPrimary950 => colorTokens.colorPrimary950;

  /// CSS: `--color-primary-1000` · axis: color
  CsColor get colorPrimary1000 => colorTokens.colorPrimary1000;

  /// CSS: `--color-neutral-50` · axis: color
  CsColor get colorNeutral50 => colorTokens.colorNeutral50;

  /// CSS: `--color-neutral-100` · axis: color
  CsColor get colorNeutral100 => colorTokens.colorNeutral100;

  /// CSS: `--color-neutral-150` · axis: color
  CsColor get colorNeutral150 => colorTokens.colorNeutral150;

  /// CSS: `--color-neutral-200` · axis: color
  CsColor get colorNeutral200 => colorTokens.colorNeutral200;

  /// CSS: `--color-neutral-250` · axis: color
  CsColor get colorNeutral250 => colorTokens.colorNeutral250;

  /// CSS: `--color-neutral-300` · axis: color
  CsColor get colorNeutral300 => colorTokens.colorNeutral300;

  /// CSS: `--color-neutral-350` · axis: color
  CsColor get colorNeutral350 => colorTokens.colorNeutral350;

  /// CSS: `--color-neutral-400` · axis: color
  CsColor get colorNeutral400 => colorTokens.colorNeutral400;

  /// CSS: `--color-neutral-450` · axis: color
  CsColor get colorNeutral450 => colorTokens.colorNeutral450;

  /// CSS: `--color-neutral-500` · axis: color
  CsColor get colorNeutral500 => colorTokens.colorNeutral500;

  /// CSS: `--color-neutral-550` · axis: color
  CsColor get colorNeutral550 => colorTokens.colorNeutral550;

  /// CSS: `--color-neutral-600` · axis: color
  CsColor get colorNeutral600 => colorTokens.colorNeutral600;

  /// CSS: `--color-neutral-650` · axis: color
  CsColor get colorNeutral650 => colorTokens.colorNeutral650;

  /// CSS: `--color-neutral-700` · axis: color
  CsColor get colorNeutral700 => colorTokens.colorNeutral700;

  /// CSS: `--color-neutral-750` · axis: color
  CsColor get colorNeutral750 => colorTokens.colorNeutral750;

  /// CSS: `--color-neutral-800` · axis: color
  CsColor get colorNeutral800 => colorTokens.colorNeutral800;

  /// CSS: `--color-neutral-850` · axis: color
  CsColor get colorNeutral850 => colorTokens.colorNeutral850;

  /// CSS: `--color-neutral-900` · axis: color
  CsColor get colorNeutral900 => colorTokens.colorNeutral900;

  /// CSS: `--color-neutral-950` · axis: color
  CsColor get colorNeutral950 => colorTokens.colorNeutral950;

  /// CSS: `--color-neutral-1000` · axis: color
  CsColor get colorNeutral1000 => colorTokens.colorNeutral1000;

  /// CSS: `--color-error-50` · axis: color
  CsColor get colorError50 => colorTokens.colorError50;

  /// CSS: `--color-error-100` · axis: color
  CsColor get colorError100 => colorTokens.colorError100;

  /// CSS: `--color-error-400` · axis: color
  CsColor get colorError400 => colorTokens.colorError400;

  /// CSS: `--color-error-600` · axis: color
  CsColor get colorError600 => colorTokens.colorError600;

  /// CSS: `--color-error-700` · axis: color
  CsColor get colorError700 => colorTokens.colorError700;

  /// CSS: `--color-error-800` · axis: color
  CsColor get colorError800 => colorTokens.colorError800;

  /// CSS: `--color-error-900` · axis: color
  CsColor get colorError900 => colorTokens.colorError900;

  /// CSS: `--color-error-950` · axis: color
  CsColor get colorError950 => colorTokens.colorError950;

  /// CSS: `--color-error-1000` · axis: color
  CsColor get colorError1000 => colorTokens.colorError1000;

  /// CSS: `--color-success-50` · axis: color
  CsColor get colorSuccess50 => colorTokens.colorSuccess50;

  /// CSS: `--color-success-100` · axis: color
  CsColor get colorSuccess100 => colorTokens.colorSuccess100;

  /// CSS: `--color-success-200` · axis: color
  CsColor get colorSuccess200 => colorTokens.colorSuccess200;

  /// CSS: `--color-success-400` · axis: color
  CsColor get colorSuccess400 => colorTokens.colorSuccess400;

  /// CSS: `--color-success-500` · axis: color
  CsColor get colorSuccess500 => colorTokens.colorSuccess500;

  /// CSS: `--color-success-600` · axis: color
  CsColor get colorSuccess600 => colorTokens.colorSuccess600;

  /// CSS: `--color-success-800` · axis: color
  CsColor get colorSuccess800 => colorTokens.colorSuccess800;

  /// CSS: `--color-success-950` · axis: color
  CsColor get colorSuccess950 => colorTokens.colorSuccess950;

  /// CSS: `--color-success-1000` · axis: color
  CsColor get colorSuccess1000 => colorTokens.colorSuccess1000;

  /// CSS: `--color-warning-50` · axis: color
  CsColor get colorWarning50 => colorTokens.colorWarning50;

  /// CSS: `--color-warning-100` · axis: color
  CsColor get colorWarning100 => colorTokens.colorWarning100;

  /// CSS: `--color-warning-200` · axis: color
  CsColor get colorWarning200 => colorTokens.colorWarning200;

  /// CSS: `--color-warning-400` · axis: color
  CsColor get colorWarning400 => colorTokens.colorWarning400;

  /// CSS: `--color-warning-500` · axis: color
  CsColor get colorWarning500 => colorTokens.colorWarning500;

  /// CSS: `--color-warning-600` · axis: color
  CsColor get colorWarning600 => colorTokens.colorWarning600;

  /// CSS: `--color-warning-800` · axis: color
  CsColor get colorWarning800 => colorTokens.colorWarning800;

  /// CSS: `--color-warning-900` · axis: color
  CsColor get colorWarning900 => colorTokens.colorWarning900;

  /// CSS: `--color-warning-950` · axis: color
  CsColor get colorWarning950 => colorTokens.colorWarning950;

  /// CSS: `--color-warning-1000` · axis: color
  CsColor get colorWarning1000 => colorTokens.colorWarning1000;

  /// CSS: `--color-info-50` · axis: color
  CsColor get colorInfo50 => colorTokens.colorInfo50;

  /// CSS: `--color-info-100` · axis: color
  CsColor get colorInfo100 => colorTokens.colorInfo100;

  /// CSS: `--color-info-300` · axis: color
  CsColor get colorInfo300 => colorTokens.colorInfo300;

  /// CSS: `--color-info-400` · axis: color
  CsColor get colorInfo400 => colorTokens.colorInfo400;

  /// CSS: `--color-info-600` · axis: color
  CsColor get colorInfo600 => colorTokens.colorInfo600;

  /// CSS: `--color-info-700` · axis: color
  CsColor get colorInfo700 => colorTokens.colorInfo700;

  /// CSS: `--color-info-800` · axis: color
  CsColor get colorInfo800 => colorTokens.colorInfo800;

  /// CSS: `--color-info-950` · axis: color
  CsColor get colorInfo950 => colorTokens.colorInfo950;

  /// CSS: `--color-info-1000` · axis: color
  CsColor get colorInfo1000 => colorTokens.colorInfo1000;

  /// CSS: `--color-grey-50` · axis: color
  CsColor get colorGrey50 => colorTokens.colorGrey50;

  /// CSS: `--color-grey-100` · axis: color
  CsColor get colorGrey100 => colorTokens.colorGrey100;

  /// CSS: `--color-grey-150` · axis: color
  CsColor get colorGrey150 => colorTokens.colorGrey150;

  /// CSS: `--color-grey-200` · axis: color
  CsColor get colorGrey200 => colorTokens.colorGrey200;

  /// CSS: `--color-grey-250` · axis: color
  CsColor get colorGrey250 => colorTokens.colorGrey250;

  /// CSS: `--color-grey-300` · axis: color
  CsColor get colorGrey300 => colorTokens.colorGrey300;

  /// CSS: `--color-grey-350` · axis: color
  CsColor get colorGrey350 => colorTokens.colorGrey350;

  /// CSS: `--color-grey-400` · axis: color
  CsColor get colorGrey400 => colorTokens.colorGrey400;

  /// CSS: `--color-grey-450` · axis: color
  CsColor get colorGrey450 => colorTokens.colorGrey450;

  /// CSS: `--color-grey-500` · axis: color
  CsColor get colorGrey500 => colorTokens.colorGrey500;

  /// CSS: `--color-grey-600` · axis: color
  CsColor get colorGrey600 => colorTokens.colorGrey600;

  /// CSS: `--color-grey-650` · axis: color
  CsColor get colorGrey650 => colorTokens.colorGrey650;

  /// CSS: `--color-grey-700` · axis: color
  CsColor get colorGrey700 => colorTokens.colorGrey700;

  /// CSS: `--color-grey-750` · axis: color
  CsColor get colorGrey750 => colorTokens.colorGrey750;

  /// CSS: `--color-grey-800` · axis: color
  CsColor get colorGrey800 => colorTokens.colorGrey800;

  /// CSS: `--color-grey-850` · axis: color
  CsColor get colorGrey850 => colorTokens.colorGrey850;

  /// CSS: `--color-grey-900` · axis: color
  CsColor get colorGrey900 => colorTokens.colorGrey900;

  /// CSS: `--color-grey-950` · axis: color
  CsColor get colorGrey950 => colorTokens.colorGrey950;

  /// CSS: `--color-grey-1000` · axis: color
  CsColor get colorGrey1000 => colorTokens.colorGrey1000;

  /// CSS: `--color-blue-50` · axis: color
  CsColor get colorBlue50 => colorTokens.colorBlue50;

  /// CSS: `--color-blue-100` · axis: color
  CsColor get colorBlue100 => colorTokens.colorBlue100;

  /// CSS: `--color-blue-200` · axis: color
  CsColor get colorBlue200 => colorTokens.colorBlue200;

  /// CSS: `--color-blue-300` · axis: color
  CsColor get colorBlue300 => colorTokens.colorBlue300;

  /// CSS: `--color-blue-400` · axis: color
  CsColor get colorBlue400 => colorTokens.colorBlue400;

  /// CSS: `--color-blue-600` · axis: color
  CsColor get colorBlue600 => colorTokens.colorBlue600;

  /// CSS: `--color-blue-700` · axis: color
  CsColor get colorBlue700 => colorTokens.colorBlue700;

  /// CSS: `--color-blue-900` · axis: color
  CsColor get colorBlue900 => colorTokens.colorBlue900;

  /// CSS: `--color-blue-1000` · axis: color
  CsColor get colorBlue1000 => colorTokens.colorBlue1000;

  /// CSS: `--color-green-50` · axis: color
  CsColor get colorGreen50 => colorTokens.colorGreen50;

  /// CSS: `--color-green-500` · axis: color
  CsColor get colorGreen500 => colorTokens.colorGreen500;

  /// CSS: `--color-green-600` · axis: color
  CsColor get colorGreen600 => colorTokens.colorGreen600;

  /// CSS: `--color-green-900` · axis: color
  CsColor get colorGreen900 => colorTokens.colorGreen900;

  /// CSS: `--color-green-1000` · axis: color
  CsColor get colorGreen1000 => colorTokens.colorGreen1000;

  /// CSS: `--color-red-50` · axis: color
  CsColor get colorRed50 => colorTokens.colorRed50;

  /// CSS: `--color-red-400` · axis: color
  CsColor get colorRed400 => colorTokens.colorRed400;

  /// CSS: `--color-red-600` · axis: color
  CsColor get colorRed600 => colorTokens.colorRed600;

  /// CSS: `--color-red-900` · axis: color
  CsColor get colorRed900 => colorTokens.colorRed900;

  /// CSS: `--color-red-1000` · axis: color
  CsColor get colorRed1000 => colorTokens.colorRed1000;

  /// CSS: `--color-yellow-50` · axis: color
  CsColor get colorYellow50 => colorTokens.colorYellow50;

  /// CSS: `--color-yellow-400` · axis: color
  CsColor get colorYellow400 => colorTokens.colorYellow400;

  /// CSS: `--color-yellow-500` · axis: color
  CsColor get colorYellow500 => colorTokens.colorYellow500;

  /// CSS: `--color-yellow-900` · axis: color
  CsColor get colorYellow900 => colorTokens.colorYellow900;

  /// CSS: `--color-yellow-1000` · axis: color
  CsColor get colorYellow1000 => colorTokens.colorYellow1000;

  /// CSS: `--color-purple-400` · axis: color
  CsColor get colorPurple400 => colorTokens.colorPurple400;

  /// CSS: `--color-purple-700` · axis: color
  CsColor get colorPurple700 => colorTokens.colorPurple700;

  /// CSS: `--color-amber-400` · axis: color
  CsColor get colorAmber400 => colorTokens.colorAmber400;

  /// CSS: `--color-amber-500` · axis: color
  CsColor get colorAmber500 => colorTokens.colorAmber500;

  /// CSS: `--color-red-950` · axis: color
  CsColor get colorRed950 => colorTokens.colorRed950;

  /// CSS: `--color-orange-50` · axis: color
  CsColor get colorOrange50 => colorTokens.colorOrange50;

  /// CSS: `--color-orange-100` · axis: color
  CsColor get colorOrange100 => colorTokens.colorOrange100;

  /// CSS: `--color-orange-400` · axis: color
  CsColor get colorOrange400 => colorTokens.colorOrange400;

  /// CSS: `--color-orange-700` · axis: color
  CsColor get colorOrange700 => colorTokens.colorOrange700;

  /// CSS: `--color-orange-800` · axis: color
  CsColor get colorOrange800 => colorTokens.colorOrange800;

  /// CSS: `--color-orange-950` · axis: color
  CsColor get colorOrange950 => colorTokens.colorOrange950;

  /// CSS: `--color-yellow-600` · axis: color
  CsColor get colorYellow600 => colorTokens.colorYellow600;

  /// CSS: `--color-yellow-950` · axis: color
  CsColor get colorYellow950 => colorTokens.colorYellow950;

  /// CSS: `--color-lime-50` · axis: color
  CsColor get colorLime50 => colorTokens.colorLime50;

  /// CSS: `--color-lime-100` · axis: color
  CsColor get colorLime100 => colorTokens.colorLime100;

  /// CSS: `--color-lime-400` · axis: color
  CsColor get colorLime400 => colorTokens.colorLime400;

  /// CSS: `--color-lime-700` · axis: color
  CsColor get colorLime700 => colorTokens.colorLime700;

  /// CSS: `--color-lime-800` · axis: color
  CsColor get colorLime800 => colorTokens.colorLime800;

  /// CSS: `--color-lime-950` · axis: color
  CsColor get colorLime950 => colorTokens.colorLime950;

  /// CSS: `--color-green-400` · axis: color
  CsColor get colorGreen400 => colorTokens.colorGreen400;

  /// CSS: `--color-green-950` · axis: color
  CsColor get colorGreen950 => colorTokens.colorGreen950;

  /// CSS: `--color-mint-50` · axis: color
  CsColor get colorMint50 => colorTokens.colorMint50;

  /// CSS: `--color-mint-100` · axis: color
  CsColor get colorMint100 => colorTokens.colorMint100;

  /// CSS: `--color-mint-400` · axis: color
  CsColor get colorMint400 => colorTokens.colorMint400;

  /// CSS: `--color-mint-700` · axis: color
  CsColor get colorMint700 => colorTokens.colorMint700;

  /// CSS: `--color-mint-800` · axis: color
  CsColor get colorMint800 => colorTokens.colorMint800;

  /// CSS: `--color-mint-950` · axis: color
  CsColor get colorMint950 => colorTokens.colorMint950;

  /// CSS: `--color-indigo-50` · axis: color
  CsColor get colorIndigo50 => colorTokens.colorIndigo50;

  /// CSS: `--color-indigo-400` · axis: color
  CsColor get colorIndigo400 => colorTokens.colorIndigo400;

  /// CSS: `--color-indigo-600` · axis: color
  CsColor get colorIndigo600 => colorTokens.colorIndigo600;

  /// CSS: `--color-indigo-950` · axis: color
  CsColor get colorIndigo950 => colorTokens.colorIndigo950;

  /// CSS: `--color-purple-50` · axis: color
  CsColor get colorPurple50 => colorTokens.colorPurple50;

  /// CSS: `--color-purple-100` · axis: color
  CsColor get colorPurple100 => colorTokens.colorPurple100;

  /// CSS: `--color-purple-600` · axis: color
  CsColor get colorPurple600 => colorTokens.colorPurple600;

  /// CSS: `--color-purple-800` · axis: color
  CsColor get colorPurple800 => colorTokens.colorPurple800;

  /// CSS: `--color-purple-950` · axis: color
  CsColor get colorPurple950 => colorTokens.colorPurple950;

  /// CSS: `--color-teal-50` · axis: color
  CsColor get colorTeal50 => colorTokens.colorTeal50;

  /// CSS: `--color-teal-100` · axis: color
  CsColor get colorTeal100 => colorTokens.colorTeal100;

  /// CSS: `--color-teal-400` · axis: color
  CsColor get colorTeal400 => colorTokens.colorTeal400;

  /// CSS: `--color-teal-700` · axis: color
  CsColor get colorTeal700 => colorTokens.colorTeal700;

  /// CSS: `--color-teal-800` · axis: color
  CsColor get colorTeal800 => colorTokens.colorTeal800;

  /// CSS: `--color-teal-950` · axis: color
  CsColor get colorTeal950 => colorTokens.colorTeal950;

  /// CSS: `--color-cyan-50` · axis: color
  CsColor get colorCyan50 => colorTokens.colorCyan50;

  /// CSS: `--color-cyan-100` · axis: color
  CsColor get colorCyan100 => colorTokens.colorCyan100;

  /// CSS: `--color-cyan-400` · axis: color
  CsColor get colorCyan400 => colorTokens.colorCyan400;

  /// CSS: `--color-cyan-700` · axis: color
  CsColor get colorCyan700 => colorTokens.colorCyan700;

  /// CSS: `--color-cyan-800` · axis: color
  CsColor get colorCyan800 => colorTokens.colorCyan800;

  /// CSS: `--color-cyan-950` · axis: color
  CsColor get colorCyan950 => colorTokens.colorCyan950;

  /// CSS: `--color-blue-950` · axis: color
  CsColor get colorBlue950 => colorTokens.colorBlue950;

  /// CSS: `--color-violet-50` · axis: color
  CsColor get colorViolet50 => colorTokens.colorViolet50;

  /// CSS: `--color-violet-100` · axis: color
  CsColor get colorViolet100 => colorTokens.colorViolet100;

  /// CSS: `--color-violet-400` · axis: color
  CsColor get colorViolet400 => colorTokens.colorViolet400;

  /// CSS: `--color-violet-700` · axis: color
  CsColor get colorViolet700 => colorTokens.colorViolet700;

  /// CSS: `--color-violet-800` · axis: color
  CsColor get colorViolet800 => colorTokens.colorViolet800;

  /// CSS: `--color-violet-950` · axis: color
  CsColor get colorViolet950 => colorTokens.colorViolet950;

  /// CSS: `--color-fuchsia-50` · axis: color
  CsColor get colorFuchsia50 => colorTokens.colorFuchsia50;

  /// CSS: `--color-fuchsia-100` · axis: color
  CsColor get colorFuchsia100 => colorTokens.colorFuchsia100;

  /// CSS: `--color-fuchsia-400` · axis: color
  CsColor get colorFuchsia400 => colorTokens.colorFuchsia400;

  /// CSS: `--color-fuchsia-700` · axis: color
  CsColor get colorFuchsia700 => colorTokens.colorFuchsia700;

  /// CSS: `--color-fuchsia-800` · axis: color
  CsColor get colorFuchsia800 => colorTokens.colorFuchsia800;

  /// CSS: `--color-fuchsia-950` · axis: color
  CsColor get colorFuchsia950 => colorTokens.colorFuchsia950;

  /// CSS: `--color-magenta-50` · axis: color
  CsColor get colorMagenta50 => colorTokens.colorMagenta50;

  /// CSS: `--color-magenta-100` · axis: color
  CsColor get colorMagenta100 => colorTokens.colorMagenta100;

  /// CSS: `--color-magenta-400` · axis: color
  CsColor get colorMagenta400 => colorTokens.colorMagenta400;

  /// CSS: `--color-magenta-700` · axis: color
  CsColor get colorMagenta700 => colorTokens.colorMagenta700;

  /// CSS: `--color-magenta-800` · axis: color
  CsColor get colorMagenta800 => colorTokens.colorMagenta800;

  /// CSS: `--color-magenta-950` · axis: color
  CsColor get colorMagenta950 => colorTokens.colorMagenta950;

  /// CSS: `--color-pink-50` · axis: color
  CsColor get colorPink50 => colorTokens.colorPink50;

  /// CSS: `--color-pink-100` · axis: color
  CsColor get colorPink100 => colorTokens.colorPink100;

  /// CSS: `--color-pink-400` · axis: color
  CsColor get colorPink400 => colorTokens.colorPink400;

  /// CSS: `--color-pink-700` · axis: color
  CsColor get colorPink700 => colorTokens.colorPink700;

  /// CSS: `--color-pink-800` · axis: color
  CsColor get colorPink800 => colorTokens.colorPink800;

  /// CSS: `--color-pink-950` · axis: color
  CsColor get colorPink950 => colorTokens.colorPink950;

  /// CSS: `--color-rose-50` · axis: color
  CsColor get colorRose50 => colorTokens.colorRose50;

  /// CSS: `--color-rose-100` · axis: color
  CsColor get colorRose100 => colorTokens.colorRose100;

  /// CSS: `--color-rose-400` · axis: color
  CsColor get colorRose400 => colorTokens.colorRose400;

  /// CSS: `--color-rose-700` · axis: color
  CsColor get colorRose700 => colorTokens.colorRose700;

  /// CSS: `--color-rose-800` · axis: color
  CsColor get colorRose800 => colorTokens.colorRose800;

  /// CSS: `--color-rose-950` · axis: color
  CsColor get colorRose950 => colorTokens.colorRose950;

  /// CSS: `--color-amber-50` · axis: color
  CsColor get colorAmber50 => colorTokens.colorAmber50;

  /// CSS: `--color-amber-100` · axis: color
  CsColor get colorAmber100 => colorTokens.colorAmber100;

  /// CSS: `--color-amber-700` · axis: color
  CsColor get colorAmber700 => colorTokens.colorAmber700;

  /// CSS: `--color-amber-800` · axis: color
  CsColor get colorAmber800 => colorTokens.colorAmber800;

  /// CSS: `--color-amber-950` · axis: color
  CsColor get colorAmber950 => colorTokens.colorAmber950;

  /// CSS: `--color-aws-squid-ink` · axis: color
  CsColor get colorAwsSquidInk => colorTokens.colorAwsSquidInk;

  /// CSS: `--color-transparent` · axis: color
  CsColor get colorTransparent => colorTokens.colorTransparent;

  /// CSS: `--color-black` · axis: color
  CsColor get colorBlack => colorTokens.colorBlack;

  /// CSS: `--color-white` · axis: color
  CsColor get colorWhite => colorTokens.colorWhite;

  /// Color from the 'red' data visualization palette at a contrast ratio of 3:1
  ///
  /// CSS: `--color-charts-red-300` · axis: color · exposed
  CsColor get colorChartsRed300 => colorTokens.colorChartsRed300;

  /// Color from the 'red' data visualization palette at a contrast ratio of 4:1
  ///
  /// CSS: `--color-charts-red-400` · axis: color · exposed
  CsColor get colorChartsRed400 => colorTokens.colorChartsRed400;

  /// Color from the 'red' data visualization palette at a contrast ratio of 5:1
  ///
  /// CSS: `--color-charts-red-500` · axis: color · exposed
  CsColor get colorChartsRed500 => colorTokens.colorChartsRed500;

  /// Color from the 'red' data visualization palette at a contrast ratio of 6:1
  ///
  /// CSS: `--color-charts-red-600` · axis: color · exposed
  CsColor get colorChartsRed600 => colorTokens.colorChartsRed600;

  /// Color from the 'red' data visualization palette at a contrast ratio of 7:1
  ///
  /// CSS: `--color-charts-red-700` · axis: color · exposed
  CsColor get colorChartsRed700 => colorTokens.colorChartsRed700;

  /// Color from the 'red' data visualization palette at a contrast ratio of 8:1
  ///
  /// CSS: `--color-charts-red-800` · axis: color · exposed
  CsColor get colorChartsRed800 => colorTokens.colorChartsRed800;

  /// Color from the 'red' data visualization palette at a contrast ratio of 9:1
  ///
  /// CSS: `--color-charts-red-900` · axis: color · exposed
  CsColor get colorChartsRed900 => colorTokens.colorChartsRed900;

  /// Color from the 'red' data visualization palette at a contrast ratio of
  /// 10:1
  ///
  /// CSS: `--color-charts-red-1000` · axis: color · exposed
  CsColor get colorChartsRed1000 => colorTokens.colorChartsRed1000;

  /// Color from the 'red' data visualization palette at a contrast ratio of
  /// 11:1
  ///
  /// CSS: `--color-charts-red-1100` · axis: color · exposed
  CsColor get colorChartsRed1100 => colorTokens.colorChartsRed1100;

  /// Color from the 'red' data visualization palette at a contrast ratio of
  /// 12:1
  ///
  /// CSS: `--color-charts-red-1200` · axis: color · exposed
  CsColor get colorChartsRed1200 => colorTokens.colorChartsRed1200;

  /// Color from the 'orange' data visualization palette at a contrast ratio of
  /// 3:1
  ///
  /// CSS: `--color-charts-orange-300` · axis: color · exposed
  CsColor get colorChartsOrange300 => colorTokens.colorChartsOrange300;

  /// Color from the 'orange' data visualization palette at a contrast ratio of
  /// 4:1
  ///
  /// CSS: `--color-charts-orange-400` · axis: color · exposed
  CsColor get colorChartsOrange400 => colorTokens.colorChartsOrange400;

  /// Color from the 'orange' data visualization palette at a contrast ratio of
  /// 5:1
  ///
  /// CSS: `--color-charts-orange-500` · axis: color · exposed
  CsColor get colorChartsOrange500 => colorTokens.colorChartsOrange500;

  /// Color from the 'orange' data visualization palette at a contrast ratio of
  /// 6:1
  ///
  /// CSS: `--color-charts-orange-600` · axis: color · exposed
  CsColor get colorChartsOrange600 => colorTokens.colorChartsOrange600;

  /// Color from the 'orange' data visualization palette at a contrast ratio of
  /// 7:1
  ///
  /// CSS: `--color-charts-orange-700` · axis: color · exposed
  CsColor get colorChartsOrange700 => colorTokens.colorChartsOrange700;

  /// Color from the 'orange' data visualization palette at a contrast ratio of
  /// 8:1
  ///
  /// CSS: `--color-charts-orange-800` · axis: color · exposed
  CsColor get colorChartsOrange800 => colorTokens.colorChartsOrange800;

  /// Color from the 'orange' data visualization palette at a contrast ratio of
  /// 9:1
  ///
  /// CSS: `--color-charts-orange-900` · axis: color · exposed
  CsColor get colorChartsOrange900 => colorTokens.colorChartsOrange900;

  /// Color from the 'orange' data visualization palette at a contrast ratio of
  /// 10:1
  ///
  /// CSS: `--color-charts-orange-1000` · axis: color · exposed
  CsColor get colorChartsOrange1000 => colorTokens.colorChartsOrange1000;

  /// Color from the 'orange' data visualization palette at a contrast ratio of
  /// 11:1
  ///
  /// CSS: `--color-charts-orange-1100` · axis: color · exposed
  CsColor get colorChartsOrange1100 => colorTokens.colorChartsOrange1100;

  /// Color from the 'orange' data visualization palette at a contrast ratio of
  /// 12:1
  ///
  /// CSS: `--color-charts-orange-1200` · axis: color · exposed
  CsColor get colorChartsOrange1200 => colorTokens.colorChartsOrange1200;

  /// Color from the 'yellow' data visualization palette at a contrast ratio of
  /// 3:1
  ///
  /// CSS: `--color-charts-yellow-300` · axis: color · exposed
  CsColor get colorChartsYellow300 => colorTokens.colorChartsYellow300;

  /// Color from the 'yellow' data visualization palette at a contrast ratio of
  /// 4:1
  ///
  /// CSS: `--color-charts-yellow-400` · axis: color · exposed
  CsColor get colorChartsYellow400 => colorTokens.colorChartsYellow400;

  /// Color from the 'yellow' data visualization palette at a contrast ratio of
  /// 5:1
  ///
  /// CSS: `--color-charts-yellow-500` · axis: color · exposed
  CsColor get colorChartsYellow500 => colorTokens.colorChartsYellow500;

  /// Color from the 'yellow' data visualization palette at a contrast ratio of
  /// 6:1
  ///
  /// CSS: `--color-charts-yellow-600` · axis: color · exposed
  CsColor get colorChartsYellow600 => colorTokens.colorChartsYellow600;

  /// Color from the 'yellow' data visualization palette at a contrast ratio of
  /// 7:1
  ///
  /// CSS: `--color-charts-yellow-700` · axis: color · exposed
  CsColor get colorChartsYellow700 => colorTokens.colorChartsYellow700;

  /// Color from the 'yellow' data visualization palette at a contrast ratio of
  /// 8:1
  ///
  /// CSS: `--color-charts-yellow-800` · axis: color · exposed
  CsColor get colorChartsYellow800 => colorTokens.colorChartsYellow800;

  /// Color from the 'yellow' data visualization palette at a contrast ratio of
  /// 9:1
  ///
  /// CSS: `--color-charts-yellow-900` · axis: color · exposed
  CsColor get colorChartsYellow900 => colorTokens.colorChartsYellow900;

  /// Color from the 'yellow' data visualization palette at a contrast ratio of
  /// 10:1
  ///
  /// CSS: `--color-charts-yellow-1000` · axis: color · exposed
  CsColor get colorChartsYellow1000 => colorTokens.colorChartsYellow1000;

  /// Color from the 'yellow' data visualization palette at a contrast ratio of
  /// 11:1
  ///
  /// CSS: `--color-charts-yellow-1100` · axis: color · exposed
  CsColor get colorChartsYellow1100 => colorTokens.colorChartsYellow1100;

  /// Color from the 'yellow' data visualization palette at a contrast ratio of
  /// 12:1
  ///
  /// CSS: `--color-charts-yellow-1200` · axis: color · exposed
  CsColor get colorChartsYellow1200 => colorTokens.colorChartsYellow1200;

  /// Color from the 'green' data visualization palette at a contrast ratio of
  /// 3:1
  ///
  /// CSS: `--color-charts-green-300` · axis: color · exposed
  CsColor get colorChartsGreen300 => colorTokens.colorChartsGreen300;

  /// Color from the 'green' data visualization palette at a contrast ratio of
  /// 4:1
  ///
  /// CSS: `--color-charts-green-400` · axis: color · exposed
  CsColor get colorChartsGreen400 => colorTokens.colorChartsGreen400;

  /// Color from the 'green' data visualization palette at a contrast ratio of
  /// 5:1
  ///
  /// CSS: `--color-charts-green-500` · axis: color · exposed
  CsColor get colorChartsGreen500 => colorTokens.colorChartsGreen500;

  /// Color from the 'green' data visualization palette at a contrast ratio of
  /// 6:1
  ///
  /// CSS: `--color-charts-green-600` · axis: color · exposed
  CsColor get colorChartsGreen600 => colorTokens.colorChartsGreen600;

  /// Color from the 'green' data visualization palette at a contrast ratio of
  /// 7:1
  ///
  /// CSS: `--color-charts-green-700` · axis: color · exposed
  CsColor get colorChartsGreen700 => colorTokens.colorChartsGreen700;

  /// Color from the 'green' data visualization palette at a contrast ratio of
  /// 8:1
  ///
  /// CSS: `--color-charts-green-800` · axis: color · exposed
  CsColor get colorChartsGreen800 => colorTokens.colorChartsGreen800;

  /// Color from the 'green' data visualization palette at a contrast ratio of
  /// 9:1
  ///
  /// CSS: `--color-charts-green-900` · axis: color · exposed
  CsColor get colorChartsGreen900 => colorTokens.colorChartsGreen900;

  /// Color from the 'green' data visualization palette at a contrast ratio of
  /// 10:1
  ///
  /// CSS: `--color-charts-green-1000` · axis: color · exposed
  CsColor get colorChartsGreen1000 => colorTokens.colorChartsGreen1000;

  /// Color from the 'green' data visualization palette at a contrast ratio of
  /// 11:1
  ///
  /// CSS: `--color-charts-green-1100` · axis: color · exposed
  CsColor get colorChartsGreen1100 => colorTokens.colorChartsGreen1100;

  /// Color from the 'green' data visualization palette at a contrast ratio of
  /// 12:1
  ///
  /// CSS: `--color-charts-green-1200` · axis: color · exposed
  CsColor get colorChartsGreen1200 => colorTokens.colorChartsGreen1200;

  /// Color from the 'teal' data visualization palette at a contrast ratio of
  /// 3:1
  ///
  /// CSS: `--color-charts-teal-300` · axis: color · exposed
  CsColor get colorChartsTeal300 => colorTokens.colorChartsTeal300;

  /// Color from the 'teal' data visualization palette at a contrast ratio of
  /// 4:1
  ///
  /// CSS: `--color-charts-teal-400` · axis: color · exposed
  CsColor get colorChartsTeal400 => colorTokens.colorChartsTeal400;

  /// Color from the 'teal' data visualization palette at a contrast ratio of
  /// 5:1
  ///
  /// CSS: `--color-charts-teal-500` · axis: color · exposed
  CsColor get colorChartsTeal500 => colorTokens.colorChartsTeal500;

  /// Color from the 'teal' data visualization palette at a contrast ratio of
  /// 6:1
  ///
  /// CSS: `--color-charts-teal-600` · axis: color · exposed
  CsColor get colorChartsTeal600 => colorTokens.colorChartsTeal600;

  /// Color from the 'teal' data visualization palette at a contrast ratio of
  /// 7:1
  ///
  /// CSS: `--color-charts-teal-700` · axis: color · exposed
  CsColor get colorChartsTeal700 => colorTokens.colorChartsTeal700;

  /// Color from the 'teal' data visualization palette at a contrast ratio of
  /// 8:1
  ///
  /// CSS: `--color-charts-teal-800` · axis: color · exposed
  CsColor get colorChartsTeal800 => colorTokens.colorChartsTeal800;

  /// Color from the 'teal' data visualization palette at a contrast ratio of
  /// 9:1
  ///
  /// CSS: `--color-charts-teal-900` · axis: color · exposed
  CsColor get colorChartsTeal900 => colorTokens.colorChartsTeal900;

  /// Color from the 'teal' data visualization palette at a contrast ratio of
  /// 10:1
  ///
  /// CSS: `--color-charts-teal-1000` · axis: color · exposed
  CsColor get colorChartsTeal1000 => colorTokens.colorChartsTeal1000;

  /// Color from the 'teal' data visualization palette at a contrast ratio of
  /// 11:1
  ///
  /// CSS: `--color-charts-teal-1100` · axis: color · exposed
  CsColor get colorChartsTeal1100 => colorTokens.colorChartsTeal1100;

  /// Color from the 'teal' data visualization palette at a contrast ratio of
  /// 12:1
  ///
  /// CSS: `--color-charts-teal-1200` · axis: color · exposed
  CsColor get colorChartsTeal1200 => colorTokens.colorChartsTeal1200;

  /// Color from the 'blue-1' data visualization palette at a contrast ratio of
  /// 3:1
  ///
  /// CSS: `--color-charts-blue-1-300` · axis: color · exposed
  CsColor get colorChartsBlue1300 => colorTokens.colorChartsBlue1300;

  /// Color from the 'blue-1' data visualization palette at a contrast ratio of
  /// 4:1
  ///
  /// CSS: `--color-charts-blue-1-400` · axis: color · exposed
  CsColor get colorChartsBlue1400 => colorTokens.colorChartsBlue1400;

  /// Color from the 'blue-1' data visualization palette at a contrast ratio of
  /// 5:1
  ///
  /// CSS: `--color-charts-blue-1-500` · axis: color · exposed
  CsColor get colorChartsBlue1500 => colorTokens.colorChartsBlue1500;

  /// Color from the 'blue-1' data visualization palette at a contrast ratio of
  /// 6:1
  ///
  /// CSS: `--color-charts-blue-1-600` · axis: color · exposed
  CsColor get colorChartsBlue1600 => colorTokens.colorChartsBlue1600;

  /// Color from the 'blue-1' data visualization palette at a contrast ratio of
  /// 7:1
  ///
  /// CSS: `--color-charts-blue-1-700` · axis: color · exposed
  CsColor get colorChartsBlue1700 => colorTokens.colorChartsBlue1700;

  /// Color from the 'blue-1' data visualization palette at a contrast ratio of
  /// 8:1
  ///
  /// CSS: `--color-charts-blue-1-800` · axis: color · exposed
  CsColor get colorChartsBlue1800 => colorTokens.colorChartsBlue1800;

  /// Color from the 'blue-1' data visualization palette at a contrast ratio of
  /// 9:1
  ///
  /// CSS: `--color-charts-blue-1-900` · axis: color · exposed
  CsColor get colorChartsBlue1900 => colorTokens.colorChartsBlue1900;

  /// Color from the 'blue-1' data visualization palette at a contrast ratio of
  /// 10:1
  ///
  /// CSS: `--color-charts-blue-1-1000` · axis: color · exposed
  CsColor get colorChartsBlue11000 => colorTokens.colorChartsBlue11000;

  /// Color from the 'blue-1' data visualization palette at a contrast ratio of
  /// 11:1
  ///
  /// CSS: `--color-charts-blue-1-1100` · axis: color · exposed
  CsColor get colorChartsBlue11100 => colorTokens.colorChartsBlue11100;

  /// Color from the 'blue-1' data visualization palette at a contrast ratio of
  /// 12:1
  ///
  /// CSS: `--color-charts-blue-1-1200` · axis: color · exposed
  CsColor get colorChartsBlue11200 => colorTokens.colorChartsBlue11200;

  /// Color from the 'blue-2' data visualization palette at a contrast ratio of
  /// 3:1
  ///
  /// CSS: `--color-charts-blue-2-300` · axis: color · exposed
  CsColor get colorChartsBlue2300 => colorTokens.colorChartsBlue2300;

  /// Color from the 'blue-2' data visualization palette at a contrast ratio of
  /// 4:1
  ///
  /// CSS: `--color-charts-blue-2-400` · axis: color · exposed
  CsColor get colorChartsBlue2400 => colorTokens.colorChartsBlue2400;

  /// Color from the 'blue-2' data visualization palette at a contrast ratio of
  /// 5:1
  ///
  /// CSS: `--color-charts-blue-2-500` · axis: color · exposed
  CsColor get colorChartsBlue2500 => colorTokens.colorChartsBlue2500;

  /// Color from the 'blue-2' data visualization palette at a contrast ratio of
  /// 6:1
  ///
  /// CSS: `--color-charts-blue-2-600` · axis: color · exposed
  CsColor get colorChartsBlue2600 => colorTokens.colorChartsBlue2600;

  /// Color from the 'blue-2' data visualization palette at a contrast ratio of
  /// 7:1
  ///
  /// CSS: `--color-charts-blue-2-700` · axis: color · exposed
  CsColor get colorChartsBlue2700 => colorTokens.colorChartsBlue2700;

  /// Color from the 'blue-2' data visualization palette at a contrast ratio of
  /// 8:1
  ///
  /// CSS: `--color-charts-blue-2-800` · axis: color · exposed
  CsColor get colorChartsBlue2800 => colorTokens.colorChartsBlue2800;

  /// Color from the 'blue-2' data visualization palette at a contrast ratio of
  /// 9:1
  ///
  /// CSS: `--color-charts-blue-2-900` · axis: color · exposed
  CsColor get colorChartsBlue2900 => colorTokens.colorChartsBlue2900;

  /// Color from the 'blue-2' data visualization palette at a contrast ratio of
  /// 10:1
  ///
  /// CSS: `--color-charts-blue-2-1000` · axis: color · exposed
  CsColor get colorChartsBlue21000 => colorTokens.colorChartsBlue21000;

  /// Color from the 'blue-2' data visualization palette at a contrast ratio of
  /// 11:1
  ///
  /// CSS: `--color-charts-blue-2-1100` · axis: color · exposed
  CsColor get colorChartsBlue21100 => colorTokens.colorChartsBlue21100;

  /// Color from the 'blue-2' data visualization palette at a contrast ratio of
  /// 12:1
  ///
  /// CSS: `--color-charts-blue-2-1200` · axis: color · exposed
  CsColor get colorChartsBlue21200 => colorTokens.colorChartsBlue21200;

  /// Color from the 'purple' data visualization palette at a contrast ratio of
  /// 3:1
  ///
  /// CSS: `--color-charts-purple-300` · axis: color · exposed
  CsColor get colorChartsPurple300 => colorTokens.colorChartsPurple300;

  /// Color from the 'purple' data visualization palette at a contrast ratio of
  /// 4:1
  ///
  /// CSS: `--color-charts-purple-400` · axis: color · exposed
  CsColor get colorChartsPurple400 => colorTokens.colorChartsPurple400;

  /// Color from the 'purple' data visualization palette at a contrast ratio of
  /// 5:1
  ///
  /// CSS: `--color-charts-purple-500` · axis: color · exposed
  CsColor get colorChartsPurple500 => colorTokens.colorChartsPurple500;

  /// Color from the 'purple' data visualization palette at a contrast ratio of
  /// 6:1
  ///
  /// CSS: `--color-charts-purple-600` · axis: color · exposed
  CsColor get colorChartsPurple600 => colorTokens.colorChartsPurple600;

  /// Color from the 'purple' data visualization palette at a contrast ratio of
  /// 7:1
  ///
  /// CSS: `--color-charts-purple-700` · axis: color · exposed
  CsColor get colorChartsPurple700 => colorTokens.colorChartsPurple700;

  /// Color from the 'purple' data visualization palette at a contrast ratio of
  /// 8:1
  ///
  /// CSS: `--color-charts-purple-800` · axis: color · exposed
  CsColor get colorChartsPurple800 => colorTokens.colorChartsPurple800;

  /// Color from the 'purple' data visualization palette at a contrast ratio of
  /// 9:1
  ///
  /// CSS: `--color-charts-purple-900` · axis: color · exposed
  CsColor get colorChartsPurple900 => colorTokens.colorChartsPurple900;

  /// Color from the 'purple' data visualization palette at a contrast ratio of
  /// 10:1
  ///
  /// CSS: `--color-charts-purple-1000` · axis: color · exposed
  CsColor get colorChartsPurple1000 => colorTokens.colorChartsPurple1000;

  /// Color from the 'purple' data visualization palette at a contrast ratio of
  /// 11:1
  ///
  /// CSS: `--color-charts-purple-1100` · axis: color · exposed
  CsColor get colorChartsPurple1100 => colorTokens.colorChartsPurple1100;

  /// Color from the 'purple' data visualization palette at a contrast ratio of
  /// 12:1
  ///
  /// CSS: `--color-charts-purple-1200` · axis: color · exposed
  CsColor get colorChartsPurple1200 => colorTokens.colorChartsPurple1200;

  /// Color from the 'pink' data visualization palette at a contrast ratio of
  /// 3:1
  ///
  /// CSS: `--color-charts-pink-300` · axis: color · exposed
  CsColor get colorChartsPink300 => colorTokens.colorChartsPink300;

  /// Color from the 'pink' data visualization palette at a contrast ratio of
  /// 4:1
  ///
  /// CSS: `--color-charts-pink-400` · axis: color · exposed
  CsColor get colorChartsPink400 => colorTokens.colorChartsPink400;

  /// Color from the 'pink' data visualization palette at a contrast ratio of
  /// 5:1
  ///
  /// CSS: `--color-charts-pink-500` · axis: color · exposed
  CsColor get colorChartsPink500 => colorTokens.colorChartsPink500;

  /// Color from the 'pink' data visualization palette at a contrast ratio of
  /// 6:1
  ///
  /// CSS: `--color-charts-pink-600` · axis: color · exposed
  CsColor get colorChartsPink600 => colorTokens.colorChartsPink600;

  /// Color from the 'pink' data visualization palette at a contrast ratio of
  /// 7:1
  ///
  /// CSS: `--color-charts-pink-700` · axis: color · exposed
  CsColor get colorChartsPink700 => colorTokens.colorChartsPink700;

  /// Color from the 'pink' data visualization palette at a contrast ratio of
  /// 8:1
  ///
  /// CSS: `--color-charts-pink-800` · axis: color · exposed
  CsColor get colorChartsPink800 => colorTokens.colorChartsPink800;

  /// Color from the 'pink' data visualization palette at a contrast ratio of
  /// 9:1
  ///
  /// CSS: `--color-charts-pink-900` · axis: color · exposed
  CsColor get colorChartsPink900 => colorTokens.colorChartsPink900;

  /// Color from the 'pink' data visualization palette at a contrast ratio of
  /// 10:1
  ///
  /// CSS: `--color-charts-pink-1000` · axis: color · exposed
  CsColor get colorChartsPink1000 => colorTokens.colorChartsPink1000;

  /// Color from the 'pink' data visualization palette at a contrast ratio of
  /// 11:1
  ///
  /// CSS: `--color-charts-pink-1100` · axis: color · exposed
  CsColor get colorChartsPink1100 => colorTokens.colorChartsPink1100;

  /// Color from the 'pink' data visualization palette at a contrast ratio of
  /// 12:1
  ///
  /// CSS: `--color-charts-pink-1200` · axis: color · exposed
  CsColor get colorChartsPink1200 => colorTokens.colorChartsPink1200;

  /// Color to represent a critical error or a critically high-level of
  /// severity. For example: "Sev-1"
  ///
  /// CSS: `--color-charts-status-critical` · axis: color · themeable · exposed
  CsColor get colorChartsStatusCritical =>
      colorTokens.colorChartsStatusCritical;

  /// Color to represent an error status or a high-level of severity. Use this
  /// color to represent a default error status when there is only one
  /// applicable to a chart. For example: "Failed" or "Sev-2"
  ///
  /// CSS: `--color-charts-status-high` · axis: color · themeable · exposed
  CsColor get colorChartsStatusHigh => colorTokens.colorChartsStatusHigh;

  /// Color to represent a medium-level of severity. For example: "Sev-3"
  ///
  /// CSS: `--color-charts-status-medium` · axis: color · themeable · exposed
  CsColor get colorChartsStatusMedium => colorTokens.colorChartsStatusMedium;

  /// Color to represent a warning or a low-level of severity. For example:
  /// "Warning" or "Sev-4"
  ///
  /// CSS: `--color-charts-status-low` · axis: color · themeable · exposed
  CsColor get colorChartsStatusLow => colorTokens.colorChartsStatusLow;

  /// Color to represent a positive status. *For example: "Success" or "Running"
  ///
  /// CSS: `--color-charts-status-positive` · axis: color · themeable · exposed
  CsColor get colorChartsStatusPositive =>
      colorTokens.colorChartsStatusPositive;

  /// Color to represent an informational status. For example: "In-progress" or
  /// "Updating"
  ///
  /// CSS: `--color-charts-status-info` · axis: color · themeable · exposed
  CsColor get colorChartsStatusInfo => colorTokens.colorChartsStatusInfo;

  /// Color to represent a neutral status, a severity level of no impact, or the
  /// lowest-level of severity. For example: "Pending" or "Sev-5"
  ///
  /// CSS: `--color-charts-status-neutral` · axis: color · themeable · exposed
  CsColor get colorChartsStatusNeutral => colorTokens.colorChartsStatusNeutral;

  /// The color to represent a threshold with a negative outcome. For example: A
  /// maximum limit
  ///
  /// CSS: `--color-charts-threshold-negative` · axis: color · themeable · exposed
  CsColor get colorChartsThresholdNegative =>
      colorTokens.colorChartsThresholdNegative;

  /// The color to represent a threshold with a positive outcome. For example: A
  /// designated pass rate
  ///
  /// CSS: `--color-charts-threshold-positive` · axis: color · themeable · exposed
  CsColor get colorChartsThresholdPositive =>
      colorTokens.colorChartsThresholdPositive;

  /// The color to represent an informational threshold to highlight special
  /// circumstances that may have or will occur. For example: A forecasted
  /// estimate
  ///
  /// CSS: `--color-charts-threshold-info` · axis: color · themeable · exposed
  CsColor get colorChartsThresholdInfo => colorTokens.colorChartsThresholdInfo;

  /// The color to represent a threshold with a neutral outcome. For example: An
  /// average or baseline
  ///
  /// CSS: `--color-charts-threshold-neutral` · axis: color · themeable · exposed
  CsColor get colorChartsThresholdNeutral =>
      colorTokens.colorChartsThresholdNeutral;

  /// Color of the grid lines in a chart.
  ///
  /// CSS: `--color-charts-line-grid` · axis: color · exposed
  CsColor get colorChartsLineGrid => colorTokens.colorChartsLineGrid;

  /// Color of the tick marks in a chart.
  ///
  /// CSS: `--color-charts-line-tick` · axis: color · exposed
  CsColor get colorChartsLineTick => colorTokens.colorChartsLineTick;

  /// Color of the axis lines in a chart.
  ///
  /// CSS: `--color-charts-line-axis` · axis: color · exposed
  CsColor get colorChartsLineAxis => colorTokens.colorChartsLineAxis;

  /// Color #1 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-1` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical1 =>
      colorTokens.colorChartsPaletteCategorical1;

  /// Color #2 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-2` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical2 =>
      colorTokens.colorChartsPaletteCategorical2;

  /// Color #3 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-3` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical3 =>
      colorTokens.colorChartsPaletteCategorical3;

  /// Color #4 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-4` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical4 =>
      colorTokens.colorChartsPaletteCategorical4;

  /// Color #5 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-5` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical5 =>
      colorTokens.colorChartsPaletteCategorical5;

  /// Color #6 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-6` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical6 =>
      colorTokens.colorChartsPaletteCategorical6;

  /// Color #7 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-7` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical7 =>
      colorTokens.colorChartsPaletteCategorical7;

  /// Color #8 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-8` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical8 =>
      colorTokens.colorChartsPaletteCategorical8;

  /// Color #9 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-9` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical9 =>
      colorTokens.colorChartsPaletteCategorical9;

  /// Color #10 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-10` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical10 =>
      colorTokens.colorChartsPaletteCategorical10;

  /// Color #11 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-11` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical11 =>
      colorTokens.colorChartsPaletteCategorical11;

  /// Color #12 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-12` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical12 =>
      colorTokens.colorChartsPaletteCategorical12;

  /// Color #13 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-13` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical13 =>
      colorTokens.colorChartsPaletteCategorical13;

  /// Color #14 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-14` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical14 =>
      colorTokens.colorChartsPaletteCategorical14;

  /// Color #15 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-15` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical15 =>
      colorTokens.colorChartsPaletteCategorical15;

  /// Color #16 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-16` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical16 =>
      colorTokens.colorChartsPaletteCategorical16;

  /// Color #17 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-17` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical17 =>
      colorTokens.colorChartsPaletteCategorical17;

  /// Color #18 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-18` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical18 =>
      colorTokens.colorChartsPaletteCategorical18;

  /// Color #19 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-19` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical19 =>
      colorTokens.colorChartsPaletteCategorical19;

  /// Color #20 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-20` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical20 =>
      colorTokens.colorChartsPaletteCategorical20;

  /// Color #21 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-21` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical21 =>
      colorTokens.colorChartsPaletteCategorical21;

  /// Color #22 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-22` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical22 =>
      colorTokens.colorChartsPaletteCategorical22;

  /// Color #23 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-23` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical23 =>
      colorTokens.colorChartsPaletteCategorical23;

  /// Color #24 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-24` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical24 =>
      colorTokens.colorChartsPaletteCategorical24;

  /// Color #25 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-25` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical25 =>
      colorTokens.colorChartsPaletteCategorical25;

  /// Color #26 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-26` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical26 =>
      colorTokens.colorChartsPaletteCategorical26;

  /// Color #27 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-27` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical27 =>
      colorTokens.colorChartsPaletteCategorical27;

  /// Color #28 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-28` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical28 =>
      colorTokens.colorChartsPaletteCategorical28;

  /// Color #29 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-29` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical29 =>
      colorTokens.colorChartsPaletteCategorical29;

  /// Color #30 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-30` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical30 =>
      colorTokens.colorChartsPaletteCategorical30;

  /// Color #31 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-31` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical31 =>
      colorTokens.colorChartsPaletteCategorical31;

  /// Color #32 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-32` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical32 =>
      colorTokens.colorChartsPaletteCategorical32;

  /// Color #33 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-33` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical33 =>
      colorTokens.colorChartsPaletteCategorical33;

  /// Color #34 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-34` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical34 =>
      colorTokens.colorChartsPaletteCategorical34;

  /// Color #35 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-35` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical35 =>
      colorTokens.colorChartsPaletteCategorical35;

  /// Color #36 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-36` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical36 =>
      colorTokens.colorChartsPaletteCategorical36;

  /// Color #37 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-37` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical37 =>
      colorTokens.colorChartsPaletteCategorical37;

  /// Color #38 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-38` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical38 =>
      colorTokens.colorChartsPaletteCategorical38;

  /// Color #39 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-39` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical39 =>
      colorTokens.colorChartsPaletteCategorical39;

  /// Color #40 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-40` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical40 =>
      colorTokens.colorChartsPaletteCategorical40;

  /// Color #41 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-41` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical41 =>
      colorTokens.colorChartsPaletteCategorical41;

  /// Color #42 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-42` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical42 =>
      colorTokens.colorChartsPaletteCategorical42;

  /// Color #43 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-43` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical43 =>
      colorTokens.colorChartsPaletteCategorical43;

  /// Color #44 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-44` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical44 =>
      colorTokens.colorChartsPaletteCategorical44;

  /// Color #45 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-45` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical45 =>
      colorTokens.colorChartsPaletteCategorical45;

  /// Color #46 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-46` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical46 =>
      colorTokens.colorChartsPaletteCategorical46;

  /// Color #47 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-47` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical47 =>
      colorTokens.colorChartsPaletteCategorical47;

  /// Color #48 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-48` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical48 =>
      colorTokens.colorChartsPaletteCategorical48;

  /// Color #49 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-49` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical49 =>
      colorTokens.colorChartsPaletteCategorical49;

  /// Color #50 on the categorical data visualization palette.
  ///
  /// CSS: `--color-charts-palette-categorical-50` · axis: color · themeable · exposed
  CsColor get colorChartsPaletteCategorical50 =>
      colorTokens.colorChartsPaletteCategorical50;

  /// Color for the error bar marker in charts.
  ///
  /// CSS: `--color-charts-error-bar-marker` · axis: color · themeable · exposed
  CsColor get colorChartsErrorBarMarker =>
      colorTokens.colorChartsErrorBarMarker;

  /// CSS: `--color-severity-dark-red` · axis: color
  CsColor get colorSeverityDarkRed => colorTokens.colorSeverityDarkRed;

  /// CSS: `--color-severity-red` · axis: color
  CsColor get colorSeverityRed => colorTokens.colorSeverityRed;

  /// CSS: `--color-severity-orange` · axis: color
  CsColor get colorSeverityOrange => colorTokens.colorSeverityOrange;

  /// CSS: `--color-severity-yellow` · axis: color
  CsColor get colorSeverityYellow => colorTokens.colorSeverityYellow;

  /// CSS: `--color-severity-grey` · axis: color
  CsColor get colorSeverityGrey => colorTokens.colorSeverityGrey;

  /// Background color in a notification to represent a critical error or a
  /// critically high-level of severity. For example: "Sev-1"
  ///
  /// CSS: `--color-background-notification-severity-critical` · axis: color · themeable · exposed
  CsColor get colorBackgroundNotificationSeverityCritical =>
      colorTokens.colorBackgroundNotificationSeverityCritical;

  /// Background color in a notification to represent an error status or a
  /// high-level of severity. For example: "Failed" or "Sev-2"
  ///
  /// CSS: `--color-background-notification-severity-high` · axis: color · themeable · exposed
  CsColor get colorBackgroundNotificationSeverityHigh =>
      colorTokens.colorBackgroundNotificationSeverityHigh;

  /// Background color in a notification to represent a medium-level of
  /// severity. For example: "Sev-3"
  ///
  /// CSS: `--color-background-notification-severity-medium` · axis: color · themeable · exposed
  CsColor get colorBackgroundNotificationSeverityMedium =>
      colorTokens.colorBackgroundNotificationSeverityMedium;

  /// Background color in a notification to represent a warning or a low-level
  /// of severity. For example: "Warning" or "Sev-4"
  ///
  /// CSS: `--color-background-notification-severity-low` · axis: color · themeable · exposed
  CsColor get colorBackgroundNotificationSeverityLow =>
      colorTokens.colorBackgroundNotificationSeverityLow;

  /// Background color in a notification to represent a neutral status, a
  /// severity level of no impact, or the lowest-level of severity. For example:
  /// "Pending" or "Sev-5"
  ///
  /// CSS: `--color-background-notification-severity-neutral` · axis: color · themeable · exposed
  CsColor get colorBackgroundNotificationSeverityNeutral =>
      colorTokens.colorBackgroundNotificationSeverityNeutral;

  /// Text color in a notification to represent a critical error or a critically
  /// high-level of severity. For example: "Sev-1"
  ///
  /// CSS: `--color-text-notification-severity-critical` · axis: color · themeable · exposed
  CsColor get colorTextNotificationSeverityCritical =>
      colorTokens.colorTextNotificationSeverityCritical;

  /// Text color in a notification to represent an error status or a high-level
  /// of severity. For example: "Failed" or "Sev-2"
  ///
  /// CSS: `--color-text-notification-severity-high` · axis: color · themeable · exposed
  CsColor get colorTextNotificationSeverityHigh =>
      colorTokens.colorTextNotificationSeverityHigh;

  /// Text color in a notification to represent a medium-level of severity. For
  /// example: "Sev-3"
  ///
  /// CSS: `--color-text-notification-severity-medium` · axis: color · themeable · exposed
  CsColor get colorTextNotificationSeverityMedium =>
      colorTokens.colorTextNotificationSeverityMedium;

  /// Text color in a notification to represent a warning or a low-level of
  /// severity. For example: "Warning" or "Sev-4"
  ///
  /// CSS: `--color-text-notification-severity-low` · axis: color · themeable · exposed
  CsColor get colorTextNotificationSeverityLow =>
      colorTokens.colorTextNotificationSeverityLow;

  /// Text color in a notification to represent a neutral status, a severity
  /// level of no impact, or the lowest-level of severity. For example:
  /// "Pending" or "Sev-5"
  ///
  /// CSS: `--color-text-notification-severity-neutral` · axis: color · themeable · exposed
  CsColor get colorTextNotificationSeverityNeutral =>
      colorTokens.colorTextNotificationSeverityNeutral;

  /// The border color of badges representing a critical severity level.
  ///
  /// CSS: `--color-border-badge-severity-critical` · axis: color · themeable · exposed
  CsColor get colorBorderBadgeSeverityCritical =>
      colorTokens.colorBorderBadgeSeverityCritical;

  /// The border color of badges representing a high severity level.
  ///
  /// CSS: `--color-border-badge-severity-high` · axis: color · themeable · exposed
  CsColor get colorBorderBadgeSeverityHigh =>
      colorTokens.colorBorderBadgeSeverityHigh;

  /// The border color of badges representing a medium severity level.
  ///
  /// CSS: `--color-border-badge-severity-medium` · axis: color · themeable · exposed
  CsColor get colorBorderBadgeSeverityMedium =>
      colorTokens.colorBorderBadgeSeverityMedium;

  /// The border color of badges representing a low severity level.
  ///
  /// CSS: `--color-border-badge-severity-low` · axis: color · themeable · exposed
  CsColor get colorBorderBadgeSeverityLow =>
      colorTokens.colorBorderBadgeSeverityLow;

  /// The border color of badges representing a neutral severity level.
  ///
  /// CSS: `--color-border-badge-severity-neutral` · axis: color · themeable · exposed
  CsColor get colorBorderBadgeSeverityNeutral =>
      colorTokens.colorBorderBadgeSeverityNeutral;

  /// The text color of badges representing a critical severity level.
  ///
  /// CSS: `--color-text-badge-severity-critical` · axis: color · themeable · exposed
  CsColor get colorTextBadgeSeverityCritical =>
      colorTokens.colorTextBadgeSeverityCritical;

  /// The text color of badges representing a high severity level.
  ///
  /// CSS: `--color-text-badge-severity-high` · axis: color · themeable · exposed
  CsColor get colorTextBadgeSeverityHigh =>
      colorTokens.colorTextBadgeSeverityHigh;

  /// The text color of badges representing a medium severity level.
  ///
  /// CSS: `--color-text-badge-severity-medium` · axis: color · themeable · exposed
  CsColor get colorTextBadgeSeverityMedium =>
      colorTokens.colorTextBadgeSeverityMedium;

  /// The text color of badges representing a low severity level.
  ///
  /// CSS: `--color-text-badge-severity-low` · axis: color · themeable · exposed
  CsColor get colorTextBadgeSeverityLow =>
      colorTokens.colorTextBadgeSeverityLow;

  /// The text color of badges representing a neutral severity level.
  ///
  /// CSS: `--color-text-badge-severity-neutral` · axis: color · themeable · exposed
  CsColor get colorTextBadgeSeverityNeutral =>
      colorTokens.colorTextBadgeSeverityNeutral;

  /// CSS: `--color-grey-opaque-10` · axis: color
  CsColor get colorGreyOpaque10 => colorTokens.colorGreyOpaque10;

  /// CSS: `--color-grey-opaque-25` · axis: color
  CsColor get colorGreyOpaque25 => colorTokens.colorGreyOpaque25;

  /// CSS: `--color-grey-opaque-40` · axis: color
  CsColor get colorGreyOpaque40 => colorTokens.colorGreyOpaque40;

  /// CSS: `--color-grey-opaque-50` · axis: color
  CsColor get colorGreyOpaque50 => colorTokens.colorGreyOpaque50;

  /// CSS: `--color-grey-opaque-70` · axis: color
  CsColor get colorGreyOpaque70 => colorTokens.colorGreyOpaque70;

  /// CSS: `--color-grey-opaque-80` · axis: color
  CsColor get colorGreyOpaque80 => colorTokens.colorGreyOpaque80;

  /// CSS: `--color-grey-opaque-90` · axis: color
  CsColor get colorGreyOpaque90 => colorTokens.colorGreyOpaque90;

  /// CSS: `--color-grey-transparent` · axis: color
  CsColor get colorGreyTransparent => colorTokens.colorGreyTransparent;

  /// CSS: `--color-grey-transparent-heavy` · axis: color
  CsColor get colorGreyTransparentHeavy =>
      colorTokens.colorGreyTransparentHeavy;

  /// CSS: `--color-grey-transparent-light` · axis: color
  CsColor get colorGreyTransparentLight =>
      colorTokens.colorGreyTransparentLight;

  /// The background color of the badge indicator on navigation and panel
  /// buttons.
  ///
  /// CSS: `--color-background-badge-icon` · axis: color · themeable · exposed
  CsColor get colorBackgroundBadgeIcon => colorTokens.colorBackgroundBadgeIcon;

  /// The background color of link buttons in active state.
  ///
  /// CSS: `--color-background-button-link-active` · axis: color · themeable · exposed
  CsColor get colorBackgroundButtonLinkActive =>
      colorTokens.colorBackgroundButtonLinkActive;

  /// The background color of link buttons in default state.
  ///
  /// CSS: `--color-background-button-link-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundButtonLinkDefault =>
      colorTokens.colorBackgroundButtonLinkDefault;

  /// The background color of link buttons in disabled state.
  ///
  /// CSS: `--color-background-button-link-disabled` · axis: color · themeable · exposed
  CsColor get colorBackgroundButtonLinkDisabled =>
      colorTokens.colorBackgroundButtonLinkDisabled;

  /// The background color of link buttons in hover state.
  ///
  /// CSS: `--color-background-button-link-hover` · axis: color · themeable · exposed
  CsColor get colorBackgroundButtonLinkHover =>
      colorTokens.colorBackgroundButtonLinkHover;

  /// The background color of normal buttons in active state.
  ///
  /// CSS: `--color-background-button-normal-active` · axis: color · themeable · exposed
  CsColor get colorBackgroundButtonNormalActive =>
      colorTokens.colorBackgroundButtonNormalActive;

  /// The default background color of normal buttons.
  ///
  /// CSS: `--color-background-button-normal-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundButtonNormalDefault =>
      colorTokens.colorBackgroundButtonNormalDefault;

  /// The background color of normal buttons in disabled state.
  ///
  /// CSS: `--color-background-button-normal-disabled` · axis: color · themeable · exposed
  CsColor get colorBackgroundButtonNormalDisabled =>
      colorTokens.colorBackgroundButtonNormalDisabled;

  /// The background color of normal buttons in hover state.
  ///
  /// CSS: `--color-background-button-normal-hover` · axis: color · themeable · exposed
  CsColor get colorBackgroundButtonNormalHover =>
      colorTokens.colorBackgroundButtonNormalHover;

  /// The background color of normal toggle buttons in pressed state.
  ///
  /// CSS: `--color-background-toggle-button-normal-pressed` · axis: color · themeable · exposed
  CsColor get colorBackgroundToggleButtonNormalPressed =>
      colorTokens.colorBackgroundToggleButtonNormalPressed;

  /// The default background color of normal toggle buttons.
  ///
  /// CSS: `--color-background-toggle-button-normal-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundToggleButtonNormalDefault =>
      colorTokens.colorBackgroundToggleButtonNormalDefault;

  /// The background color of normal toggle buttons in hover state.
  ///
  /// CSS: `--color-background-toggle-button-normal-hover` · axis: color · themeable · exposed
  CsColor get colorBackgroundToggleButtonNormalHover =>
      colorTokens.colorBackgroundToggleButtonNormalHover;

  /// The background color of primary buttons in active state.
  ///
  /// CSS: `--color-background-button-primary-active` · axis: color · themeable · exposed
  CsColor get colorBackgroundButtonPrimaryActive =>
      colorTokens.colorBackgroundButtonPrimaryActive;

  /// The default background color of primary buttons.
  ///
  /// CSS: `--color-background-button-primary-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundButtonPrimaryDefault =>
      colorTokens.colorBackgroundButtonPrimaryDefault;

  /// The background color of primary buttons in disabled state.
  ///
  /// CSS: `--color-background-button-primary-disabled` · axis: color · themeable · exposed
  CsColor get colorBackgroundButtonPrimaryDisabled =>
      colorTokens.colorBackgroundButtonPrimaryDisabled;

  /// The background color of primary buttons in hover state.
  ///
  /// CSS: `--color-background-button-primary-hover` · axis: color · themeable · exposed
  CsColor get colorBackgroundButtonPrimaryHover =>
      colorTokens.colorBackgroundButtonPrimaryHover;

  /// CSS: `--color-background-direction-button-active` · axis: color
  CsColor get colorBackgroundDirectionButtonActive =>
      colorTokens.colorBackgroundDirectionButtonActive;

  /// CSS: `--color-background-direction-button-default` · axis: color
  CsColor get colorBackgroundDirectionButtonDefault =>
      colorTokens.colorBackgroundDirectionButtonDefault;

  /// CSS: `--color-background-direction-button-disabled` · axis: color
  CsColor get colorBackgroundDirectionButtonDisabled =>
      colorTokens.colorBackgroundDirectionButtonDisabled;

  /// CSS: `--color-background-direction-button-hover` · axis: color
  CsColor get colorBackgroundDirectionButtonHover =>
      colorTokens.colorBackgroundDirectionButtonHover;

  /// CSS: `--color-text-direction-button-default` · axis: color
  CsColor get colorTextDirectionButtonDefault =>
      colorTokens.colorTextDirectionButtonDefault;

  /// CSS: `--color-text-direction-button-disabled` · axis: color
  CsColor get colorTextDirectionButtonDisabled =>
      colorTokens.colorTextDirectionButtonDisabled;

  /// CSS: `--color-background-calendar-current-date` · axis: color
  CsColor get colorBackgroundCalendarCurrentDate =>
      colorTokens.colorBackgroundCalendarCurrentDate;

  /// The background color of shaded table cells.
  ///
  /// CSS: `--color-background-cell-shaded` · axis: color · themeable · exposed
  CsColor get colorBackgroundCellShaded =>
      colorTokens.colorBackgroundCellShaded;

  /// CSS: `--color-background-code-editor-gutter-active-line-default` · axis: color
  CsColor get colorBackgroundCodeEditorGutterActiveLineDefault =>
      colorTokens.colorBackgroundCodeEditorGutterActiveLineDefault;

  /// CSS: `--color-background-code-editor-gutter-active-line-error` · axis: color
  CsColor get colorBackgroundCodeEditorGutterActiveLineError =>
      colorTokens.colorBackgroundCodeEditorGutterActiveLineError;

  /// CSS: `--color-background-code-editor-gutter-default` · axis: color
  CsColor get colorBackgroundCodeEditorGutterDefault =>
      colorTokens.colorBackgroundCodeEditorGutterDefault;

  /// CSS: `--color-background-code-editor-loading` · axis: color
  CsColor get colorBackgroundCodeEditorLoading =>
      colorTokens.colorBackgroundCodeEditorLoading;

  /// CSS: `--color-background-code-editor-pane-item-hover` · axis: color
  CsColor get colorBackgroundCodeEditorPaneItemHover =>
      colorTokens.colorBackgroundCodeEditorPaneItemHover;

  /// CSS: `--color-background-code-editor-status-bar` · axis: color
  CsColor get colorBackgroundCodeEditorStatusBar =>
      colorTokens.colorBackgroundCodeEditorStatusBar;

  /// The background color of a card.
  ///
  /// CSS: `--color-background-card` · axis: color · themeable · exposed
  CsColor get colorBackgroundCard => colorTokens.colorBackgroundCard;

  /// CSS: `--color-background-item-card` · axis: color
  CsColor get colorBackgroundItemCard => colorTokens.colorBackgroundItemCard;

  /// The background color of container main content areas. For example: content
  /// areas of form sections, containers, tables, and cards.
  ///
  /// CSS: `--color-background-container-content` · axis: color · themeable · exposed
  CsColor get colorBackgroundContainerContent =>
      colorTokens.colorBackgroundContainerContent;

  /// The background color of container headers. For example: headers of form
  /// sections, containers, tables, and card collections.
  ///
  /// CSS: `--color-background-container-header` · axis: color · themeable · exposed
  CsColor get colorBackgroundContainerHeader =>
      colorTokens.colorBackgroundContainerHeader;

  /// The background color of a checked form control. For example: background
  /// fill of a selected radio button, checked checkbox, and toggle that is
  /// switched on.
  ///
  /// CSS: `--color-background-control-checked` · axis: color · themeable · exposed
  CsColor get colorBackgroundControlChecked =>
      colorTokens.colorBackgroundControlChecked;

  /// The default background color of form controls. For example: radio buttons
  /// and checkboxes default background fill color.
  ///
  /// CSS: `--color-background-control-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundControlDefault =>
      colorTokens.colorBackgroundControlDefault;

  /// The background color of a disabled form control. For example: background
  /// fill of a disabled radio button and checkbox.
  ///
  /// CSS: `--color-background-control-disabled` · axis: color · themeable · exposed
  CsColor get colorBackgroundControlDisabled =>
      colorTokens.colorBackgroundControlDisabled;

  /// The default background color of dropdown items. For example: select,
  /// multiselect, autosuggest, and datepicker dropdown backgrounds.
  ///
  /// CSS: `--color-background-dropdown-item-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundDropdownItemDefault =>
      colorTokens.colorBackgroundDropdownItemDefault;

  /// CSS: `--color-background-dropdown-item-dimmed` · axis: color
  CsColor get colorBackgroundDropdownItemDimmed =>
      colorTokens.colorBackgroundDropdownItemDimmed;

  /// The background color of text that matches a user's query. For example: the
  /// background of text matching a query entered into a table filter, select,
  /// multiselect, or autosuggest.
  ///
  /// CSS: `--color-background-dropdown-item-filter-match` · axis: color · themeable · exposed
  CsColor get colorBackgroundDropdownItemFilterMatch =>
      colorTokens.colorBackgroundDropdownItemFilterMatch;

  /// The background color of dropdown items on hover. For example: background
  /// of hovered items in select, multiselect, autosuggest, and datepicker
  /// dropdowns.
  ///
  /// CSS: `--color-background-dropdown-item-hover` · axis: color · themeable · exposed
  CsColor get colorBackgroundDropdownItemHover =>
      colorTokens.colorBackgroundDropdownItemHover;

  /// The background color of selected dropdown items. For example: background
  /// of selected items in select, multiselect, autosuggest, and datepicker
  /// dropdowns.
  ///
  /// CSS: `--color-background-dropdown-item-selected` · axis: color · themeable · exposed
  CsColor get colorBackgroundDropdownItemSelected =>
      colorTokens.colorBackgroundDropdownItemSelected;

  /// The background color of the home header, displayed on the Service's home
  /// page.
  ///
  /// CSS: `--color-background-home-header` · axis: color · themeable · exposed
  CsColor get colorBackgroundHomeHeader =>
      colorTokens.colorBackgroundHomeHeader;

  /// CSS: `--color-background-inline-code` · axis: color
  CsColor get colorBackgroundInlineCode =>
      colorTokens.colorBackgroundInlineCode;

  /// The default background color of form inputs. For example: background fill
  /// of an input, textarea, autosuggest, and trigger of a select and
  /// multiselect.
  ///
  /// CSS: `--color-background-input-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundInputDefault =>
      colorTokens.colorBackgroundInputDefault;

  /// The background color of a disabled form input. For example: background
  /// fill of a disabled input, textarea, autosuggest, and trigger of a select
  /// and multiselect.
  ///
  /// CSS: `--color-background-input-disabled` · axis: color · themeable · exposed
  CsColor get colorBackgroundInputDisabled =>
      colorTokens.colorBackgroundInputDisabled;

  /// The background color of a selected item. For example: tokens, selected
  /// table rows, cards, and tile backgrounds.
  ///
  /// CSS: `--color-background-item-selected` · axis: color · themeable · exposed
  CsColor get colorBackgroundItemSelected =>
      colorTokens.colorBackgroundItemSelected;

  /// The background color of an active (highlighted) side navigation item.
  ///
  /// CSS: `--color-background-side-navigation-item-active` · axis: color · themeable · exposed
  CsColor get colorBackgroundSideNavigationItemActive =>
      colorTokens.colorBackgroundSideNavigationItemActive;

  /// CSS: `--color-background-side-navigation-item-active-collapsed` · axis: color · themeable
  CsColor get colorBackgroundSideNavigationItemActiveCollapsed =>
      colorTokens.colorBackgroundSideNavigationItemActiveCollapsed;

  /// CSS: `--color-background-side-navigation-item-icon-hover` · axis: color
  CsColor get colorBackgroundSideNavigationItemIconHover =>
      colorTokens.colorBackgroundSideNavigationItemIconHover;

  /// The background color of the main content area on a page. For example:
  /// content area in app layout.
  ///
  /// CSS: `--color-background-layout-main` · axis: color · themeable · exposed
  CsColor get colorBackgroundLayoutMain =>
      colorTokens.colorBackgroundLayoutMain;

  /// CSS: `--color-background-layout-ai-drawer` · axis: color · themeable
  CsColor get colorBackgroundLayoutAiDrawer =>
      colorTokens.colorBackgroundLayoutAiDrawer;

  /// CSS: `--color-background-drawer` · axis: color
  CsColor get colorBackgroundDrawer => colorTokens.colorBackgroundDrawer;

  /// The background color of the backdrop shown behind overlay surfaces such as
  /// modals and drawers.
  ///
  /// CSS: `--color-background-backdrop` · axis: color · themeable · exposed
  CsColor get colorBackgroundBackdrop => colorTokens.colorBackgroundBackdrop;

  /// CSS: `--color-background-drawer-backdrop` · axis: color
  CsColor get colorBackgroundDrawerBackdrop =>
      colorTokens.colorBackgroundDrawerBackdrop;

  /// CSS: `--color-background-layout-mobile-panel` · axis: color
  CsColor get colorBackgroundLayoutMobilePanel =>
      colorTokens.colorBackgroundLayoutMobilePanel;

  /// The background color of the selected (active) drawer panel in the app
  /// layout. Use this token to theme the background of the open drawer.
  ///
  /// CSS: `--color-background-layout-panel` · axis: color · themeable · exposed
  CsColor get colorBackgroundLayoutPanel =>
      colorTokens.colorBackgroundLayoutPanel;

  /// The background color of app layout panel content area. For example: The
  /// side navigation and tools panel content background color.
  ///
  /// CSS: `--color-background-layout-panel-content` · axis: color · themeable · exposed
  CsColor get colorBackgroundLayoutPanelContent =>
      colorTokens.colorBackgroundLayoutPanelContent;

  /// CSS: `--color-background-layout-panel-hover` · axis: color
  CsColor get colorBackgroundLayoutPanelHover =>
      colorTokens.colorBackgroundLayoutPanelHover;

  /// The background color of the app layout's toolbar. For example: The toolbar
  /// bar containing breadcrumbs and toggle buttons.
  ///
  /// CSS: `--color-background-layout-toolbar` · axis: color · themeable · exposed
  CsColor get colorBackgroundLayoutToolbar =>
      colorTokens.colorBackgroundLayoutToolbar;

  /// The background color of the app layout toggle button when it's active.
  ///
  /// CSS: `--color-background-layout-toggle-active` · axis: color · themeable · exposed
  CsColor get colorBackgroundLayoutToggleActive =>
      colorTokens.colorBackgroundLayoutToggleActive;

  /// The default background color of the app layout toggle button.
  ///
  /// CSS: `--color-background-layout-toggle-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundLayoutToggleDefault =>
      colorTokens.colorBackgroundLayoutToggleDefault;

  /// The background color of the app layout toggle button on hover.
  ///
  /// CSS: `--color-background-layout-toggle-hover` · axis: color · themeable · exposed
  CsColor get colorBackgroundLayoutToggleHover =>
      colorTokens.colorBackgroundLayoutToggleHover;

  /// The background color of the app layout toggle button when it's selected
  /// and active.
  ///
  /// CSS: `--color-background-layout-toggle-selected-active` · axis: color · themeable · exposed
  CsColor get colorBackgroundLayoutToggleSelectedActive =>
      colorTokens.colorBackgroundLayoutToggleSelectedActive;

  /// The default background color of the app layout toggle button when it's
  /// selected.
  ///
  /// CSS: `--color-background-layout-toggle-selected-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundLayoutToggleSelectedDefault =>
      colorTokens.colorBackgroundLayoutToggleSelectedDefault;

  /// The background color of the app layout toggle button on hover when it's
  /// selected.
  ///
  /// CSS: `--color-background-layout-toggle-selected-hover` · axis: color · themeable · exposed
  CsColor get colorBackgroundLayoutToggleSelectedHover =>
      colorTokens.colorBackgroundLayoutToggleSelectedHover;

  /// CSS: `--color-background-modal-overlay` · axis: color
  CsColor get colorBackgroundModalOverlay =>
      colorTokens.colorBackgroundModalOverlay;

  /// Background color for blue notifications. For example: blue badges and info
  /// flash messages.
  ///
  /// CSS: `--color-background-notification-blue` · axis: color · themeable · exposed
  CsColor get colorBackgroundNotificationBlue =>
      colorTokens.colorBackgroundNotificationBlue;

  /// Background color for green notifications. For example: green badges and
  /// success flash messages.
  ///
  /// CSS: `--color-background-notification-green` · axis: color · themeable · exposed
  CsColor get colorBackgroundNotificationGreen =>
      colorTokens.colorBackgroundNotificationGreen;

  /// Background color for grey notifications. For example: grey badges.
  ///
  /// CSS: `--color-background-notification-grey` · axis: color · themeable · exposed
  CsColor get colorBackgroundNotificationGrey =>
      colorTokens.colorBackgroundNotificationGrey;

  /// Background color for red notifications. For example: red badges and error
  /// flash messages.
  ///
  /// CSS: `--color-background-notification-red` · axis: color · themeable · exposed
  CsColor get colorBackgroundNotificationRed =>
      colorTokens.colorBackgroundNotificationRed;

  /// Background color for yellow notifications. For example: yellow badges and
  /// warning flash messages.
  ///
  /// CSS: `--color-background-notification-yellow` · axis: color · themeable · exposed
  CsColor get colorBackgroundNotificationYellow =>
      colorTokens.colorBackgroundNotificationYellow;

  /// The background color of success flash messages.
  ///
  /// CSS: `--color-background-flashbar-success` · axis: color · themeable · exposed
  CsColor get colorBackgroundFlashbarSuccess =>
      colorTokens.colorBackgroundFlashbarSuccess;

  /// The background color of error flash messages.
  ///
  /// CSS: `--color-background-flashbar-error` · axis: color · themeable · exposed
  CsColor get colorBackgroundFlashbarError =>
      colorTokens.colorBackgroundFlashbarError;

  /// The background color of info and in-progress flash messages.
  ///
  /// CSS: `--color-background-flashbar-info` · axis: color · themeable · exposed
  CsColor get colorBackgroundFlashbarInfo =>
      colorTokens.colorBackgroundFlashbarInfo;

  /// The background color of warning flash messages.
  ///
  /// CSS: `--color-background-flashbar-warning` · axis: color · themeable · exposed
  CsColor get colorBackgroundFlashbarWarning =>
      colorTokens.colorBackgroundFlashbarWarning;

  /// CSS: `--color-background-notification-stack-bar` · axis: color
  CsColor get colorBackgroundNotificationStackBar =>
      colorTokens.colorBackgroundNotificationStackBar;

  /// CSS: `--color-background-notification-stack-bar-active` · axis: color
  CsColor get colorBackgroundNotificationStackBarActive =>
      colorTokens.colorBackgroundNotificationStackBarActive;

  /// CSS: `--color-background-notification-stack-bar-hover` · axis: color
  CsColor get colorBackgroundNotificationStackBarHover =>
      colorTokens.colorBackgroundNotificationStackBarHover;

  /// Background color for the popover container.
  ///
  /// CSS: `--color-background-popover` · axis: color · themeable · exposed
  CsColor get colorBackgroundPopover => colorTokens.colorBackgroundPopover;

  /// The default background color of the progress bar value.
  ///
  /// CSS: `--color-background-progress-bar-value-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundProgressBarValueDefault =>
      colorTokens.colorBackgroundProgressBarValueDefault;

  /// CSS: `--color-background-progress-bar-value-flash` · axis: color
  CsColor get colorBackgroundProgressBarValueFlash =>
      colorTokens.colorBackgroundProgressBarValueFlash;

  /// CSS: `--color-background-progress-bar-flash` · axis: color
  CsColor get colorBackgroundProgressBarFlash =>
      colorTokens.colorBackgroundProgressBarFlash;

  /// The default background color of the progress bar.
  ///
  /// CSS: `--color-background-progress-bar-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundProgressBarDefault =>
      colorTokens.colorBackgroundProgressBarDefault;

  /// The background color of the active segment in a segmented control.
  ///
  /// CSS: `--color-background-segment-active` · axis: color · themeable · exposed
  CsColor get colorBackgroundSegmentActive =>
      colorTokens.colorBackgroundSegmentActive;

  /// The background color of inactive segments in a segmented control.
  ///
  /// CSS: `--color-background-segment-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundSegmentDefault =>
      colorTokens.colorBackgroundSegmentDefault;

  /// The background color of disabled segments in a segmented control.
  ///
  /// CSS: `--color-background-segment-disabled` · axis: color · themeable · exposed
  CsColor get colorBackgroundSegmentDisabled =>
      colorTokens.colorBackgroundSegmentDisabled;

  /// The background color of inactive segments in a segmented control on hover.
  ///
  /// CSS: `--color-background-segment-hover` · axis: color · themeable · exposed
  CsColor get colorBackgroundSegmentHover =>
      colorTokens.colorBackgroundSegmentHover;

  /// The background color of segmented control wrapper.
  ///
  /// CSS: `--color-background-segment-wrapper` · axis: color · themeable · exposed
  CsColor get colorBackgroundSegmentWrapper =>
      colorTokens.colorBackgroundSegmentWrapper;

  /// The default background color of the slider range.
  ///
  /// CSS: `--color-background-slider-range-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundSliderRangeDefault =>
      colorTokens.colorBackgroundSliderRangeDefault;

  /// The background color of the slider range in active state.
  ///
  /// CSS: `--color-background-slider-range-active` · axis: color · themeable · exposed
  CsColor get colorBackgroundSliderRangeActive =>
      colorTokens.colorBackgroundSliderRangeActive;

  /// The default background color of the slider handle.
  ///
  /// CSS: `--color-background-slider-handle-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundSliderHandleDefault =>
      colorTokens.colorBackgroundSliderHandleDefault;

  /// The background color of the slider handle in active state.
  ///
  /// CSS: `--color-background-slider-handle-active` · axis: color · themeable · exposed
  CsColor get colorBackgroundSliderHandleActive =>
      colorTokens.colorBackgroundSliderHandleActive;

  /// The default background color of the slider track.
  ///
  /// CSS: `--color-background-slider-track-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundSliderTrackDefault =>
      colorTokens.colorBackgroundSliderTrackDefault;

  /// CSS: `--color-background-slider-handle-ring` · axis: color
  CsColor get colorBackgroundSliderHandleRing =>
      colorTokens.colorBackgroundSliderHandleRing;

  /// CSS: `--color-background-slider-handle-error-default` · axis: color
  CsColor get colorBackgroundSliderHandleErrorDefault =>
      colorTokens.colorBackgroundSliderHandleErrorDefault;

  /// CSS: `--color-background-slider-handle-error-active` · axis: color
  CsColor get colorBackgroundSliderHandleErrorActive =>
      colorTokens.colorBackgroundSliderHandleErrorActive;

  /// CSS: `--color-background-slider-handle-warning-default` · axis: color
  CsColor get colorBackgroundSliderHandleWarningDefault =>
      colorTokens.colorBackgroundSliderHandleWarningDefault;

  /// CSS: `--color-background-slider-handle-warning-active` · axis: color
  CsColor get colorBackgroundSliderHandleWarningActive =>
      colorTokens.colorBackgroundSliderHandleWarningActive;

  /// CSS: `--color-background-slider-range-error-default` · axis: color
  CsColor get colorBackgroundSliderRangeErrorDefault =>
      colorTokens.colorBackgroundSliderRangeErrorDefault;

  /// CSS: `--color-background-slider-range-error-active` · axis: color
  CsColor get colorBackgroundSliderRangeErrorActive =>
      colorTokens.colorBackgroundSliderRangeErrorActive;

  /// CSS: `--color-background-slider-range-warning-default` · axis: color
  CsColor get colorBackgroundSliderRangeWarningDefault =>
      colorTokens.colorBackgroundSliderRangeWarningDefault;

  /// CSS: `--color-background-slider-range-warning-active` · axis: color
  CsColor get colorBackgroundSliderRangeWarningActive =>
      colorTokens.colorBackgroundSliderRangeWarningActive;

  /// The background color of an item in error state. For example: error alerts.
  ///
  /// CSS: `--color-background-status-error` · axis: color · themeable · exposed
  CsColor get colorBackgroundStatusError =>
      colorTokens.colorBackgroundStatusError;

  /// The background color of an informational item. For example: information
  /// alerts.
  ///
  /// CSS: `--color-background-status-info` · axis: color · themeable · exposed
  CsColor get colorBackgroundStatusInfo =>
      colorTokens.colorBackgroundStatusInfo;

  /// CSS: `--color-background-alert-error` · axis: color
  CsColor get colorBackgroundAlertError =>
      colorTokens.colorBackgroundAlertError;

  /// CSS: `--color-background-alert-info` · axis: color
  CsColor get colorBackgroundAlertInfo => colorTokens.colorBackgroundAlertInfo;

  /// CSS: `--color-background-alert-success` · axis: color
  CsColor get colorBackgroundAlertSuccess =>
      colorTokens.colorBackgroundAlertSuccess;

  /// CSS: `--color-background-alert-warning` · axis: color
  CsColor get colorBackgroundAlertWarning =>
      colorTokens.colorBackgroundAlertWarning;

  /// The background color of the feedback/input dialogue box.
  ///
  /// CSS: `--color-background-dialog` · axis: color · themeable · exposed
  CsColor get colorBackgroundDialog => colorTokens.colorBackgroundDialog;

  /// CSS: `--color-background-dialog-default` · axis: color · themeable
  CsColor get colorBackgroundDialogDefault =>
      colorTokens.colorBackgroundDialogDefault;

  /// The background color of an item in success state. For example: success
  /// alerts.
  ///
  /// CSS: `--color-background-status-success` · axis: color · themeable · exposed
  CsColor get colorBackgroundStatusSuccess =>
      colorTokens.colorBackgroundStatusSuccess;

  /// The background color of an item in warning state. For example: warning
  /// alerts.
  ///
  /// CSS: `--color-background-status-warning` · axis: color · themeable · exposed
  CsColor get colorBackgroundStatusWarning =>
      colorTokens.colorBackgroundStatusWarning;

  /// CSS: `--color-background-table-header` · axis: color
  CsColor get colorBackgroundTableHeader =>
      colorTokens.colorBackgroundTableHeader;

  /// The background color of disabled tiles.
  ///
  /// CSS: `--color-background-tiles-disabled` · axis: color · themeable · exposed
  CsColor get colorBackgroundTilesDisabled =>
      colorTokens.colorBackgroundTilesDisabled;

  /// The background color of checked toggles in disabled state.
  ///
  /// CSS: `--color-background-toggle-checked-disabled` · axis: color · themeable · exposed
  CsColor get colorBackgroundToggleCheckedDisabled =>
      colorTokens.colorBackgroundToggleCheckedDisabled;

  /// The default background color of the toggle track in its unchecked state.
  ///
  /// CSS: `--color-background-toggle-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundToggleDefault =>
      colorTokens.colorBackgroundToggleDefault;

  /// The gen-ai background color of avatars.
  ///
  /// CSS: `--color-background-avatar-gen-ai` · axis: color · exposed
  CsColorValue get colorBackgroundAvatarGenAi =>
      colorTokens.colorBackgroundAvatarGenAi;

  /// The default background color of avatars.
  ///
  /// CSS: `--color-background-avatar-default` · axis: color · exposed
  CsColor get colorBackgroundAvatarDefault =>
      colorTokens.colorBackgroundAvatarDefault;

  /// The text and icon color of avatars.
  ///
  /// CSS: `--color-text-avatar` · axis: color · exposed
  CsColor get colorTextAvatar => colorTokens.colorTextAvatar;

  /// The background color of gen-ai loading bars.
  ///
  /// CSS: `--color-background-loading-bar-gen-ai` · axis: color · exposed
  CsColorValue get colorBackgroundLoadingBarGenAi =>
      colorTokens.colorBackgroundLoadingBarGenAi;

  /// CSS: `--color-background-status-indicator-error` · axis: color · themeable
  CsColor get colorBackgroundStatusIndicatorError =>
      colorTokens.colorBackgroundStatusIndicatorError;

  /// CSS: `--color-background-status-indicator-warning` · axis: color · themeable
  CsColor get colorBackgroundStatusIndicatorWarning =>
      colorTokens.colorBackgroundStatusIndicatorWarning;

  /// CSS: `--color-background-status-indicator-success` · axis: color · themeable
  CsColor get colorBackgroundStatusIndicatorSuccess =>
      colorTokens.colorBackgroundStatusIndicatorSuccess;

  /// CSS: `--color-background-status-indicator-info` · axis: color · themeable
  CsColor get colorBackgroundStatusIndicatorInfo =>
      colorTokens.colorBackgroundStatusIndicatorInfo;

  /// CSS: `--color-background-status-indicator-neutral` · axis: color · themeable
  CsColor get colorBackgroundStatusIndicatorNeutral =>
      colorTokens.colorBackgroundStatusIndicatorNeutral;

  /// The background color of `outgoing` chat bubble.
  ///
  /// CSS: `--color-background-chat-bubble-outgoing` · axis: color · themeable · exposed
  CsColor get colorBackgroundChatBubbleOutgoing =>
      colorTokens.colorBackgroundChatBubbleOutgoing;

  /// The background color of `incoming` chat bubble.
  ///
  /// CSS: `--color-background-chat-bubble-incoming` · axis: color · themeable · exposed
  CsColor get colorBackgroundChatBubbleIncoming =>
      colorTokens.colorBackgroundChatBubbleIncoming;

  /// Text color of `outgoing` chat bubble.
  ///
  /// CSS: `--color-text-chat-bubble-outgoing` · axis: color · themeable · exposed
  CsColor get colorTextChatBubbleOutgoing =>
      colorTokens.colorTextChatBubbleOutgoing;

  /// Text color of `incoming` chat bubble.
  ///
  /// CSS: `--color-text-chat-bubble-incoming` · axis: color · themeable · exposed
  CsColor get colorTextChatBubbleIncoming =>
      colorTokens.colorTextChatBubbleIncoming;

  /// The border color of link buttons in disabled state.
  ///
  /// CSS: `--color-border-button-link-disabled` · axis: color · themeable · exposed
  CsColor get colorBorderButtonLinkDisabled =>
      colorTokens.colorBorderButtonLinkDisabled;

  /// The border color of normal buttons in active state.
  ///
  /// CSS: `--color-border-button-normal-active` · axis: color · themeable · exposed
  CsColor get colorBorderButtonNormalActive =>
      colorTokens.colorBorderButtonNormalActive;

  /// The border color of normal buttons.
  ///
  /// CSS: `--color-border-button-normal-default` · axis: color · themeable · exposed
  CsColor get colorBorderButtonNormalDefault =>
      colorTokens.colorBorderButtonNormalDefault;

  /// The border color of normal toggle buttons in pressed state.
  ///
  /// CSS: `--color-border-toggle-button-normal-pressed` · axis: color · themeable · exposed
  CsColor get colorBorderToggleButtonNormalPressed =>
      colorTokens.colorBorderToggleButtonNormalPressed;

  /// The default border color of normal toggle buttons.
  ///
  /// CSS: `--color-border-toggle-button-normal-default` · axis: color · themeable · exposed
  CsColor get colorBorderToggleButtonNormalDefault =>
      colorTokens.colorBorderToggleButtonNormalDefault;

  /// The border color of normal toggle buttons in hover state.
  ///
  /// CSS: `--color-border-toggle-button-normal-hover` · axis: color · themeable · exposed
  CsColor get colorBorderToggleButtonNormalHover =>
      colorTokens.colorBorderToggleButtonNormalHover;

  /// The border color of normal buttons in disabled state.
  ///
  /// CSS: `--color-border-button-normal-disabled` · axis: color · themeable · exposed
  CsColor get colorBorderButtonNormalDisabled =>
      colorTokens.colorBorderButtonNormalDisabled;

  /// The text color of normal buttons in disabled state.
  ///
  /// CSS: `--color-text-button-normal-disabled` · axis: color · themeable · exposed
  CsColor get colorTextButtonNormalDisabled =>
      colorTokens.colorTextButtonNormalDisabled;

  /// The border color of normal buttons in hover state.
  ///
  /// CSS: `--color-border-button-normal-hover` · axis: color · themeable · exposed
  CsColor get colorBorderButtonNormalHover =>
      colorTokens.colorBorderButtonNormalHover;

  /// The color of icon buttons in disabled state.
  ///
  /// CSS: `--color-text-button-icon-disabled` · axis: color · themeable · exposed
  CsColor get colorTextButtonIconDisabled =>
      colorTokens.colorTextButtonIconDisabled;

  /// The border color of primary buttons in active state.
  ///
  /// CSS: `--color-border-button-primary-active` · axis: color · themeable · exposed
  CsColor get colorBorderButtonPrimaryActive =>
      colorTokens.colorBorderButtonPrimaryActive;

  /// The border color of primary buttons.
  ///
  /// CSS: `--color-border-button-primary-default` · axis: color · themeable · exposed
  CsColor get colorBorderButtonPrimaryDefault =>
      colorTokens.colorBorderButtonPrimaryDefault;

  /// The border color of primary buttons in disabled state.
  ///
  /// CSS: `--color-border-button-primary-disabled` · axis: color · themeable · exposed
  CsColor get colorBorderButtonPrimaryDisabled =>
      colorTokens.colorBorderButtonPrimaryDisabled;

  /// The border color of primary buttons in hover state.
  ///
  /// CSS: `--color-border-button-primary-hover` · axis: color · themeable · exposed
  CsColor get colorBorderButtonPrimaryHover =>
      colorTokens.colorBorderButtonPrimaryHover;

  /// The text color of primary buttons in disabled state.
  ///
  /// CSS: `--color-text-button-primary-disabled` · axis: color · themeable · exposed
  CsColor get colorTextButtonPrimaryDisabled =>
      colorTokens.colorTextButtonPrimaryDisabled;

  /// The highlight color for selected items. For example: borders of tokens and
  /// selected table rows, and check icons in selected dropdown items.
  ///
  /// CSS: `--color-item-selected` · axis: color · themeable · exposed
  CsColor get colorItemSelected => colorTokens.colorItemSelected;

  /// The text color of an active (highlighted) side navigation item.
  ///
  /// CSS: `--color-text-side-navigation-item-active` · axis: color · themeable · exposed
  CsColor get colorTextSideNavigationItemActive =>
      colorTokens.colorTextSideNavigationItemActive;

  /// CSS: `--color-text-side-navigation-item-active-collapsed` · axis: color · themeable
  CsColor get colorTextSideNavigationItemActiveCollapsed =>
      colorTokens.colorTextSideNavigationItemActiveCollapsed;

  /// CSS: `--color-text-side-navigation-item-default` · axis: color · themeable
  CsColor get colorTextSideNavigationItemDefault =>
      colorTokens.colorTextSideNavigationItemDefault;

  /// CSS: `--color-border-calendar-grid` · axis: color
  CsColor get colorBorderCalendarGrid => colorTokens.colorBorderCalendarGrid;

  /// CSS: `--color-border-calendar-grid-selected-focus-ring` · axis: color
  CsColor get colorBorderCalendarGridSelectedFocusRing =>
      colorTokens.colorBorderCalendarGridSelectedFocusRing;

  /// CSS: `--color-border-cell-shaded` · axis: color
  CsColor get colorBorderCellShaded => colorTokens.colorBorderCellShaded;

  /// CSS: `--color-border-code-editor-ace-active-line-light-theme` · axis: color
  CsColor get colorBorderCodeEditorAceActiveLineLightTheme =>
      colorTokens.colorBorderCodeEditorAceActiveLineLightTheme;

  /// CSS: `--color-border-code-editor-ace-active-line-dark-theme` · axis: color
  CsColor get colorBorderCodeEditorAceActiveLineDarkTheme =>
      colorTokens.colorBorderCodeEditorAceActiveLineDarkTheme;

  /// CSS: `--color-border-code-editor-default` · axis: color
  CsColor get colorBorderCodeEditorDefault =>
      colorTokens.colorBorderCodeEditorDefault;

  /// CSS: `--color-border-code-editor-pane-item-hover` · axis: color
  CsColor get colorBorderCodeEditorPaneItemHover =>
      colorTokens.colorBorderCodeEditorPaneItemHover;

  /// The border color of a card.
  ///
  /// CSS: `--color-border-card` · axis: color · themeable · exposed
  CsColor get colorBorderCard => colorTokens.colorBorderCard;

  /// CSS: `--color-border-card-highlighted` · axis: color
  CsColor get colorBorderCardHighlighted =>
      colorTokens.colorBorderCardHighlighted;

  /// CSS: `--color-border-item-card` · axis: color
  CsColor get colorBorderItemCard => colorTokens.colorBorderItemCard;

  /// CSS: `--color-border-item-card-highlighted` · axis: color
  CsColor get colorBorderItemCardHighlighted =>
      colorTokens.colorBorderItemCardHighlighted;

  /// CSS: `--color-border-container-divider` · axis: color
  CsColor get colorBorderContainerDivider =>
      colorTokens.colorBorderContainerDivider;

  /// The top border color for containers and first item in dropdowns. For
  /// example: the top border of a card, dropdown, and table.
  ///
  /// CSS: `--color-border-container-top` · axis: color · themeable · exposed
  CsColor get colorBorderContainerTop => colorTokens.colorBorderContainerTop;

  /// CSS: `--color-border-control-checked` · axis: color
  CsColor get colorBorderControlChecked =>
      colorTokens.colorBorderControlChecked;

  /// The default border color of form controls. For example: radio buttons and
  /// checkboxes.
  ///
  /// CSS: `--color-border-control-default` · axis: color · themeable · exposed
  CsColor get colorBorderControlDefault =>
      colorTokens.colorBorderControlDefault;

  /// CSS: `--color-border-control-disabled` · axis: color
  CsColor get colorBorderControlDisabled =>
      colorTokens.colorBorderControlDisabled;

  /// CSS: `--color-border-divider-active` · axis: color
  CsColor get colorBorderDividerActive => colorTokens.colorBorderDividerActive;

  /// The default color for dividers. For example: dividers in column layout,
  /// expanding sections, side nav, help panel, between table rows and dropdown
  /// items, and inside containers.
  ///
  /// CSS: `--color-border-divider-default` · axis: color · themeable · exposed
  CsColor get colorBorderDividerDefault =>
      colorTokens.colorBorderDividerDefault;

  /// CSS: `--color-border-divider-notification` · axis: color
  CsColor get colorBorderDividerNotification =>
      colorTokens.colorBorderDividerNotification;

  /// CSS: `--color-border-divider-panel-bottom` · axis: color
  CsColor get colorBorderDividerPanelBottom =>
      colorTokens.colorBorderDividerPanelBottom;

  /// CSS: `--color-border-divider-panel-side` · axis: color
  CsColor get colorBorderDividerPanelSide =>
      colorTokens.colorBorderDividerPanelSide;

  /// The border color for row dividers. For example: row dividers for table and
  /// collection preferences.
  ///
  /// CSS: `--color-border-divider-secondary` · axis: color · themeable · exposed
  CsColor get colorBorderDividerSecondary =>
      colorTokens.colorBorderDividerSecondary;

  /// CSS: `--color-border-divider-table-group` · axis: color
  CsColor get colorBorderDividerTableGroup =>
      colorTokens.colorBorderDividerTableGroup;

  /// The border color of the dropdown container. For example: border color of
  /// the dropdown container in button dropdown, select, and multi-select.
  ///
  /// CSS: `--color-border-dropdown-container` · axis: color · themeable · exposed
  CsColor get colorBorderDropdownContainer =>
      colorTokens.colorBorderDropdownContainer;

  /// CSS: `--color-border-dropdown-group` · axis: color
  CsColor get colorBorderDropdownGroup => colorTokens.colorBorderDropdownGroup;

  /// CSS: `--color-border-dropdown-item-default` · axis: color
  CsColor get colorBorderDropdownItemDefault =>
      colorTokens.colorBorderDropdownItemDefault;

  /// The border color of dropdown items on hover. For example: border of
  /// hovered items in select, multiselect, autosuggest, and hovered days in
  /// datepicker.
  ///
  /// CSS: `--color-border-dropdown-item-hover` · axis: color · themeable · exposed
  CsColor get colorBorderDropdownItemHover =>
      colorTokens.colorBorderDropdownItemHover;

  /// CSS: `--color-border-dropdown-item-dimmed-hover` · axis: color
  CsColor get colorBorderDropdownItemDimmedHover =>
      colorTokens.colorBorderDropdownItemDimmedHover;

  /// CSS: `--color-border-dropdown-item-selected` · axis: color
  CsColor get colorBorderDropdownItemSelected =>
      colorTokens.colorBorderDropdownItemSelected;

  /// CSS: `--color-border-dropdown-item-top` · axis: color
  CsColor get colorBorderDropdownItemTop =>
      colorTokens.colorBorderDropdownItemTop;

  /// CSS: `--color-border-editable-cell-hover` · axis: color
  CsColor get colorBorderEditableCellHover =>
      colorTokens.colorBorderEditableCellHover;

  /// CSS: `--color-border-control-group-default` · axis: color
  CsColor get colorBorderControlGroupDefault =>
      colorTokens.colorBorderControlGroupDefault;

  /// The default border color of form inputs. For example: input, textarea,
  /// autosuggest, datepicker, select, and multiselect.
  ///
  /// CSS: `--color-border-input-default` · axis: color · themeable · exposed
  CsColor get colorBorderInputDefault => colorTokens.colorBorderInputDefault;

  /// CSS: `--color-border-input-disabled` · axis: color
  CsColor get colorBorderInputDisabled => colorTokens.colorBorderInputDisabled;

  /// The color of focus states for form inputs. For example: input, textarea,
  /// autosuggest, datepicker, select, and multiselect.
  ///
  /// CSS: `--color-border-input-focused` · axis: color · themeable · exposed
  CsColor get colorBorderInputFocused => colorTokens.colorBorderInputFocused;

  /// The color of focus states. For example: the focus ring around interactive
  /// elements.
  ///
  /// CSS: `--color-border-item-focused` · axis: color · themeable · exposed
  CsColor get colorBorderItemFocused => colorTokens.colorBorderItemFocused;

  /// The color of focus states for dropdown items. For example: the focus ring
  /// around selectable elements in the dropdown of button dropdown, select, and
  /// multi-select.
  ///
  /// CSS: `--color-border-dropdown-item-focused` · axis: color · themeable · exposed
  CsColor get colorBorderDropdownItemFocused =>
      colorTokens.colorBorderDropdownItemFocused;

  /// CSS: `--color-border-item-placeholder` · axis: color
  CsColor get colorBorderItemPlaceholder =>
      colorTokens.colorBorderItemPlaceholder;

  /// The border color of a selected item. For example: tokens, selected table
  /// rows, selected cards, and selected tile borders.
  ///
  /// CSS: `--color-border-item-selected` · axis: color · themeable · exposed
  CsColor get colorBorderItemSelected => colorTokens.colorBorderItemSelected;

  /// CSS: `--color-border-layout` · axis: color · themeable
  CsColor get colorBorderLayout => colorTokens.colorBorderLayout;

  /// The border color of the side navigation divider in the app layout.
  ///
  /// CSS: `--color-border-layout-side-navigation` · axis: color · themeable · exposed
  CsColor get colorBorderLayoutSideNavigation =>
      colorTokens.colorBorderLayoutSideNavigation;

  /// CSS: `--color-border-notification-stack-bar` · axis: color
  CsColor get colorBorderNotificationStackBar =>
      colorTokens.colorBorderNotificationStackBar;

  /// CSS: `--color-border-notification-stack-bar-hover` · axis: color
  CsColor get colorBorderNotificationStackBarHover =>
      colorTokens.colorBorderNotificationStackBarHover;

  /// CSS: `--color-border-notification-stack-bar-active` · axis: color
  CsColor get colorBorderNotificationStackBarActive =>
      colorTokens.colorBorderNotificationStackBarActive;

  /// CSS: `--color-border-notification-stack-bar-focused` · axis: color
  CsColor get colorBorderNotificationStackBarFocused =>
      colorTokens.colorBorderNotificationStackBarFocused;

  /// CSS: `--color-border-panel-header` · axis: color
  CsColor get colorBorderPanelHeader => colorTokens.colorBorderPanelHeader;

  /// The border color of the popover.
  ///
  /// CSS: `--color-border-popover` · axis: color · themeable · exposed
  CsColor get colorBorderPopover => colorTokens.colorBorderPopover;

  /// Deprecated - this token is no longer in use.
  ///
  /// CSS: `--color-border-segment-active` · axis: color · themeable · exposed
  CsColor get colorBorderSegmentActive => colorTokens.colorBorderSegmentActive;

  /// Deprecated - this token is no longer in use.
  ///
  /// CSS: `--color-border-segment-default` · axis: color · themeable · exposed
  CsColor get colorBorderSegmentDefault =>
      colorTokens.colorBorderSegmentDefault;

  /// Deprecated - this token is no longer in use.
  ///
  /// CSS: `--color-border-segment-disabled` · axis: color · themeable · exposed
  CsColor get colorBorderSegmentDisabled =>
      colorTokens.colorBorderSegmentDisabled;

  /// The color of the dividers between segments in a segmented control.
  ///
  /// CSS: `--color-border-segment-divider` · axis: color · themeable · exposed
  CsColor get colorBorderSegmentDivider =>
      colorTokens.colorBorderSegmentDivider;

  /// Deprecated - this token is no longer in use.
  ///
  /// CSS: `--color-border-segment-hover` · axis: color · themeable · exposed
  CsColor get colorBorderSegmentHover => colorTokens.colorBorderSegmentHover;

  /// The border color of the segmented control wrapper.
  ///
  /// CSS: `--color-border-segment-wrapper` · axis: color · themeable · exposed
  CsColor get colorBorderSegmentWrapper =>
      colorTokens.colorBorderSegmentWrapper;

  /// The border color of an item in error state. For example: error alerts.
  ///
  /// CSS: `--color-border-status-error` · axis: color · themeable · exposed
  CsColor get colorBorderStatusError => colorTokens.colorBorderStatusError;

  /// The border color of an informational item. For example: information
  /// alerts.
  ///
  /// CSS: `--color-border-status-info` · axis: color · themeable · exposed
  CsColor get colorBorderStatusInfo => colorTokens.colorBorderStatusInfo;

  /// The border color of an item in success state. For example: success alerts.
  ///
  /// CSS: `--color-border-status-success` · axis: color · themeable · exposed
  CsColor get colorBorderStatusSuccess => colorTokens.colorBorderStatusSuccess;

  /// The border color of an item in warning state. For example: warning alerts.
  ///
  /// CSS: `--color-border-status-warning` · axis: color · themeable · exposed
  CsColor get colorBorderStatusWarning => colorTokens.colorBorderStatusWarning;

  /// The border color of the feedback/input dialogue box.
  ///
  /// CSS: `--color-border-dialog` · axis: color · themeable · exposed
  CsColor get colorBorderDialog => colorTokens.colorBorderDialog;

  /// CSS: `--color-border-dialog-default` · axis: color · themeable
  CsColor get colorBorderDialogDefault => colorTokens.colorBorderDialogDefault;

  /// CSS: `--color-border-divider-interactive-default` · axis: color
  CsColor get colorBorderDividerInteractiveDefault =>
      colorTokens.colorBorderDividerInteractiveDefault;

  /// CSS: `--color-border-tabs-divider` · axis: color
  CsColor get colorBorderTabsDivider => colorTokens.colorBorderTabsDivider;

  /// CSS: `--color-border-tabs-shadow` · axis: color
  CsColor get colorBorderTabsShadow => colorTokens.colorBorderTabsShadow;

  /// CSS: `--color-border-tabs-underline` · axis: color
  CsColor get colorBorderTabsUnderline => colorTokens.colorBorderTabsUnderline;

  /// CSS: `--color-border-tiles-disabled` · axis: color
  CsColor get colorBorderTilesDisabled => colorTokens.colorBorderTilesDisabled;

  /// CSS: `--color-border-tutorial` · axis: color
  CsColor get colorBorderTutorial => colorTokens.colorBorderTutorial;

  /// The color used to mark enabled form controls. For example: the checkmark
  /// on checkboxes, inner circle on radio buttons, and handle on toggles.
  ///
  /// CSS: `--color-foreground-control-default` · axis: color · themeable · exposed
  CsColor get colorForegroundControlDefault =>
      colorTokens.colorForegroundControlDefault;

  /// The color used to mark disabled form controls. For example: the checkmark
  /// on checkboxes, inner circle on radio buttons, and handle on toggles.
  ///
  /// CSS: `--color-foreground-control-disabled` · axis: color · themeable · exposed
  CsColor get colorForegroundControlDisabled =>
      colorTokens.colorForegroundControlDisabled;

  /// The color used to mark readonly form controls. For example: the checkmark
  /// on checkboxes, inner circle on radio buttons, and handle on toggles.
  ///
  /// CSS: `--color-foreground-control-read-only` · axis: color · themeable · exposed
  CsColor get colorForegroundControlReadOnly =>
      colorTokens.colorForegroundControlReadOnly;

  /// CSS: `--color-shadow-default` · axis: color
  CsColor get colorShadowDefault => colorTokens.colorShadowDefault;

  /// CSS: `--color-shadow-medium` · axis: color
  CsColor get colorShadowMedium => colorTokens.colorShadowMedium;

  /// CSS: `--color-shadow-side` · axis: color
  CsColor get colorShadowSide => colorTokens.colorShadowSide;

  /// The color of the drop shadow under the toggle handle.
  ///
  /// CSS: `--color-shadow-toggle-handle` · axis: color · themeable · exposed
  CsColor get colorShadowToggleHandle => colorTokens.colorShadowToggleHandle;

  /// CSS: `--color-stroke-chart-line` · axis: color
  CsColor get colorStrokeChartLine => colorTokens.colorStrokeChartLine;

  /// CSS: `--color-stroke-code-editor-gutter-active-line-default` · axis: color
  CsColor get colorStrokeCodeEditorGutterActiveLineDefault =>
      colorTokens.colorStrokeCodeEditorGutterActiveLineDefault;

  /// CSS: `--color-stroke-code-editor-gutter-active-line-hover` · axis: color
  CsColor get colorStrokeCodeEditorGutterActiveLineHover =>
      colorTokens.colorStrokeCodeEditorGutterActiveLineHover;

  /// The accent text color used to guide a user. For example: the highlighted
  /// page in the side navigation, active tab text, selected day text color in
  /// date picker, and hover state in expandable section.
  ///
  /// CSS: `--color-text-accent` · axis: color · themeable · exposed
  CsColor get colorTextAccent => colorTokens.colorTextAccent;

  /// The default color of non-heading text and body content. For example: text
  /// in a paragraph tag, table cell data, form field labels and values.
  ///
  /// CSS: `--color-text-body-default` · axis: color · themeable · exposed
  CsColor get colorTextBodyDefault => colorTokens.colorTextBodyDefault;

  /// The color of text that is secondary to base text. For example: text in the
  /// navigation and tools panels.
  ///
  /// CSS: `--color-text-body-secondary` · axis: color · themeable · exposed
  CsColor get colorTextBodySecondary => colorTokens.colorTextBodySecondary;

  /// The text color that marks the breadcrumb item for the page the user is
  /// currently viewing.
  ///
  /// CSS: `--color-text-breadcrumb-current` · axis: color · themeable · exposed
  CsColor get colorTextBreadcrumbCurrent =>
      colorTokens.colorTextBreadcrumbCurrent;

  /// The color used for the icon delimiter between breadcrumb items.
  ///
  /// CSS: `--color-text-breadcrumb-icon` · axis: color · themeable · exposed
  CsColor get colorTextBreadcrumbIcon => colorTokens.colorTextBreadcrumbIcon;

  /// The default color of inline button icons.
  ///
  /// CSS: `--color-text-button-inline-icon-default` · axis: color · themeable · exposed
  CsColor get colorTextButtonInlineIconDefault =>
      colorTokens.colorTextButtonInlineIconDefault;

  /// The color of inline button icons in disabled state.
  ///
  /// CSS: `--color-text-button-inline-icon-disabled` · axis: color · themeable · exposed
  CsColor get colorTextButtonInlineIconDisabled =>
      colorTokens.colorTextButtonInlineIconDisabled;

  /// The color of inline button icons in hover state.
  ///
  /// CSS: `--color-text-button-inline-icon-hover` · axis: color · themeable · exposed
  CsColor get colorTextButtonInlineIconHover =>
      colorTokens.colorTextButtonInlineIconHover;

  /// CSS: `--color-text-button-inline-link-hover` · axis: color · themeable
  CsColor get colorTextButtonInlineLinkHover =>
      colorTokens.colorTextButtonInlineLinkHover;

  /// CSS: `--color-text-button-icon-hover` · axis: color · themeable
  CsColor get colorTextButtonIconHover => colorTokens.colorTextButtonIconHover;

  /// The active text color of normal buttons. For example: Active text color in
  /// normal and link buttons.
  ///
  /// CSS: `--color-text-button-normal-active` · axis: color · themeable · exposed
  CsColor get colorTextButtonNormalActive =>
      colorTokens.colorTextButtonNormalActive;

  /// The pressed text color of normal toggle buttons.
  ///
  /// CSS: `--color-text-toggle-button-normal-pressed` · axis: color · themeable · exposed
  CsColor get colorTextToggleButtonNormalPressed =>
      colorTokens.colorTextToggleButtonNormalPressed;

  /// The default text color of normal buttons.
  ///
  /// CSS: `--color-text-button-normal-default` · axis: color · themeable · exposed
  CsColor get colorTextButtonNormalDefault =>
      colorTokens.colorTextButtonNormalDefault;

  /// The hover text color of normal buttons.
  ///
  /// CSS: `--color-text-button-normal-hover` · axis: color · themeable · exposed
  CsColor get colorTextButtonNormalHover =>
      colorTokens.colorTextButtonNormalHover;

  /// CSS: `--color-text-link-button-normal-default` · axis: color · themeable
  CsColor get colorTextLinkButtonNormalDefault =>
      colorTokens.colorTextLinkButtonNormalDefault;

  /// CSS: `--color-text-link-button-normal-hover` · axis: color · themeable
  CsColor get colorTextLinkButtonNormalHover =>
      colorTokens.colorTextLinkButtonNormalHover;

  /// CSS: `--color-text-link-button-normal-active` · axis: color · themeable
  CsColor get colorTextLinkButtonNormalActive =>
      colorTokens.colorTextLinkButtonNormalActive;

  /// The text color of link buttons in active state.
  ///
  /// CSS: `--color-text-button-link-active` · axis: color · themeable · exposed
  CsColor get colorTextButtonLinkActive =>
      colorTokens.colorTextButtonLinkActive;

  /// The default text color of link buttons.
  ///
  /// CSS: `--color-text-button-link-default` · axis: color · themeable · exposed
  CsColor get colorTextButtonLinkDefault =>
      colorTokens.colorTextButtonLinkDefault;

  /// The text color of link buttons in disabled state.
  ///
  /// CSS: `--color-text-button-link-disabled` · axis: color · themeable · exposed
  CsColor get colorTextButtonLinkDisabled =>
      colorTokens.colorTextButtonLinkDisabled;

  /// The text color of link buttons in hover state.
  ///
  /// CSS: `--color-text-button-link-hover` · axis: color · themeable · exposed
  CsColor get colorTextButtonLinkHover => colorTokens.colorTextButtonLinkHover;

  /// The active text color of primary buttons.
  ///
  /// CSS: `--color-text-button-primary-active` · axis: color · themeable · exposed
  CsColor get colorTextButtonPrimaryActive =>
      colorTokens.colorTextButtonPrimaryActive;

  /// The default text color of primary buttons.
  ///
  /// CSS: `--color-text-button-primary-default` · axis: color · themeable · exposed
  CsColor get colorTextButtonPrimaryDefault =>
      colorTokens.colorTextButtonPrimaryDefault;

  /// The hover text color of primary buttons.
  ///
  /// CSS: `--color-text-button-primary-hover` · axis: color · themeable · exposed
  CsColor get colorTextButtonPrimaryHover =>
      colorTokens.colorTextButtonPrimaryHover;

  /// CSS: `--color-text-calendar-date-hover` · axis: color
  CsColor get colorTextCalendarDateHover =>
      colorTokens.colorTextCalendarDateHover;

  /// The text color of selected dates in the calendar.
  ///
  /// CSS: `--color-text-calendar-date-selected` · axis: color · themeable · exposed
  CsColor get colorTextCalendarDateSelected =>
      colorTokens.colorTextCalendarDateSelected;

  /// CSS: `--color-text-calendar-month` · axis: color
  CsColor get colorTextCalendarMonth => colorTokens.colorTextCalendarMonth;

  /// CSS: `--color-text-code-editor-gutter-active-line` · axis: color
  CsColor get colorTextCodeEditorGutterActiveLine =>
      colorTokens.colorTextCodeEditorGutterActiveLine;

  /// CSS: `--color-text-code-editor-gutter-default` · axis: color
  CsColor get colorTextCodeEditorGutterDefault =>
      colorTokens.colorTextCodeEditorGutterDefault;

  /// CSS: `--color-text-code-editor-status-bar-disabled` · axis: color
  CsColor get colorTextCodeEditorStatusBarDisabled =>
      colorTokens.colorTextCodeEditorStatusBarDisabled;

  /// CSS: `--color-text-code-editor-tab-button-error` · axis: color
  CsColor get colorTextCodeEditorTabButtonError =>
      colorTokens.colorTextCodeEditorTabButtonError;

  /// CSS: `--color-text-column-header` · axis: color
  CsColor get colorTextColumnHeader => colorTokens.colorTextColumnHeader;

  /// CSS: `--color-text-column-sorting-icon` · axis: color
  CsColor get colorTextColumnSortingIcon =>
      colorTokens.colorTextColumnSortingIcon;

  /// CSS: `--color-text-control-disabled` · axis: color
  CsColor get colorTextControlDisabled => colorTokens.colorTextControlDisabled;

  /// The default color for counters. For example: counters in table headers
  ///
  /// CSS: `--color-text-counter` · axis: color · themeable · exposed
  CsColor get colorTextCounter => colorTokens.colorTextCounter;

  /// CSS: `--color-text-disabled` · axis: color
  CsColor get colorTextDisabled => colorTokens.colorTextDisabled;

  /// CSS: `--color-text-disabled-inline-edit` · axis: color
  CsColor get colorTextDisabledInlineEdit =>
      colorTokens.colorTextDisabledInlineEdit;

  /// CSS: `--color-text-dropdown-footer` · axis: color
  CsColor get colorTextDropdownFooter => colorTokens.colorTextDropdownFooter;

  /// CSS: `--color-text-dropdown-group-label` · axis: color
  CsColor get colorTextDropdownGroupLabel =>
      colorTokens.colorTextDropdownGroupLabel;

  /// The default text color of dropdown items. For example: label and label tag
  /// text color for autosuggest, select, and multiselect.
  ///
  /// CSS: `--color-text-dropdown-item-default` · axis: color · themeable · exposed
  CsColor get colorTextDropdownItemDefault =>
      colorTokens.colorTextDropdownItemDefault;

  /// CSS: `--color-text-dropdown-item-dimmed` · axis: color
  CsColor get colorTextDropdownItemDimmed =>
      colorTokens.colorTextDropdownItemDimmed;

  /// The text color of disabled dropdown items. For example: label, label tag,
  /// description, and tag text color of a disabled item in a select,
  /// multiselect, and autosuggest.
  ///
  /// CSS: `--color-text-dropdown-item-disabled` · axis: color · themeable · exposed
  CsColor get colorTextDropdownItemDisabled =>
      colorTokens.colorTextDropdownItemDisabled;

  /// The color of text matching a user's query. For example: the text matching
  /// a query entered into a table filter, select, multiselect, or autosuggest.
  ///
  /// CSS: `--color-text-dropdown-item-filter-match` · axis: color · themeable · exposed
  CsColor get colorTextDropdownItemFilterMatch =>
      colorTokens.colorTextDropdownItemFilterMatch;

  /// The text color of hovered or selected dropdown items. For example: label
  /// text color of the item on hover in a select, multiselect, and autosuggest.
  ///
  /// CSS: `--color-text-dropdown-item-highlighted` · axis: color · themeable · exposed
  CsColor get colorTextDropdownItemHighlighted =>
      colorTokens.colorTextDropdownItemHighlighted;

  /// The text color of secondary information in dropdown items. For example:
  /// descriptions and tags text color in a select, multiselect, and
  /// autosuggest.
  ///
  /// CSS: `--color-text-dropdown-item-secondary` · axis: color · themeable · exposed
  CsColor get colorTextDropdownItemSecondary =>
      colorTokens.colorTextDropdownItemSecondary;

  /// CSS: `--color-text-dropdown-item-secondary-hover` · axis: color
  CsColor get colorTextDropdownItemSecondaryHover =>
      colorTokens.colorTextDropdownItemSecondaryHover;

  /// The color of text in non-dropdown empty states. For example: tables, card
  /// collections, and attribute editor empty state text.
  ///
  /// CSS: `--color-text-empty` · axis: color · themeable · exposed
  CsColor get colorTextEmpty => colorTokens.colorTextEmpty;

  /// The default color of the expandable section header text.
  ///
  /// CSS: `--color-text-expandable-section-default` · axis: color · themeable · exposed
  CsColor get colorTextExpandableSectionDefault =>
      colorTokens.colorTextExpandableSectionDefault;

  /// The color of the expandable section header text in hover state.
  ///
  /// CSS: `--color-text-expandable-section-hover` · axis: color · themeable · exposed
  CsColor get colorTextExpandableSectionHover =>
      colorTokens.colorTextExpandableSectionHover;

  /// The default color of the expand icon in the navigation variant of the
  /// expandable section.
  ///
  /// CSS: `--color-text-expandable-section-navigation-icon-default` · axis: color · themeable · exposed
  CsColor get colorTextExpandableSectionNavigationIconDefault =>
      colorTokens.colorTextExpandableSectionNavigationIconDefault;

  /// CSS: `--color-border-expandable-section-default` · axis: color · themeable
  CsColor get colorBorderExpandableSectionDefault =>
      colorTokens.colorBorderExpandableSectionDefault;

  /// The default color of form field labels and values. For example: the label
  /// in form fields, checkboxes, radio buttons, toggles, and the value in
  /// inputs and text areas.
  ///
  /// CSS: `--color-text-form-default` · axis: color · themeable · exposed
  CsColor get colorTextFormDefault => colorTokens.colorTextFormDefault;

  /// CSS: `--color-text-form-label` · axis: color · themeable
  CsColor get colorTextFormLabel => colorTokens.colorTextFormLabel;

  /// The color of secondary text in form fields and controls. For example: the
  /// description and constraint text in form fields, the descriptions in
  /// checkboxes, radio buttons, toggles, and any additional info in an
  /// attribute editor.
  ///
  /// CSS: `--color-text-form-secondary` · axis: color · themeable · exposed
  CsColor get colorTextFormSecondary => colorTokens.colorTextFormSecondary;

  /// The default color for group labels. For example: group label in dropdown
  /// part of button dropdown, select, and multiselect, and group label in table
  /// and cards' preferences content selector.
  ///
  /// CSS: `--color-text-group-label` · axis: color · themeable · exposed
  CsColor get colorTextGroupLabel => colorTokens.colorTextGroupLabel;

  /// The default color for labels indicating that content is produced by
  /// generative AI.
  ///
  /// CSS: `--color-text-label-gen-ai` · axis: color · exposed
  CsColor get colorTextLabelGenAi => colorTokens.colorTextLabelGenAi;

  /// The default color for headings 2-5. For example: headings in containers,
  /// form sections, forms, and app layout panels.
  ///
  /// CSS: `--color-text-heading-default` · axis: color · themeable · exposed
  CsColor get colorTextHeadingDefault => colorTokens.colorTextHeadingDefault;

  /// The default color for secondary heading text such as page and container
  /// descriptions. For example: descriptions in containers such as form
  /// sections, tables, and card collections, as well as form page descriptions.
  ///
  /// CSS: `--color-text-heading-secondary` · axis: color · themeable · exposed
  CsColor get colorTextHeadingSecondary =>
      colorTokens.colorTextHeadingSecondary;

  /// The color of the home header's text, displayed on the Service's home page.
  ///
  /// CSS: `--color-text-home-header-default` · axis: color · themeable · exposed
  CsColor get colorTextHomeHeaderDefault =>
      colorTokens.colorTextHomeHeaderDefault;

  /// The color of the home header's secondary text, displayed on the Service's
  /// home page.
  ///
  /// CSS: `--color-text-home-header-secondary` · axis: color · themeable · exposed
  CsColor get colorTextHomeHeaderSecondary =>
      colorTokens.colorTextHomeHeaderSecondary;

  /// CSS: `--color-text-icon-caret` · axis: color
  CsColor get colorTextIconCaret => colorTokens.colorTextIconCaret;

  /// The color of subtle icons. For example: secondary icons with lower visual
  /// emphasis.
  ///
  /// CSS: `--color-text-icon-subtle` · axis: color · themeable · exposed
  CsColor get colorTextIconSubtle => colorTokens.colorTextIconSubtle;

  /// The color of the text value in a disabled input. For example: text in a
  /// disabled input, autosuggest, datepicker, and the trigger of a select and
  /// multiselect.
  ///
  /// CSS: `--color-text-input-disabled` · axis: color · themeable · exposed
  CsColor get colorTextInputDisabled => colorTokens.colorTextInputDisabled;

  /// The color of placeholder text in an input. For example: placeholder text
  /// in an input, autosuggest, datepicker, and the trigger of a select and
  /// multiselect.
  ///
  /// CSS: `--color-text-input-placeholder` · axis: color · themeable · exposed
  CsColor get colorTextInputPlaceholder =>
      colorTokens.colorTextInputPlaceholder;

  /// CSS: `--color-text-input-placeholder-disabled` · axis: color
  CsColor get colorTextInputPlaceholderDisabled =>
      colorTokens.colorTextInputPlaceholderDisabled;

  /// The color of clickable elements in their active state. For example: tabs
  /// and icons.
  ///
  /// CSS: `--color-text-interactive-active` · axis: color · themeable · exposed
  CsColor get colorTextInteractiveActive =>
      colorTokens.colorTextInteractiveActive;

  /// The color of clickable elements in their default state. For example: tabs,
  /// and icons.
  ///
  /// CSS: `--color-text-interactive-default` · axis: color · themeable · exposed
  CsColor get colorTextInteractiveDefault =>
      colorTokens.colorTextInteractiveDefault;

  /// The color of clickable elements in their disabled state. For example:
  /// disabled tabs, button text, and icons.
  ///
  /// CSS: `--color-text-interactive-disabled` · axis: color · themeable · exposed
  CsColor get colorTextInteractiveDisabled =>
      colorTokens.colorTextInteractiveDisabled;

  /// The color of clickable elements on hover. For example: icons on hover.
  ///
  /// CSS: `--color-text-interactive-hover` · axis: color · themeable · exposed
  CsColor get colorTextInteractiveHover =>
      colorTokens.colorTextInteractiveHover;

  /// The pressed text color of icon toggle buttons.
  ///
  /// CSS: `--color-text-toggle-button-icon-pressed` · axis: color · themeable · exposed
  CsColor get colorTextToggleButtonIconPressed =>
      colorTokens.colorTextToggleButtonIconPressed;

  /// The default color of clickable elements in the flashbar. For example: The
  /// dismiss icon button in a flashbar.
  ///
  /// CSS: `--color-text-interactive-inverted-default` · axis: color · themeable · exposed
  CsColor get colorTextInteractiveInvertedDefault =>
      colorTokens.colorTextInteractiveInvertedDefault;

  /// The hover color of clickable elements in the flashbar. For example: The
  /// dismiss icon button in a flashbar.
  ///
  /// CSS: `--color-text-interactive-inverted-hover` · axis: color · themeable · exposed
  CsColor get colorTextInteractiveInvertedHover =>
      colorTokens.colorTextInteractiveInvertedHover;

  /// CSS: `--color-text-inverted` · axis: color
  CsColor get colorTextInverted => colorTokens.colorTextInverted;

  /// The default color for non-form labels. For example: the key in key/value
  /// pairs and card's sections labels.
  ///
  /// CSS: `--color-text-label` · axis: color · themeable · exposed
  CsColor get colorTextLabel => colorTokens.colorTextLabel;

  /// CSS: `--color-text-key-value-pairs-value` · axis: color · themeable
  CsColor get colorTextKeyValuePairsValue =>
      colorTokens.colorTextKeyValuePairsValue;

  /// The default color of the app layout toggle.
  ///
  /// CSS: `--color-text-layout-toggle` · axis: color · themeable · exposed
  CsColor get colorTextLayoutToggle => colorTokens.colorTextLayoutToggle;

  /// The color of the app layout toggle button when it's active.
  ///
  /// CSS: `--color-text-layout-toggle-active` · axis: color · themeable · exposed
  CsColor get colorTextLayoutToggleActive =>
      colorTokens.colorTextLayoutToggleActive;

  /// The color of the app layout toggle button on hover.
  ///
  /// CSS: `--color-text-layout-toggle-hover` · axis: color · themeable · exposed
  CsColor get colorTextLayoutToggleHover =>
      colorTokens.colorTextLayoutToggleHover;

  /// The color of the app layout toggle button when it's selected.
  ///
  /// CSS: `--color-text-layout-toggle-selected` · axis: color · themeable · exposed
  CsColor get colorTextLayoutToggleSelected =>
      colorTokens.colorTextLayoutToggleSelected;

  /// The default color for links. For example: text in an anchor tag, info
  /// links, breadcrumb links, and icon links.
  ///
  /// CSS: `--color-text-link-default` · axis: color · themeable · exposed
  CsColor get colorTextLinkDefault => colorTokens.colorTextLinkDefault;

  /// The hover color for links. For example: text in an anchor tag, info links,
  /// breadcrumb links, and icon links.
  ///
  /// CSS: `--color-text-link-hover` · axis: color · themeable · exposed
  CsColor get colorTextLinkHover => colorTokens.colorTextLinkHover;

  /// The default color of the text decoration (underline) of links. Defaults to
  /// the link text color.
  ///
  /// CSS: `--color-text-link-decoration-default` · axis: color · themeable · exposed
  CsColorValue get colorTextLinkDecorationDefault =>
      colorTokens.colorTextLinkDecorationDefault;

  /// The hover color of the text decoration (underline) of links. Defaults to
  /// the link hover text color.
  ///
  /// CSS: `--color-text-link-decoration-hover` · axis: color · themeable · exposed
  CsColorValue get colorTextLinkDecorationHover =>
      colorTokens.colorTextLinkDecorationHover;

  /// The default color for secondary links. For example: links with lower
  /// visual emphasis or supplementary content.
  ///
  /// CSS: `--color-text-link-secondary-default` · axis: color · themeable · exposed
  CsColor get colorTextLinkSecondaryDefault =>
      colorTokens.colorTextLinkSecondaryDefault;

  /// The hover color for secondary links. For example: links with lower visual
  /// emphasis or supplementary content.
  ///
  /// CSS: `--color-text-link-secondary-hover` · axis: color · themeable · exposed
  CsColor get colorTextLinkSecondaryHover =>
      colorTokens.colorTextLinkSecondaryHover;

  /// CSS: `--color-text-link-secondary-decoration-default` · axis: color
  CsColor get colorTextLinkSecondaryDecorationDefault =>
      colorTokens.colorTextLinkSecondaryDecorationDefault;

  /// The default color for info links.
  ///
  /// CSS: `--color-text-link-info-default` · axis: color · themeable · exposed
  CsColor get colorTextLinkInfoDefault => colorTokens.colorTextLinkInfoDefault;

  /// The hover color for info links.
  ///
  /// CSS: `--color-text-link-info-hover` · axis: color · themeable · exposed
  CsColor get colorTextLinkInfoHover => colorTokens.colorTextLinkInfoHover;

  /// CSS: `--color-text-link-inverted-default` · axis: color
  CsColor get colorTextLinkInvertedDefault =>
      colorTokens.colorTextLinkInvertedDefault;

  /// CSS: `--color-text-link-inverted-hover` · axis: color
  CsColor get colorTextLinkInvertedHover =>
      colorTokens.colorTextLinkInvertedHover;

  /// CSS: `--color-text-link-button-underline` · axis: color
  CsColor get colorTextLinkButtonUnderline =>
      colorTokens.colorTextLinkButtonUnderline;

  /// CSS: `--color-text-link-button-underline-hover` · axis: color
  CsColor get colorTextLinkButtonUnderlineHover =>
      colorTokens.colorTextLinkButtonUnderlineHover;

  /// Default text color for notifications. For example: the text on badges and
  /// flashes.
  ///
  /// CSS: `--color-text-notification-default` · axis: color · themeable · exposed
  CsColor get colorTextNotificationDefault =>
      colorTokens.colorTextNotificationDefault;

  /// CSS: `--color-text-alert-default` · axis: color
  CsColor get colorTextAlertDefault => colorTokens.colorTextAlertDefault;

  /// CSS: `--color-text-notification-link-default` · axis: color
  CsColor get colorTextNotificationLinkDefault =>
      colorTokens.colorTextNotificationLinkDefault;

  /// CSS: `--color-text-notification-link-hover` · axis: color
  CsColor get colorTextNotificationLinkHover =>
      colorTokens.colorTextNotificationLinkHover;

  /// CSS: `--color-text-notification-stack-bar` · axis: color
  CsColor get colorTextNotificationStackBar =>
      colorTokens.colorTextNotificationStackBar;

  /// The text and foreground color used on warning flash messages (yellow
  /// notification surface).
  ///
  /// CSS: `--color-text-notification-yellow` · axis: color · themeable · exposed
  CsColor get colorTextNotificationYellow =>
      colorTokens.colorTextNotificationYellow;

  /// CSS: `--color-text-pagination-page-number-active-disabled` · axis: color
  CsColor get colorTextPaginationPageNumberActiveDisabled =>
      colorTokens.colorTextPaginationPageNumberActiveDisabled;

  /// CSS: `--color-text-pagination-page-number-default` · axis: color
  CsColor get colorTextPaginationPageNumberDefault =>
      colorTokens.colorTextPaginationPageNumberDefault;

  /// The text color of the active segment in a segmented control.
  ///
  /// CSS: `--color-text-segment-active` · axis: color · themeable · exposed
  CsColor get colorTextSegmentActive => colorTokens.colorTextSegmentActive;

  /// The text color of inactive segments in a segmented control.
  ///
  /// CSS: `--color-text-segment-default` · axis: color · themeable · exposed
  CsColor get colorTextSegmentDefault => colorTokens.colorTextSegmentDefault;

  /// The text color of inactive segments in a segmented control on hover.
  ///
  /// CSS: `--color-text-segment-hover` · axis: color · themeable · exposed
  CsColor get colorTextSegmentHover => colorTokens.colorTextSegmentHover;

  /// CSS: `--color-text-small` · axis: color
  CsColor get colorTextSmall => colorTokens.colorTextSmall;

  /// CSS: `--color-text-flashbar-icon-error` · axis: color
  CsColor get colorTextFlashbarIconError =>
      colorTokens.colorTextFlashbarIconError;

  /// CSS: `--color-text-flashbar-icon-info` · axis: color
  CsColor get colorTextFlashbarIconInfo =>
      colorTokens.colorTextFlashbarIconInfo;

  /// CSS: `--color-text-flashbar-icon-success` · axis: color
  CsColor get colorTextFlashbarIconSuccess =>
      colorTokens.colorTextFlashbarIconSuccess;

  /// CSS: `--color-text-flashbar-icon-warning` · axis: color
  CsColor get colorTextFlashbarIconWarning =>
      colorTokens.colorTextFlashbarIconWarning;

  /// CSS: `--color-text-alert-icon-error` · axis: color
  CsColor get colorTextAlertIconError => colorTokens.colorTextAlertIconError;

  /// CSS: `--color-text-alert-icon-info` · axis: color
  CsColor get colorTextAlertIconInfo => colorTokens.colorTextAlertIconInfo;

  /// CSS: `--color-text-alert-icon-success` · axis: color
  CsColor get colorTextAlertIconSuccess =>
      colorTokens.colorTextAlertIconSuccess;

  /// CSS: `--color-text-alert-icon-warning` · axis: color
  CsColor get colorTextAlertIconWarning =>
      colorTokens.colorTextAlertIconWarning;

  /// The color of error text and icons. For example: form field error text and
  /// error status indicators.
  ///
  /// CSS: `--color-text-status-error` · axis: color · themeable · exposed
  CsColor get colorTextStatusError => colorTokens.colorTextStatusError;

  /// The color of inactive and loading text and icons. For example: table and
  /// card collection loading states icon and text and inactive and pending
  /// status indicators.
  ///
  /// CSS: `--color-text-status-inactive` · axis: color · themeable · exposed
  CsColor get colorTextStatusInactive => colorTokens.colorTextStatusInactive;

  /// The color of info text and icons. For example: info status indicators and
  /// info alert icon.
  ///
  /// CSS: `--color-text-status-info` · axis: color · themeable · exposed
  CsColor get colorTextStatusInfo => colorTokens.colorTextStatusInfo;

  /// The color of success text and icons. For example: success status
  /// indicators and success alert icon.
  ///
  /// CSS: `--color-text-status-success` · axis: color · themeable · exposed
  CsColor get colorTextStatusSuccess => colorTokens.colorTextStatusSuccess;

  /// The color of warning icons.
  ///
  /// CSS: `--color-text-status-warning` · axis: color · themeable · exposed
  CsColor get colorTextStatusWarning => colorTokens.colorTextStatusWarning;

  /// The color of the title in the top navigation.
  ///
  /// CSS: `--color-text-top-navigation-title` · axis: color · themeable · exposed
  CsColor get colorTextTopNavigationTitle =>
      colorTokens.colorTextTopNavigationTitle;

  /// CSS: `--color-text-tutorial-hotspot-default` · axis: color
  CsColor get colorTextTutorialHotspotDefault =>
      colorTokens.colorTextTutorialHotspotDefault;

  /// CSS: `--color-text-tutorial-hotspot-hover` · axis: color
  CsColor get colorTextTutorialHotspotHover =>
      colorTokens.colorTextTutorialHotspotHover;

  /// The color of board placeholder in active state.
  ///
  /// CSS: `--color-board-placeholder-active` · axis: color · exposed
  CsColor get colorBoardPlaceholderActive =>
      colorTokens.colorBoardPlaceholderActive;

  /// The color of board placeholder in hovered state.
  ///
  /// CSS: `--color-board-placeholder-hover` · axis: color · exposed
  CsColor get colorBoardPlaceholderHover =>
      colorTokens.colorBoardPlaceholderHover;

  /// The color of drag placeholder in active state.
  ///
  /// CSS: `--color-drag-placeholder-active` · axis: color · exposed
  CsColor get colorDragPlaceholderActive =>
      colorTokens.colorDragPlaceholderActive;

  /// The color of drag placeholder in hovered state.
  ///
  /// CSS: `--color-drag-placeholder-hover` · axis: color · exposed
  CsColor get colorDragPlaceholderHover =>
      colorTokens.colorDragPlaceholderHover;

  /// The default color of file upload dropzone background.
  ///
  /// CSS: `--color-dropzone-background-default` · axis: color · themeable · exposed
  CsColor get colorDropzoneBackgroundDefault =>
      colorTokens.colorDropzoneBackgroundDefault;

  /// The color of file upload dropzone background in hovered state.
  ///
  /// CSS: `--color-dropzone-background-hover` · axis: color · themeable · exposed
  CsColor get colorDropzoneBackgroundHover =>
      colorTokens.colorDropzoneBackgroundHover;

  /// The default color of file upload dropzone text.
  ///
  /// CSS: `--color-dropzone-text-default` · axis: color · themeable · exposed
  CsColor get colorDropzoneTextDefault => colorTokens.colorDropzoneTextDefault;

  /// The color of file upload dropzone text in hovered state.
  ///
  /// CSS: `--color-dropzone-text-hover` · axis: color · themeable · exposed
  CsColor get colorDropzoneTextHover => colorTokens.colorDropzoneTextHover;

  /// The default color of file upload dropzone border.
  ///
  /// CSS: `--color-dropzone-border-default` · axis: color · themeable · exposed
  CsColor get colorDropzoneBorderDefault =>
      colorTokens.colorDropzoneBorderDefault;

  /// The color of file upload dropzone border in hovered state.
  ///
  /// CSS: `--color-dropzone-border-hover` · axis: color · themeable · exposed
  CsColor get colorDropzoneBorderHover => colorTokens.colorDropzoneBorderHover;

  /// CSS: `--color-gap-global-drawer` · axis: color
  CsColor get colorGapGlobalDrawer => colorTokens.colorGapGlobalDrawer;

  /// The color of the tree view connector lines.
  ///
  /// CSS: `--color-tree-view-connector-line` · axis: color · themeable · exposed
  CsColor get colorTreeViewConnectorLine =>
      colorTokens.colorTreeViewConnectorLine;

  /// The default background color of action cards.
  ///
  /// CSS: `--color-background-action-card-default` · axis: color · themeable · exposed
  CsColor get colorBackgroundActionCardDefault =>
      colorTokens.colorBackgroundActionCardDefault;

  /// The background color of action cards in hover state.
  ///
  /// CSS: `--color-background-action-card-hover` · axis: color · themeable · exposed
  CsColor get colorBackgroundActionCardHover =>
      colorTokens.colorBackgroundActionCardHover;

  /// The background color of action cards in active state.
  ///
  /// CSS: `--color-background-action-card-active` · axis: color · themeable · exposed
  CsColor get colorBackgroundActionCardActive =>
      colorTokens.colorBackgroundActionCardActive;

  /// The default border color of action cards.
  ///
  /// CSS: `--color-border-action-card-default` · axis: color · themeable · exposed
  CsColor get colorBorderActionCardDefault =>
      colorTokens.colorBorderActionCardDefault;

  /// The border color of action cards in hover state.
  ///
  /// CSS: `--color-border-action-card-hover` · axis: color · themeable · exposed
  CsColor get colorBorderActionCardHover =>
      colorTokens.colorBorderActionCardHover;

  /// The border color of action cards in active state.
  ///
  /// CSS: `--color-border-action-card-active` · axis: color · themeable · exposed
  CsColor get colorBorderActionCardActive =>
      colorTokens.colorBorderActionCardActive;

  /// The border color of action cards in disabled state.
  ///
  /// CSS: `--color-border-action-card-disabled` · axis: color · themeable · exposed
  CsColor get colorBorderActionCardDisabled =>
      colorTokens.colorBorderActionCardDisabled;

  /// The background color of action cards in disabled state.
  ///
  /// CSS: `--color-background-action-card-disabled` · axis: color · themeable · exposed
  CsColor get colorBackgroundActionCardDisabled =>
      colorTokens.colorBackgroundActionCardDisabled;

  /// The text color of action cards in disabled state.
  ///
  /// CSS: `--color-text-action-card-disabled` · axis: color · themeable · exposed
  CsColor get colorTextActionCardDisabled =>
      colorTokens.colorTextActionCardDisabled;

  /// The default color of icons in action cards.
  ///
  /// CSS: `--color-text-action-card-icon-default` · axis: color · themeable · exposed
  CsColor get colorTextActionCardIconDefault =>
      colorTokens.colorTextActionCardIconDefault;

  /// The color of icons in action cards in hover state.
  ///
  /// CSS: `--color-text-action-card-icon-hover` · axis: color · themeable · exposed
  CsColor get colorTextActionCardIconHover =>
      colorTokens.colorTextActionCardIconHover;

  /// The color of icons in action cards in active state.
  ///
  /// CSS: `--color-text-action-card-icon-active` · axis: color · themeable · exposed
  CsColor get colorTextActionCardIconActive =>
      colorTokens.colorTextActionCardIconActive;

  /// The color of icons in action cards in disabled state.
  ///
  /// CSS: `--color-text-action-card-icon-disabled` · axis: color · themeable · exposed
  CsColor get colorTextActionCardIconDisabled =>
      colorTokens.colorTextActionCardIconDisabled;

  /// CSS: `--color-background-skeleton` · axis: color
  CsColor get colorBackgroundSkeleton => colorTokens.colorBackgroundSkeleton;

  /// CSS: `--color-background-skeleton-wave` · axis: color
  CsColor get colorBackgroundSkeletonWave =>
      colorTokens.colorBackgroundSkeletonWave;

  /// The background color of green badges.
  ///
  /// CSS: `--color-background-badge-green` · axis: color · themeable · exposed
  CsColor get colorBackgroundBadgeGreen =>
      colorTokens.colorBackgroundBadgeGreen;

  /// The background color of blue badges.
  ///
  /// CSS: `--color-background-badge-blue` · axis: color · themeable · exposed
  CsColor get colorBackgroundBadgeBlue => colorTokens.colorBackgroundBadgeBlue;

  /// The background color of red badges.
  ///
  /// CSS: `--color-background-badge-red` · axis: color · themeable · exposed
  CsColor get colorBackgroundBadgeRed => colorTokens.colorBackgroundBadgeRed;

  /// The background color of yellow badges.
  ///
  /// CSS: `--color-background-badge-yellow` · axis: color · themeable · exposed
  CsColor get colorBackgroundBadgeYellow =>
      colorTokens.colorBackgroundBadgeYellow;

  /// The background color of grey badges.
  ///
  /// CSS: `--color-background-badge-grey` · axis: color · themeable · exposed
  CsColor get colorBackgroundBadgeGrey => colorTokens.colorBackgroundBadgeGrey;

  /// The default border color of badges.
  ///
  /// CSS: `--color-border-badge` · axis: color · themeable · exposed
  CsColor get colorBorderBadge => colorTokens.colorBorderBadge;

  /// The border color of grey badges.
  ///
  /// CSS: `--color-border-badge-grey` · axis: color · themeable · exposed
  CsColor get colorBorderBadgeGrey => colorTokens.colorBorderBadgeGrey;

  /// The border color of green badges.
  ///
  /// CSS: `--color-border-badge-green` · axis: color · themeable · exposed
  CsColor get colorBorderBadgeGreen => colorTokens.colorBorderBadgeGreen;

  /// The border color of blue badges.
  ///
  /// CSS: `--color-border-badge-blue` · axis: color · themeable · exposed
  CsColor get colorBorderBadgeBlue => colorTokens.colorBorderBadgeBlue;

  /// The border color of red badges.
  ///
  /// CSS: `--color-border-badge-red` · axis: color · themeable · exposed
  CsColor get colorBorderBadgeRed => colorTokens.colorBorderBadgeRed;

  /// The text color of grey badges.
  ///
  /// CSS: `--color-text-badge-grey` · axis: color · themeable · exposed
  CsColor get colorTextBadgeGrey => colorTokens.colorTextBadgeGrey;

  /// The text color of green badges.
  ///
  /// CSS: `--color-text-badge-green` · axis: color · themeable · exposed
  CsColor get colorTextBadgeGreen => colorTokens.colorTextBadgeGreen;

  /// The text color of blue badges.
  ///
  /// CSS: `--color-text-badge-blue` · axis: color · themeable · exposed
  CsColor get colorTextBadgeBlue => colorTokens.colorTextBadgeBlue;

  /// The text color of red badges.
  ///
  /// CSS: `--color-text-badge-red` · axis: color · themeable · exposed
  CsColor get colorTextBadgeRed => colorTokens.colorTextBadgeRed;

  /// The background color of the code view component.
  ///
  /// CSS: `--color-background-code-view` · axis: color · themeable · exposed
  CsColor get colorBackgroundCodeView => colorTokens.colorBackgroundCodeView;

  /// CSS: `--color-background-visual-accent-red` · axis: color
  CsColor get colorBackgroundVisualAccentRed =>
      colorTokens.colorBackgroundVisualAccentRed;

  /// CSS: `--color-background-visual-accent-yellow` · axis: color
  CsColor get colorBackgroundVisualAccentYellow =>
      colorTokens.colorBackgroundVisualAccentYellow;

  /// CSS: `--color-background-visual-accent-indigo` · axis: color
  CsColor get colorBackgroundVisualAccentIndigo =>
      colorTokens.colorBackgroundVisualAccentIndigo;

  /// CSS: `--color-background-visual-accent-green` · axis: color
  CsColor get colorBackgroundVisualAccentGreen =>
      colorTokens.colorBackgroundVisualAccentGreen;

  /// CSS: `--color-background-visual-accent-orange` · axis: color
  CsColor get colorBackgroundVisualAccentOrange =>
      colorTokens.colorBackgroundVisualAccentOrange;

  /// CSS: `--color-background-visual-accent-purple` · axis: color
  CsColor get colorBackgroundVisualAccentPurple =>
      colorTokens.colorBackgroundVisualAccentPurple;

  /// CSS: `--color-background-visual-accent-lime` · axis: color
  CsColor get colorBackgroundVisualAccentLime =>
      colorTokens.colorBackgroundVisualAccentLime;

  /// CSS: `--color-background-visual-accent-grey` · axis: color
  CsColor get colorBackgroundVisualAccentGrey =>
      colorTokens.colorBackgroundVisualAccentGrey;

  /// CSS: `--color-background-visual-accent-teal` · axis: color
  CsColor get colorBackgroundVisualAccentTeal =>
      colorTokens.colorBackgroundVisualAccentTeal;

  /// CSS: `--color-background-visual-accent-blue` · axis: color
  CsColor get colorBackgroundVisualAccentBlue =>
      colorTokens.colorBackgroundVisualAccentBlue;

  /// CSS: `--color-background-visual-accent-violet` · axis: color
  CsColor get colorBackgroundVisualAccentViolet =>
      colorTokens.colorBackgroundVisualAccentViolet;

  /// CSS: `--color-background-visual-accent-magenta` · axis: color
  CsColor get colorBackgroundVisualAccentMagenta =>
      colorTokens.colorBackgroundVisualAccentMagenta;

  /// CSS: `--color-background-visual-accent-pink` · axis: color
  CsColor get colorBackgroundVisualAccentPink =>
      colorTokens.colorBackgroundVisualAccentPink;

  /// CSS: `--color-background-visual-accent-amber` · axis: color
  CsColor get colorBackgroundVisualAccentAmber =>
      colorTokens.colorBackgroundVisualAccentAmber;

  /// CSS: `--color-text-visual-accent-red` · axis: color
  CsColor get colorTextVisualAccentRed => colorTokens.colorTextVisualAccentRed;

  /// CSS: `--color-text-visual-accent-yellow` · axis: color
  CsColor get colorTextVisualAccentYellow =>
      colorTokens.colorTextVisualAccentYellow;

  /// CSS: `--color-text-visual-accent-indigo` · axis: color
  CsColor get colorTextVisualAccentIndigo =>
      colorTokens.colorTextVisualAccentIndigo;

  /// CSS: `--color-text-visual-accent-green` · axis: color
  CsColor get colorTextVisualAccentGreen =>
      colorTokens.colorTextVisualAccentGreen;

  /// CSS: `--color-text-visual-accent-orange` · axis: color
  CsColor get colorTextVisualAccentOrange =>
      colorTokens.colorTextVisualAccentOrange;

  /// CSS: `--color-text-visual-accent-purple` · axis: color
  CsColor get colorTextVisualAccentPurple =>
      colorTokens.colorTextVisualAccentPurple;

  /// CSS: `--color-text-visual-accent-lime` · axis: color
  CsColor get colorTextVisualAccentLime =>
      colorTokens.colorTextVisualAccentLime;

  /// CSS: `--color-text-visual-accent-grey` · axis: color
  CsColor get colorTextVisualAccentGrey =>
      colorTokens.colorTextVisualAccentGrey;

  /// CSS: `--color-text-visual-accent-teal` · axis: color
  CsColor get colorTextVisualAccentTeal =>
      colorTokens.colorTextVisualAccentTeal;

  /// CSS: `--color-text-visual-accent-blue` · axis: color
  CsColor get colorTextVisualAccentBlue =>
      colorTokens.colorTextVisualAccentBlue;

  /// CSS: `--color-text-visual-accent-violet` · axis: color
  CsColor get colorTextVisualAccentViolet =>
      colorTokens.colorTextVisualAccentViolet;

  /// CSS: `--color-text-visual-accent-magenta` · axis: color
  CsColor get colorTextVisualAccentMagenta =>
      colorTokens.colorTextVisualAccentMagenta;

  /// CSS: `--color-text-visual-accent-pink` · axis: color
  CsColor get colorTextVisualAccentPink =>
      colorTokens.colorTextVisualAccentPink;

  /// CSS: `--color-text-visual-accent-amber` · axis: color
  CsColor get colorTextVisualAccentAmber =>
      colorTokens.colorTextVisualAccentAmber;

  /// CSS: `--font-box-value-large-weight` · axis: none
  CsFontWeight get fontBoxValueLargeWeight =>
      staticTokens.fontBoxValueLargeWeight;

  /// CSS: `--font-button-letter-spacing` · axis: none
  CsLength get fontButtonLetterSpacing => staticTokens.fontButtonLetterSpacing;

  /// CSS: `--font-chart-detail-size` · axis: none
  double get fontChartDetailSize => staticTokens.fontChartDetailSize;

  /// CSS: `--font-decoration-style-link` · axis: none · themeable
  String get fontDecorationStyleLink => staticTokens.fontDecorationStyleLink;

  /// CSS: `--font-decoration-line-button-inline-link` · axis: none · themeable
  String get fontDecorationLineButtonInlineLink =>
      staticTokens.fontDecorationLineButtonInlineLink;

  /// CSS: `--font-decoration-line-link-secondary` · axis: none
  String get fontDecorationLineLinkSecondary =>
      staticTokens.fontDecorationLineLinkSecondary;

  /// CSS: `--font-decoration-thickness-link` · axis: none · themeable
  double get fontDecorationThicknessLink =>
      staticTokens.fontDecorationThicknessLink;

  /// CSS: `--font-decoration-thickness-link-display-l` · axis: none · themeable
  double get fontDecorationThicknessLinkDisplayL =>
      staticTokens.fontDecorationThicknessLinkDisplayL;

  /// CSS: `--font-display-label-weight` · axis: none
  CsFontWeight get fontDisplayLabelWeight =>
      staticTokens.fontDisplayLabelWeight;

  /// CSS: `--font-size-expandable-heading` · axis: none · themeable
  double get fontSizeExpandableHeading =>
      staticTokens.fontSizeExpandableHeading;

  /// The default font family that will be applied globally to the product
  /// interface.
  ///
  /// CSS: `--font-family-base` · axis: none · themeable · exposed
  List<String> get fontFamilyBase => staticTokens.fontFamilyBase;

  /// The font family for display text. Defaults to the base font family.
  ///
  /// CSS: `--font-family-display` · axis: none · themeable · exposed
  List<String> get fontFamilyDisplay => staticTokens.fontFamilyDisplay;

  /// The font family for headings and component headers. Defaults to the base
  /// font family.
  ///
  /// CSS: `--font-family-heading` · axis: none · themeable · exposed
  List<String> get fontFamilyHeading => staticTokens.fontFamilyHeading;

  /// The monospace font family that will be applied globally to the product
  /// interface.
  ///
  /// CSS: `--font-family-monospace` · axis: none · themeable · exposed
  List<String> get fontFamilyMonospace => staticTokens.fontFamilyMonospace;

  /// CSS: `--font-header-h2-description-line-height` · axis: none
  double get fontHeaderH2DescriptionLineHeight =>
      staticTokens.fontHeaderH2DescriptionLineHeight;

  /// CSS: `--font-header-h2-description-size` · axis: none
  double get fontHeaderH2DescriptionSize =>
      staticTokens.fontHeaderH2DescriptionSize;

  /// CSS: `--font-link-button-letter-spacing` · axis: none
  CsLength get fontLinkButtonLetterSpacing =>
      staticTokens.fontLinkButtonLetterSpacing;

  /// CSS: `--font-link-button-weight` · axis: none
  CsFontWeight get fontLinkButtonWeight => staticTokens.fontLinkButtonWeight;

  /// CSS: `--font-panel-header-line-height` · axis: none
  double get fontPanelHeaderLineHeight =>
      staticTokens.fontPanelHeaderLineHeight;

  /// CSS: `--font-panel-header-size` · axis: none
  double get fontPanelHeaderSize => staticTokens.fontPanelHeaderSize;

  /// CSS: `--font-side-navigation-section-header-size` · axis: none
  CsLength get fontSideNavigationSectionHeaderSize =>
      staticTokens.fontSideNavigationSectionHeaderSize;

  /// CSS: `--font-side-navigation-section-header-weight` · axis: none
  CsFontWeight get fontSideNavigationSectionHeaderWeight =>
      staticTokens.fontSideNavigationSectionHeaderWeight;

  /// The default font size for regular body text. For example, <p> tags in text
  /// content, or button text.
  ///
  /// CSS: `--font-size-body-m` · axis: none · themeable · exposed
  double get fontSizeBodyM => staticTokens.fontSizeBodyM;

  /// The default font size for small body text. For example, form field
  /// descriptions, or badge text.
  ///
  /// CSS: `--font-size-body-s` · axis: none · themeable · exposed
  double get fontSizeBodyS => staticTokens.fontSizeBodyS;

  /// The default font size for large display text.
  ///
  /// CSS: `--font-size-display-l` · axis: none · themeable · exposed
  double get fontSizeDisplayL => staticTokens.fontSizeDisplayL;

  /// The default font size for extra large display text.
  ///
  /// CSS: `--font-size-display-xl` · axis: none · themeable · exposed
  double get fontSizeDisplayXl => staticTokens.fontSizeDisplayXl;

  /// CSS: `--font-size-form-label` · axis: none · themeable
  double get fontSizeFormLabel => staticTokens.fontSizeFormLabel;

  /// The default font size for h2s.
  ///
  /// CSS: `--font-size-heading-l` · axis: none · themeable · exposed
  double get fontSizeHeadingL => staticTokens.fontSizeHeadingL;

  /// The default font size for h3s.
  ///
  /// CSS: `--font-size-heading-m` · axis: none · themeable · exposed
  double get fontSizeHeadingM => staticTokens.fontSizeHeadingM;

  /// The default font size for h4s.
  ///
  /// CSS: `--font-size-heading-s` · axis: none · themeable · exposed
  double get fontSizeHeadingS => staticTokens.fontSizeHeadingS;

  /// The default font size for h1s.
  ///
  /// CSS: `--font-size-heading-xl` · axis: none · themeable · exposed
  double get fontSizeHeadingXl => staticTokens.fontSizeHeadingXl;

  /// The default font size for h5s.
  ///
  /// CSS: `--font-size-heading-xs` · axis: none · themeable · exposed
  double get fontSizeHeadingXs => staticTokens.fontSizeHeadingXs;

  /// CSS: `--font-size-key-value-pairs-label` · axis: none · themeable
  double get fontSizeKeyValuePairsLabel =>
      staticTokens.fontSizeKeyValuePairsLabel;

  /// The default font size for tabs.
  ///
  /// CSS: `--font-size-tabs` · axis: none · themeable · exposed
  double get fontSizeTabs => staticTokens.fontSizeTabs;

  /// CSS: `--font-smoothing-moz-osx` · axis: none
  String get fontSmoothingMozOsx => staticTokens.fontSmoothingMozOsx;

  /// CSS: `--font-smoothing-webkit` · axis: none
  String get fontSmoothingWebkit => staticTokens.fontSmoothingWebkit;

  /// CSS: `--font-wayfinding-link-active-weight` · axis: none
  CsFontWeight get fontWayfindingLinkActiveWeight =>
      staticTokens.fontWayfindingLinkActiveWeight;

  /// The default font weight for alert header text.
  ///
  /// CSS: `--font-weight-alert-header` · axis: none · themeable · exposed
  CsFontWeight get fontWeightAlertHeader => staticTokens.fontWeightAlertHeader;

  /// The default bold font weight for body text. For example, <strong> and <b>
  /// tags in text content.
  ///
  /// CSS: `--font-weight-bold` · axis: none · themeable · exposed
  CsFontWeight get fontWeightBold => staticTokens.fontWeightBold;

  /// CSS: `--font-weight-breadcrumb-current` · axis: none · themeable
  CsFontWeight get fontWeightBreadcrumbCurrent =>
      staticTokens.fontWeightBreadcrumbCurrent;

  /// The default font weight for button text.
  ///
  /// CSS: `--font-weight-button` · axis: none · themeable · exposed
  CsFontWeight get fontWeightButton => staticTokens.fontWeightButton;

  /// The default font weight for large display text.
  ///
  /// CSS: `--font-weight-display-l` · axis: none · themeable · exposed
  CsFontWeight get fontWeightDisplayL => staticTokens.fontWeightDisplayL;

  /// The default font weight for extra large display text.
  ///
  /// CSS: `--font-weight-display-xl` · axis: none · themeable · exposed
  CsFontWeight get fontWeightDisplayXl => staticTokens.fontWeightDisplayXl;

  /// The default font weight for flashbar header text.
  ///
  /// CSS: `--font-weight-flashbar-header` · axis: none · themeable · exposed
  CsFontWeight get fontWeightFlashbarHeader =>
      staticTokens.fontWeightFlashbarHeader;

  /// CSS: `--font-weight-form-label` · axis: none · themeable
  CsFontWeight get fontWeightFormLabel => staticTokens.fontWeightFormLabel;

  /// The default font weight for h2s.
  ///
  /// CSS: `--font-weight-heading-l` · axis: none · themeable · exposed
  CsFontWeight get fontWeightHeadingL => staticTokens.fontWeightHeadingL;

  /// The default font weight for h3s.
  ///
  /// CSS: `--font-weight-heading-m` · axis: none · themeable · exposed
  CsFontWeight get fontWeightHeadingM => staticTokens.fontWeightHeadingM;

  /// The default font weight for h4s.
  ///
  /// CSS: `--font-weight-heading-s` · axis: none · themeable · exposed
  CsFontWeight get fontWeightHeadingS => staticTokens.fontWeightHeadingS;

  /// The default font weight for h1s.
  ///
  /// CSS: `--font-weight-heading-xl` · axis: none · themeable · exposed
  CsFontWeight get fontWeightHeadingXl => staticTokens.fontWeightHeadingXl;

  /// The default font weight for h5s.
  ///
  /// CSS: `--font-weight-heading-xs` · axis: none · themeable · exposed
  CsFontWeight get fontWeightHeadingXs => staticTokens.fontWeightHeadingXs;

  /// The default heavy font weight.
  ///
  /// CSS: `--font-weight-heavy` · axis: none · themeable · exposed
  CsFontWeight get fontWeightHeavy => staticTokens.fontWeightHeavy;

  /// CSS: `--font-weight-key-value-pairs-label` · axis: none · themeable
  CsFontWeight get fontWeightKeyValuePairsLabel =>
      staticTokens.fontWeightKeyValuePairsLabel;

  /// The default lighter font weight.
  ///
  /// CSS: `--font-weight-lighter` · axis: none · themeable · exposed
  CsFontWeight get fontWeightLighter => staticTokens.fontWeightLighter;

  /// CSS: `--font-weight-link-secondary` · axis: none
  CsFontWeight get fontWeightLinkSecondary =>
      staticTokens.fontWeightLinkSecondary;

  /// The default normal font weight.
  ///
  /// CSS: `--font-weight-normal` · axis: none · themeable · exposed
  CsFontWeight get fontWeightNormal => staticTokens.fontWeightNormal;

  /// The default font weight for tabs.
  ///
  /// CSS: `--font-weight-tabs` · axis: none · themeable · exposed
  CsFontWeight get fontWeightTabs => staticTokens.fontWeightTabs;

  /// The default font weight for disabled tabs.
  ///
  /// CSS: `--font-weight-tabs-disabled` · axis: none · themeable · exposed
  CsFontWeight get fontWeightTabsDisabled =>
      staticTokens.fontWeightTabsDisabled;

  /// CSS: `--letter-spacing-body-s` · axis: none
  CsLength get letterSpacingBodyS => staticTokens.letterSpacingBodyS;

  /// The default letter spacing for large display text.
  ///
  /// CSS: `--letter-spacing-display-l` · axis: none · themeable · exposed
  CsLength get letterSpacingDisplayL => staticTokens.letterSpacingDisplayL;

  /// The default letter spacing for extra large display text.
  ///
  /// CSS: `--letter-spacing-display-xl` · axis: none · themeable · exposed
  CsLength get letterSpacingDisplayXl => staticTokens.letterSpacingDisplayXl;

  /// The default letter spacing for h2s.
  ///
  /// CSS: `--letter-spacing-heading-l` · axis: none · themeable · exposed
  CsLength get letterSpacingHeadingL => staticTokens.letterSpacingHeadingL;

  /// The default letter spacing for h3s.
  ///
  /// CSS: `--letter-spacing-heading-m` · axis: none · themeable · exposed
  CsLength get letterSpacingHeadingM => staticTokens.letterSpacingHeadingM;

  /// The default letter spacing for h4s.
  ///
  /// CSS: `--letter-spacing-heading-s` · axis: none · themeable · exposed
  CsLength get letterSpacingHeadingS => staticTokens.letterSpacingHeadingS;

  /// The default letter spacing for h1s.
  ///
  /// CSS: `--letter-spacing-heading-xl` · axis: none · themeable · exposed
  CsLength get letterSpacingHeadingXl => staticTokens.letterSpacingHeadingXl;

  /// The default letter spacing for h5s.
  ///
  /// CSS: `--letter-spacing-heading-xs` · axis: none · themeable · exposed
  CsLength get letterSpacingHeadingXs => staticTokens.letterSpacingHeadingXs;

  /// The default line height for regular body text.
  ///
  /// CSS: `--line-height-body-m` · axis: none · themeable · exposed
  double get lineHeightBodyM => staticTokens.lineHeightBodyM;

  /// The default line height for small body text.
  ///
  /// CSS: `--line-height-body-s` · axis: none · themeable · exposed
  double get lineHeightBodyS => staticTokens.lineHeightBodyS;

  /// The default line height for large display text.
  ///
  /// CSS: `--line-height-display-l` · axis: none · themeable · exposed
  double get lineHeightDisplayL => staticTokens.lineHeightDisplayL;

  /// The default line height for extra large display text.
  ///
  /// CSS: `--line-height-display-xl` · axis: none · themeable · exposed
  double get lineHeightDisplayXl => staticTokens.lineHeightDisplayXl;

  /// CSS: `--line-height-form-label` · axis: none · themeable
  double get lineHeightFormLabel => staticTokens.lineHeightFormLabel;

  /// The default line height for h2s.
  ///
  /// CSS: `--line-height-heading-l` · axis: none · themeable · exposed
  double get lineHeightHeadingL => staticTokens.lineHeightHeadingL;

  /// The default line height for h3s.
  ///
  /// CSS: `--line-height-heading-m` · axis: none · themeable · exposed
  double get lineHeightHeadingM => staticTokens.lineHeightHeadingM;

  /// The default line height for h4s.
  ///
  /// CSS: `--line-height-heading-s` · axis: none · themeable · exposed
  double get lineHeightHeadingS => staticTokens.lineHeightHeadingS;

  /// The default line height for h1s.
  ///
  /// CSS: `--line-height-heading-xl` · axis: none · themeable · exposed
  double get lineHeightHeadingXl => staticTokens.lineHeightHeadingXl;

  /// The default line height for h5s.
  ///
  /// CSS: `--line-height-heading-xs` · axis: none · themeable · exposed
  double get lineHeightHeadingXs => staticTokens.lineHeightHeadingXs;

  /// CSS: `--line-height-key-value-pairs-label` · axis: none · themeable
  double get lineHeightKeyValuePairsLabel =>
      staticTokens.lineHeightKeyValuePairsLabel;

  /// The default line height for tabs.
  ///
  /// CSS: `--line-height-tabs` · axis: none · themeable · exposed
  double get lineHeightTabs => staticTokens.lineHeightTabs;

  /// CSS: `--border-active-width` · axis: none
  double get borderActiveWidth => staticTokens.borderActiveWidth;

  /// CSS: `--border-code-editor-status-divider-width` · axis: none
  double get borderCodeEditorStatusDividerWidth =>
      staticTokens.borderCodeEditorStatusDividerWidth;

  /// CSS: `--border-container-sticky-width` · axis: none
  double get borderContainerStickyWidth =>
      staticTokens.borderContainerStickyWidth;

  /// CSS: `--border-container-top-width` · axis: none
  double get borderContainerTopWidth => staticTokens.borderContainerTopWidth;

  /// CSS: `--border-control-focus-ring-shadow-spread` · axis: none
  double get borderControlFocusRingShadowSpread =>
      staticTokens.borderControlFocusRingShadowSpread;

  /// CSS: `--border-control-invalid-focus-ring-shadow-spread` · axis: none
  double get borderControlInvalidFocusRingShadowSpread =>
      staticTokens.borderControlInvalidFocusRingShadowSpread;

  /// CSS: `--border-divider-list-width` · axis: none
  double get borderDividerListWidth => staticTokens.borderDividerListWidth;

  /// CSS: `--border-divider-section-width` · axis: none
  double get borderDividerSectionWidth =>
      staticTokens.borderDividerSectionWidth;

  /// CSS: `--border-dropdown-virtual-offset-width` · axis: none
  double get borderDropdownVirtualOffsetWidth =>
      staticTokens.borderDropdownVirtualOffsetWidth;

  /// The inline-start border width of form fields and file tokens in invalid
  /// and warning states.
  ///
  /// CSS: `--border-width-field-status-inline-start` · axis: none · themeable · exposed
  double get borderWidthFieldStatusInlineStart =>
      staticTokens.borderWidthFieldStatusInlineStart;

  /// CSS: `--border-item-width` · axis: none
  double get borderItemWidth => staticTokens.borderItemWidth;

  /// CSS: `--border-line-chart-dash-array` · axis: none
  List<double> get borderLineChartDashArray =>
      staticTokens.borderLineChartDashArray;

  /// CSS: `--border-line-chart-line-join` · axis: none
  String get borderLineChartLineJoin => staticTokens.borderLineChartLineJoin;

  /// CSS: `--border-line-chart-width` · axis: none
  double get borderLineChartWidth => staticTokens.borderLineChartWidth;

  /// CSS: `--border-link-focus-ring-outline` · axis: none
  double get borderLinkFocusRingOutline =>
      staticTokens.borderLinkFocusRingOutline;

  /// CSS: `--border-link-focus-ring-shadow-spread` · axis: none
  double get borderLinkFocusRingShadowSpread =>
      staticTokens.borderLinkFocusRingShadowSpread;

  /// CSS: `--border-panel-header-width` · axis: none
  double get borderPanelHeaderWidth => staticTokens.borderPanelHeaderWidth;

  /// CSS: `--border-panel-top-width` · axis: none
  double get borderPanelTopWidth => staticTokens.borderPanelTopWidth;

  /// The border radius of default action cards.
  ///
  /// CSS: `--border-radius-action-card-default` · axis: none · themeable · exposed
  double get borderRadiusActionCardDefault =>
      staticTokens.borderRadiusActionCardDefault;

  /// The border radius of embedded action cards.
  ///
  /// CSS: `--border-radius-action-card-embedded` · axis: none · themeable · exposed
  double get borderRadiusActionCardEmbedded =>
      staticTokens.borderRadiusActionCardEmbedded;

  /// The border radius of alerts.
  ///
  /// CSS: `--border-radius-alert` · axis: none · themeable · exposed
  double get borderRadiusAlert => staticTokens.borderRadiusAlert;

  /// The border radius of badges.
  ///
  /// CSS: `--border-radius-badge` · axis: none · themeable · exposed
  double get borderRadiusBadge => staticTokens.borderRadiusBadge;

  /// The border radius of buttons and segmented control's segments.
  ///
  /// CSS: `--border-radius-button` · axis: none · themeable · exposed
  double get borderRadiusButton => staticTokens.borderRadiusButton;

  /// The border radius of the focused day in date picker and date range picker.
  ///
  /// CSS: `--border-radius-calendar-day-focus-ring` · axis: none · themeable · exposed
  double get borderRadiusCalendarDayFocusRing =>
      staticTokens.borderRadiusCalendarDayFocusRing;

  /// The border radius of default cards.
  ///
  /// CSS: `--border-radius-card-default` · axis: none · themeable · exposed
  double get borderRadiusCardDefault => staticTokens.borderRadiusCardDefault;

  /// The border radius of embedded cards.
  ///
  /// CSS: `--border-radius-card-embedded` · axis: none · themeable · exposed
  double get borderRadiusCardEmbedded => staticTokens.borderRadiusCardEmbedded;

  /// The border radius of chat bubbles.
  ///
  /// CSS: `--border-radius-chat-bubble` · axis: none · themeable · exposed
  double get borderRadiusChatBubble => staticTokens.borderRadiusChatBubble;

  /// The border radius of support prompts.
  ///
  /// CSS: `--border-radius-support-prompt` · axis: none · themeable · exposed
  double get borderRadiusSupportPrompt =>
      staticTokens.borderRadiusSupportPrompt;

  /// CSS: `--border-radius-code-editor` · axis: none
  double get borderRadiusCodeEditor => staticTokens.borderRadiusCodeEditor;

  /// The border radius of containers. Also used in container-based components
  /// like table, cards, expandable section, and modal.
  ///
  /// CSS: `--border-radius-container` · axis: none · themeable · exposed
  double get borderRadiusContainer => staticTokens.borderRadiusContainer;

  /// The border radius of the focus indicator of circular controls. For
  /// example: radio button.
  ///
  /// CSS: `--border-radius-control-circular-focus-ring` · axis: none · themeable · exposed
  double get borderRadiusControlCircularFocusRing =>
      staticTokens.borderRadiusControlCircularFocusRing;

  /// The border radius of the focus indicator of interactive elements. For
  /// example: button, link, toggle, pagination controls, expandable section
  /// header, popover trigger.
  ///
  /// CSS: `--border-radius-control-default-focus-ring` · axis: none · themeable · exposed
  double get borderRadiusControlDefaultFocusRing =>
      staticTokens.borderRadiusControlDefaultFocusRing;

  /// The border radius of dropdown containers. For example: button dropdown,
  /// select, multiselect, autosuggest, date picker, date range picker.
  ///
  /// CSS: `--border-radius-dropdown` · axis: none · themeable · exposed
  double get borderRadiusDropdown => staticTokens.borderRadiusDropdown;

  /// The border radius of file upload dropzone.
  ///
  /// CSS: `--border-radius-dropzone` · axis: none · themeable · exposed
  double get borderRadiusDropzone => staticTokens.borderRadiusDropzone;

  /// The border radius of flash messages in flashbars.
  ///
  /// CSS: `--border-radius-flashbar` · axis: none · themeable · exposed
  double get borderRadiusFlashbar => staticTokens.borderRadiusFlashbar;

  /// The border radius of form controls. For example: input, select.
  ///
  /// CSS: `--border-radius-input` · axis: none · themeable · exposed
  double get borderRadiusInput => staticTokens.borderRadiusInput;

  /// The border radius of items that can be selected from a list. For example:
  /// select options, table rows, calendar days.
  ///
  /// CSS: `--border-radius-item` · axis: none · themeable · exposed
  double get borderRadiusItem => staticTokens.borderRadiusItem;

  /// CSS: `--border-radius-side-navigation-item` · axis: none · themeable
  double get borderRadiusSideNavigationItem =>
      staticTokens.borderRadiusSideNavigationItem;

  /// CSS: `--border-radius-side-navigation-item-collapsed` · axis: none · themeable
  CsLength get borderRadiusSideNavigationItemCollapsed =>
      staticTokens.borderRadiusSideNavigationItemCollapsed;

  /// CSS: `--border-radius-item-card-default` · axis: none
  double get borderRadiusItemCardDefault =>
      staticTokens.borderRadiusItemCardDefault;

  /// CSS: `--border-radius-item-card-embedded` · axis: none
  double get borderRadiusItemCardEmbedded =>
      staticTokens.borderRadiusItemCardEmbedded;

  /// CSS: `--border-radius-dialog` · axis: none · themeable
  double get borderRadiusDialog => staticTokens.borderRadiusDialog;

  /// The border radius of popovers.
  ///
  /// CSS: `--border-radius-popover` · axis: none · themeable · exposed
  double get borderRadiusPopover => staticTokens.borderRadiusPopover;

  /// CSS: `--border-radius-skeleton` · axis: none
  double get borderRadiusSkeleton => staticTokens.borderRadiusSkeleton;

  /// CSS: `--border-radius-status-indicator` · axis: none · themeable
  double get borderRadiusStatusIndicator =>
      staticTokens.borderRadiusStatusIndicator;

  /// The border radius of tabs' focus indicator. Used in tabs and in the code
  /// editor status bar.
  ///
  /// CSS: `--border-radius-tabs-focus-ring` · axis: none · themeable · exposed
  double get borderRadiusTabsFocusRing =>
      staticTokens.borderRadiusTabsFocusRing;

  /// The border radius of tiles.
  ///
  /// CSS: `--border-radius-tiles` · axis: none · themeable · exposed
  double get borderRadiusTiles => staticTokens.borderRadiusTiles;

  /// The border radius of tokens. For example: token groups, multiselect
  /// tokens, property filter tokens.
  ///
  /// CSS: `--border-radius-token` · axis: none · themeable · exposed
  double get borderRadiusToken => staticTokens.borderRadiusToken;

  /// The border radius of inline tokens. For example: multiselect component.
  ///
  /// CSS: `--border-radius-token-inline` · axis: none · themeable · exposed
  double get borderRadiusTokenInline => staticTokens.borderRadiusTokenInline;

  /// The border radius of tutorials inside a tutorial panel.
  ///
  /// CSS: `--border-radius-tutorial-panel-item` · axis: none · themeable · exposed
  double get borderRadiusTutorialPanelItem =>
      staticTokens.borderRadiusTutorialPanelItem;

  /// CSS: `--border-table-sticky-width` · axis: none
  double get borderTableStickyWidth => staticTokens.borderTableStickyWidth;

  /// The border width of action cards in active state.
  ///
  /// CSS: `--border-width-action-card-active` · axis: none · themeable · exposed
  double get borderWidthActionCardActive =>
      staticTokens.borderWidthActionCardActive;

  /// The border width of action cards in default state.
  ///
  /// CSS: `--border-width-action-card-default` · axis: none · themeable · exposed
  double get borderWidthActionCardDefault =>
      staticTokens.borderWidthActionCardDefault;

  /// The border width of action cards in disabled state.
  ///
  /// CSS: `--border-width-action-card-disabled` · axis: none · themeable · exposed
  double get borderWidthActionCardDisabled =>
      staticTokens.borderWidthActionCardDisabled;

  /// The border width of action cards in hover state.
  ///
  /// CSS: `--border-width-action-card-hover` · axis: none · themeable · exposed
  double get borderWidthActionCardHover =>
      staticTokens.borderWidthActionCardHover;

  /// The border width of alerts.
  ///
  /// CSS: `--border-width-alert` · axis: none · themeable · exposed
  double get borderWidthAlert => staticTokens.borderWidthAlert;

  /// The block-end border width of alerts.
  ///
  /// CSS: `--border-width-alert-block-end` · axis: none · themeable · exposed
  double get borderWidthAlertBlockEnd => staticTokens.borderWidthAlertBlockEnd;

  /// The block-start border width of alerts.
  ///
  /// CSS: `--border-width-alert-block-start` · axis: none · themeable · exposed
  double get borderWidthAlertBlockStart =>
      staticTokens.borderWidthAlertBlockStart;

  /// The inline-end border width of alerts.
  ///
  /// CSS: `--border-width-alert-inline-end` · axis: none · themeable · exposed
  double get borderWidthAlertInlineEnd =>
      staticTokens.borderWidthAlertInlineEnd;

  /// The inline-start border width of alerts.
  ///
  /// CSS: `--border-width-alert-inline-start` · axis: none · themeable · exposed
  double get borderWidthAlertInlineStart =>
      staticTokens.borderWidthAlertInlineStart;

  /// The inline-start border width of flash messages in flashbars.
  ///
  /// CSS: `--border-width-flashbar-inline-start` · axis: none · themeable · exposed
  double get borderWidthFlashbarInlineStart =>
      staticTokens.borderWidthFlashbarInlineStart;

  /// The border width of buttons.
  ///
  /// CSS: `--border-width-button` · axis: none · themeable · exposed
  double get borderWidthButton => staticTokens.borderWidthButton;

  /// The border width of a card.
  ///
  /// CSS: `--border-width-card` · axis: none · themeable · exposed
  double get borderWidthCard => staticTokens.borderWidthCard;

  /// The border width of a selected card.
  ///
  /// CSS: `--border-width-card-selected` · axis: none · themeable · exposed
  double get borderWidthCardSelected => staticTokens.borderWidthCardSelected;

  /// The border width of dropdowns.
  ///
  /// CSS: `--border-width-dropdown` · axis: none · themeable · exposed
  double get borderWidthDropdown => staticTokens.borderWidthDropdown;

  /// The border width of form fields.
  ///
  /// CSS: `--border-width-field` · axis: none · themeable · exposed
  double get borderWidthField => staticTokens.borderWidthField;

  /// The visual stroke width of big icons.
  ///
  /// CSS: `--border-width-icon-big` · axis: none · themeable · exposed
  double get borderWidthIconBig => staticTokens.borderWidthIconBig;

  /// The visual stroke width of large icons.
  ///
  /// CSS: `--border-width-icon-large` · axis: none · themeable · exposed
  double get borderWidthIconLarge => staticTokens.borderWidthIconLarge;

  /// The visual stroke width of medium icons.
  ///
  /// CSS: `--border-width-icon-medium` · axis: none · themeable · exposed
  double get borderWidthIconMedium => staticTokens.borderWidthIconMedium;

  /// The visual stroke width of normal icons.
  ///
  /// CSS: `--border-width-icon-normal` · axis: none · themeable · exposed
  double get borderWidthIconNormal => staticTokens.borderWidthIconNormal;

  /// The visual stroke width of small icons.
  ///
  /// CSS: `--border-width-icon-small` · axis: none · themeable · exposed
  double get borderWidthIconSmall => staticTokens.borderWidthIconSmall;

  /// The visual stroke width of extra small icons.
  ///
  /// CSS: `--border-width-icon-x-small` · axis: none · themeable · exposed
  double get borderWidthIconXSmall => staticTokens.borderWidthIconXSmall;

  /// CSS: `--border-width-item-card` · axis: none
  double get borderWidthItemCard => staticTokens.borderWidthItemCard;

  /// CSS: `--border-width-item-card-highlighted` · axis: none
  double get borderWidthItemCardHighlighted =>
      staticTokens.borderWidthItemCardHighlighted;

  /// CSS: `--border-width-dialog` · axis: none · themeable
  double get borderWidthDialog => staticTokens.borderWidthDialog;

  /// The border width of selected items, like table rows.
  ///
  /// CSS: `--border-width-item-selected` · axis: none · themeable · exposed
  double get borderWidthItemSelected => staticTokens.borderWidthItemSelected;

  /// The border width of the side navigation divider in the AppLayout and
  /// AppLayoutToolbar components.
  ///
  /// CSS: `--border-width-layout-side-navigation` · axis: none · themeable · exposed
  double get borderWidthLayoutSideNavigation =>
      staticTokens.borderWidthLayoutSideNavigation;

  /// CSS: `--border-width-notification-stack-bar` · axis: none
  double get borderWidthNotificationStackBar =>
      staticTokens.borderWidthNotificationStackBar;

  /// The border width of badges.
  ///
  /// CSS: `--border-width-badge` · axis: none · themeable · exposed
  double get borderWidthBadge => staticTokens.borderWidthBadge;

  /// The border width of popovers.
  ///
  /// CSS: `--border-width-popover` · axis: none · themeable · exposed
  double get borderWidthPopover => staticTokens.borderWidthPopover;

  /// The border width of tokens.
  ///
  /// CSS: `--border-width-token` · axis: none · themeable · exposed
  double get borderWidthToken => staticTokens.borderWidthToken;

  /// CSS: `--motion-duration-extra-fast` · axis: motion
  Duration get motionDurationExtraFast => motionTokens.motionDurationExtraFast;

  /// CSS: `--motion-duration-extra-slow` · axis: motion
  Duration get motionDurationExtraSlow => motionTokens.motionDurationExtraSlow;

  /// CSS: `--motion-duration-fast` · axis: motion
  Duration get motionDurationFast => motionTokens.motionDurationFast;

  /// CSS: `--motion-duration-moderate` · axis: motion
  Duration get motionDurationModerate => motionTokens.motionDurationModerate;

  /// CSS: `--motion-duration-refresh-only-ambient` · axis: motion
  Duration get motionDurationRefreshOnlyAmbient =>
      motionTokens.motionDurationRefreshOnlyAmbient;

  /// CSS: `--motion-duration-refresh-only-fast` · axis: motion
  Duration get motionDurationRefreshOnlyFast =>
      motionTokens.motionDurationRefreshOnlyFast;

  /// CSS: `--motion-duration-refresh-only-medium` · axis: motion
  Duration get motionDurationRefreshOnlyMedium =>
      motionTokens.motionDurationRefreshOnlyMedium;

  /// CSS: `--motion-duration-refresh-only-slow` · axis: motion
  Duration get motionDurationRefreshOnlySlow =>
      motionTokens.motionDurationRefreshOnlySlow;

  /// The duration for gradient motion of gen-ai avatars.
  ///
  /// CSS: `--motion-duration-avatar-gen-ai-gradient` · axis: motion · exposed
  Duration get motionDurationAvatarGenAiGradient =>
      motionTokens.motionDurationAvatarGenAiGradient;

  /// The duration for loading motion of avatars.
  ///
  /// CSS: `--motion-duration-avatar-loading-dots` · axis: motion · exposed
  Duration get motionDurationAvatarLoadingDots =>
      motionTokens.motionDurationAvatarLoadingDots;

  /// CSS: `--motion-duration-rotate-180` · axis: motion
  Duration get motionDurationRotate180 => motionTokens.motionDurationRotate180;

  /// CSS: `--motion-duration-rotate-90` · axis: motion
  Duration get motionDurationRotate90 => motionTokens.motionDurationRotate90;

  /// CSS: `--motion-duration-show-paced` · axis: motion
  Duration get motionDurationShowPaced => motionTokens.motionDurationShowPaced;

  /// CSS: `--motion-duration-show-quick` · axis: motion
  Duration get motionDurationShowQuick => motionTokens.motionDurationShowQuick;

  /// CSS: `--motion-duration-slow` · axis: motion
  Duration get motionDurationSlow => motionTokens.motionDurationSlow;

  /// CSS: `--motion-duration-transition-quick` · axis: motion
  Duration get motionDurationTransitionQuick =>
      motionTokens.motionDurationTransitionQuick;

  /// CSS: `--motion-duration-transition-show-paced` · axis: motion
  Duration get motionDurationTransitionShowPaced =>
      motionTokens.motionDurationTransitionShowPaced;

  /// CSS: `--motion-duration-transition-show-quick` · axis: motion
  Duration get motionDurationTransitionShowQuick =>
      motionTokens.motionDurationTransitionShowQuick;

  /// CSS: `--motion-easing-ease-out-quart` · axis: motion
  CsCubicBezier get motionEasingEaseOutQuart =>
      motionTokens.motionEasingEaseOutQuart;

  /// CSS: `--motion-easing-refresh-only-a` · axis: motion
  CsCubicBezier get motionEasingRefreshOnlyA =>
      motionTokens.motionEasingRefreshOnlyA;

  /// CSS: `--motion-easing-refresh-only-b` · axis: motion
  CsCubicBezier get motionEasingRefreshOnlyB =>
      motionTokens.motionEasingRefreshOnlyB;

  /// CSS: `--motion-easing-refresh-only-c` · axis: motion
  CsCubicBezier get motionEasingRefreshOnlyC =>
      motionTokens.motionEasingRefreshOnlyC;

  /// CSS: `--motion-easing-refresh-only-d` · axis: motion
  CsCubicBezier get motionEasingRefreshOnlyD =>
      motionTokens.motionEasingRefreshOnlyD;

  /// The easing curve for gradient motion of gen-ai avatars.
  ///
  /// CSS: `--motion-easing-avatar-gen-ai-gradient` · axis: motion · exposed
  CsCubicBezier get motionEasingAvatarGenAiGradient =>
      motionTokens.motionEasingAvatarGenAiGradient;

  /// CSS: `--motion-easing-rotate-180` · axis: motion
  CsCubicBezier get motionEasingRotate180 => motionTokens.motionEasingRotate180;

  /// CSS: `--motion-easing-rotate-90` · axis: motion
  CsCubicBezier get motionEasingRotate90 => motionTokens.motionEasingRotate90;

  /// CSS: `--motion-easing-show-paced` · axis: motion
  CsCubicBezier get motionEasingShowPaced => motionTokens.motionEasingShowPaced;

  /// CSS: `--motion-easing-show-quick` · axis: motion
  CsCubicBezier get motionEasingShowQuick => motionTokens.motionEasingShowQuick;

  /// CSS: `--motion-easing-transition-quick` · axis: motion
  CsCubicBezier get motionEasingTransitionQuick =>
      motionTokens.motionEasingTransitionQuick;

  /// CSS: `--motion-easing-transition-show-paced` · axis: motion
  CsCubicBezier get motionEasingTransitionShowPaced =>
      motionTokens.motionEasingTransitionShowPaced;

  /// CSS: `--motion-easing-transition-show-quick` · axis: motion
  CsCubicBezier get motionEasingTransitionShowQuick =>
      motionTokens.motionEasingTransitionShowQuick;

  /// The easing curve for providing responsive yet smooth visual feedback.
  ///
  /// CSS: `--motion-easing-responsive` · axis: motion · exposed
  CsCubicBezier get motionEasingResponsive =>
      motionTokens.motionEasingResponsive;

  /// The easing curve for making an element sticky to a certain state.
  ///
  /// CSS: `--motion-easing-sticky` · axis: motion · exposed
  CsCubicBezier get motionEasingSticky => motionTokens.motionEasingSticky;

  /// The easing curve for drawing a user's attention in an expressive way.
  ///
  /// CSS: `--motion-easing-expressive` · axis: motion · exposed
  CsCubicBezier get motionEasingExpressive =>
      motionTokens.motionEasingExpressive;

  /// The duration for making the motion feel quick and responsive.
  ///
  /// CSS: `--motion-duration-responsive` · axis: motion · exposed
  Duration get motionDurationResponsive =>
      motionTokens.motionDurationResponsive;

  /// The duration for accommodating the motion with more expressiveness.
  ///
  /// CSS: `--motion-duration-expressive` · axis: motion · exposed
  Duration get motionDurationExpressive =>
      motionTokens.motionDurationExpressive;

  /// The duration for drawing more attention or accommodating for more
  /// complexity.
  ///
  /// CSS: `--motion-duration-complex` · axis: motion · exposed
  Duration get motionDurationComplex => motionTokens.motionDurationComplex;

  /// The duration for the tooltip enter transition.
  ///
  /// CSS: `--motion-duration-tooltip-enter` · axis: motion · themeable · exposed
  Duration get motionDurationTooltipEnter =>
      motionTokens.motionDurationTooltipEnter;

  /// The easing curve for the tooltip enter transition.
  ///
  /// CSS: `--motion-easing-tooltip-enter` · axis: motion · themeable · exposed
  CsCubicBezier get motionEasingTooltipEnter =>
      motionTokens.motionEasingTooltipEnter;

  /// CSS: `--motion-duration-expandable-content-enter` · axis: motion
  Duration get motionDurationExpandableContentEnter =>
      motionTokens.motionDurationExpandableContentEnter;

  /// CSS: `--motion-easing-expandable-content-enter` · axis: motion
  CsCubicBezier get motionEasingExpandableContentEnter =>
      motionTokens.motionEasingExpandableContentEnter;

  /// CSS: `--motion-duration-side-navigation-content-enter-fade` · axis: motion
  Duration get motionDurationSideNavigationContentEnterFade =>
      motionTokens.motionDurationSideNavigationContentEnterFade;

  /// CSS: `--motion-duration-side-navigation-content-exit` · axis: motion
  Duration get motionDurationSideNavigationContentExit =>
      motionTokens.motionDurationSideNavigationContentExit;

  /// CSS: `--motion-duration-side-navigation-content-exit-fade` · axis: motion
  Duration get motionDurationSideNavigationContentExitFade =>
      motionTokens.motionDurationSideNavigationContentExitFade;

  /// CSS: `--motion-easing-side-navigation-content-exit` · axis: motion
  CsCubicBezier get motionEasingSideNavigationContentExit =>
      motionTokens.motionEasingSideNavigationContentExit;

  /// The CSS keyframes for showing an element.
  ///
  /// CSS: `--motion-keyframes-fade-in` · axis: motion · exposed
  String get motionKeyframesFadeIn => motionTokens.motionKeyframesFadeIn;

  /// The CSS keyframes for hiding an element.
  ///
  /// CSS: `--motion-keyframes-fade-out` · axis: motion · exposed
  String get motionKeyframesFadeOut => motionTokens.motionKeyframesFadeOut;

  /// The CSS keyframes applied to an error status icon to draw the user's
  /// attention.
  ///
  /// CSS: `--motion-keyframes-status-icon-error` · axis: motion · exposed
  String get motionKeyframesStatusIconError =>
      motionTokens.motionKeyframesStatusIconError;

  /// The CSS keyframes for scaling up an element to draw the user's attention.
  ///
  /// CSS: `--motion-keyframes-scale-popup` · axis: motion · exposed
  String get motionKeyframesScalePopup =>
      motionTokens.motionKeyframesScalePopup;

  /// CSS: `--size-calendar-grid-width` · axis: density
  double get sizeCalendarGridWidth => densityTokens.sizeCalendarGridWidth;

  /// CSS: `--size-control` · axis: density
  double get sizeControl => densityTokens.sizeControl;

  /// CSS: `--size-icon-big` · axis: density
  double get sizeIconBig => densityTokens.sizeIconBig;

  /// CSS: `--size-icon-large` · axis: density
  double get sizeIconLarge => densityTokens.sizeIconLarge;

  /// CSS: `--size-icon-medium` · axis: density
  double get sizeIconMedium => densityTokens.sizeIconMedium;

  /// CSS: `--size-icon-normal` · axis: density
  double get sizeIconNormal => densityTokens.sizeIconNormal;

  /// CSS: `--size-table-selection-horizontal` · axis: density
  double get sizeTableSelectionHorizontal =>
      densityTokens.sizeTableSelectionHorizontal;

  /// The height of form input components. For example: input, select,
  /// multiselect, autosuggest, and datepicker.
  ///
  /// CSS: `--size-vertical-input` · axis: density · themeable · exposed
  double get sizeVerticalInput => densityTokens.sizeVerticalInput;

  /// CSS: `--size-vertical-panel-icon-offset` · axis: density
  double get sizeVerticalPanelIconOffset =>
      densityTokens.sizeVerticalPanelIconOffset;

  /// The minimum height of side navigation items.
  ///
  /// CSS: `--size-side-navigation-item-height` · axis: density · themeable · exposed
  double get sizeSideNavigationItemHeight =>
      densityTokens.sizeSideNavigationItemHeight;

  /// The square size of collapsed side navigation items.
  ///
  /// CSS: `--size-side-navigation-item-collapsed` · axis: density · themeable · exposed
  double get sizeSideNavigationItemCollapsed =>
      densityTokens.sizeSideNavigationItemCollapsed;

  /// The default width of the collapsed side navigation rail.
  ///
  /// CSS: `--size-side-navigation-collapsed-width` · axis: density · themeable · exposed
  double get sizeSideNavigationCollapsedWidth =>
      densityTokens.sizeSideNavigationCollapsedWidth;

  /// CSS: `--space-alert-action-left` · axis: density
  double get spaceAlertActionLeft => densityTokens.spaceAlertActionLeft;

  /// CSS: `--space-alert-horizontal` · axis: density
  double get spaceAlertHorizontal => densityTokens.spaceAlertHorizontal;

  /// CSS: `--space-alert-message-right` · axis: density
  double get spaceAlertMessageRight => densityTokens.spaceAlertMessageRight;

  /// The vertical padding inside alert components.
  ///
  /// CSS: `--space-alert-vertical` · axis: density · themeable · exposed
  double get spaceAlertVertical => densityTokens.spaceAlertVertical;

  /// CSS: `--space-button-focus-outline-gutter` · axis: density
  double get spaceButtonFocusOutlineGutter =>
      densityTokens.spaceButtonFocusOutlineGutter;

  /// CSS: `--space-expand-toggle-focus-outline-gutter` · axis: density
  double get spaceExpandToggleFocusOutlineGutter =>
      densityTokens.spaceExpandToggleFocusOutlineGutter;

  /// CSS: `--space-button-inline-link-focus-outline-gutter` · axis: density
  double get spaceButtonInlineLinkFocusOutlineGutter =>
      densityTokens.spaceButtonInlineLinkFocusOutlineGutter;

  /// The horizontal padding inside buttons.
  ///
  /// CSS: `--space-button-horizontal` · axis: density · themeable · exposed
  double get spaceButtonHorizontal => densityTokens.spaceButtonHorizontal;

  /// The vertical padding inside buttons.
  ///
  /// CSS: `--space-button-vertical` · axis: density · themeable · exposed
  double get spaceButtonVertical => densityTokens.spaceButtonVertical;

  /// The vertical padding inside tokens.
  ///
  /// CSS: `--space-token-vertical` · axis: density · themeable · exposed
  double get spaceTokenVertical => densityTokens.spaceTokenVertical;

  /// The vertical padding inside control components.
  ///
  /// CSS: `--space-field-vertical` · axis: density · themeable · exposed
  double get spaceFieldVertical => densityTokens.spaceFieldVertical;

  /// CSS: `--space-button-icon-focus-outline-gutter-vertical` · axis: density
  double get spaceButtonIconFocusOutlineGutterVertical =>
      densityTokens.spaceButtonIconFocusOutlineGutterVertical;

  /// CSS: `--space-button-icon-only-horizontal` · axis: density
  double get spaceButtonIconOnlyHorizontal =>
      densityTokens.spaceButtonIconOnlyHorizontal;

  /// CSS: `--space-button-inline-icon-focus-outline-gutter` · axis: density
  double get spaceButtonInlineIconFocusOutlineGutter =>
      densityTokens.spaceButtonInlineIconFocusOutlineGutter;

  /// CSS: `--space-button-modal-dismiss-vertical` · axis: density
  double get spaceButtonModalDismissVertical =>
      densityTokens.spaceButtonModalDismissVertical;

  /// CSS: `--space-calendar-grid-focus-outline-gutter` · axis: density
  double get spaceCalendarGridFocusOutlineGutter =>
      densityTokens.spaceCalendarGridFocusOutlineGutter;

  /// CSS: `--space-calendar-grid-selected-focus-outline-gutter` · axis: density
  double get spaceCalendarGridSelectedFocusOutlineGutter =>
      densityTokens.spaceCalendarGridSelectedFocusOutlineGutter;

  /// CSS: `--space-calendar-grid-gutter` · axis: density
  double get spaceCalendarGridGutter => densityTokens.spaceCalendarGridGutter;

  /// The default horizontal padding inside a card.
  ///
  /// CSS: `--space-card-horizontal-default` · axis: density · themeable · exposed
  double get spaceCardHorizontalDefault =>
      densityTokens.spaceCardHorizontalDefault;

  /// The horizontal padding inside embedded a card.
  ///
  /// CSS: `--space-card-horizontal-embedded` · axis: density · themeable · exposed
  double get spaceCardHorizontalEmbedded =>
      densityTokens.spaceCardHorizontalEmbedded;

  /// The default vertical padding inside a card.
  ///
  /// CSS: `--space-card-vertical-default` · axis: density · themeable · exposed
  double get spaceCardVerticalDefault => densityTokens.spaceCardVerticalDefault;

  /// The vertical padding inside embedded a card.
  ///
  /// CSS: `--space-card-vertical-embedded` · axis: density · themeable · exposed
  double get spaceCardVerticalEmbedded =>
      densityTokens.spaceCardVerticalEmbedded;

  /// CSS: `--space-item-card-horizontal-default` · axis: density
  double get spaceItemCardHorizontalDefault =>
      densityTokens.spaceItemCardHorizontalDefault;

  /// CSS: `--space-item-card-horizontal-embedded` · axis: density
  double get spaceItemCardHorizontalEmbedded =>
      densityTokens.spaceItemCardHorizontalEmbedded;

  /// CSS: `--space-item-card-vertical-default` · axis: density
  double get spaceItemCardVerticalDefault =>
      densityTokens.spaceItemCardVerticalDefault;

  /// CSS: `--space-item-card-vertical-embedded` · axis: density
  double get spaceItemCardVerticalEmbedded =>
      densityTokens.spaceItemCardVerticalEmbedded;

  /// CSS: `--space-dialog-horizontal` · axis: density · themeable
  double get spaceDialogHorizontal => densityTokens.spaceDialogHorizontal;

  /// CSS: `--space-dialog-vertical` · axis: density · themeable
  double get spaceDialogVertical => densityTokens.spaceDialogVertical;

  /// CSS: `--space-dialog-action-block` · axis: density · themeable
  double get spaceDialogActionBlock => densityTokens.spaceDialogActionBlock;

  /// CSS: `--space-dialog-action-inline` · axis: density · themeable
  double get spaceDialogActionInline => densityTokens.spaceDialogActionInline;

  /// CSS: `--space-dialog-header-gap` · axis: density · themeable
  double get spaceDialogHeaderGap => densityTokens.spaceDialogHeaderGap;

  /// CSS: `--space-dialog-section-gap` · axis: density · themeable
  double get spaceDialogSectionGap => densityTokens.spaceDialogSectionGap;

  /// CSS: `--space-code-editor-status-focus-outline-gutter` · axis: density
  double get spaceCodeEditorStatusFocusOutlineGutter =>
      densityTokens.spaceCodeEditorStatusFocusOutlineGutter;

  /// CSS: `--space-container-content-top` · axis: density
  double get spaceContainerContentTop => densityTokens.spaceContainerContentTop;

  /// CSS: `--space-container-content-vertical` · axis: density
  double get spaceContainerContentVertical =>
      densityTokens.spaceContainerContentVertical;

  /// CSS: `--space-container-header-top` · axis: density
  double get spaceContainerHeaderTop => densityTokens.spaceContainerHeaderTop;

  /// CSS: `--space-container-header-bottom` · axis: density
  double get spaceContainerHeaderBottom =>
      densityTokens.spaceContainerHeaderBottom;

  /// The horizontal padding inside a container.
  ///
  /// CSS: `--space-container-horizontal` · axis: density · exposed
  double get spaceContainerHorizontal => densityTokens.spaceContainerHorizontal;

  /// CSS: `--space-content-header-padding-bottom` · axis: density
  double get spaceContentHeaderPaddingBottom =>
      densityTokens.spaceContentHeaderPaddingBottom;

  /// CSS: `--space-dark-header-overlap-distance` · axis: density
  double get spaceDarkHeaderOverlapDistance =>
      densityTokens.spaceDarkHeaderOverlapDistance;

  /// CSS: `--space-expandable-section-icon-offset-top` · axis: density
  double get spaceExpandableSectionIconOffsetTop =>
      densityTokens.spaceExpandableSectionIconOffsetTop;

  /// The horizontal padding inside field components.
  ///
  /// CSS: `--space-field-horizontal` · axis: density · exposed
  double get spaceFieldHorizontal => densityTokens.spaceFieldHorizontal;

  /// CSS: `--space-field-icon-offset` · axis: density
  double get spaceFieldIconOffset => densityTokens.spaceFieldIconOffset;

  /// CSS: `--space-filtering-token-dismiss-button-focus-outline-gutter` · axis: density
  double get spaceFilteringTokenDismissButtonFocusOutlineGutter =>
      densityTokens.spaceFilteringTokenDismissButtonFocusOutlineGutter;

  /// CSS: `--space-filtering-token-operation-select-focus-outline-gutter` · axis: density
  double get spaceFilteringTokenOperationSelectFocusOutlineGutter =>
      densityTokens.spaceFilteringTokenOperationSelectFocusOutlineGutter;

  /// CSS: `--space-flashbar-action-left` · axis: density
  double get spaceFlashbarActionLeft => densityTokens.spaceFlashbarActionLeft;

  /// CSS: `--space-flashbar-dismiss-right` · axis: density
  double get spaceFlashbarDismissRight =>
      densityTokens.spaceFlashbarDismissRight;

  /// CSS: `--space-flashbar-horizontal` · axis: density
  double get spaceFlashbarHorizontal => densityTokens.spaceFlashbarHorizontal;

  /// CSS: `--space-flashbar-vertical` · axis: density
  double get spaceFlashbarVertical => densityTokens.spaceFlashbarVertical;

  /// CSS: `--space-grid-gutter` · axis: density
  double get spaceGridGutter => densityTokens.spaceGridGutter;

  /// CSS: `--space-key-value-gap` · axis: density
  double get spaceKeyValueGap => densityTokens.spaceKeyValueGap;

  /// CSS: `--space-layout-content-bottom` · axis: density
  double get spaceLayoutContentBottom => densityTokens.spaceLayoutContentBottom;

  /// CSS: `--space-layout-content-horizontal` · axis: density
  double get spaceLayoutContentHorizontal =>
      densityTokens.spaceLayoutContentHorizontal;

  /// CSS: `--space-layout-toggle-diameter` · axis: density
  double get spaceLayoutToggleDiameter =>
      densityTokens.spaceLayoutToggleDiameter;

  /// CSS: `--space-layout-toggle-padding` · axis: density
  double get spaceLayoutTogglePadding => densityTokens.spaceLayoutTogglePadding;

  /// CSS: `--space-modal-content-bottom` · axis: density
  double get spaceModalContentBottom => densityTokens.spaceModalContentBottom;

  /// CSS: `--space-modal-horizontal` · axis: density
  double get spaceModalHorizontal => densityTokens.spaceModalHorizontal;

  /// CSS: `--space-panel-content-bottom` · axis: density
  double get spacePanelContentBottom => densityTokens.spacePanelContentBottom;

  /// CSS: `--space-panel-content-top` · axis: density
  double get spacePanelContentTop => densityTokens.spacePanelContentTop;

  /// CSS: `--space-panel-divider-margin-horizontal` · axis: density
  double get spacePanelDividerMarginHorizontal =>
      densityTokens.spacePanelDividerMarginHorizontal;

  /// CSS: `--space-panel-header-vertical` · axis: density
  double get spacePanelHeaderVertical => densityTokens.spacePanelHeaderVertical;

  /// CSS: `--space-panel-nav-left` · axis: density
  double get spacePanelNavLeft => densityTokens.spacePanelNavLeft;

  /// CSS: `--space-panel-side-left` · axis: density
  double get spacePanelSideLeft => densityTokens.spacePanelSideLeft;

  /// CSS: `--space-panel-side-right` · axis: density
  double get spacePanelSideRight => densityTokens.spacePanelSideRight;

  /// CSS: `--space-panel-split-top` · axis: density
  double get spacePanelSplitTop => densityTokens.spacePanelSplitTop;

  /// CSS: `--space-panel-split-bottom` · axis: density
  double get spacePanelSplitBottom => densityTokens.spacePanelSplitBottom;

  /// CSS: `--space-segmented-control-focus-outline-gutter` · axis: density
  double get spaceSegmentedControlFocusOutlineGutter =>
      densityTokens.spaceSegmentedControlFocusOutlineGutter;

  /// CSS: `--space-tabs-content-top` · axis: density
  double get spaceTabsContentTop => densityTokens.spaceTabsContentTop;

  /// CSS: `--space-tabs-focus-outline-gutter` · axis: density
  double get spaceTabsFocusOutlineGutter =>
      densityTokens.spaceTabsFocusOutlineGutter;

  /// The vertical padding inside tabs.
  ///
  /// CSS: `--space-tabs-vertical` · axis: density · themeable · exposed
  double get spaceTabsVertical => densityTokens.spaceTabsVertical;

  /// CSS: `--space-table-content-bottom` · axis: density
  double get spaceTableContentBottom => densityTokens.spaceTableContentBottom;

  /// CSS: `--space-table-embedded-header-top` · axis: density
  double get spaceTableEmbeddedHeaderTop =>
      densityTokens.spaceTableEmbeddedHeaderTop;

  /// CSS: `--space-table-footer-horizontal` · axis: density
  double get spaceTableFooterHorizontal =>
      densityTokens.spaceTableFooterHorizontal;

  /// CSS: `--space-table-header-focus-outline-gutter` · axis: density
  double get spaceTableHeaderFocusOutlineGutter =>
      densityTokens.spaceTableHeaderFocusOutlineGutter;

  /// CSS: `--space-table-header-horizontal` · axis: density
  double get spaceTableHeaderHorizontal =>
      densityTokens.spaceTableHeaderHorizontal;

  /// CSS: `--space-table-header-tools-bottom` · axis: density
  double get spaceTableHeaderToolsBottom =>
      densityTokens.spaceTableHeaderToolsBottom;

  /// CSS: `--space-table-header-tools-full-page-bottom` · axis: density
  double get spaceTableHeaderToolsFullPageBottom =>
      densityTokens.spaceTableHeaderToolsFullPageBottom;

  /// CSS: `--space-table-horizontal` · axis: density
  double get spaceTableHorizontal => densityTokens.spaceTableHorizontal;

  /// CSS: `--space-table-cell-vertical` · axis: density
  double get spaceTableCellVertical => densityTokens.spaceTableCellVertical;

  /// The indentation of tree view items.
  ///
  /// CSS: `--space-tree-view-indentation` · axis: density · exposed
  double get spaceTreeViewIndentation => densityTokens.spaceTreeViewIndentation;

  /// The vertical gap between side navigation items when no item has an icon.
  ///
  /// CSS: `--space-side-navigation-item-default-gap` · axis: density · themeable · exposed
  double get spaceSideNavigationItemDefaultGap =>
      densityTokens.spaceSideNavigationItemDefaultGap;

  /// The vertical gap between side navigation items when at least one item has
  /// an icon.
  ///
  /// CSS: `--space-side-navigation-item-icon-gap` · axis: density · themeable · exposed
  double get spaceSideNavigationItemIconGap =>
      densityTokens.spaceSideNavigationItemIconGap;

  /// CSS: `--space-tile-gutter` · axis: density
  double get spaceTileGutter => densityTokens.spaceTileGutter;

  /// The default horizontal padding inside an action card.
  ///
  /// CSS: `--space-action-card-horizontal-default` · axis: density · themeable · exposed
  double get spaceActionCardHorizontalDefault =>
      densityTokens.spaceActionCardHorizontalDefault;

  /// The horizontal padding inside an embedded action card.
  ///
  /// CSS: `--space-action-card-horizontal-embedded` · axis: density · themeable · exposed
  double get spaceActionCardHorizontalEmbedded =>
      densityTokens.spaceActionCardHorizontalEmbedded;

  /// The default vertical padding inside an action card.
  ///
  /// CSS: `--space-action-card-vertical-default` · axis: density · themeable · exposed
  double get spaceActionCardVerticalDefault =>
      densityTokens.spaceActionCardVerticalDefault;

  /// The vertical padding inside an embedded action card.
  ///
  /// CSS: `--space-action-card-vertical-embedded` · axis: density · themeable · exposed
  double get spaceActionCardVerticalEmbedded =>
      densityTokens.spaceActionCardVerticalEmbedded;

  /// CSS: `--space-action-card-description-padding-top` · axis: density
  double get spaceActionCardDescriptionPaddingTop =>
      densityTokens.spaceActionCardDescriptionPaddingTop;

  /// CSS: `--space-action-card-content-padding-top` · axis: density
  double get spaceActionCardContentPaddingTop =>
      densityTokens.spaceActionCardContentPaddingTop;

  /// The vertical padding inside dropdown option items.
  ///
  /// CSS: `--space-option-padding-vertical` · axis: density · exposed
  double get spaceOptionPaddingVertical =>
      densityTokens.spaceOptionPaddingVertical;

  /// The horizontal padding inside dropdown option items.
  ///
  /// CSS: `--space-option-padding-horizontal` · axis: density · exposed
  double get spaceOptionPaddingHorizontal =>
      densityTokens.spaceOptionPaddingHorizontal;

  /// CSS: `--space-status-indicator-padding-horizontal` · axis: density · themeable
  double get spaceStatusIndicatorPaddingHorizontal =>
      densityTokens.spaceStatusIndicatorPaddingHorizontal;

  /// CSS: `--space-scaled-2x-none` · axis: density
  double get spaceScaled2xNone => densityTokens.spaceScaled2xNone;

  /// CSS: `--space-scaled-2x-xxxs` · axis: density
  double get spaceScaled2xXxxs => densityTokens.spaceScaled2xXxxs;

  /// CSS: `--space-scaled-2x-xxs` · axis: density
  double get spaceScaled2xXxs => densityTokens.spaceScaled2xXxs;

  /// CSS: `--space-scaled-2x-xs` · axis: density
  double get spaceScaled2xXs => densityTokens.spaceScaled2xXs;

  /// CSS: `--space-scaled-2x-s` · axis: density
  double get spaceScaled2xS => densityTokens.spaceScaled2xS;

  /// CSS: `--space-scaled-2x-m` · axis: density
  double get spaceScaled2xM => densityTokens.spaceScaled2xM;

  /// CSS: `--space-scaled-2x-l` · axis: density
  double get spaceScaled2xL => densityTokens.spaceScaled2xL;

  /// CSS: `--space-scaled-2x-xl` · axis: density
  double get spaceScaled2xXl => densityTokens.spaceScaled2xXl;

  /// CSS: `--space-scaled-2x-xxl` · axis: density
  double get spaceScaled2xXxl => densityTokens.spaceScaled2xXxl;

  /// CSS: `--space-scaled-2x-xxxl` · axis: density
  double get spaceScaled2xXxxl => densityTokens.spaceScaled2xXxxl;

  /// CSS: `--space-scaled-none` · axis: density
  double get spaceScaledNone => densityTokens.spaceScaledNone;

  /// The XXXS spacing unit which scales between modes.
  ///
  /// CSS: `--space-scaled-xxxs` · axis: density · exposed
  double get spaceScaledXxxs => densityTokens.spaceScaledXxxs;

  /// The XXS spacing unit which scales between modes. For example: vertical
  /// space between form field label and control.
  ///
  /// CSS: `--space-scaled-xxs` · axis: density · exposed
  double get spaceScaledXxs => densityTokens.spaceScaledXxs;

  /// The XS spacing unit which scales between modes. For example: horizontal
  /// space between buttons in an action stripe.
  ///
  /// CSS: `--space-scaled-xs` · axis: density · exposed
  double get spaceScaledXs => densityTokens.spaceScaledXs;

  /// The S spacing unit which scales between modes. For example: vertical
  /// padding inside a popover.
  ///
  /// CSS: `--space-scaled-s` · axis: density · exposed
  double get spaceScaledS => densityTokens.spaceScaledS;

  /// The M spacing unit which scales between modes. For example: horizontal
  /// padding inside a popover.
  ///
  /// CSS: `--space-scaled-m` · axis: density · exposed
  double get spaceScaledM => densityTokens.spaceScaledM;

  /// The L spacing unit which scales between modes. For example: vertical space
  /// between form fields.
  ///
  /// CSS: `--space-scaled-l` · axis: density · exposed
  double get spaceScaledL => densityTokens.spaceScaledL;

  /// The XL spacing unit which scales between modes. For example: horizontal
  /// space between wizard navigation and content.
  ///
  /// CSS: `--space-scaled-xl` · axis: density · exposed
  double get spaceScaledXl => densityTokens.spaceScaledXl;

  /// The XXL spacing unit which scales between modes. For example: left
  /// indentation of grouped options in a select.
  ///
  /// CSS: `--space-scaled-xxl` · axis: density · exposed
  double get spaceScaledXxl => densityTokens.spaceScaledXxl;

  /// The XXXL spacing unit which scales between modes. For example: horizontal
  /// padding for app layout and split panel content on large screens.
  ///
  /// CSS: `--space-scaled-xxxl` · axis: density · exposed
  double get spaceScaledXxxl => densityTokens.spaceScaledXxxl;

  /// The static XXXS spacing unit.
  ///
  /// CSS: `--space-static-xxxs` · axis: density · exposed
  double get spaceStaticXxxs => densityTokens.spaceStaticXxxs;

  /// The static XXS spacing unit.
  ///
  /// CSS: `--space-static-xxs` · axis: density · exposed
  double get spaceStaticXxs => densityTokens.spaceStaticXxs;

  /// The static XS spacing unit.
  ///
  /// CSS: `--space-static-xs` · axis: density · exposed
  double get spaceStaticXs => densityTokens.spaceStaticXs;

  /// The static S spacing unit.
  ///
  /// CSS: `--space-static-s` · axis: density · exposed
  double get spaceStaticS => densityTokens.spaceStaticS;

  /// The static M spacing unit.
  ///
  /// CSS: `--space-static-m` · axis: density · exposed
  double get spaceStaticM => densityTokens.spaceStaticM;

  /// The static L spacing unit.
  ///
  /// CSS: `--space-static-l` · axis: density · exposed
  double get spaceStaticL => densityTokens.spaceStaticL;

  /// The static XL spacing unit.
  ///
  /// CSS: `--space-static-xl` · axis: density · exposed
  double get spaceStaticXl => densityTokens.spaceStaticXl;

  /// The static XXL spacing unit.
  ///
  /// CSS: `--space-static-xxl` · axis: density · exposed
  double get spaceStaticXxl => densityTokens.spaceStaticXxl;

  /// The static XXXL spacing unit.
  ///
  /// CSS: `--space-static-xxxl` · axis: density · exposed
  double get spaceStaticXxxl => densityTokens.spaceStaticXxxl;

  /// CSS: `--space-none` · axis: density
  double get spaceNone => densityTokens.spaceNone;

  /// CSS: `--space-xxxs` · axis: density
  double get spaceXxxs => densityTokens.spaceXxxs;

  /// CSS: `--space-xxs` · axis: density
  double get spaceXxs => densityTokens.spaceXxs;

  /// CSS: `--space-xs` · axis: density
  double get spaceXs => densityTokens.spaceXs;

  /// CSS: `--space-s` · axis: density
  double get spaceS => densityTokens.spaceS;

  /// CSS: `--space-m` · axis: density
  double get spaceM => densityTokens.spaceM;

  /// CSS: `--space-l` · axis: density
  double get spaceL => densityTokens.spaceL;

  /// CSS: `--space-xl` · axis: density
  double get spaceXl => densityTokens.spaceXl;

  /// CSS: `--space-xxl` · axis: density
  double get spaceXxl => densityTokens.spaceXxl;

  /// CSS: `--space-xxxl` · axis: density
  double get spaceXxxl => densityTokens.spaceXxxl;

  /// The shadow of a card.
  ///
  /// CSS: `--shadow-card` · axis: color · themeable · exposed
  List<CsShadow> get shadowCard => colorTokens.shadowCard;

  /// CSS: `--shadow-item-card` · axis: color
  List<CsShadow> get shadowItemCard => colorTokens.shadowItemCard;

  /// CSS: `--shadow-dialog` · axis: color · themeable
  List<CsShadow> get shadowDialog => colorTokens.shadowDialog;

  /// CSS: `--shadow-container` · axis: color
  List<CsShadow> get shadowContainer => colorTokens.shadowContainer;

  /// Shadow for containers and cards in active state.
  ///
  /// CSS: `--shadow-container-active` · axis: color · exposed
  List<CsShadow> get shadowContainerActive => colorTokens.shadowContainerActive;

  /// CSS: `--shadow-dropdown` · axis: color
  List<CsShadow> get shadowDropdown => colorTokens.shadowDropdown;

  /// CSS: `--shadow-dropup` · axis: color
  List<CsShadow> get shadowDropup => colorTokens.shadowDropup;

  /// CSS: `--shadow-flash-collapsed` · axis: color
  List<CsShadow> get shadowFlashCollapsed => colorTokens.shadowFlashCollapsed;

  /// CSS: `--shadow-flash-sticky` · axis: color
  List<CsShadow> get shadowFlashSticky => colorTokens.shadowFlashSticky;

  /// CSS: `--shadow-modal` · axis: color
  List<CsShadow> get shadowModal => colorTokens.shadowModal;

  /// CSS: `--shadow-panel` · axis: color
  List<CsShadow> get shadowPanel => colorTokens.shadowPanel;

  /// CSS: `--shadow-panel-toggle` · axis: color
  List<CsShadow> get shadowPanelToggle => colorTokens.shadowPanelToggle;

  /// CSS: `--shadow-popover` · axis: color
  List<CsShadow> get shadowPopover => colorTokens.shadowPopover;

  /// CSS: `--shadow-split-bottom` · axis: color
  List<CsShadow> get shadowSplitBottom => colorTokens.shadowSplitBottom;

  /// CSS: `--shadow-split-side` · axis: color
  List<CsShadow> get shadowSplitSide => colorTokens.shadowSplitSide;

  /// CSS: `--shadow-sticky` · axis: color
  List<CsShadow> get shadowSticky => colorTokens.shadowSticky;

  /// CSS: `--shadow-sticky-embedded` · axis: color
  List<CsShadow> get shadowStickyEmbedded => colorTokens.shadowStickyEmbedded;

  /// CSS: `--shadow-sticky-column-first` · axis: color
  List<CsShadow> get shadowStickyColumnFirst =>
      colorTokens.shadowStickyColumnFirst;

  /// CSS: `--shadow-sticky-column-last` · axis: color
  List<CsShadow> get shadowStickyColumnLast =>
      colorTokens.shadowStickyColumnLast;

  /// Returns the value of the token called [name].
  Object operator [](String name) => switch (csTokenInfo[name]?.axis) {
    CsTokenAxis.color => colorTokens[name],
    CsTokenAxis.density => densityTokens[name],
    CsTokenAxis.motion => motionTokens[name],
    CsTokenAxis.none => staticTokens[name],
    null => throw ArgumentError.value(name, 'name', 'Unknown token'),
  };

  /// Returns a copy with some fields replaced.
  CsTokens copyWith({
    CsColorMode? colorMode,
    CsDensity? density,
    CsMotionMode? motion,
    CsColorModeTokens? colorTokens,
    CsDensityModeTokens? densityTokens,
    CsMotionModeTokens? motionTokens,
    CsStaticTokens? staticTokens,
  }) => CsTokens(
    colorMode: colorMode ?? this.colorMode,
    density: density ?? this.density,
    motion: motion ?? this.motion,
    colorTokens: colorTokens ?? this.colorTokens,
    densityTokens: densityTokens ?? this.densityTokens,
    motionTokens: motionTokens ?? this.motionTokens,
    staticTokens: staticTokens ?? this.staticTokens,
  );

  /// Returns a copy with token values replaced by name.
  ///
  /// Only the named tokens change; tokens that reference them upstream
  /// are not re-resolved here (see [CsTokenInfo.references]).
  CsTokens withOverrides(Map<String, Object> overrides) {
    if (overrides.isEmpty) return this;
    final byAxis = <CsTokenAxis, Map<String, Object>>{};
    for (final entry in overrides.entries) {
      final info = csTokenInfo[entry.key];
      if (info == null) {
        throw ArgumentError.value(entry.key, 'overrides', 'Unknown token');
      }
      (byAxis[info.axis] ??= {})[entry.key] = entry.value;
    }
    return copyWith(
      colorTokens: colorTokens.copyWithMap(
        byAxis[CsTokenAxis.color] ?? const {},
      ),
      densityTokens: densityTokens.copyWithMap(
        byAxis[CsTokenAxis.density] ?? const {},
      ),
      motionTokens: motionTokens.copyWithMap(
        byAxis[CsTokenAxis.motion] ?? const {},
      ),
      staticTokens: staticTokens.copyWithMap(
        byAxis[CsTokenAxis.none] ?? const {},
      ),
    );
  }

  /// Returns these tokens with the overrides of visual context [id]
  /// applied for the current modes.
  CsTokens inContext(CsVisualContextId id) {
    final ctx = csVisualContexts[id]!;
    return withOverrides({
      ...?ctx.color[colorMode],
      ...?ctx.density[density],
      ...?ctx.motion[motion],
      ...ctx.statics,
    });
  }
}
