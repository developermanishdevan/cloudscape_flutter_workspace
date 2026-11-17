import 'dart:math' as math;

import 'package:cloudscape_flutter/src/components/dropdown/dropdown_geometry.dart';
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:cloudscape_flutter/src/theme/typography.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Upstream `DropdownProps.Style.dropdown`.
@immutable
class CsDropdownStyle {
  /// Creates style overrides.
  const CsDropdownStyle({
    this.background,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
  });

  /// Background color.
  final Color? background;

  /// Outline color.
  final Color? borderColor;

  /// Corner radius.
  final double? borderRadius;

  /// Outline width.
  final double? borderWidth;
}

/// Upstream `DropdownAlignment`.
enum CsDropdownAlignment {
  /// Aligned to the trigger's start (or end when it does not fit).
  start,

  /// Centered on the trigger when there is room.
  center,
}

/// Where the open dropdown sits relative to its trigger (upstream
/// `DropdownContext.position`).
enum CsDropdownPlacement {
  /// Below, extending towards inline end.
  bottomRight,

  /// Below, extending towards inline start.
  bottomLeft,

  /// Above, extending towards inline end.
  topRight,

  /// Above, extending towards inline start.
  topLeft,
}

/// Exposes the dropdown placement to its content.
class CsDropdownContext extends InheritedWidget {
  /// Creates the context.
  const CsDropdownContext({
    super.key,
    required this.placement,
    required super.child,
  });

  /// The placement.
  final CsDropdownPlacement placement;

  /// The nearest placement, or [CsDropdownPlacement.bottomRight].
  static CsDropdownPlacement placementOf(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<CsDropdownContext>()
          ?.placement ??
      CsDropdownPlacement.bottomRight;

  @override
  bool updateShouldNotify(CsDropdownContext old) => old.placement != placement;
}

/// A trigger with an attached floating panel (upstream `Dropdown`).
///
/// The panel opens below the trigger, or above when there is not enough
/// room, aligned to the trigger's start (or end), sized to its content
/// within [minWidth]/[maxWidth] and the space available inside scroll
/// containers and the screen (upstream fit handler), and cropped to whole
/// 31px rows when it does not fit vertically.
class CsDropdown extends StatefulWidget {
  /// Creates a dropdown.
  const CsDropdown({
    super.key,
    required this.trigger,
    this.header,
    this.content,
    this.footer,
    this.open = false,
    this.onOutsideClick,
    this.minWidth,
    this.maxWidth,
    this.onEscape,
    this.onFocusEnter,
    this.onFocusLeave,
    this.ariaRole,
    this.ariaLabel,
    this.style,
    this.expandToViewport = false,
    this.stretchTriggerHeight = false,
    this.stretchHeight = false,
    this.maxHeight,
    this.hideBlockBorder = true,
    this.preferredAlignment = CsDropdownAlignment.start,
    this.interior = false,
    bool? loopFocus,
    this.onFocus,
    this.onBlur,
    this.contentKey,
    this.contentScrolls = true,
  }) : loopFocus = loopFocus ?? expandToViewport;

  /// The trigger.
  final Widget trigger;

  /// Content above [content].
  final Widget? header;

  /// The main content.
  final Widget? content;

  /// Content below [content].
  final Widget? footer;

  /// Whether the panel is shown.
  final bool open;

  /// A pointer press outside the trigger and the panel.
  final VoidCallback? onOutsideClick;

  /// Minimum width: pixels or [CsDropdownWidth.trigger].
  final CsDropdownWidth? minWidth;

  /// Maximum width: pixels or [CsDropdownWidth.trigger].
  final CsDropdownWidth? maxWidth;

  /// Escape pressed while open (consumes the key, like upstream).
  final VoidCallback? onEscape;

  /// Focus moved into the panel.
  final VoidCallback? onFocusEnter;

  /// Focus left the panel.
  final VoidCallback? onFocusLeave;

  /// ARIA role of the panel (`dialog`, `alertdialog`, `tooltip`, `form`
  /// map to Flutter roles; others only set the label).
  final String? ariaRole;

