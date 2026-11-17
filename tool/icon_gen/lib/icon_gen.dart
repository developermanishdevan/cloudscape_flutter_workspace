/// Generates cloudscape_flutter icon data from upstream Cloudscape icons.
library;

import 'dart:io';

import 'package:icon_gen/src/js_parse.dart';
import 'package:icon_gen/src/svg_path.dart';

export 'package:icon_gen/src/js_parse.dart';
export 'package:icon_gen/src/svg_path.dart';

const iconsFile = 'tool/upstream/icons/icons.js';
const iconStylesFile = 'tool/upstream/icons/styles.scoped.css';
const iconInternalFile = 'tool/upstream/icons/internal.js';
const lockFile = 'tool/upstream/upstream.json';
const outputFile =
    'packages/cloudscape_flutter/lib/src/icon/generated/icons.g.dart';

/// Finds the workspace root (the pubspec.yaml with a `workspace:` key).
Directory findWorkspaceRoot() {
  var dir = Directory.current.absolute;
  while (true) {
    final pubspec = File('${dir.path}/pubspec.yaml');
    if (pubspec.existsSync() &&
        RegExp(
          r'^workspace:',
          multiLine: true,
        ).hasMatch(pubspec.readAsStringSync())) {
      return dir;
    }
    if (dir.parent.path == dir.path) {
      throw StateError('No workspace root found');
    }
    dir = dir.parent;
  }
}

/// The parsed icon set.
class IconSet {
  IconSet(this.icons, this.genAiSmall, this.rtlMirrored);

  /// Icon name → root svg element.
  final Map<String, JsElement> icons;

  /// The small/x-small `gen-ai` glyph from `icon/internal.js`.
  final JsElement genAiSmall;

  /// Icons mirrored in RTL (from `icon/styles.scoped.css`).
  final List<String> rtlMirrored;
}

/// Reads the vendored upstream files.
IconSet loadIconSet(Directory root) {
  String read(String p) => File('${root.path}/$p').readAsStringSync();
  final icons = parseIconsModule(read(iconsFile));
  final internal = read(iconInternalFile);
  final genAiAt = internal.indexOf("name === 'gen-ai'");
  if (genAiAt < 0) {
    throw const FormatException(
      'gen-ai special case not found in icon/internal.js',
    );
  }
  final genAi = parseElementAt(internal, genAiAt);
  final css = read(iconStylesFile);
  final rtl = RegExp(r':is\(([^)]*)\)[^{]*\{[^}]*transform:\s*scaleX\(-1\)')
      .firstMatch(css);
  if (rtl == null) {
    throw const FormatException('RTL mirror rule not found in icon CSS');
  }
  final mirrored = [
    for (final m in RegExp(r'name-([a-z0-9-]+)').allMatches(rtl[1]!)) m[1]!,
  ];
  for (final n in mirrored) {
    if (!icons.containsKey(n)) {
      throw FormatException('RTL list names unknown icon $n');
    }
  }
  return IconSet(icons, genAi, mirrored);
}

String _num(num v) {
  final d = (v * 1e6).round() / 1e6;
  return d.toString();
}

String _list(Iterable<num> v) => '<double>[${v.map(_num).join(', ')}]';

String _str(String s) =>
    "'${s.replaceAll(r'\', r'\\').replaceAll("'", r"\'").replaceAll(r'$', r'\$')}'";

List<double> _viewBox(Object? v) {
  final parts = '$v'.trim().split(RegExp(r'[\s,]+')).map(double.parse).toList();
  if (parts.length != 4) throw FormatException('Bad viewBox "$v"');
  return parts;
}

double _attr(Map<String, Object?> props, String key, [double? fallback]) {
  final v = props[key];
  if (v == null) {
    if (fallback != null) return fallback;
    throw FormatException('Missing attribute $key in $props');
  }
  return double.parse('$v');
}

/// CSS `clip-path: inset(t r b l) view-box` → clip rect [l, t, r, b] in user
/// space of [viewBox].
List<double> _clip(String css, List<double> viewBox) {
  final m = RegExp(r'^inset\(([^)]*)\)\s*(view-box)?$').firstMatch(css.trim());
  if (m == null || m[2] == null) {
    throw FormatException('Unsupported clip-path "$css"');
  }
  final v = m[1]!.trim().split(RegExp(r'\s+'));
  final sides = switch (v.length) {
    1 => [v[0], v[0], v[0], v[0]],
    2 => [v[0], v[1], v[0], v[1]],
    3 => [v[0], v[1], v[2], v[1]],
    4 => v,
    _ => throw FormatException('Bad inset "$css"'),
  };
  double len(String s, double ref) => s.endsWith('%')
      ? double.parse(s.substring(0, s.length - 1)) / 100 * ref
      : s == '0'
      ? 0
      : s.endsWith('px')
      ? double.parse(s.substring(0, s.length - 2))
      : throw FormatException('Bad inset length "$s"');
  final [vx, vy, vw, vh] = viewBox;
  final top = len(sides[0], vh),
      right = len(sides[1], vw),
      bottom = len(sides[2], vh),
      left = len(sides[3], vw);
  return [vx + left, vy + top, vx + vw - right, vy + vh - bottom];
}

