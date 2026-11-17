import 'package:cloudscape_flutter/src/internal/focus_visible.dart';
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:flutter/widgets.dart';

/// Upstream's focus highlight: a solid ring drawn outside the child,
/// [gutter] away from its edges, shown only when [focused] and the user is
/// navigating with the keyboard ([CsFocusVisible]).
///
/// Mirrors the `::before` pseudo-element: inset by `-gutter`, radius
/// `border-radius-control-default-focus-ring`, `box-shadow: 0 0 0 2px
/// color-border-item-focused`.
class CsFocusRing extends StatefulWidget {
  /// Creates a focus ring.
  const CsFocusRing({
    super.key,
    required this.focused,
    required this.child,
    this.gutter = 4,
    this.borderRadius,
    this.width = 2,
    this.color,
  });

  /// Whether the wrapped element has focus.
  final bool focused;

  /// The element.
  final Widget child;

  /// Distance between the element and the ring (e.g.
  /// `space-button-focus-outline-gutter`).
  final double gutter;

  /// Ring corner radius. Defaults to `border-radius-control-default-focus-ring`.
  final double? borderRadius;

  /// Ring width (upstream default 2px).
  final double width;

  /// Ring color. Defaults to `color-border-item-focused`.
  final Color? color;

  @override
  State<CsFocusRing> createState() => _CsFocusRingState();
}

class _CsFocusRingState extends State<CsFocusRing> {
  @override
  void initState() {
    super.initState();
    CsFocusVisible.attach();
  }

  @override
  void dispose() {
    CsFocusVisible.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = CsTheme.tokensOf(context);
    return ValueListenableBuilder<bool>(
      valueListenable: CsFocusVisible.isKeyboard,
      builder: (context, keyboard, child) => CustomPaint(
        foregroundPainter: widget.focused && keyboard
            ? _RingPainter(
                gutter: widget.gutter,
                radius:
                    widget.borderRadius ??
                    tokens.borderRadiusControlDefaultFocusRing,
                width: widget.width,
                color: widget.color ?? tokens.colorBorderItemFocused.toColor(),
              )
            : null,
        child: child,
      ),
      child: widget.child,
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.gutter,
    required this.radius,
    required this.width,
    required this.color,
  });

  final double gutter;
  final double radius;
  final double width;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final inner = RRect.fromRectAndRadius(
      (Offset.zero & size).inflate(gutter),
      Radius.circular(radius),
    );
    final outer = RRect.fromRectAndRadius(
      inner.outerRect.inflate(width),
      Radius.circular(radius + width),
    );
    canvas.drawDRRect(outer, inner, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.gutter != gutter ||
      old.radius != radius ||
      old.width != width ||
      old.color != color;
}