  /// Accessible label of the panel.
  final String? ariaLabel;

  /// Style overrides.
  final CsDropdownStyle? style;

  /// Position against the screen only, ignoring scroll containers.
  final bool expandToViewport;

  /// Internal: the trigger fills the available height.
  final bool stretchTriggerHeight;

  /// Internal: use all available height (no row cropping or reserve).
  final bool stretchHeight;

  /// Internal: maximum panel height.
  final double? maxHeight;

  /// Internal: hide the top/bottom list borders (default true).
  final bool hideBlockBorder;

  /// Internal: preferred alignment.
  final CsDropdownAlignment preferredAlignment;

  /// Internal: nested fly-out next to the trigger (sub-menus).
  final bool interior;

  /// Internal: Tab cycles between trigger and panel (default:
  /// [expandToViewport]).
  final bool loopFocus;

  /// Internal: focus entered the trigger or panel from outside.
  final VoidCallback? onFocus;

  /// Internal: focus left the trigger and panel.
  final VoidCallback? onBlur;

  /// Internal: changing it re-runs positioning while open.
  final Object? contentKey;

  /// Wrap [content] in a vertical scroll view (set false when the content
  /// scrolls itself, e.g. option lists).
  final bool contentScrolls;

  @override
  State<CsDropdown> createState() => _CsDropdownState();
}

class _CsDropdownState extends State<CsDropdown> {
  final LayerLink _link = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();
  final OverlayPortalController _portal = OverlayPortalController();
  final Object _tapGroup = Object();
  final FocusNode _contentGroup = FocusNode(
    debugLabel: 'CsDropdown content',
    skipTraversal: true,
    canRequestFocus: false,
  );
  final FocusNode _triggerGroup = FocusNode(
    debugLabel: 'CsDropdown trigger',
    skipTraversal: true,
    canRequestFocus: false,
  );
  int _openCount = 0;
  CsDropdownPlacement _placement = CsDropdownPlacement.bottomRight;

  @override
  void initState() {
    super.initState();
    _portal.show();
    if (widget.open) _openCount++;
    _syncEscape();
  }

