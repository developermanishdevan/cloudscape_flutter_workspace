import 'package:cloudscape_flutter/src/icon/cs_icon_provider.dart';
import 'package:cloudscape_flutter/src/icon/generated/icons.g.dart';
import 'package:cloudscape_flutter/src/icon/icon_painter.dart';
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:cloudscape_tokens/cloudscape_tokens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Icon sizes (upstream `IconProps.Size`).
enum CsIconSize {
  /// 12px.
  xSmall,

  /// 16px with a small line height.
  small,

  /// 16px.
  normal,

  /// 20px.
  medium,

  /// 32px.
  big,

  /// 48px.
  large,

  /// Picked from the surrounding text's line height and font size.
  inherit,
}

/// Icon color variants (upstream `IconProps.Variant`).
enum CsIconVariant {
  /// The current text color.
  normal,

  /// Disabled.
  disabled,

  /// Inverted.
  inverted,

  /// Subtle.
  subtle,

  /// Warning.
  warning,

  /// Error.
  error,

  /// Success.
  success,

  /// Link.
  link,

  /// Info.
  info,
}

/// Upstream `iconSizeMap(height, fontSize)` for [CsIconSize.inherit].
CsIconSize csContextualIconSize(int? height, int? fontSize) {
  if (height == null) return CsIconSize.normal;
  if (height >= 50) return CsIconSize.large;
  if (height >= 36) return CsIconSize.big;
  if (height >= 24 && fontSize != null && fontSize >= 20) {
    return CsIconSize.medium;
  }
  if (height <= 16) {
    return fontSize != null && fontSize <= 12
        ? CsIconSize.xSmall
        : CsIconSize.small;
  }
  return CsIconSize.normal;
}

final Set<String> _warned = {};

/// A Cloudscape icon (upstream `Icon`).
///
/// Shows a built-in icon by [name], a provider-registered icon by
/// [customName], an image from [url], or custom [svg] content.
class CsIcon extends StatelessWidget {
  /// Creates an icon.
  const CsIcon({
    super.key,
    this.name,
    this.customName,
    this.size = CsIconSize.normal,
    this.variant = CsIconVariant.normal,
    this.url,
    this.alt,
    this.ariaLabel,
    this.svg,
    this.badge = false,
  }) : assert(
         name == null || customName == null,
         'Use name or customName, not both',
       );

  /// A built-in icon.
  final CsIconName? name;

  /// An icon registered with [CsIconProvider] (upstream custom names).
  final String? customName;

  /// The size.
  final CsIconSize size;

  /// The color variant.
  final CsIconVariant variant;

  /// Image URL. Ignored when [svg] is set.
  final String? url;

  /// Alternative text for [url] images (prefer [ariaLabel]).
  final String? alt;

  /// Accessible label. Without it the icon is decorative.
  final String? ariaLabel;

  /// Custom icon content, sized to the icon box.
  final Widget? svg;

  /// Shows a notification badge dot.
  final bool badge;

  String? get _name => customName ?? name?.id;

  static ({double size, double stroke, double mappedHeight}) _metrics(
    CsIconSize size,
    CsTokens t,
  ) => switch (size) {
    CsIconSize.xSmall => (
      size: 12,
      stroke: t.borderWidthIconXSmall,
      mappedHeight: t.lineHeightBodyS,
    ),
    CsIconSize.small => (
      size: t.sizeIconNormal,
      stroke: t.borderWidthIconSmall,
      mappedHeight: t.lineHeightBodyS,
    ),
    CsIconSize.normal => (
      size: t.sizeIconNormal,
      stroke: t.borderWidthIconNormal,
      mappedHeight: t.lineHeightBodyM,
    ),
    CsIconSize.medium => (
      size: t.sizeIconMedium,
      stroke: t.borderWidthIconMedium,
      mappedHeight: t.lineHeightHeadingL,
    ),
    CsIconSize.big => (
      size: t.sizeIconBig,
      stroke: t.borderWidthIconBig,
      mappedHeight: t.lineHeightHeadingXl,
    ),
    CsIconSize.large => (
      size: t.sizeIconLarge,
      stroke: t.borderWidthIconLarge,
      mappedHeight: t.lineHeightDisplayL,
    ),
    CsIconSize.inherit => throw StateError('resolve inherit first'),
  };

  /// Upstream `.custom-icon.size-*` text metrics for overridden icons.
  static ({double fontSize, double lineHeight}) _customText(
    CsIconSize size,
    CsTokens t,
  ) => switch (size) {
    CsIconSize.xSmall => (fontSize: t.fontSizeBodyS, lineHeight: 12),
    CsIconSize.small || CsIconSize.normal => (
      fontSize: t.fontSizeBodyM,
      lineHeight: t.sizeIconNormal,
    ),
    CsIconSize.medium => (
      fontSize: t.fontSizeHeadingL,
      lineHeight: t.sizeIconMedium,
    ),
    CsIconSize.big => (
      fontSize: t.fontSizeHeadingXl,
      lineHeight: t.sizeIconBig,
    ),
    CsIconSize.large => (
      fontSize: t.fontSizeDisplayL,
      lineHeight: t.sizeIconLarge,
    ),
    CsIconSize.inherit => throw StateError('resolve inherit first'),
  };

