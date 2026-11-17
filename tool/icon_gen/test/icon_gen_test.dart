import 'package:icon_gen/icon_gen.dart';
import 'package:test/test.dart';

void main() {
  group('parseSvgPath', () {
    test('relative, H/V and implicit lineto become absolute', () {
      expect(parseSvgPath('m1 2 3 4h1v-2Z'), [
        PathOp.move, 1, 2, //
        PathOp.line, 4, 6,
        PathOp.line, 5, 6,
        PathOp.line, 5, 4,
        PathOp.close,
      ]);
    });
    test('packed numbers', () {
      expect(parseSvgPath('M2.01 8h12M8 14l.01-12'), [
        PathOp.move, 2.01, 8, PathOp.line, 14.01, 8, //
        PathOp.move, 8, 14, PathOp.line, 8.01, 2,
      ]);
    });
    test('S reflects the previous cubic control point', () {
      final ops = parseSvgPath('M0 0C1 1 2 1 3 0s2-1 3 0');
      expect(ops.sublist(10), [PathOp.cubic, 4, -1, 5, -1, 6, 0]);
    });
    test('arcs with packed flags; zero radius becomes a line', () {
      expect(parseSvgPath('M0 0a1 1 0 01 2 0'), [
        PathOp.move,
        0,
        0,
        PathOp.arc,
        1,
        1,
        0,
        0,
        1,
        2,
        0,
      ]);
      expect(parseSvgPath('M0 0a.5.5 0 0 0 1 0'), [
        PathOp.move,
        0,
        0,
        PathOp.arc,
        .5,
        .5,
        0,
        0,
        0,
        1,
        0,
      ]);
      expect(parseSvgPath('M0 0A0 3 0 0 0 1 1'), [
        PathOp.move,
        0,
        0,
        PathOp.line,
        1,
        1,
      ]);
    });
    test('rejects garbage', () {
      expect(() => parseSvgPath('X1 2'), throwsFormatException);
      expect(() => parseSvgPath('M1'), throwsFormatException);
    });
  });

  test('parses createElement trees', () {
    final icons = parseIconsModule(
      'import React from "react";\nconst icons = {\n "a-b": React.createElement("svg", { viewBox: "0 0 16 16" },\n'
      ' React.createElement("path", { d: "M0 0", className: "filled" })),\n};\nexport default icons;',
    );
    expect(icons.keys, ['a-b']);
    expect(icons['a-b']!.children.single.props, {
      'd': 'M0 0',
      'className': 'filled',
    });
  });

  test('the vendored upstream icon set loads completely', () {
    final set = loadIconSet(findWorkspaceRoot());
    expect(set.icons.length, 148);
    expect(set.rtlMirrored, hasLength(19));
    expect(set.genAiSmall.tag, 'svg');
    // Emission validates every element, attribute and class.
    expect(() => emit(set, 'test'), returnsNormally);
  });
}