  @override
  void didUpdateWidget(CsDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.open && !oldWidget.open) {
      _openCount++;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && widget.open) _portal.show(); // bring to the top
      });
    }
    _syncEscape();
  }

  bool _escapeAttached = false;

  void _syncEscape() {
    final want = widget.open && widget.onEscape != null;
    if (want && !_escapeAttached) {
      HardwareKeyboard.instance.addHandler(_onKey);
    } else if (!want && _escapeAttached) {
      HardwareKeyboard.instance.removeHandler(_onKey);
    }
    _escapeAttached = want;
  }

  bool _onKey(KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.escape) {
      widget.onEscape?.call();
      return true; // like stopPropagation in the capture phase
    }
    return false;
  }

  @override
  void dispose() {
    if (_escapeAttached) HardwareKeyboard.instance.removeHandler(_onKey);
    _contentGroup.dispose();
    _triggerGroup.dispose();
    super.dispose();
  }

  /// The overlay hosting the panel; all geometry is measured in its
  /// coordinate space (it plays the role of upstream's viewport and is
  /// immune to app nesting, offsets and zoom, e.g. in widget previews).
  RenderBox? _overlayBox() {
    final ctx = _triggerKey.currentContext;
    if (ctx == null) return null;
    final box = Overlay.maybeOf(ctx)?.context.findRenderObject();
    return box is RenderBox && box.hasSize ? box : null;
  }

  Rect? _triggerRect() {
    final box = _triggerKey.currentContext?.findRenderObject();
    final overlay = _overlayBox();
    if (box is! RenderBox || !box.hasSize || !box.attached || overlay == null) {
      return null;
    }
    return box.localToGlobal(Offset.zero, ancestor: overlay) & box.size;
  }

  /// Upstream `getOverflowParentDimensions`: clipping ancestors (scroll
  /// views, clips) then the screen.
  List<Rect> _overflowParents(Size screen) {
    final parents = <Rect>[];
    final overlay = _overlayBox();
    if (!widget.expandToViewport) {
      RenderObject? node = _triggerKey.currentContext
          ?.findRenderObject()
          ?.parent;
      while (node != null) {
        final clips =
            node is RenderAbstractViewport ||
            (node is RenderClipRect && node.clipBehavior != Clip.none) ||
            (node is RenderClipRRect && node.clipBehavior != Clip.none) ||
            (node is RenderClipPath && node.clipBehavior != Clip.none);
        if (identical(node, overlay)) break;
        if (clips && node is RenderBox && node.hasSize) {
          parents.add(
            node.localToGlobal(Offset.zero, ancestor: overlay) & node.size,
          );
        }
        node = node.parent;
      }
    }
    parents.add(Offset.zero & screen);
    if (widget.interior && !widget.expandToViewport && parents.length > 1) {
      parents.removeAt(0);
    }
    return parents;
  }

  void _setPlacement(CsDropdownPosition p) {
    final placement = p.dropBlockStart
        ? (p.dropInlineStart
              ? CsDropdownPlacement.topLeft
              : CsDropdownPlacement.topRight)
        : (p.dropInlineStart
              ? CsDropdownPlacement.bottomLeft
              : CsDropdownPlacement.bottomRight);
    if (placement != _placement) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _placement = placement);
      });
    }
  }

  Widget _buildOverlay(BuildContext context) {
    if (!widget.open) return const SizedBox.shrink();
    final media = MediaQuery.of(context);
    final rtl = Directionality.maybeOf(context) == TextDirection.rtl;
    // Geometry of the trigger and clipping ancestors from the last laid-out
    // frame (reading other render objects is not allowed during layout).
    final measuredTrigger = _triggerRect();
    if (measuredTrigger == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && widget.open) setState(() {});
      });
      return const SizedBox.shrink();
    }
    final overlaySize = _overlayBox()?.size ?? media.size;
    final measuredParents = _overflowParents(overlaySize);
    // If the trigger is resized in this frame, re-measure on the next one.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final now = _triggerRect();
      if (mounted &&
          widget.open &&
          now != null &&
          now.size != measuredTrigger.size) {
        setState(() {});
      }
    });
    return CompositedTransformFollower(
      link: _link,
      showWhenUnlinked: false,
      child: _DropdownLayout(
        // Re-position on the same dependencies as upstream's layout effect.
        key: ValueKey((
          'pos',
          _openCount,
          widget.contentKey,
          widget.interior,
          widget.minWidth == CsDropdownWidth.trigger &&
              widget.maxWidth == CsDropdownWidth.trigger,
          media.size.width <= csMobileBreakpoint,
          measuredTrigger.size,
        )),
        computePosition: (requiredWidth, measureHeight) {
          final screen = overlaySize;
          Rect logical(Rect r) => rtl
              ? Rect.fromLTRB(
                  screen.width - r.right,
                  r.top,
                  screen.width - r.left,
                  r.bottom,
                )
              : r;
          final t = logical(measuredTrigger);
          final parents = measuredParents.map(logical).toList();
          final isMobile = screen.width <= csMobileBreakpoint;
          final matchTriggerWidth =
              widget.minWidth == CsDropdownWidth.trigger &&
              widget.maxWidth == CsDropdownWidth.trigger;
          final flexible = !matchTriggerWidth && !widget.interior;
          // Natural width: max-content within the CSS min/max of
          // `use-flexible-width`, or the trigger width.
          var natural = flexible
              ? requiredWidth
                    .clamp(
                      csResolveDropdownWidth(widget.minWidth, t.width, 0),
                      math.max(
                        csResolveDropdownWidth(widget.minWidth, t.width, 0),
                        csResolveDropdownWidth(
                          widget.maxWidth,
                          t.width,
                          double.maxFinite,
                        ),
                      ),
                    )
                    .toDouble()
              : (widget.interior ? requiredWidth : t.width);
          final CsDropdownPosition p;
          if (widget.interior) {
            p = csInteriorDropdownPosition(
              trigger: t,
              overflowParents: parents,
              dropdownWidth: natural,
              dropdownHeight: measureHeight(natural),
              isMobile: isMobile,
            );
          } else {
            p = csDropdownPosition(
              trigger: t,
              overflowParents: parents,
              requiredWidth: natural,
              dropdownHeight: measureHeight(natural),
              minWidth: widget.minWidth,
              maxWidth: widget.maxWidth,
              preferCenter:
                  widget.preferredAlignment == CsDropdownAlignment.center,
              matchTriggerWidth: matchTriggerWidth,
              stretchHeight: widget.stretchHeight,
              isMobile: isMobile,
              maxHeight: widget.maxHeight,
            );
          }
          _setPlacement(p);
          final width =
              !widget.interior && matchTriggerWidth && !widget.expandToViewport
              ? t.width
              : p.inlineSize;
          natural = width;
          // Logical offset of the panel's start from the trigger's start.
          final double dx;
          if (p.insetInlineStart != null) {
            dx = p.insetInlineStart!;
          } else {
            dx = p.dropInlineStart ? t.width - width : 0;
          }
          return _Placement(
            width: width,
            maxHeight: p.blockSize,
            up:
                p.dropBlockStart && !widget.interior ||
                (widget.interior && p.dropBlockStart),
            interior: widget.interior,
            dx: rtl ? t.width - dx - width : dx,
            triggerHeight: t.height,
          );
        },
        child: TapRegion(
          groupId: _tapGroup,
          child: Focus(
            focusNode: _contentGroup,
            onFocusChange: (has) =>
                has ? widget.onFocusEnter?.call() : widget.onFocusLeave?.call(),
            child: CsDropdownContext(
              placement: _placement,
              child: _DropdownPanel(
                header: widget.header,
                content: widget.content,
                footer: widget.footer,
                style: widget.style,
                hideBlockBorder: widget.hideBlockBorder,
                interior: widget.interior,
                ariaRole: widget.ariaRole,
                ariaLabel: widget.ariaLabel,
                contentScrolls: widget.contentScrolls,
                up:
                    _placement == CsDropdownPlacement.topLeft ||
                    _placement == CsDropdownPlacement.topRight,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget trigger = KeyedSubtree(key: _triggerKey, child: widget.trigger);
    if (widget.stretchTriggerHeight) {
      trigger = SizedBox(height: double.infinity, child: trigger);
    }
    return FocusTraversalGroup(
      policy: _DropdownTraversalPolicy(
        loop: () => widget.open && widget.loopFocus,
        trigger: _triggerGroup,
        content: _contentGroup,
      ),
      child: Focus(
        canRequestFocus: false,
        skipTraversal: true,
        onFocusChange: (has) =>
            has ? widget.onFocus?.call() : widget.onBlur?.call(),
        child: TapRegion(
          groupId: _tapGroup,
          onTapOutside: widget.open && widget.onOutsideClick != null
              ? (_) => widget.onOutsideClick!()
              : null,
          child: OverlayPortal(
            controller: _portal,
            overlayChildBuilder: _buildOverlay,
            child: CompositedTransformTarget(
              link: _link,
              child: Focus(focusNode: _triggerGroup, child: trigger),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tab order: trigger, then panel (DOM order). With `loopFocus`, Tab from
/// the panel's last item returns to the trigger, and Shift+Tab from the
/// panel's first item goes to the trigger's last item (upstream TabTraps).
class _DropdownTraversalPolicy extends WidgetOrderTraversalPolicy {
  _DropdownTraversalPolicy({
    required this.loop,
    required this.trigger,
    required this.content,
  });

  final bool Function() loop;
  final FocusNode trigger;
  final FocusNode content;

  List<FocusNode> _focusables(FocusNode group) => group.traversalDescendants
      .where((n) => n.canRequestFocus && !n.skipTraversal)
      .toList();

  @override
  bool next(FocusNode currentNode) {
    if (loop()) {
      final inContent = _focusables(content);
      final inTrigger = _focusables(trigger);
      if (inContent.isNotEmpty &&
          inContent.last == currentNode &&
          inTrigger.isNotEmpty) {
        inTrigger.first.requestFocus();
        return true;
      }
      if (inTrigger.isNotEmpty &&
          inTrigger.last == currentNode &&
          inContent.isNotEmpty) {
        inContent.first.requestFocus();
        return true;
      }
    }
    return super.next(currentNode);
  }

  @override
  bool previous(FocusNode currentNode) {
    if (loop()) {
      final inContent = _focusables(content);
      final inTrigger = _focusables(trigger);
      if (inContent.isNotEmpty &&
          inContent.first == currentNode &&
          inTrigger.isNotEmpty) {
        inTrigger.last.requestFocus();
        return true;
      }
    }
    return super.previous(currentNode);
  }
}

class _Placement {
  _Placement({
    required this.width,
    required this.maxHeight,
    required this.up,
    required this.interior,
    required this.dx,
    required this.triggerHeight,
  });

  final double width;
  final double maxHeight;
  final bool up;
  final bool interior;

  /// Physical x offset of the panel from the trigger's left edge.
  final double dx;
  final double triggerHeight;
}

/// Measures the panel, asks for a placement once per open/contentKey, lays
/// the panel out and paints it next to the trigger.
class _DropdownLayout extends SingleChildRenderObjectWidget {
  const _DropdownLayout({
    super.key,
    required this.computePosition,
    required super.child,
  });

  final _Placement? Function(
    double requiredWidth,
    double Function(double width) measureHeight,
  )
  computePosition;

  @override
  _RenderDropdownLayout createRenderObject(BuildContext context) =>
      _RenderDropdownLayout(computePosition);

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderDropdownLayout renderObject,
  ) {
    renderObject.computePosition = computePosition;
  }
}

class _RenderDropdownLayout extends RenderProxyBox {
  _RenderDropdownLayout(this.computePosition);

  _Placement? Function(
    double requiredWidth,
    double Function(double width) measureHeight,
  )
  computePosition;
  _Placement? _placement; // frozen for this open (key)
  Offset _childOffset = Offset.zero;

  @override
  void performLayout() {
    final c = child;
    if (c == null) {
      size = constraints.constrain(
        Size.zero,
      ); // overlay children get tight constraints
      return;
    }
    _placement ??= computePosition(
      c.getMaxIntrinsicWidth(double.infinity),
      (w) => c.getMaxIntrinsicHeight(w),
    );
    final p = _placement;
    if (p == null) {
      c.layout(const BoxConstraints.tightFor(width: 0, height: 0));
      size = constraints.constrain(
        Size.zero,
      ); // overlay children get tight constraints
      return;
    }
    c.layout(
      BoxConstraints(
        minWidth: p.width,
        maxWidth: p.width,
        maxHeight: p.maxHeight,
      ),
      parentUsesSize: true,
    );
    final h = c.size.height;
    final double dy;
    if (p.interior) {
      dy = p.up ? p.triggerHeight - h : -1; // margin-block-start: -1px
    } else {
      dy = p.up ? -h : p.triggerHeight;
    }
    _childOffset = Offset(p.dx, dy);
    size = constraints.constrain(
      Size.zero,
    ); // overlay children get tight constraints
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final c = child;
    if (c != null && _placement != null) {
      context.paintChild(c, offset + _childOffset);
    }
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.translateByDouble(_childOffset.dx, _childOffset.dy, 0, 1);
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final c = child;
    if (c == null || _placement == null) return false;
    return result.addWithPaintOffset(
      offset: _childOffset,
      position: position,
      hitTest: (result, transformed) =>
          c.hitTest(result, position: transformed),
    );
  }
}

/// The panel: background, shadow, radius, outline, enter animation.
class _DropdownPanel extends StatefulWidget {
  const _DropdownPanel({
    required this.header,
    required this.content,
    required this.footer,
    required this.style,
    required this.hideBlockBorder,
    required this.interior,
    required this.ariaRole,
    required this.ariaLabel,
    required this.contentScrolls,
    required this.up,
  });

  final Widget? header;
  final Widget? content;
  final Widget? footer;
  final CsDropdownStyle? style;
  final bool hideBlockBorder;
  final bool interior;
  final String? ariaRole;
  final String? ariaLabel;
  final bool contentScrolls;
  final bool up;

  @override
  State<_DropdownPanel> createState() => _DropdownPanelState();
}

class _DropdownPanelState extends State<_DropdownPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final d = CsTheme.tokensOf(context).motionDurationShowQuick;
    // Fade (one duration) then the 4px slide returns (second duration).
    _controller.duration = d * 2;
    if (_controller.status == AnimationStatus.dismissed) {
      if (d == Duration.zero) {
        _controller.value = 1;
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    final style = widget.style;
    final radius = style?.borderRadius ?? t.borderRadiusDropdown;
    final outlineWidth = style?.borderWidth ?? t.borderWidthPopover;
    final outlineColor =
        style?.borderColor ?? t.colorBorderDropdownContainer.toColor();
    final ease = t.motionEasingShowQuick.toCurve();
    final empty = widget.header == null && widget.content == null;

    Widget? content = widget.content;
    if (content != null && widget.contentScrolls) {
      content = SingleChildScrollView(child: content);
    }
    Widget body = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ?widget.header,
        if (content != null) Flexible(child: content),
        ?widget.footer,
      ],
    );
    final showTop = !widget.hideBlockBorder && !widget.up;
    final showBottom = !widget.hideBlockBorder && widget.up;
    body = DecoratedBox(
      decoration: BoxDecoration(
        color:
            style?.background ?? t.colorBackgroundDropdownItemDefault.toColor(),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: (widget.up ? t.shadowDropup : t.shadowDropdown)
            .toBoxShadows(),
        border: Border(
          top: showTop
              ? BorderSide(
                  width: t.borderDividerListWidth,
                  color: t.colorBorderContainerTop.toColor(),
                )
              : BorderSide.none,
          bottom: showBottom
              ? BorderSide(
                  width: t.borderDividerListWidth,
                  color: t.colorBorderDropdownGroup.toColor(),
                )
              : BorderSide.none,
        ),
      ),
      child: DefaultTextStyle(style: CsTypography(t).reset, child: body),
    );
    if (!empty) {
      body = CustomPaint(
        foregroundPainter: _OutlinePainter(
          width: outlineWidth,
          color: outlineColor,
          radius: radius,
        ),
        child: body,
      );
    }
    final role = switch (widget.ariaRole) {
      'dialog' => SemanticsRole.dialog,
      'alertdialog' => SemanticsRole.alertDialog,
      'tooltip' => SemanticsRole.tooltip,
      'form' => SemanticsRole.form,
      _ => null,
    };
    body = Semantics(
      container: true,
      label: widget.ariaLabel,
      role: role,
      explicitChildNodes: true,
      child: body,
    );
    final slide = widget.interior ? 0.0 : (widget.up ? -4.0 : 4.0);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final v = _controller.value;
        final fade = ease.transform((v * 2).clamp(0, 1));
        final offset = v <= 0.5
            ? Curves.ease.transform(v * 2) * slide
            : (1 - Curves.ease.transform((v - 0.5) * 2)) * slide;
        return Opacity(
          opacity: fade,
          child: Transform.translate(offset: Offset(0, offset), child: child),
        );
      },
      child: body,
    );
  }
}

/// The `::after` outline: all sides, extending 1px above and below.
class _OutlinePainter extends CustomPainter {
  _OutlinePainter({
    required this.width,
    required this.color,
    required this.radius,
  });

  final double width;
  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final outer = RRect.fromRectAndRadius(
      Rect.fromLTRB(0, -1, size.width, size.height + 1),
      Radius.circular(radius),
    );
    final inner = outer.deflate(width);
    canvas.drawDRRect(outer, inner, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_OutlinePainter old) =>
      old.width != width || old.color != color || old.radius != radius;
}
