// Normalizes SVG path data to absolute move/line/cubic/quad/arc/close ops.

/// Op codes in the encoded geometry list.
abstract final class PathOp {
  static const move = 0; // x y
  static const line = 1; // x y
  static const cubic = 2; // x1 y1 x2 y2 x y
  static const quad = 3; // x1 y1 x y
  static const arc = 4; // rx ry rotation largeArc sweep x y
  static const close = 5;
}

final _number = RegExp(r'[+-]?(\d+\.?\d*|\.\d+)([eE][+-]?\d+)?');

/// Parses SVG path data into an encoded op list (see [PathOp]).
List<double> parseSvgPath(String d) {
  var i = 0;
  void skip() {
    while (i < d.length &&
        (d[i] == ' ' ||
            d[i] == ',' ||
            d[i] == '\n' ||
            d[i] == '\t' ||
            d[i] == '\r')) {
      i++;
    }
  }

  double number() {
    skip();
    final m = _number.matchAsPrefix(d, i);
    if (m == null) throw FormatException('Expected a number', d, i);
    i = m.end;
    return double.parse(m[0]!);
  }

  double flag() {
    skip();
    if (i < d.length && (d[i] == '0' || d[i] == '1')) {
      return d[i++] == '1' ? 1 : 0;
    }
    throw FormatException('Expected an arc flag', d, i);
  }

  bool hasNumber() {
    skip();
    return i < d.length && _number.matchAsPrefix(d, i) != null;
  }

  final out = <double>[];
  var x = 0.0, y = 0.0, startX = 0.0, startY = 0.0;
  double? lastCx, lastCy; // last cubic control 2
  double? lastQx, lastQy; // last quad control
  String? command;
  skip();
  while (i < d.length) {
    if (RegExp(r'[A-Za-z]').hasMatch(d[i])) {
      command = d[i++];
    } else if (command == null) {
      throw FormatException('Path must start with a command', d, i);
    }
    final c = command;
    final rel = c == c.toLowerCase() && c != 'Z' && c != 'z';
    double ax(double v) => rel ? x + v : v;
    double ay(double v) => rel ? y + v : v;
    var cubicCtrl = false, quadCtrl = false;
    switch (c.toUpperCase()) {
      case 'M':
        x = ax(number());
        y = ay(number());
        startX = x;
        startY = y;
        out.addAll([PathOp.move.toDouble(), x, y]);
        command = rel ? 'l' : 'L'; // implicit lineto for further pairs
      case 'L':
        x = ax(number());
        y = ay(number());
        out.addAll([PathOp.line.toDouble(), x, y]);
      case 'H':
        x = rel ? x + number() : number();
        out.addAll([PathOp.line.toDouble(), x, y]);
      case 'V':
        y = rel ? y + number() : number();
        out.addAll([PathOp.line.toDouble(), x, y]);
      case 'C':
        final x1 = ax(number()), y1 = ay(number());
        final x2 = ax(number()), y2 = ay(number());
        final nx = ax(number()), ny = ay(number());
        out.addAll([PathOp.cubic.toDouble(), x1, y1, x2, y2, nx, ny]);
        lastCx = x2;
        lastCy = y2;
        cubicCtrl = true;
        x = nx;
        y = ny;
      case 'S':
        final x1 = lastCx != null ? 2 * x - lastCx : x;
        final y1 = lastCy != null ? 2 * y - lastCy : y;
        final x2 = ax(number()), y2 = ay(number());
        final nx = ax(number()), ny = ay(number());
        out.addAll([PathOp.cubic.toDouble(), x1, y1, x2, y2, nx, ny]);
        lastCx = x2;
        lastCy = y2;
        cubicCtrl = true;
        x = nx;
        y = ny;
      case 'Q':
        final x1 = ax(number()), y1 = ay(number());
        final nx = ax(number()), ny = ay(number());
        out.addAll([PathOp.quad.toDouble(), x1, y1, nx, ny]);
        lastQx = x1;
        lastQy = y1;
        quadCtrl = true;
        x = nx;
        y = ny;
      case 'T':
        final x1 = lastQx != null ? 2 * x - lastQx : x;
        final y1 = lastQy != null ? 2 * y - lastQy : y;
        final nx = ax(number()), ny = ay(number());
        out.addAll([PathOp.quad.toDouble(), x1, y1, nx, ny]);
        lastQx = x1;
        lastQy = y1;
        quadCtrl = true;
        x = nx;
        y = ny;
      case 'A':
        final rx = number().abs(), ry = number().abs(), rot = number();
        final large = flag(), sweep = flag();
        final nx = ax(number()), ny = ay(number());
        if (rx == 0 || ry == 0) {
          out.addAll([PathOp.line.toDouble(), nx, ny]);
        } else {
          out.addAll([
            PathOp.arc.toDouble(),
            rx,
            ry,
            rot,
            large,
            sweep,
            nx,
            ny,
          ]);
        }
        x = nx;
        y = ny;
      case 'Z':
        out.add(PathOp.close.toDouble());
        x = startX;
        y = startY;
      default:
        throw FormatException('Unsupported path command "$c"', d, i);
    }
    if (!cubicCtrl) lastCx = lastCy = null;
    if (!quadCtrl) lastQx = lastQy = null;
    if (c.toUpperCase() == 'Z') {
      skip();
      continue;
    }
    if (!hasNumber()) {
      skip();
      if (i < d.length && !RegExp(r'[A-Za-z]').hasMatch(d[i])) {
        throw FormatException('Unexpected path data', d, i);
      }
    }
  }
  return out;
}
