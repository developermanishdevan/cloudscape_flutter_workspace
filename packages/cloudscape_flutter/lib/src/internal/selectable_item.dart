// Port of upstream `internal/components/selectable-item`: the row used by
// option lists and menus (select, multiselect, autosuggest, button dropdown).
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:flutter/widgets.dart';

/// What moved the highlight (upstream `highlightType`).
enum CsHighlightType {
  /// Pointer hover.
  mouse,

  /// Arrow keys.
  keyboard,
}

/// One option / menu row with upstream's states: highlighted (hover or
/// keyboard), selected, disabled, and selected-neighbour corner joining.
class CsSelectableItem extends StatelessWidget {
  /// Creates an item.
  const CsSelectableItem({
    super.key,
    required this.child,
    this.selected = false,
    this.highlighted = false,
    this.disabled = false,
    this.highlightType = CsHighlightType.mouse,
    this.hasBackground = false,
    this.padBottom = false,
    this.isNextSelected = false,
    this.isPreviousSelected = false,
    this.disableContentStyling = false,
    this.isParent = false,
    this.isChild = false,
    this.onHover,
    this.onTap,
  });

  /// Content.
  final Widget child;

  /// Selected (checked) option.
  final bool selected;

  /// Highlighted by hover or keyboard.
  final bool highlighted;

  /// Disabled option.
  final bool disabled;

  /// What highlighted it (keyboard uses the focused ring color).
  final CsHighlightType highlightType;

  /// Always use the highlighted background.
  final bool hasBackground;

  /// Extra bottom padding with a divider (last item of a group).
  final bool padBottom;

  /// The next item is selected (square bottom corners).
  final bool isNextSelected;

  /// The previous item is selected (square top corners).
  final bool isPreviousSelected;

  /// Skip the default content padding.
  final bool disableContentStyling;

  /// Pointer entered (upstream highlights on mouse move).
  final VoidCallback? onHover;

  /// Pointer tap.
  final VoidCallback? onTap;

  /// A (non-interactive) group header row: bold, group label color, a
  /// group divider on top.
  final bool isParent;

  /// An option inside a group: indented.
  final bool isChild;

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    final bw = t.borderWidthItemSelected;
    final rings = <(double, Color)>[];
    Color background;
    Color textColor;
    if (highlighted && disabled) {
      background = t.colorBackgroundDropdownItemDimmed.toColor();
      textColor = t.colorTextDropdownItemDimmed.toColor();
      rings.add((bw, t.colorBorderDropdownItemDimmedHover.toColor()));
    } else {
      final ringColor =
          (highlightType == CsHighlightType.keyboard
                  ? t.colorBorderDropdownItemFocused
                  : t.colorBorderDropdownItemHover)
              .toColor();
      if (selected) {
        background = t.colorBackgroundDropdownItemSelected.toColor();
        rings.add((bw, t.colorBorderDropdownItemSelected.toColor()));
        if (highlighted) rings.add((2 * bw, ringColor));
      } else if (highlighted) {
        background = t.colorBackgroundDropdownItemHover.toColor();
        rings.add((bw, ringColor));
      } else {
        background =
            (hasBackground
                    ? t.colorBackgroundDropdownItemHover
                    : t.colorBackgroundDropdownItemDefault)
                .toColor();
      }
      textColor = disabled
          ? t.colorTextDropdownItemDisabled.toColor()
          : (isParent
                    ? t.colorTextDropdownGroupLabel
                    : highlighted || selected
                    ? t.colorTextDropdownItemHighlighted
                    : t.colorTextDropdownItemDefault)
                .toColor();
    }
    // Radius: highlighted → dropdown radius; selected only → item radius;
    // joined corners between consecutive selected items.
    final r = highlighted
        ? t.borderRadiusDropdown
        : (selected ? t.borderRadiusItem : 0.0);
    final top = selected && isPreviousSelected ? 0.0 : r;
    final bottom = selected && isNextSelected ? 0.0 : r;
    final radius = BorderRadius.only(
      topLeft: Radius.circular(top),
      topRight: Radius.circular(top),
      bottomLeft: Radius.circular(bottom),
      bottomRight: Radius.circular(bottom),
    );

