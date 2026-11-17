import 'dart:math' as math;

import 'package:cloudscape_flutter/src/icon/icon_data.dart';
import 'package:flutter/widgets.dart';

final Expando<Path> _pathCache = Expando('CsIconShape.path');

Path _shapePath(CsIconShape s) => _pathCache[s] ??= _buildPath(s);

Path _buildPath(CsIconShape s) {
  final g = s.geometry;
  switch (s.kind) {
    case CsIconShapeKind.circle:
      return Path()
        ..addOval(Rect.fromCircle(center: Offset(g[0], g[1]), radius: g[2]));
    case CsIconShapeKind.ellipse:
      return Path()..addOval(
        Rect.fromCenter(
          center: Offset(g[0], g[1]),
          width: g[2] * 2,
          height: g[3] * 2,
        ),
      );
    case CsIconShapeKind.rect:
      final r = Rect.fromLTWH(g[0], g[1], g[2], g[3]);
      if (g[4] == 0 && g[5] == 0) return Path()..addRect(r);
      return Path()..addRRect(RRect.fromRectXY(r, g[4], g[5]));
    case CsIconShapeKind.path:
      final p = Path();
      var i = 0;
      while (i < g.length) {
        switch (g[i].toInt()) {
          case CsIconPathOp.move:
            p.moveTo(g[i + 1], g[i + 2]);
            i += 3;
          case CsIconPathOp.line:
            p.lineTo(g[i + 1], g[i + 2]);
            i += 3;
          case CsIconPathOp.cubic:
            p.cubicTo(
              g[i + 1],
              g[i + 2],
              g[i + 3],
              g[i + 4],
              g[i + 5],
              g[i + 6],
            );
            i += 7;
          case CsIconPathOp.quad:
            p.quadraticBezierTo(g[i + 1], g[i + 2], g[i + 3], g[i + 4]);
            i += 5;
          case CsIconPathOp.arc:
            p.arcToPoint(
              Offset(g[i + 6], g[i + 7]),
              radius: Radius.elliptical(g[i + 1], g[i + 2]),
              rotation: g[i + 3],
              largeArc: g[i + 4] != 0,
              clockwise: g[i + 5] != 0,
            );
            i += 8;
          case CsIconPathOp.close:
            p.close();
            i += 1;
          default:
            throw StateError('Bad icon path op ${g[i]}');
        }
      }
      return p;
  }
}

/// SVG dashing: [array] and [offset] are in units of [pathLength] (or the
/// real length when null).
@visibleForTesting
Path csIconDashPath(
  Path source,
  List<double> array,
  double offset,
  double? pathLength,
) {
  final pattern = array.length.isOdd ? [...array, ...array] : array;
  final total = pattern.fold<double>(0, (a, b) => a + b);
  if (total <= 0) return source;
  final out = Path();
  for (final metric in source.computeMetrics()) {
    final scale = pathLength == null || pathLength == 0
        ? 1.0
        : metric.length / pathLength;
    final dashes = [for (final d in pattern) d * scale];
    final period = total * scale;
    // Start position within the pattern.
    var phase = (offset * scale) % period;
    if (phase < 0) phase += period;
    var index = 0;
    while (phase >= dashes[index]) {
      phase -= dashes[index];
      index = (index + 1) % dashes.length;
    }
    var distance = 0.0;
    var remaining = dashes[index] - phase;
    while (distance < metric.length) {
      final end = math.min(metric.length, distance + remaining);
      if (index.isEven) {
        out.addPath(metric.extractPath(distance, end), Offset.zero);
      }
      distance = end;
      index = (index + 1) % dashes.length;
      remaining = dashes[index];
    }
  }
  return out;
}

/// Paints [CsIconData] like upstream's icon CSS: every element is stroked
/// with the current color at [strokeWidth] rendered pixels (unless
/// `no-stroke`), `filled` elements are also filled, and line joins/caps
/// follow the element classes (default miter/butt).
class CsIconPainter extends CustomPainter {
  /// Creates a painter.
  CsIconPainter({
    required this.data,
    required this.color,
    required this.strokeWidth,
  });

  /// The artwork.
  final CsIconData data;

  /// The current color.
  final Color color;

  /// Stroke width in logical pixels at the rendered size.
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final vb = data.viewBox;
    final scale = math.min(size.width / vb[2], size.height / vb[3]);
    canvas.save();
    canvas.translate(
      (size.width - vb[2] * scale) / 2,
      (size.height - vb[3] * scale) / 2,
    );
    canvas.scale(scale);
    canvas.translate(-vb[0], -vb[1]);
    _paintNodes(canvas, data.children, strokeWidth / scale);
    canvas.restore();
  }

  void _paintNodes(Canvas canvas, List<CsIconNode> nodes, double userStroke) {
    for (final node in nodes) {
      canvas.save();
      final clip = node.clip;
      if (clip != null) {
        canvas.clipRect(Rect.fromLTRB(clip[0], clip[1], clip[2], clip[3]));
      }
      switch (node) {
        case CsIconGroup(:final transform, :final children):
          if (transform != null) {
            canvas.translate(transform[2], transform[3]);
            canvas.scale(transform[0], transform[1]);
          }
          // CSS stroke-width is in each element's user units, so nested
          // viewports scale strokes along with geometry.
          _paintNodes(canvas, children, userStroke);
        case final CsIconShape shape:
          _paintShape(canvas, shape, userStroke);
      }
      canvas.restore();
    }
  }

  void _paintShape(Canvas canvas, CsIconShape shape, double userStroke) {
    final classes = shape.classes;
    var path = _shapePath(shape);
    if (classes.contains('filled')) {
      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
      );
    }
    if (classes.contains('no-stroke')) return;
    final dash = shape.dashArray;
    if (dash != null && dash.isNotEmpty && dash.any((d) => d > 0)) {
      path = csIconDashPath(
        path,
        dash,
        shape.dashOffset ?? 0,
        shape.pathLength,
      );
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = userStroke
        ..strokeMiterLimit = 4
        ..strokeJoin = classes.contains('stroke-linejoin-round')
            ? StrokeJoin.round
            : StrokeJoin.miter
        ..strokeCap = classes.contains('stroke-linecap-round')
            ? StrokeCap.round
            : classes.contains('stroke-linecap-square')
            ? StrokeCap.square
            : StrokeCap.butt,
    );
  }

  @override
  bool shouldRepaint(CsIconPainter old) =>
      !identical(old.data, data) ||
      old.color != color ||
      old.strokeWidth != strokeWidth;
}