const _rootProps = {
  'viewBox',
  'xmlns',
  'focusable',
  'aria-hidden',
  'data-awsui-icon-animated',
  'width',
  'height',
  'data-testid',
};
const _common = {
  'className',
  'pathLength',
  'strokeDasharray',
  'strokeDashoffset',
  'clipPath',
};
const _shapeProps = {
  'path': {'d'},
  'circle': {'cx', 'cy', 'r'},
  'ellipse': {'cx', 'cy', 'rx', 'ry'},
  'rect': {'x', 'y', 'width', 'height', 'rx', 'ry'},
  'g': <String>{},
  'svg': {'x', 'y', 'width', 'height', 'viewBox', 'overflow'},
};
const _knownClasses = {
  'stroke-linejoin-round',
  'stroke-linecap-square',
  'stroke-linecap-round',
  'filled',
  'no-stroke',
};

String _node(JsElement e, List<double> viewBox, String indent) {
  final allowed = _shapeProps[e.tag];
  if (allowed == null) throw FormatException('Unsupported element <${e.tag}>');
  for (final k in e.props.keys) {
    if (!allowed.contains(k) && !_common.contains(k)) {
      throw FormatException('Unsupported attribute $k on <${e.tag}>');
    }
  }
  final classes = '${e.props['className'] ?? ''}'
      .split(' ')
      .where((c) => c.isNotEmpty)
      .toList();
  for (final c in classes) {
    if (!_knownClasses.contains(c) && !c.startsWith('awsui-icon-')) {
      throw FormatException('Unknown icon class $c');
    }
  }
  final named = <String>[
    if (classes.isNotEmpty)
      'classes: <String>[${classes.map(_str).join(', ')}]',
    if (e.props['pathLength'] != null)
      'pathLength: ${_num(_attr(e.props, 'pathLength'))}',
    if (e.props['strokeDasharray'] != null)
      'dashArray: ${_list('${e.props['strokeDasharray']}'.trim().split(RegExp(r'[\s,]+')).map(double.parse))}',
    if (e.props['strokeDashoffset'] != null)
      'dashOffset: ${_num(_attr(e.props, 'strokeDashoffset'))}',
    if (e.props['clipPath'] != null)
      'clip: ${_list(_clip('${e.props['clipPath']}', viewBox))}',
  ];
  String shape(String kind, List<double> geometry) {
    if (e.children.isNotEmpty) {
      throw FormatException('<${e.tag}> with children');
    }
    return '${indent}CsIconShape(CsIconShapeKind.$kind, ${_list(geometry)}${named.map((n) => ', $n').join()}),';
  }

  switch (e.tag) {
    case 'path':
      return shape('path', parseSvgPath('${e.props['d']}'));
    case 'circle':
      return shape('circle', [
        _attr(e.props, 'cx', 0),
        _attr(e.props, 'cy', 0),
        _attr(e.props, 'r'),
      ]);
    case 'ellipse':
      return shape('ellipse', [
        _attr(e.props, 'cx', 0),
        _attr(e.props, 'cy', 0),
        _attr(e.props, 'rx'),
        _attr(e.props, 'ry'),
      ]);
    case 'rect':
      final w = _attr(e.props, 'width'), h = _attr(e.props, 'height');
      var rx = e.props['rx'] == null ? null : _attr(e.props, 'rx');
      var ry = e.props['ry'] == null ? null : _attr(e.props, 'ry');
      rx ??= ry ?? 0;
      ry ??= rx;
      return shape('rect', [
        _attr(e.props, 'x', 0),
        _attr(e.props, 'y', 0),
        w,
        h,
        rx.clamp(0, w / 2),
        ry.clamp(0, h / 2),
      ]);
    case 'g':
      return '${indent}CsIconGroup(${named.map((n) => '$n, ').join()}children: [\n'
          '${e.children.map((c) => _node(c, viewBox, '$indent  ')).join('\n')}\n$indent]),';
    case 'svg':
      // Nested viewport: map its viewBox into (x, y, width, height) with the
      // default preserveAspectRatio (xMidYMid meet); clip if overflow hidden.
      final x = _attr(e.props, 'x', 0), y = _attr(e.props, 'y', 0);
      final w = _attr(e.props, 'width'), h = _attr(e.props, 'height');
      final vb = _viewBox(e.props['viewBox']);
      final s = (w / vb[2]) < (h / vb[3]) ? w / vb[2] : h / vb[3];
      final tx = x + (w - vb[2] * s) / 2 - vb[0] * s;
      final ty = y + (h - vb[3] * s) / 2 - vb[1] * s;
      final overflow = e.props['overflow'];
      if (overflow != null && overflow != 'hidden' && overflow != 'visible') {
        throw FormatException('Unsupported overflow "$overflow"');
      }
      final nestedNamed = [
        ...named,
        if (overflow != 'visible') 'clip: ${_list([x, y, x + w, y + h])}',
        'transform: ${_list([s, s, tx, ty])}',
      ];
      return '${indent}CsIconGroup(${nestedNamed.map((n) => '$n, ').join()}children: [\n'
          '${e.children.map((c) => _node(c, vb, '$indent  ')).join('\n')}\n$indent]),';
  }
  throw StateError('unreachable');
}

