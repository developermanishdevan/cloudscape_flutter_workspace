// Parses CSS token values (as used by upstream presets and applyTheme) into
// cloudscape_tokens values.
//
// Every parser throws [FormatException] on input it does not understand, so
// an upstream format change fails generation instead of being dropped.
import 'package:cloudscape_tokens/src/values.dart';

/// The kind of a parsed value, used to pick the Dart type of a token.
enum ValueKind {
  color,
  colorOther,
  px,
  length,
  number,
  numberList,
  duration,
  easing,
  shadow,
  fontFamily,
  fontWeight,
  keyword,
}

/// A parsed token value plus its kind.
class ParsedValue {
  const ParsedValue(this.kind, this.value);

  final ValueKind kind;
  final Object value;

  @override
  String toString() => '$kind:$value';
}

final _px = RegExp(r'^(-?\d*\.?\d+)(px)?$');
final _em = RegExp(r'^(-?\d*\.?\d+)em$');
final _percent = RegExp(r'^(-?\d*\.?\d+)%$');
final _number = RegExp(r'^-?\d*\.?\d+$');
final _keyword = RegExp(r'^[a-z][a-z0-9-]*$');

/// Parses the resolved [raw] value of the token called [name].
ParsedValue parseToken(String name, String raw) {
  final v = raw.trim();
  try {
    if (name.startsWith('color')) return _colorValue(v);
    if (name.startsWith('shadow')) {
      return ParsedValue(ValueKind.shadow, parseShadows(v));
    }
    if (name.startsWith('motionDuration')) {
      return ParsedValue(ValueKind.duration, parseDuration(v));
    }
    if (name.startsWith('motionEasing')) {
      return ParsedValue(ValueKind.easing, parseEasing(v));
    }
    if (name.startsWith('motionKeyframes')) {
      return ParsedValue(ValueKind.keyword, _checkKeyword(v));
    }
    if (name.startsWith('fontFamily')) {
      return ParsedValue(ValueKind.fontFamily, parseFontFamily(v));
    }
    if (name.contains('Weight')) {
      return ParsedValue(ValueKind.fontWeight, parseFontWeight(v));
    }
    return _generic(v);
  } on FormatException catch (e) {
    throw FormatException('Token $name: ${e.message}', raw);
  }
}

ParsedValue _generic(String v) {
  if (v.endsWith('px')) {
    return ParsedValue(ValueKind.px, double.parse(_px.firstMatch(v)![1]!));
  }
  if (_number.hasMatch(v)) {
    return ParsedValue(ValueKind.number, double.parse(v));
  }
  final em = _em.firstMatch(v);
  if (em != null) {
    return ParsedValue(ValueKind.length, CsEm(double.parse(em[1]!)));
  }
  final pc = _percent.firstMatch(v);
  if (pc != null) {
    return ParsedValue(ValueKind.length, CsPercent(double.parse(pc[1]!) / 100));
  }
  if (v == 'inherit') {
    return const ParsedValue(ValueKind.length, CsLengthKeyword.inherit);
  }
  if (v == 'normal') {
    return const ParsedValue(ValueKind.length, CsLengthKeyword.normal);
  }
  final parts = v.split(RegExp(r'\s+'));
  if (parts.length > 1 && parts.every(_number.hasMatch)) {
    return ParsedValue(ValueKind.numberList, [
      for (final p in parts) double.parse(p),
    ]);
  }
  return ParsedValue(ValueKind.keyword, _checkKeyword(v));
}

String _checkKeyword(String v) {
  if (!_keyword.hasMatch(v)) throw FormatException('Unrecognized value "$v"');
  return v;
}

ParsedValue _colorValue(String v) {
  if (v == 'currentColor') {
    return const ParsedValue(ValueKind.colorOther, CsCurrentColor());
  }
  if (v.startsWith('linear-gradient(')) {
    return ParsedValue(ValueKind.colorOther, parseLinearGradient(v));
  }
  if (v.startsWith('radial-gradient(')) {
    return ParsedValue(ValueKind.colorOther, parseRadialGradient(v));
  }
  return ParsedValue(ValueKind.color, parseColor(v));
}

