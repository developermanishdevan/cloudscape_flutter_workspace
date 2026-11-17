import 'dart:convert';
import 'dart:io';

import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cloudscape_flutter/i18n/messages/all_en.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

const _upstreamDir = '../../tool/upstream';

/// formatjs JSON AST → CsMessageNode (independent of the generator).
List<CsMessageNode> _fromJson(List<Object?> nodes) => <CsMessageNode>[
  for (final raw in nodes)
    () {
      final n = (raw! as Map).cast<String, Object?>();
      Map<String, List<CsMessageNode>> opts() => {
        for (final o in (n['options']! as Map).entries)
          o.key as String: _fromJson(
            ((o.value as Map)['value']! as List).cast<Object?>(),
          ),
      };
      return switch (n['type']) {
        0 => CsLiteralNode(n['value']! as String),
        1 => CsArgumentNode(n['value']! as String),
        5 => CsSelectNode(n['value']! as String, opts()),
        6 => CsPluralNode(
          n['value']! as String,
          opts(),
          offset: (n['offset'] as num?) ?? 0,
          ordinal: n['pluralType'] == 'ordinal',
        ),
        7 => const CsPoundNode(),
        8 => CsTagNode(
          n['value']! as String,
          _fromJson((n['children']! as List).cast<Object?>()),
        ),
        _ => throw StateError(
          'type ${n['type']} not expected in upstream bundles',
        ),
      };
    }(),
];

List<String> _locales() =>
    ((jsonDecode(File('$_upstreamDir/upstream.json').readAsStringSync())
                as Map)['locales']!
            as List)
        .cast<String>();

Map<String, Map<String, List<Object?>>> _upstream(String locale) {
  final json = jsonDecode(
    File('$_upstreamDir/i18n/$locale.json').readAsStringSync(),
  ) as Map;
  final comps = ((json[csI18nNamespace]! as Map)[locale]! as Map)
      .cast<String, Object?>();
  return {
    for (final c in comps.entries)
      c.key: {
        for (final m in (c.value! as Map).entries)
          m.key as String: (m.value as List).cast<Object?>(),
      },
  };
}

String _t(CsI18nMessages m, String locale, String component, String key) =>
    CsI18nFormatter(
      locale,
      csNormalizeMessages([m]),
    ).format(csI18nNamespace, component, key, null)!;

