// Small catalog-only building blocks, made from Cloudscape primitives and
// tokens (no Material). They stand in for components that later phases
// build properly (Segmented control, Link, Container, Header).
import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter/widgets.dart';

/// Text styles from tokens, with the token text colors applied.
extension CatalogText on BuildContext {
  CsTypography get _type => CsTypography(csTokens);

  /// Body text.
  TextStyle get body =>
      _type.bodyM.copyWith(color: csTokens.colorTextBodyDefault.toColor());

  /// Secondary body text.
  TextStyle get secondary =>
      _type.bodyM.copyWith(color: csTokens.colorTextBodySecondary.toColor());

  /// Small secondary text.
  TextStyle get small =>
      _type.bodyS.copyWith(color: csTokens.colorTextBodySecondary.toColor());

  /// Monospace body text.
  TextStyle get code => _type.monospace(body);

  /// Heading styles.
  TextStyle heading(TextStyle Function(CsTypography) pick) =>
      pick(_type).copyWith(color: csTokens.colorTextHeadingDefault.toColor());
}

/// One option of a [CatalogSegmented].
typedef CatalogSegment<T> = ({T value, String label});

/// A segmented toggle (stand-in for phase 2's Segmented control), using the
/// segment tokens. Arrow keys move between segments (Navigable group).
class CatalogSegmented<T> extends StatelessWidget {
  /// Creates the toggle.
  const CatalogSegmented({
    super.key,
    required this.label,
    required this.segments,
    required this.value,
    required this.onChange,
  });

  /// Accessible group label.
  final String label;

  /// Segments.
  final List<CatalogSegment<T>> segments;

  /// Selected value.
  final T value;

  /// Selection callback.
  final ValueChanged<T> onChange;

  @override
  Widget build(BuildContext context) {
    final t = context.csTokens;
    final radius = BorderRadius.circular(t.borderRadiusButton);
    return Semantics(
      container: true,
      label: label,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: t.colorBackgroundSegmentWrapper.toColor(),
          borderRadius: radius,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: CsNavigableGroup(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final s in segments)
                  CsPressable(
                    itemKey: s.label,
                    semanticLabel: s.label,
                    focusRingRadius: t.borderRadiusButton,
                    onPressed: () => onChange(s.value),
                    builder: (context, state) {
                      final active = s.value == value;
                      return Semantics(
                        selected: active,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color:
                                (active
                                        ? t.colorBackgroundSegmentActive
                                        : state.hovered
                                        ? t.colorBackgroundSegmentHover
                                        : t.colorBackgroundSegmentDefault)
                                    .toColor(),
                            borderRadius: radius,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: t.spaceScaledS,
                              vertical: t.spaceScaledXxxs,
                            ),
                            child: Text(
                              s.label,
                              style: context.small.copyWith(
                                fontWeight: t.fontWeightButton.toFontWeight(),
                                color:
                                    (active
                                            ? t.colorTextSegmentActive
                                            : state.hovered
                                            ? t.colorTextSegmentHover
                                            : t.colorTextSegmentDefault)
                                        .toColor(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A text link (stand-in for phase 1's Link).
class CatalogLink extends StatelessWidget {
  /// Creates the link.
  const CatalogLink({
    super.key,
    required this.text,
    required this.onFollow,
    this.external = false,
    this.active = false,
    this.style,
  });

  /// Link text.
  final String text;

  /// Follow callback.
  final VoidCallback onFollow;

  /// Shows the external icon.
  final bool external;

  /// Current page (side-navigation active state: bold accent, no hover).
  final bool active;

  /// Base style (defaults to body text).
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final t = context.csTokens;
    return CsPressable(
      role: CsPressableRole.link,
      semanticLabel: external ? '$text (opens in a new tab)' : text,
      onPressed: onFollow,
      builder: (context, state) {
        final color =
            (active
                    ? t.colorTextAccent
                    : state.hovered
                    ? t.colorTextLinkHover
                    : t.colorTextLinkDefault)
                .toColor();
        final base = style ?? context.body;
        // The external icon takes the link color from the default text style.
        return DefaultTextStyle.merge(
          style: TextStyle(color: color),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: base.copyWith(
                    color: color,
                    fontWeight: active ? FontWeight.w700 : base.fontWeight,
                    decoration: state.hovered && !active
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    decorationColor: color,
                  ),
                ),
              ),
              if (external) ...[
                SizedBox(width: t.spaceXxs),
                const CsIcon(
                  name: CsIconName.external,
                  size: CsIconSize.inherit,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// A bordered content panel (stand-in for phase 1's Container).
class CatalogPanel extends StatelessWidget {
  /// Creates the panel.
  const CatalogPanel({super.key, required this.child, this.padding = true});

  /// Content.
  final Widget child;

  /// Whether to pad the content with the container spacing.
  final bool padding;

  @override
  Widget build(BuildContext context) {
    final t = context.csTokens;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: t.colorBackgroundContainerContent.toColor(),
        borderRadius: BorderRadius.circular(t.borderRadiusContainer),
        border: Border.all(color: t.colorBorderDividerDefault.toColor()),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(t.borderRadiusContainer),
        child: padding
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: t.spaceContainerHorizontal,
                  vertical: t.spaceScaledL,
                ),
                child: child,
              )
            : child,
      ),
    );
  }
}

/// A horizontal divider line.
class CatalogDivider extends StatelessWidget {
  /// Creates the divider.
  const CatalogDivider({super.key, this.vertical = false});

  /// Vertical instead of horizontal.
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final t = context.csTokens;
    final c = t.colorBorderDividerDefault.toColor();
    final w = t.borderDividerSectionWidth;
    return vertical
        ? SizedBox(
            width: w,
            child: ColoredBox(color: c),
          )
        : SizedBox(
            height: w,
            child: ColoredBox(color: c),
          );
  }
}