/// Parses `#rgb`, `#rgba`, `#rrggbb`, `#rrggbbaa`, `rgb()`, `rgba()` and
/// `transparent`.
CsColor parseColor(String input) {
  final v = input.trim();
  if (v == 'transparent') return CsColor.transparent;
  if (v.startsWith('#')) {
    var hex = v.substring(1);
    if (!RegExp(r'^[0-9a-fA-F]+$').hasMatch(hex)) {
      throw FormatException('Bad hex color "$v"');
    }
    if (hex.length == 3 || hex.length == 4) {
      hex = hex.split('').map((c) => '$c$c').join();
    }
    if (hex.length == 6) hex = '${hex}ff';
    if (hex.length != 8) throw FormatException('Bad hex color "$v"');
    final rgb = int.parse(hex.substring(0, 6), radix: 16);
    final a = int.parse(hex.substring(6), radix: 16);
    return CsColor((a << 24) | rgb);
  }
  final m = RegExp(r'^rgba?\((.*)\)$').firstMatch(v);
  if (m != null) {
    final parts = m[1]!.split(',').map((s) => s.trim()).toList();
    if (parts.length != 3 && parts.length != 4) {
      throw FormatException('Bad rgb color "$v"');
    }
    int channel(String s) => s.endsWith('%')
        ? (double.parse(s.substring(0, s.length - 1)) * 2.55).round()
        : int.parse(s);
    final r = channel(parts[0]), g = channel(parts[1]), b = channel(parts[2]);
    final a = parts.length == 4 ? double.parse(parts[3]) : 1.0;
    for (final c in [r, g, b]) {
      if (c < 0 || c > 255) throw FormatException('Bad channel in "$v"');
    }
    if (a < 0 || a > 1) throw FormatException('Bad alpha in "$v"');
    return CsColor(((a * 255).round() << 24) | (r << 16) | (g << 8) | b);
  }
  throw FormatException('Unrecognized color "$v"');
}

/// Splits [s] on [sep] characters that are not inside parentheses.
List<String> splitTopLevel(String s, String sep) {
  final out = <String>[];
  var depth = 0;
  var start = 0;
  for (var i = 0; i < s.length; i++) {
    final c = s[i];
    if (c == '(') depth++;
    if (c == ')') depth--;
    if (depth < 0) throw FormatException('Unbalanced parentheses in "$s"');
    if (depth == 0 && c == sep) {
      out.add(s.substring(start, i).trim());
      start = i + 1;
    }
  }
  if (depth != 0) throw FormatException('Unbalanced parentheses in "$s"');
  out.add(s.substring(start).trim());
  return out.where((p) => p.isNotEmpty).toList();
}

List<String> _words(String s) {
  // Splits on whitespace outside parentheses.
  final out = <String>[];
  final buf = StringBuffer();
  var depth = 0;
  for (final c in s.split('')) {
    if (c == '(') depth++;
    if (c == ')') depth--;
    if (depth == 0 && RegExp(r'\s').hasMatch(c)) {
      if (buf.isNotEmpty) out.add(buf.toString());
      buf.clear();
    } else {
      buf.write(c);
    }
  }
  if (buf.isNotEmpty) out.add(buf.toString());
  return out;
}

double _pxLength(String s) {
  final m = _px.firstMatch(s);
  if (m == null) throw FormatException('Expected a px length, got "$s"');
  if (m[2] == null && double.parse(m[1]!) != 0) {
    throw FormatException('Unitless non-zero length "$s"');
  }
  return double.parse(m[1]!);
}

/// Parses a CSS `box-shadow` list. `none` is an empty list.
List<CsShadow> parseShadows(String v) {
  if (v == 'none') return const [];
  return [
    for (final layer in splitTopLevel(v, ','))
      () {
        final words = _words(layer);
        var inset = false;
        CsColor? color;
        final lengths = <double>[];
        for (final w in words) {
          if (w == 'inset') {
            inset = true;
          } else if (_px.hasMatch(w)) {
            lengths.add(_pxLength(w));
          } else {
            if (color != null) throw FormatException('Two colors in "$layer"');
            color = parseColor(w);
          }
        }
        if (color == null || lengths.length < 2 || lengths.length > 4) {
          throw FormatException('Bad shadow layer "$layer"');
        }
        return CsShadow(
          offsetX: lengths[0],
          offsetY: lengths[1],
          blur: lengths.length > 2 ? lengths[2] : 0,
          spread: lengths.length > 3 ? lengths[3] : 0,
          color: color,
          inset: inset,
        );
      }(),
  ];
}

/// Parses `Nms` or `Ns`.
Duration parseDuration(String v) {
  final m = RegExp(r'^(\d*\.?\d+)(ms|s)$').firstMatch(v);
  if (m == null) throw FormatException('Bad duration "$v"');
  final n = double.parse(m[1]!);
  final micros = (m[2] == 's' ? n * 1e6 : n * 1e3).round();
  return Duration(microseconds: micros);
}

const _easingKeywords = {
  'linear': CsCubicBezier(0, 0, 1, 1),
  'ease': CsCubicBezier(0.25, 0.1, 0.25, 1),
  'ease-in': CsCubicBezier(0.42, 0, 1, 1),
  'ease-out': CsCubicBezier(0, 0, 0.58, 1),
  'ease-in-out': CsCubicBezier(0.42, 0, 0.58, 1),
};

