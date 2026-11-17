// Vector icon data generated from upstream Cloudscape SVGs. Pure data.

/// Shape element kinds.
enum CsIconShapeKind {
  /// Geometry: encoded path ops (see [CsIconPathOp]).
  path,

  /// Geometry: cx, cy, r.
  circle,

  /// Geometry: cx, cy, rx, ry.
  ellipse,

  /// Geometry: x, y, width, height, rx, ry.
  rect,
}

/// Op codes in [CsIconShapeKind.path] geometry.
abstract final class CsIconPathOp {
  /// x y.
  static const int move = 0;

  /// x y.
  static const int line = 1;

  /// x1 y1 x2 y2 x y.
  static const int cubic = 2;

  /// x1 y1 x y.
  static const int quad = 3;

  /// rx ry rotation largeArc sweep x y.
  static const int arc = 4;

  /// No operands.
  static const int close = 5;
}

/// A node of an icon's element tree.
sealed class CsIconNode {
  const CsIconNode({this.classes = const [], this.clip});

  /// Upstream SVG classes (`filled`, `no-stroke`, `stroke-linejoin-round`,
  /// `stroke-linecap-round`, `stroke-linecap-square`, `awsui-icon-*` part
  /// names).
  final List<String> classes;

  /// Clip rect `[left, top, right, bottom]` in the node's user space.
  final List<double>? clip;
}

/// One SVG shape.
final class CsIconShape extends CsIconNode {
  /// Creates a shape.
  const CsIconShape(
    this.kind,
    this.geometry, {
    super.classes,
    super.clip,
    this.pathLength,
    this.dashArray,
    this.dashOffset,
  });

  /// The element kind.
  final CsIconShapeKind kind;

  /// Kind-specific geometry.
  final List<double> geometry;

  /// SVG `pathLength`: dash values are relative to this length.
  final double? pathLength;

  /// SVG `stroke-dasharray`.
  final List<double>? dashArray;

  /// SVG `stroke-dashoffset`.
  final double? dashOffset;
}

/// A `<g>` or nested `<svg>` viewport.
final class CsIconGroup extends CsIconNode {
  /// Creates a group.
  const CsIconGroup({
    super.classes,
    super.clip,
    this.transform,
    required this.children,
  });

  /// `[scaleX, scaleY, translateX, translateY]` applied to [children].
  final List<double>? transform;

  /// Child nodes.
  final List<CsIconNode> children;
}

/// One icon: a view box and its elements.
final class CsIconData {
  /// Creates icon data.
  const CsIconData({required this.viewBox, required this.children});

  /// `[minX, minY, width, height]`.
  final List<double> viewBox;

  /// Top-level elements in paint order.
  final List<CsIconNode> children;
}
