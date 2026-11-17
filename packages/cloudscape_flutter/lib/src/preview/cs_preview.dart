// Widget preview support: `@CsPreview` renders every preview in light, dark,
// compact and RTL, each inside a real CsApp (theme, fonts, icons, overlay).
//
// Run the previewer:  dart run melos run preview
// (or: cd packages/cloudscape_flutter && fvm flutter widget-preview start)
import 'package:cloudscape_flutter/src/app/cs_app.dart';
import 'package:cloudscape_flutter/src/internal/pressable.dart';
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:cloudscape_tokens/cloudscape_tokens.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter/widgets.dart';

/// A previewed widget inside a Cloudscape app frame.
class CsPreviewFrame extends StatelessWidget {
  /// Creates the frame.
  const CsPreviewFrame({
    super.key,
    required this.child,
    this.colorMode = CsColorMode.light,
    this.density = CsDensity.comfortable,
    this.direction = TextDirection.ltr,
  });

  /// The previewed widget.
  final Widget child;

  /// Light or dark.
  final CsColorMode colorMode;

  /// Comfortable or compact.
  final CsDensity density;

  /// LTR or RTL.
  final TextDirection direction;

  @override
  Widget build(BuildContext context) => CsApp(
    debugShowCheckedModeBanner: false,
    theme: CsThemeData(
      colorMode: colorMode,
      density: density,
      motion: CsMotionMode.normal,
    ),
    home: Directionality(
      textDirection: direction,
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    ),
  );
}

/// Preview wrapper: light, comfortable, LTR.
Widget csPreviewLight(Widget child) => CsPreviewFrame(child: child);

/// Preview wrapper: dark.
Widget csPreviewDark(Widget child) =>
    CsPreviewFrame(colorMode: CsColorMode.dark, child: child);

/// Preview wrapper: compact density.
Widget csPreviewCompact(Widget child) =>
    CsPreviewFrame(density: CsDensity.compact, child: child);

/// Preview wrapper: right-to-left.
Widget csPreviewRtl(Widget child) =>
    CsPreviewFrame(direction: TextDirection.rtl, child: child);

/// The four preview variants.
enum CsPreviewVariant {
  /// Light, comfortable, LTR.
  light,

  /// Dark mode.
  dark,

  /// Compact density.
  compact,

  /// Right-to-left.
  rtl;

  /// The wrapper for this variant.
  WidgetWrapper get wrapper => switch (this) {
    light => csPreviewLight,
    dark => csPreviewDark,
    compact => csPreviewCompact,
    rtl => csPreviewRtl,
  };
}

/// Marks a Cloudscape widget preview. Expands to light, dark, compact and
/// RTL previews in the same [group].
final class CsPreview extends MultiPreview {
  /// Creates the annotation.
  const CsPreview({required this.group, required this.name, this.size});

  /// Component name, e.g. `Box`.
  final String group;

  /// Scenario name, e.g. `Variants`.
  final String name;

  /// Optional fixed preview size.
  final Size? size;

  @override
  List<Preview> get previews => [
    for (final v in CsPreviewVariant.values)
      Preview(
        group: group,
        name: '$name · ${v.name}',
        size: size,
        wrapper: v.wrapper,
      ),
  ];
}

/// A minimal clickable control for previews of components that host
/// interactive children (until the real Button lands in phase 1).
class CsPreviewButton extends StatelessWidget {
  /// Creates the control.
  const CsPreviewButton(
    this.label, {
    super.key,
    this.onPressed,
    this.disabled = false,
  });

  /// Label.
  final String label;

  /// Press callback.
  final VoidCallback? onPressed;

  /// Disabled state.
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    return CsPressable(
      disabled: disabled,
      onPressed: onPressed ?? () {},
      builder: (context, s) => DecoratedBox(
        decoration: BoxDecoration(
          color:
              (s.pressed
                      ? t.colorBackgroundButtonNormalActive
                      : s.hovered
                      ? t.colorBackgroundButtonNormalHover
                      : t.colorBackgroundButtonNormalDefault)
                  .toColor(),
          border: Border.all(
            width: t.borderWidthButton,
            color:
                (s.disabled
                        ? t.colorBorderButtonNormalDisabled
                        : t.colorBorderButtonNormalDefault)
                    .toColor(),
          ),
          borderRadius: BorderRadius.circular(t.borderRadiusButton),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: t.spaceButtonHorizontal,
            vertical: t.spaceScaledXxs,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: t.fontWeightButton.toFontWeight(),
              color:
                  (s.disabled
                          ? t.colorTextInteractiveDisabled
                          : t.colorTextButtonNormalDefault)
                      .toColor(),
            ),
          ),
        ),
      ),
    );
  }
}