/// Parses `cubic-bezier(a, b, c, d)` or a CSS easing keyword.
CsCubicBezier parseEasing(String v) {
  final keyword = _easingKeywords[v];
  if (keyword != null) return keyword;
  final m = RegExp(r'^cubic-bezier\((.*)\)$').firstMatch(v);
  if (m == null) throw FormatException('Bad easing "$v"');
  final n = m[1]!.split(',').map((s) => double.parse(s.trim())).toList();
  if (n.length != 4) throw FormatException('Bad easing "$v"');
  return CsCubicBezier(n[0], n[1], n[2], n[3]);
}

/// Parses a CSS font-family list.
List<String> parseFontFamily(String v) => [
  for (final f in splitTopLevel(v, ','))
    f.replaceAll(RegExp(r'''^['"]|['"]$'''), ''),
];

/// Parses a numeric font weight or `inherit`.
CsFontWeight parseFontWeight(String v) {
  if (v == 'inherit') return CsFontWeight.inherit;
  final w = int.tryParse(v);
  if (w == null || w < 1 || w > 1000) {
    throw FormatException('Bad font weight "$v"');
  }
  return CsFontWeight(w);
}

List<CsGradientStop> _stops(List<String> parts) => [
  for (final p in parts)
    () {
      final words = _words(p);
      if (words.isEmpty || words.length > 2) {
        throw FormatException('Bad stop "$p"');
      }
      final color = parseColor(words[0]);
      if (words.length == 1) return CsGradientStop(color);
      final pc = _percent.firstMatch(words[1]);
      if (pc == null) throw FormatException('Bad stop position "$p"');
      return CsGradientStop(color, double.parse(pc[1]!) / 100);
    }(),
];

const _directionAngles = {
  'to top': 0.0,
  'to right': 90.0,
  'to bottom': 180.0,
  'to left': 270.0,
};

/// Parses `linear-gradient(<angle>, <stops>)`.
CsLinearGradient parseLinearGradient(String v) {
  final inner = RegExp(r'^linear-gradient\((.*)\)$').firstMatch(v)?[1];
  if (inner == null) throw FormatException('Bad linear-gradient "$v"');
  final parts = splitTopLevel(inner, ',');
  final first = parts.first;
  final deg = RegExp(r'^(-?\d*\.?\d+)deg$').firstMatch(first);
  if (deg != null) {
    return CsLinearGradient(
      angleDegrees: double.parse(deg[1]!),
      stops: _stops(parts.sublist(1)),
    );
  }
  final dir = _directionAngles[first];
  if (dir != null) {
    return CsLinearGradient(angleDegrees: dir, stops: _stops(parts.sublist(1)));
  }
  return CsLinearGradient(angleDegrees: 180, stops: _stops(parts));
}

const _positionX = {'left': 0.0, 'center': 0.5, 'right': 1.0};
const _positionY = {'top': 0.0, 'center': 0.5, 'bottom': 1.0};

/// Parses `radial-gradient([circle|ellipse] [extent] [at <pos>], <stops>)`.
CsRadialGradient parseRadialGradient(String v) {
  final inner = RegExp(r'^radial-gradient\((.*)\)$').firstMatch(v)?[1];
  if (inner == null) throw FormatException('Bad radial-gradient "$v"');
  final parts = splitTopLevel(inner, ',');
  final head = _words(parts.first);
  const extents = {
    'closest-side',
    'closest-corner',
    'farthest-side',
    'farthest-corner',
  };
  final isShape =
      head.isNotEmpty &&
      (head.first == 'circle' ||
          head.first == 'ellipse' ||
          extents.contains(head.first) ||
          head.first == 'at');
  if (!isShape) {
    return CsRadialGradient(
      circle: false,
      extent: 'farthest-corner',
      centerX: 0.5,
      centerY: 0.5,
      stops: _stops(parts),
    );
  }
  var circle = false;
  var extent = 'farthest-corner';
  var cx = 0.5, cy = 0.5;
  var i = 0;
  for (; i < head.length && head[i] != 'at'; i++) {
    final w = head[i];
    if (w == 'circle') {
      circle = true;
    } else if (w == 'ellipse') {
      circle = false;
    } else if (extents.contains(w)) {
      extent = w;
    } else {
      throw FormatException('Bad radial-gradient shape "${parts.first}"');
    }
  }
  if (i < head.length) {
    final pos = head.sublist(i + 1);
    if (pos.isEmpty || pos.length > 2) {
      throw FormatException('Bad position in "$v"');
    }
    for (final p in pos) {
      if (p == 'center') continue;
      if (_positionX.containsKey(p)) {
        cx = _positionX[p]!;
      } else if (_positionY.containsKey(p)) {
        cy = _positionY[p]!;
      } else {
        throw FormatException('Bad position "$p" in "$v"');
      }
    }
  }
  return CsRadialGradient(
    circle: circle,
    extent: extent,
    centerX: cx,
    centerY: cy,
    stops: _stops(parts.sublist(1)),
  );
}
