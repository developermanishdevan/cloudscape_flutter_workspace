import 'package:i18n_gen/i18n_gen.dart';
import 'package:test/test.dart';

void main() {
  test('ICU printer quotes special characters', () {
    expect(
      icu([
        {'type': 0, 'value': "It's {x} <b>"},
      ]),
      "It''s '{'x'}' '<'b'>'",
    );
    expect(
      icu([
        {
          'type': 6,
          'value': 'n',
          'pluralType': 'cardinal',
          'offset': 0,
          'options': {
            'other': {
              'value': [
                {'type': 7},
                {'type': 0, 'value': ' #'},
              ],
            },
          },
        },
      ]),
      "{n, plural, other {# '#'}}",
    );
  });

  test('CLDR rules load with every category but other', () {
    final root = findWorkspaceRoot();
    final cardinal = loadPluralRules(root, ordinal: false);
    expect(cardinal['ar'], {
      'zero': 'n = 0',
      'one': 'n = 1',
      'two': 'n = 2',
      'few': 'n % 100 = 3..10',
      'many': 'n % 100 = 11..99',
    });
    expect(cardinal['ja'], isEmpty);
    expect(loadPluralRules(root, ordinal: true)['en']!.keys, [
      'one',
      'two',
      'few',
    ]);
  });

  test('all vendored bundles load and emit', () {
    final root = findWorkspaceRoot();
    final bundles = loadBundles(root);
    expect(bundles, hasLength(15));
    final files = emitAll(
      bundles,
      'test',
      cardinal: loadPluralRules(root, ordinal: false),
      ordinal: loadPluralRules(root, ordinal: true),
      cldrVersion: 'test',
    );
    expect(files.keys.where((k) => k.endsWith('.arb')), hasLength(15));
    expect(files.keys.where((k) => k.contains('/all_')), hasLength(15));
  });
}