  Color _color(BuildContext context, CsTokens t) => switch (variant) {
    CsIconVariant.normal =>
      DefaultTextStyle.of(context).style.color ??
          t.colorTextBodyDefault.toColor(),
    CsIconVariant.disabled => t.colorTextInteractiveDisabled.toColor(),
    CsIconVariant.inverted => t.colorTextInverted.toColor(),
    CsIconVariant.subtle => t.colorTextIconSubtle.toColor(),
    CsIconVariant.warning => t.colorTextStatusWarning.toColor(),
    CsIconVariant.error => t.colorTextStatusError.toColor(),
    CsIconVariant.success => t.colorTextStatusSuccess.toColor(),
    CsIconVariant.link => t.colorTextLinkDefault.toColor(),
    CsIconVariant.info => t.colorTextStatusInfo.toColor(),
  };

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    final contextual = size == CsIconSize.inherit;
    int? parentHeight;
    var iconSize = size;
    if (contextual) {
      final style = DefaultTextStyle.of(context).style;
      final fontSize = style.fontSize;
      final lineHeight = fontSize != null && style.height != null
          ? style.height! * fontSize
          : null;
      parentHeight = lineHeight?.floor();
      iconSize = csContextualIconSize(parentHeight, fontSize?.floor());
    }
    final m = _metrics(iconSize, t);
    final color = _color(context, t);
    final iconName = _name;

    Widget? content;
    var isCustom = false;
    if (svg != null) {
      if (url != null) {
        _warnOnce(
          'You have specified both `url` and `svg`. `svg` will take precedence and `url` will be ignored.',
        );
      }
      content = svg;
      isCustom = true;
    } else if (url != null) {
      content = Image.network(
        url!,
        width: m.size,
        height: m.size,
        semanticLabel: ariaLabel ?? alt,
      );
    } else if (iconName != null) {
      final override = CsIconProvider.iconOf(context, iconName);
      if (override != null) {
        final text = _customText(iconSize, t);
        content = DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: text.fontSize,
            height: text.lineHeight / text.fontSize,
            color: color,
          ),
          child: override,
        );
        isCustom = true;
      } else {
        final data =
            iconName == 'gen-ai' &&
                (iconSize == CsIconSize.small || iconSize == CsIconSize.xSmall)
            ? csGenAiSmallIcon
            : csBuiltInIcons[iconName];
        if (data == null) {
          _warnOnce(
            'You have specified `name="$iconName"` but no icon with that name was found in the current '
            'CsIconProvider context. If this is a custom icon, register it with CsIconProvider.',
          );
        } else {
          content = CustomPaint(
            size: Size.square(m.size),
            painter: CsIconPainter(
              data: data,
              color: color,
              strokeWidth: m.stroke,
            ),
          );
        }
      }
    }

    Widget icon = SizedBox.square(
      dimension: m.size,
      child: isCustom
          ? IconTheme.merge(
              data: IconThemeData(color: color, size: m.size),
              child: DefaultTextStyle.merge(
                style: TextStyle(color: color),
                child: content!,
              ),
            )
          : content,
    );
    final boxHeight = contextual
        ? (parentHeight?.toDouble() ?? m.size)
        : m.mappedHeight;
    icon = SizedBox(
      width: m.size,
      height: boxHeight,
      child: OverflowBox(
        minWidth: m.size,
        maxWidth: m.size,
        minHeight: m.size,
        maxHeight: m.size,
        // Negative CSS padding clamps to 0, so a taller icon overflows down.
        alignment: boxHeight >= m.size ? Alignment.center : Alignment.topCenter,
        child: icon,
      ),
    );
    if (badge) {
      icon = Stack(
        clipBehavior: Clip.none,
        children: [
          icon,
          PositionedDirectional(
            top: 0,
            end: -3,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: t.colorBackgroundBadgeIcon.toColor(),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      );
    }
    if (iconName != null &&
        csRtlMirroredIcons.contains(iconName) &&
        Directionality.maybeOf(context) == TextDirection.rtl) {
      icon = Transform.flip(flipX: true, child: icon);
    }
    if (url != null && svg == null) return icon; // the image carries the label
    return ariaLabel != null
        ? Semantics(
            label: ariaLabel,
            image: true,
            child: ExcludeSemantics(child: icon),
          )
        : ExcludeSemantics(child: icon);
  }

  void _warnOnce(String message) {
    if (kDebugMode && _warned.add(message)) {
      debugPrint('[AwsUi] [Icon] $message');
    }
  }
}