    Widget content = disableContentStyling
        ? child
        : Padding(
            padding: isParent
                ? EdgeInsets.all(t.spaceXs)
                : EdgeInsetsDirectional.only(
                    top: t.spaceOptionPaddingVertical,
                    bottom:
                        t.spaceOptionPaddingVertical +
                        (padBottom ? t.spaceXxxs : 0),
                    start: isChild ? t.spaceXxl : t.spaceFieldHorizontal,
                    end: t.spaceFieldHorizontal,
                  ),
            child: child,
          );
    content = DefaultTextStyle.merge(
      style: TextStyle(
        color: textColor,
        fontWeight: isParent ? t.fontWeightBold.toFontWeight() : null,
      ),
      child: content,
    );
    final outer = isParent && !disableContentStyling ? 0.0 : t.borderItemWidth;
    Widget item = CustomPaint(
      painter: CsSelectableItemPainter(
        background: background,
        radius: radius,
        rings: rings,
        divider: rings.isEmpty
            ? t.colorBorderDropdownItemDefault.toColor()
            : null,
        dividerTop: rings.isEmpty && isParent
            ? t.colorBorderDropdownGroup.toColor()
            : null,
        dividerWidth: t.borderDividerListWidth,
        padBottom: padBottom,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: outer,
          right: outer,
          top: outer,
          bottom: outer + (padBottom ? outer : 0),
        ),
        child: content,
      ),
    );
    item = Semantics(
      selected: isParent ? null : selected,
      enabled: isParent ? null : !disabled,
      header: isParent,
      child: item,
    );
    if (onHover == null && onTap == null) return item;
    return MouseRegion(
      onEnter: (_) => onHover?.call(),
      onHover: (_) => onHover?.call(),
      cursor: disabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: disabled ? null : onTap,
        child: item,
      ),
    );
  }
}

/// Background, inset rings (CSS `box-shadow: inset 0 0 0 w color`, first
/// ring on top) and the top/bottom 1px dividers of a [CsSelectableItem].
class CsSelectableItemPainter extends CustomPainter {
  /// Creates the painter.
  CsSelectableItemPainter({
    required this.background,
    required this.radius,
    required this.rings,
    required this.divider,
    required this.dividerWidth,
    required this.padBottom,
    this.dividerTop,
  });

  /// Fill color.
  final Color background;

  /// Corner radii.
  final BorderRadius radius;

  /// Inset rings `(width, color)`, first on top.
  final List<(double, Color)> rings;

  /// Divider color (null when a ring is shown).
  final Color? divider;

  /// Top divider color; defaults to [divider].
  final Color? dividerTop;

  /// Divider thickness.
  final double dividerWidth;

  /// Extra bottom padding (last item of a group).
  final bool padBottom;

  @override
  void paint(Canvas canvas, Size size) {
    final outer = radius.toRRect(Offset.zero & size);
    canvas.drawRRect(outer, Paint()..color = background);
    // Inset shadows: later ones are drawn first (beneath).
    for (final (width, color) in rings.reversed) {
      final inner = outer.deflate(width);
      canvas.drawDRRect(outer, inner, Paint()..color = color);
    }
    final d = divider;
    if (d != null) {
      final paint = Paint()..color = d;
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, dividerWidth),
        Paint()..color = dividerTop ?? d,
      );
      canvas.drawRect(
        Rect.fromLTWH(0, size.height - dividerWidth, size.width, dividerWidth),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CsSelectableItemPainter old) =>
      old.background != background ||
      old.radius != radius ||
      old.divider != divider ||
      old.dividerTop != dividerTop ||
      old.rings.length != rings.length ||
      [for (var i = 0; i < rings.length; i++) rings[i] != old.rings[i]]
          .any((x) => x);
}
