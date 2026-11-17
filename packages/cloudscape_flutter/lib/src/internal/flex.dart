// A CSS-flexbox-like layout: column, or row with optional wrap, with gaps,
// `align-items` (stretch/start/center/end) and block-level width (fills the
// available width when bounded, like a CSS block box).
import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// CSS `align-items`.
enum CsFlexAlign {
  /// Stretch across the cross axis (CSS default).
  stretch,

  /// Cross-axis start (inline start for columns; top for rows).
  start,

  /// Centered.
  center,

  /// Cross-axis end.
  end,
}

/// A CSS flex container (`display: flex`), block-level.
class CsFlex extends MultiChildRenderObjectWidget {
  /// Creates a flex container.
  const CsFlex({
    super.key,
    required this.direction,
    this.wrap = false,
    this.mainGap = 0,
    this.crossGap = 0,
    this.alignItems = CsFlexAlign.stretch,
    this.block = true,
    super.children,
  });

  /// `flex-direction`: vertical = column, horizontal = row.
  final Axis direction;

  /// `flex-wrap: wrap` (rows only).
  final bool wrap;

  /// Gap between items along the main axis.
  final double mainGap;

  /// Gap between wrapped lines.
  final double crossGap;

  /// `align-items`.
  final CsFlexAlign alignItems;

  /// Fill the available width when bounded (`display: flex` vs
  /// `inline-flex`).
  final bool block;

  @override
  RenderCsFlex createRenderObject(BuildContext context) => RenderCsFlex(
    direction: direction,
    wrap: wrap,
    mainGap: mainGap,
    crossGap: crossGap,
    alignItems: alignItems,
    block: block,
    textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
  );

  @override
  void updateRenderObject(BuildContext context, RenderCsFlex renderObject) {
    renderObject
      ..direction = direction
      ..wrap = wrap
      ..mainGap = mainGap
      ..crossGap = crossGap
      ..alignItems = alignItems
      ..block = block
      ..textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
  }
}

/// Parent data for [RenderCsFlex].
class CsFlexParentData extends ContainerBoxParentData<RenderBox> {}

/// Render object for [CsFlex].
class RenderCsFlex extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CsFlexParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CsFlexParentData> {
  /// Creates the render object.
  RenderCsFlex({
    required this._direction,
    required this._wrap,
    required this._mainGap,
    required this._crossGap,
    required this._alignItems,
    required this._block,
    required this._textDirection,
  });

  Axis _direction;
  set direction(Axis v) => _set(_direction != v, () => _direction = v);
  bool _wrap;
  set wrap(bool v) => _set(_wrap != v, () => _wrap = v);
  double _mainGap;
  set mainGap(double v) => _set(_mainGap != v, () => _mainGap = v);
  double _crossGap;
  set crossGap(double v) => _set(_crossGap != v, () => _crossGap = v);
  CsFlexAlign _alignItems;
  set alignItems(CsFlexAlign v) =>
      _set(_alignItems != v, () => _alignItems = v);
  bool _block;
  set block(bool v) => _set(_block != v, () => _block = v);
  TextDirection _textDirection;
  set textDirection(TextDirection v) =>
      _set(_textDirection != v, () => _textDirection = v);