String _icon(JsElement svg, String indent) {
  if (svg.tag != 'svg') throw FormatException('Icon root is <${svg.tag}>');
  for (final k in svg.props.keys) {
    if (!_rootProps.contains(k)) {
      throw FormatException('Unsupported root attribute $k');
    }
  }
  final vb = _viewBox(svg.props['viewBox']);
  return 'CsIconData(\n$indent  viewBox: ${_list(vb)},\n$indent  children: [\n'
      '${svg.children.map((c) => _node(c, vb, '$indent    ')).join('\n')}\n$indent  ],\n$indent)';
}

String _camel(String kebab) {
  final parts = kebab.split('-');
  return parts.first +
      parts
          .skip(1)
          .map((p) => p.isEmpty ? '' : '${p[0].toUpperCase()}${p.substring(1)}')
          .join();
}

const _reservedEnumNames = {
  'index',
  'name',
  'values',
  'hashCode',
  'runtimeType',
  'toString',
  'noSuchMethod',
  'id',
};

/// Emits the generated Dart library.
String emit(IconSet set, String upstreamVersion) {
  final b = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND.')
    ..writeln('//')
    ..writeln(
      '// Source: @cloudscape-design/components $upstreamVersion (icon/generated/icons.js,',
    )
    ..writeln('// icon/internal.js, icon/styles.scoped.css).')
    ..writeln('// Regenerate with: dart run melos run icons:generate')
    ..writeln('//')
    ..writeln(
      '// Cloudscape is Copyright Amazon.com, Inc. or its affiliates, Apache-2.0.',
    )
    ..writeln()
    ..writeln("import 'package:cloudscape_flutter/src/icon/icon_data.dart';")
    ..writeln()
    ..writeln('/// Every built-in Cloudscape icon.')
    ..writeln('enum CsIconName {');
  for (final name in set.icons.keys) {
    final id = _camel(name);
    if (_reservedEnumNames.contains(id)) {
      throw StateError('Icon name $name collides with an enum member');
    }
    b
      ..writeln('  /// Upstream `$name`.')
      ..writeln('  $id(${_str(name)}),');
  }
  b
    ..writeln('  ;')
    ..writeln()
    ..writeln('  const CsIconName(this.id);')
    ..writeln()
    ..writeln('  /// The upstream icon name.')
    ..writeln('  final String id;')
    ..writeln()
    ..writeln('  /// Looks up a built-in icon by upstream name.')
    ..writeln('  static CsIconName? byId(String id) => _byId[id];')
    ..writeln()
    ..writeln(
      '  static final Map<String, CsIconName> _byId = {for (final n in values) n.id: n};',
    )
    ..writeln('}')
    ..writeln()
    ..writeln('/// Built-in icon artwork keyed by upstream name.')
    ..writeln('const Map<String, CsIconData> csBuiltInIcons = {');
  for (final e in set.icons.entries) {
    b.writeln('  ${_str(e.key)}: ${_icon(e.value, '  ')},');
  }
  b
    ..writeln('};')
    ..writeln()
    ..writeln('/// The `gen-ai` glyph used at `small` and `x-small` sizes.')
    ..writeln(
      'const CsIconData csGenAiSmallIcon = ${_icon(set.genAiSmall, '')};',
    )
    ..writeln()
    ..writeln('/// Icons that are mirrored in right-to-left layouts.')
    ..writeln('const Set<String> csRtlMirroredIcons = {')
    ..writeAll(set.rtlMirrored.map((n) => '  ${_str(n)},\n'))
    ..writeln('};');
  return b.toString();
}

/// Writes [source] to [file] and formats it with the SDK formatter.
Future<void> writeFormatted(File file, String source) async {
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(source);
  final r = await Process.run(Platform.resolvedExecutable, [
    'format',
    file.path,
  ]);
  if (r.exitCode != 0) {
    throw StateError('dart format failed: ${r.stdout}${r.stderr}');
  }
}
