import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:catalog_gen/catalog_gen.dart';
import 'package:test/test.dart';

const _source = r'''
/// Sizes.
enum Size2 {
  /// Small.
  s,

  /// Large.
  l,
}

/// Unused.
enum Unused { a }

/// A sample widget. It has a second sentence.
///
/// Second paragraph.
class Sample extends StatelessWidget {
  /// Creates it.
  const Sample({
    super.key,
    required this.label,
    this.size = Size2.s,
    this.onTap,
    double? delay,
  }) : delay = delay ?? 1;

  /// A named constructor.
  const Sample.small(this.label) : size = Size2.s, onTap = null, delay = 0;

  const Sample._private() : label = '', size = Size2.l, onTap = null, delay = 0;

  /// The label,
  /// wrapped over two lines.
  final String label;

  /// Size.
  final Size2 size;

  /// Tap callback.
  final void Function()? onTap;

  /// Delay in seconds.
  final double delay;

  /// Mutable extra.
  int counter = 0;

  /// Test hook.
  @visibleForTesting
  static int hook = 0;

  static const int _secret = 1;

  /// Computes a value.
  static double compute(int a, [int b = 2]) => 0;

  /// Current text.
  String? get text => null;

  @override
  Widget build(BuildContext context) => const SizedBox();

  void _hidden() {}
}

/// A preview.
@CsPreview(group: 'Sample', name: 'Basic', size: Size(320, 200))
Widget samplePreview() => const Sample(label: 'x');

/// Another preview.
@CsPreview(group: 'Sample', name: 'Unsized')
Widget sampleUnsizedPreview() => const Sample(label: 'y');
''';

void main() {
  final unit = parseString(content: _source).unit;

  group('extractClass', () {
    final c = extractClass(unit, 'Sample');

    test('class header and doc', () {
      expect(c.superclass, 'StatelessWidget');
      expect(
        c.doc,
        'A sample widget. It has a second sentence.\n\nSecond paragraph.',
      );
      expect(firstSentence(c.doc), 'A sample widget.');
    });

    test('public constructors with field types, defaults and docs', () {
      final ctors = c.members.where((m) => m.kind == 'constructor').toList();
      expect(ctors.map((m) => m.name), ['Sample', 'Sample.small']);
      final params = {for (final p in ctors[0].params) p.name: p};
      expect(params.keys, ['label', 'size', 'onTap', 'delay']);
      expect(params['label']!.type, 'String');
      expect(params['label']!.isRequired, isTrue);
      expect(params['label']!.doc, 'The label, wrapped over two lines.');
      expect(params['size']!.defaultValue, 'Size2.s');
      expect(params['onTap']!.type, 'void Function()?');
      expect(params['delay']!.type, 'double?');
      expect(ctors[1].params.single.isNamed, isFalse);
      expect(ctors[1].signature, 'Sample.small(this.label)');
    });

    test('properties exclude constructor params, statics and private', () {
      final props = c.members.where((m) => m.kind == 'property');
      expect(props.map((m) => m.signature), ['int counter']);
    });

    test('methods and getters skip build, private and overrides', () {
      final rest = c.members
          .where((m) => !m.kind.contains('constructor') && m.kind != 'property')
          .map((m) => '${m.kind}:${m.name}');
      expect(rest, ['getter:text', 'static method:compute']);
      final compute = c.members.firstWhere((m) => m.name == 'compute');
      expect(compute.signature, 'double compute(int a, [int b = 2])');
      expect(compute.params.last.defaultValue, '2');
    });

    test('missing class fails loudly', () {
      expect(() => extractClass(unit, 'Nope'), throwsStateError);
    });
  });

  test('extractEnums keeps only referenced enums', () {
    final enums = extractEnums([unit], [extractClass(unit, 'Sample')]);
    expect(enums.map((e) => e.name), ['Size2']);
    expect(enums.single.values, [('s', 'Small.'), ('l', 'Large.')]);
  });

  test('extractPreviews reads group, name and size', () {
    final dir = Directory.systemTemp.createTempSync('catalog_gen_test');
    addTearDown(() => dir.deleteSync(recursive: true));
    File('${dir.path}/a.dart').writeAsStringSync(_source);
    final previews = extractPreviews(dir);
    expect(previews.map((p) => (p.group, p.name, p.function, p.size)), [
      ('Sample', 'Basic', 'samplePreview', (320.0, 200.0)),
      ('Sample', 'Unsized', 'sampleUnsizedPreview', null),
    ]);
  });

  group('workspace', () {
    final root = findWorkspaceRoot();
    final pages = buildPages(root);

    test('every manifest entry resolves with API and previews', () {
      expect(pages, hasLength(manifest.length));
      for (final p in pages) {
        expect(p.classes, isNotEmpty, reason: p.entry.name);
        expect(p.previews, isNotEmpty, reason: p.entry.name);
        expect(p.summary, isNotEmpty, reason: p.entry.name);
      }
    });

    test('generated file is up to date with the sources', () async {
      final tmp = Directory.systemTemp.createTempSync('catalog_gen_check');
      addTearDown(() => tmp.deleteSync(recursive: true));
      final f = File('${tmp.path}/out.g.dart');
      await writeFormatted(f, emit(pages));
      expect(
        File('${root.path}/$outputFile').readAsStringSync(),
        f.readAsStringSync(),
        reason: 'Run: dart run melos run catalog:generate',
      );
    });
  });
}