void main() {
  group('parity with upstream bundles', () {
    test(
      'generated Dart messages equal the upstream ASTs (all locales)',
      () async {
        var count = 0;
        for (final locale in _locales()) {
          final loaded = await csImportMessages(locale);
          final generated = loaded.single[csI18nNamespace]![locale]!;
          final upstream = _upstream(locale);
          expect(generated.keys.toSet(), upstream.keys.toSet(), reason: locale);
          for (final c in upstream.entries) {
            expect(
              generated[c.key]!.keys.toSet(),
              c.value.keys.toSet(),
              reason: '$locale ${c.key}',
            );
            for (final m in c.value.entries) {
              final g = generated[c.key]![m.key]! as List<CsMessageNode>;
              expect(
                csMessageEquals(g, _fromJson(m.value)),
                isTrue,
                reason: '$locale ${c.key}.${m.key}',
              );
              count++;
            }
          }
        }
        expect(count, 6482);
      },
    );

    test('ARB ICU strings parse back to the upstream ASTs (all locales)', () {
      for (final locale in _locales()) {
        final arb = jsonDecode(
          File(
            'l10n/cloudscape_${locale.toLowerCase().replaceAll('-', '_')}.arb',
          ).readAsStringSync(),
        ) as Map<String, Object?>;
        expect(arb['@@locale'], locale.replaceAll('-', '_'));
        for (final c in _upstream(locale).entries) {
          for (final m in c.value.entries) {
            final icu = arb['${c.key}.${m.key}']! as String;
            expect(
              csMessageEquals(parseIcuMessage(icu), _fromJson(m.value)),
              isTrue,
              reason: '$locale ${c.key}.${m.key}: $icu',
            );
          }
        }
      }
    });

    test('csImportMessages widens locales and ignores unknown ones', () async {
      expect((await csImportMessages('en-AU')).single[csI18nNamespace]!.keys, [
        'en',
      ]);
      expect((await csImportMessages('pt-BR')).single[csI18nNamespace]!.keys, [
        'pt-BR',
      ]);
      expect(await csImportMessages('xx-YY'), isEmpty);
      expect(csI18nLocales, hasLength(15));
    });
  });

  group('formatting', () {
    const component = 'collection-preferences';
    const key = 'contentDisplayPreference.i18nStrings.columnFilteringCountText';

    test('plain messages and locale widening', () {
      expect(
        _t(csMessagesEn, 'en', 'pagination', 'ariaLabels.nextPageLabel'),
        'Next page',
      );
      expect(
        _t(csMessagesEn, 'en-AU', 'pagination', 'ariaLabels.nextPageLabel'),
        'Next page',
      );
      expect(
        _t(csMessagesEn, 'EN', 'pagination', 'ariaLabels.nextPageLabel'),
        'Next page',
      );
    });

    test(
      'CLDR plural categories: zero applies in Arabic, not English',
      () async {
        final ar = (await csImportMessages('ar')).single;
        String count(CsI18nMessages m, String locale, num n) =>
            CsI18nFormatter(locale, csNormalizeMessages([m])).formatWith(
              csI18nNamespace,
              component,
              key,
              null,
              (msg) => msg.format({'count': n}),
            )!;
        expect(count(csMessagesEn, 'en', 0), '0 matches');
        expect(count(csMessagesEn, 'en', 1), '1 match');
        expect(count(csMessagesEn, 'en', 5), '5 matches');
        expect(count(ar, 'ar', 0), 'لا توجد تطابقات');
        expect(count(ar, 'ar', 1), 'تطابق واحد');
        expect(count(ar, 'ar', 7), '7 تطابق');
      },
    );

    test('select with boolean arguments', () {
      final f = CsI18nFormatter('en', csNormalizeMessages([csMessagesEn]));
      final text = f.formatWith(
        csI18nNamespace,
        'annotation-context',
        'i18nStrings.labelHotspot',
        null,
        (m) =>
            m.format({'openState': true, 'stepNumber': 2, 'totalStepCount': 5}),
      );
      expect(text, 'Annotation for step 2 of 5');
    });

    test('rich text tags return parts', () {
      final f = CsI18nFormatter('en', csNormalizeMessages([csMessagesEn]));
      final parts = f.formatWith(
        csI18nNamespace,
        'error-boundary',
        'i18nStrings.descriptionText',
        null,
        (m) => m.formatToParts({
          'hasFeedback': true,
          'Feedback': (List<Object> c) => const SizedBox(),
        }),
      )!;
      expect(
        parts.first,
        'Refresh to try again. We are tracking this issue, but you can share ',
      );
      expect(parts[1], isA<SizedBox>());
      expect(parts.last, '.');
    });

    test('provided values win; failures fall back gracefully', () {
      final f = CsI18nFormatter('en', csNormalizeMessages([csMessagesEn]));
      expect(
        f.format(
          csI18nNamespace,
          'pagination',
          'ariaLabels.nextPageLabel',
          'Mine',
        ),
        'Mine',
      );
      expect(f.format(csI18nNamespace, 'pagination', 'nope', null), isNull);
      // Needs arguments: plain format fails → provided (null).
      expect(f.format(csI18nNamespace, component, key, null), isNull);
      // Handler without the argument → '' (upstream returns '' too).
      expect(
        f.formatWith(csI18nNamespace, component, key, null, (m) => m.format()),
        '',
      );
    });
  });

  group('ICU parser', () {
    test('quoting, offset, exact keys, pound and selectordinal', () {
      String f(String icu, Map<String, Object?> args, [String locale = 'en']) =>
          CsMessageFormat(parseIcuMessage(icu), locale).format(args);
      expect(f("It''s '{literal}' text", const {}), "It's {literal} text");
      expect(
        f(
          '{n, plural, offset:1 =0 {nobody} =1 {just {who}} one {{who} and # other} other {{who} and # others}}',
          {'n': 3, 'who': 'Ann'},
        ),
        'Ann and 2 others',
      );
      expect(
        f('{n, plural, =0 {none} other {# items}}', const {'n': 0}),
        'none',
      );
      expect(
        f('{n, plural, other {# items}}', const {'n': 1234}),
        '1,234 items',
      );
      expect(
        f(
          '{n, selectordinal, one {#st} two {#nd} few {#rd} other {#th}}',
          const {'n': 22},
        ),
        '22nd',
      );
      expect(f('{v, number, percent}', const {'v': 0.25}), '25%');
      expect(
        () => parseIcuMessage('{x, select, a {A}}'),
        throwsA(isA<CsIcuSyntaxError>()),
      );
      expect(() => parseIcuMessage('{x'), throwsA(isA<CsIcuSyntaxError>()));
    });
  });

  group('CsI18nProvider', () {
    testWidgets(
      'looks up strings, merges nested providers, exposes the locale',
      (tester) async {
        late String? outer;
        late String? inner;
        late String? custom;
        late String? locale;
        const override =
            <String, Map<String, Map<String, Map<String, Object>>>>{
              csI18nNamespace: {
                'en': {
                  'pagination': {'ariaLabels.nextPageLabel': 'Onward'},
                },
              },
              'my-lib': {
                'en': {
                  'widget': {'greeting': 'Hello {name}'},
                },
              },
            };
        await tester.pumpWidget(
          CsApp(
            i18nMessages: const [csMessagesEn],
            i18nLocale: 'en-US',
            home: Column(
              children: [
                Builder(
                  builder: (c) {
                    outer = CsI18n.of(c, 'pagination')(
                      'ariaLabels.nextPageLabel',
                    );
                    locale = CsI18n.localeOf(c);
                    return const SizedBox();
                  },
                ),
                CsI18nProvider(
                  messages: const [override],
                  child: Builder(
                    builder: (c) {
                      inner = CsI18n.of(c, 'pagination')(
                        'ariaLabels.nextPageLabel',
                      );
                      custom = CsI18n.custom(c, 'my-lib', 'widget')
                          .withHandler<String>(
                            'greeting',
                            null,
                            (m) => m.format({'name': 'Ann'}),
                          );
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
        expect(outer, 'Next page');
        expect(locale, 'en-us');
        expect(inner, 'Onward');
        expect(custom, 'Hello Ann');
      },
    );

    testWidgets('without a provider, lookups return the provided value', (
      tester,
    ) async {
      late String? value;
      late String? locale;
      await tester.pumpWidget(
        CsApp(
          home: Builder(
            builder: (c) {
              value = CsI18n.of(c, 'pagination')(
                'ariaLabels.nextPageLabel',
                'Given',
              );
              locale = CsI18n.localeOf(c);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(value, 'Given');
      expect(locale, isNull);
    });
  });
}
