// Port of upstream `internal/components/options-list` + `hooks/use-virtual`:
// the scrolling container of option rows.
import 'dart:math' as math;

import 'package:cloudscape_flutter/src/internal/options/highlight.dart';
import 'package:cloudscape_flutter/src/internal/selectable_item.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Upstream `BOTTOM_TRIGGER_OFFSET`: load more within this many px of the end.
const double csLoadMoreOffset = 80;

/// Upstream use-virtual mounts at most 50 rows; the width sample matches it.
const int csVirtualMeasureSample = 50;

/// A scrolling list of option rows (upstream `OptionsList`).
class CsOptionsList extends StatefulWidget {
  /// Creates the list.
  const CsOptionsList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.virtualScroll = false,
    this.estimatedItemExtent = 31,
    this.firstItemSticky = false,
    this.highlightedIndex = -1,
    this.highlight = const CsHighlight(CsHighlightType.keyboard),
    this.open = true,
    this.statusPending = false,
    this.onLoadMore,
    this.onMouseMove,
    this.onMouseUp,
    this.onKeyEvent,
    this.focusNode,
    this.embedded = false,
    this.ariaLabel,
    this.decreaseBlockMargin = false,
  });

  /// Number of rows.
  final int itemCount;

  /// Builds row [index].
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// Only build visible rows.
  final bool virtualScroll;

  /// Row height estimate for unbuilt rows (virtual mode).
  final double estimatedItemExtent;

  /// Keep row 0 pinned at the top (virtual mode; e.g. "select all").
  final bool firstItemSticky;

  /// Highlighted row (-1: none); scrolled into view when
  /// [highlight].moveFocus.
  final int highlightedIndex;

  /// How the highlight was set.
  final CsHighlight highlight;

  /// Whether the containing dropdown is open (rows are built only then).
  final bool open;

  /// Upstream `statusType === 'pending'`: try to load more on open.
  final bool statusPending;

  /// Scrolled within [csLoadMoreOffset] of the end.
  final VoidCallback? onLoadMore;

  /// Pointer moved over row index.
  final ValueChanged<int>? onMouseMove;

  /// Pointer released over row index.
  final ValueChanged<int>? onMouseUp;

  /// Keys while the list has focus.
  final KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent;

  /// Focus node of the list.
  final FocusNode? focusNode;

  /// Embedded (tabbable, square corners) instead of inside a dropdown.
  final bool embedded;

  /// Accessible label.
  final String? ariaLabel;

  /// `margin-block: -1px`.
  final bool decreaseBlockMargin;

  @override
  State<CsOptionsList> createState() => CsOptionsListState();
}

/// State of [CsOptionsList]; [scrollToIndex] mirrors upstream's API.
class CsOptionsListState extends State<CsOptionsList> {
  final ScrollController _scroll = ScrollController();
  final Map<int, GlobalKey> _keys = {};
  final Map<int, double> _extents = {};
  double _stickyExtent = 0;