  void _set(bool changed, VoidCallback apply) {
    if (!changed) return;
    apply();
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! CsFlexParentData) {
      child.parentData = CsFlexParentData();
    }
  }

  List<RenderBox> get _children {
    final out = <RenderBox>[];
    var c = firstChild;
    while (c != null) {
      out.add(c);
      c = childAfter(c);
    }
    return out;
  }

  double _gaps(int n, double gap) => n <= 1 ? 0 : gap * (n - 1);

  @override
  double computeMinIntrinsicWidth(double height) {
    final c = _children;
    if (_direction == Axis.vertical || _wrap) {
      return c.fold(
        0.0,
        (m, x) => math.max(m, x.getMinIntrinsicWidth(double.infinity)),
      );
    }
    return c.fold(0.0, (s, x) => s + x.getMinIntrinsicWidth(double.infinity)) +
        _gaps(c.length, _mainGap);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final c = _children;
    if (_direction == Axis.vertical) {
      return c.fold(
        0.0,
        (m, x) => math.max(m, x.getMaxIntrinsicWidth(double.infinity)),
      );
    }
    return c.fold(0.0, (s, x) => s + x.getMaxIntrinsicWidth(double.infinity)) +
        _gaps(c.length, _mainGap);
  }

  @override
  double computeMinIntrinsicHeight(double width) => _intrinsicHeight(width);

  @override
  double computeMaxIntrinsicHeight(double width) => _intrinsicHeight(width);

  double _intrinsicHeight(double width) {
    final c = _children;
    if (_direction == Axis.vertical) {
      return c.fold(0.0, (s, x) => s + x.getMaxIntrinsicHeight(width)) +
          _gaps(c.length, _mainGap);
    }
    return c.fold(
      0.0,
      (m, x) => math.max(m, x.getMaxIntrinsicHeight(double.infinity)),
    );
  }

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) =>
      _layout(constraints, dry: true);

  @override
  void performLayout() {
    size = _layout(constraints, dry: false);
  }

  Size _layout(BoxConstraints constraints, {required bool dry}) {
    final children = _children;
    final boundedWidth = constraints.hasBoundedWidth;
    Size measure(RenderBox child, BoxConstraints c) => dry
        ? child.getDryLayout(c)
        : (child..layout(c, parentUsesSize: true)).size;
    void place(RenderBox child, Offset offset) {
      if (!dry) (child.parentData! as CsFlexParentData).offset = offset;
    }

    final rtl = _textDirection == TextDirection.rtl;
    if (_direction == Axis.vertical) {
      final stretchWidth = _alignItems == CsFlexAlign.stretch && boundedWidth
          ? constraints.maxWidth
          : null;
      final sizes = [
        for (final child in children)
          measure(
            child,
            stretchWidth != null
                ? BoxConstraints.tightFor(width: stretchWidth)
                : BoxConstraints(maxWidth: constraints.maxWidth),
          ),
      ];
      final contentWidth = sizes.fold(0.0, (m, s) => math.max(m, s.width));
      final width = _block && boundedWidth
          ? constraints.maxWidth
          : contentWidth;
      var y = 0.0;
      for (var i = 0; i < children.length; i++) {
        final free = width - sizes[i].width;
        final fromStart = switch (_alignItems) {
          CsFlexAlign.center => free / 2,
          CsFlexAlign.end => free,
          _ => 0.0,
        };
        place(
          children[i],
          Offset(rtl ? width - sizes[i].width - fromStart : fromStart, y),
        );
        y += sizes[i].height + (i < children.length - 1 ? _mainGap : 0);
      }
      return constraints.constrain(Size(width, y));
    }

    // Row (optionally wrapping).
    final loose = BoxConstraints(maxWidth: constraints.maxWidth);
    final sizes = [for (final child in children) measure(child, loose)];
    final available = boundedWidth ? constraints.maxWidth : double.infinity;
    final runs = <List<int>>[];
    var current = <int>[];
    var runWidth = 0.0;
    for (var i = 0; i < children.length; i++) {
      final extra = current.isEmpty
          ? sizes[i].width
          : runWidth + _mainGap + sizes[i].width;
      if (_wrap && current.isNotEmpty && extra > available + 1e-9) {
        runs.add(current);
        current = [i];
        runWidth = sizes[i].width;
      } else {
        current.add(i);
        runWidth = extra;
      }
    }
    if (current.isNotEmpty) runs.add(current);
    final runWidths = [
      for (final r in runs)
        r.fold(0.0, (s, i) => s + sizes[i].width) + _gaps(r.length, _mainGap),
    ];
    final contentWidth = runWidths.fold(0.0, math.max);
    final width = _block && boundedWidth ? constraints.maxWidth : contentWidth;
    var y = 0.0;
    for (var r = 0; r < runs.length; r++) {
      final runHeight = runs[r].fold(
        0.0,
        (m, i) => math.max(m, sizes[i].height),
      );
      var x = 0.0;
      for (final i in runs[r]) {
        var s = sizes[i];
        if (_alignItems == CsFlexAlign.stretch && s.height != runHeight) {
          s = sizes[i] = measure(
            children[i],
            BoxConstraints.tightFor(width: s.width, height: runHeight),
          );
        }
        final free = runHeight - s.height;
        final dy = switch (_alignItems) {
          CsFlexAlign.center => free / 2,
          CsFlexAlign.end => free,
          _ => 0.0,
        };
        place(children[i], Offset(rtl ? width - x - s.width : x, y + dy));
        x += s.width + _mainGap;
      }
      y += runHeight + (r < runs.length - 1 ? _crossGap : 0);
    }
    return constraints.constrain(Size(width, y));
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  @override
  void paint(PaintingContext context, Offset offset) =>
      defaultPaint(context, offset);
}