  GlobalKey _keyFor(int i) => _keys.putIfAbsent(i, GlobalKey.new);

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_checkLoadMore);
    if (widget.open && widget.statusPending) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkLoadMore());
    }
  }

  @override
  void didUpdateWidget(CsOptionsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.open &&
        widget.statusPending &&
        (!oldWidget.open || !oldWidget.statusPending)) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkLoadMore());
    }
    if (widget.highlightedIndex != oldWidget.highlightedIndex &&
        widget.highlightedIndex >= 0 &&
        widget.highlight.moveFocus) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => scrollToIndex(widget.highlightedIndex),
      );
    }
    if (widget.itemCount != oldWidget.itemCount) {
      _extents.removeWhere((i, _) => i >= widget.itemCount);
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _checkLoadMore() {
    if (!mounted || !_scroll.hasClients || widget.onLoadMore == null) return;
    final p = _scroll.position;
    if (p.maxScrollExtent - p.pixels < csLoadMoreOffset) widget.onLoadMore!();
  }

  /// Scrolls row [index] into view with the minimum movement
  /// (`block: nearest`), below a sticky first row.
  void scrollToIndex(int index, {@visibleForTesting int attempt = 0}) {
    if (!mounted ||
        !_scroll.hasClients ||
        index < 0 ||
        index >= widget.itemCount) {
      return;
    }
    final ctx = _keys[index]?.currentContext;
    final box = ctx?.findRenderObject();
    if (box is RenderBox && box.attached) {
      final viewport = RenderAbstractViewport.maybeOf(box);
      if (viewport == null) return;
      final top =
          viewport.getOffsetToReveal(box, 0).offset -
          (widget.firstItemSticky && index > 0 ? _stickyExtent : 0);
      final bottom = viewport.getOffsetToReveal(box, 1).offset;
      final p = _scroll.position;
      final target = p.pixels > top
          ? top
          : (p.pixels < bottom ? bottom : p.pixels);
      _scroll.jumpTo(target.clamp(p.minScrollExtent, p.maxScrollExtent));
      return;
    }
    // Not built (virtual): jump by measured extents (unmeasured rows use
    // the measured average, like a virtualizer's estimate), then refine
    // once the row is built.
    final estimate = _extents.isEmpty
        ? widget.estimatedItemExtent
        : _extents.values.reduce((a, b) => a + b) / _extents.length;
    var offset = 0.0;
    for (var i = 0; i < index; i++) {
      offset += _extents[i] ?? estimate;
    }
    if (widget.firstItemSticky) offset -= _stickyExtent;
    final p = _scroll.position;
    _scroll.jumpTo(offset.clamp(p.minScrollExtent, p.maxScrollExtent));
    if (attempt >= 3) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) scrollToIndex(index, attempt: attempt + 1);
    });
  }

  Widget _row(BuildContext context, int i) {
    Widget row = KeyedSubtree(
      key: _keyFor(i),
      child: widget.itemBuilder(context, i),
    );
    if (widget.virtualScroll) {
      row = _ExtentReporter(
        onExtent: (h) {
          _extents[i] = h;
          if (i == 0) _stickyExtent = h;
        },
        child: row,
      );
    }
    if (widget.onMouseMove != null || widget.onMouseUp != null) {
      row = MouseRegion(
        onHover: widget.onMouseMove == null
            ? null
            : (_) => widget.onMouseMove!(i),
        onEnter: widget.onMouseMove == null
            ? null
            : (_) => widget.onMouseMove!(i),
        child: Listener(
          onPointerUp: widget.onMouseUp == null
              ? null
              : (_) => widget.onMouseUp!(i),
          child: row,
        ),
      );
    }
    return row;
  }

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    Widget list;
    if (!widget.open) {
      list = const SizedBox.shrink();
    } else if (!widget.virtualScroll) {
      list = SingleChildScrollView(
        controller: _scroll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < widget.itemCount; i++) _row(context, i),
          ],
        ),
      );
    } else {
      final sticky = widget.firstItemSticky && widget.itemCount > 0;
      final scroll = CustomScrollView(
        controller: _scroll,
        shrinkWrap: true,
        slivers: [
          if (sticky) PinnedHeaderSliver(child: _row(context, 0)),
          SliverList.builder(
            itemCount: widget.itemCount - (sticky ? 1 : 0),
            itemBuilder: (context, i) => _row(context, i + (sticky ? 1 : 0)),
          ),
        ],
      );
      list = _IntrinsicFromSample(
        sample: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (
              var i = 0;
              i < math.min(widget.itemCount, csVirtualMeasureSample);
              i++
            )
              widget.itemBuilder(context, i),
          ],
        ),
        estimatedHeight: widget.itemCount * widget.estimatedItemExtent,
        child: scroll,
      );
    }
    final radius = widget.embedded ? 0.0 : t.borderRadiusDropdown;
    list = ClipRRect(borderRadius: BorderRadius.circular(radius), child: list);
    if (widget.decreaseBlockMargin) {
      list = Transform.translate(offset: const Offset(0, -1), child: list);
    }
    return Semantics(
      container: true,
      label: widget.ariaLabel,
      child: Focus(
        focusNode: widget.focusNode,
        canRequestFocus: true,
        skipTraversal: !widget.embedded, // tabIndex 0 when embedded, else -1
        onKeyEvent: widget.onKeyEvent,
        child: list,
      ),
    );
  }
}

class _ExtentReporter extends SingleChildRenderObjectWidget {
  const _ExtentReporter({required this.onExtent, required super.child});

  final ValueChanged<double> onExtent;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderExtentReporter(onExtent);

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderExtentReporter renderObject,
  ) => renderObject.onExtent = onExtent;
}

class _RenderExtentReporter extends RenderProxyBox {
  _RenderExtentReporter(this.onExtent);

  ValueChanged<double> onExtent;

  @override
  void performLayout() {
    super.performLayout();
    onExtent(size.height);
  }
}

/// Lays out and paints [child] (a lazy scroll view); answers intrinsic size
/// queries from [sample] (the first rows, never painted), so a virtual list
/// can be measured by the dropdown.
class _IntrinsicFromSample extends MultiChildRenderObjectWidget {
  _IntrinsicFromSample({
    required Widget sample,
    required this.estimatedHeight,
    required Widget child,
  }) : super(children: [child, sample]);

  final double estimatedHeight;

  @override
  MultiChildRenderObjectElement createElement() => _SampleElement(this);

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderIntrinsicFromSample(estimatedHeight);

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderIntrinsicFromSample renderObject,
  ) => renderObject.estimatedHeight = estimatedHeight;
}

/// Only the list is onstage: finders and tests never see the sample rows.
class _SampleElement extends MultiChildRenderObjectElement {
  _SampleElement(super.widget);

  @override
  void debugVisitOnstageChildren(ElementVisitor visitor) =>
      visitor(children.first);
}

class _SampleParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderIntrinsicFromSample extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _SampleParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _SampleParentData> {
  _RenderIntrinsicFromSample(this.estimatedHeight);

  double estimatedHeight;

  RenderBox get _list => firstChild!;
  RenderBox get _sample => lastChild!;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _SampleParentData) {
      child.parentData = _SampleParentData();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) =>
      _sample.getMinIntrinsicWidth(double.infinity);

  @override
  double computeMaxIntrinsicWidth(double height) =>
      _sample.getMaxIntrinsicWidth(double.infinity);

  @override
  double computeMinIntrinsicHeight(double width) => estimatedHeight;

  @override
  double computeMaxIntrinsicHeight(double width) => estimatedHeight;

  @override
  void performLayout() {
    _list.layout(constraints, parentUsesSize: true);
    size = constraints.constrain(_list.size);
    // The sample is laid out loosely (never painted) so it stays clean.
    _sample.layout(BoxConstraints(maxWidth: constraints.maxWidth));
  }

  @override
  void paint(PaintingContext context, Offset offset) =>
      context.paintChild(_list, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      _list.hitTest(result, position: position);

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) => visitor(_list);
}
