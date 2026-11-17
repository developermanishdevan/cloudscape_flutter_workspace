import 'dart:convert';
import 'dart:io';

import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter_test/flutter_test.dart';

/// Expands CLDR sample lists: `0, 2~16, 1c3, …` and `0.0~1.5`.
List<String> _samples(String list) {
  final out = <String>[];
  for (var item in list.split(',')) {
    item = item.trim();
    if (item.isEmpty || item == '…' || item == '...') continue;
    if (!item.contains('~')) {
      out.add(item);
      continue;
    }
    final [lo, hi] = item.split('~');
    final decimals = lo.contains('.') ? lo.split('.').last.length : 0;
    BigInt scaled(String s) => BigInt.parse(s.replaceAll('.', ''));
    for (var v = scaled(lo); v <= scaled(hi); v += BigInt.one) {
      final digits = v.toString().padLeft(decimals + 1, '0');
      out.add(
        decimals == 0
            ? digits
            : '${digits.substring(0, digits.length - decimals)}.${digits.substring(digits.length - decimals)}',
      );
    }
  }
  return out;
}

void main() {
  for (final ordinal in [false, true]) {
    test(
      'every CLDR ${ordinal ? 'ordinal' : 'cardinal'} sample maps to its category',
      () {
        final file = File(
          '../../tool/upstream/cldr/${ordinal ? 'ordinals' : 'plurals'}.json',
        );
        final json =
            jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
        final data =
            ((json['supplemental']!
                        as Map)['plurals-type-${ordinal ? 'ordinal' : 'cardinal'}']!
                    as Map)
                .cast<String, Object?>();
        var checked = 0;
        for (final locale in data.entries) {
          expect(
            csPluralRulesLocale(locale.key, ordinal: ordinal),
            locale.key.toLowerCase(),
            reason: locale.key,
          );
          for (final rule
              in (locale.value! as Map).cast<String, String>().entries) {
            final category = rule.key.replaceFirst('pluralRule-count-', '');
            for (final part in rule.value.split('@').skip(1)) {
              final kind = part.split(' ').first;
              for (final sample in _samples(part.substring(kind.length))) {
                expect(
                  csPluralCategoryOf(
                    CsPluralOperands.parse(sample),
                    locale.key,
                    ordinal: ordinal,
                  ),
                  category,
                  reason: '${locale.key} $sample',
                );
                checked++;
              }
            }
          }
        }
        expect(checked, greaterThan(ordinal ? 1000 : 5000));
      },
    );
  }

  test('operands follow Intl.PluralRules (max 3 fraction digits, half away from zero)', () {
    expect(csRoundDecimalString(1.0005, 3), '1.001');
    expect(csRoundDecimalString(2.5, 0), '3');
    expect(csRoundDecimalString(1.2304, 3), '1.23');
    expect(csRoundDecimalString(1e21, 3), '1000000000000000000000');
    expect(csRoundDecimalString(1.5e-7, 3), '0');
    final o = CsPluralOperands.parse('1.50');
    expect([o.i.toInt(), o.v, o.w, o.f.toInt(), o.t.toInt()], [1, 2, 1, 50, 5]);
    expect(CsPluralOperands.parse('1.2c6').i.toInt(), 1200000);
    expect(csPluralCategory(1.5, 'en'), 'other'); // v != 0
    expect(csPluralCategory(1, 'en'), 'one');
    expect(csPluralCategory(1000000, 'fr'), 'many');
    expect(csPluralCategory(0, 'ar'), 'zero');
    expect(csPluralCategory(1, 'fr', ordinal: true), 'one');
    expect(csPluralCategory(2, 'fr', ordinal: true), 'other');
  });

  test('locale matching widens and falls back to en', () {
    expect(csPluralRulesLocale('pt-BR'), 'pt');
    expect(csPluralRulesLocale('pt-PT'), 'pt-pt');
    expect(csPluralRulesLocale('zh-TW'), 'zh');
    expect(csPluralRulesLocale('xx-YY'), 'en');
  });

  group('date and time arguments', () {
    setUp(() => CsMessageFormat.debugFormatDatesInUtc = true);
    tearDown(() => CsMessageFormat.debugFormatDatesInUtc = false);
    final when = DateTime.utc(2026, 3, 9, 14, 5, 7).millisecondsSinceEpoch;
    String f(String icu, [String locale = 'en']) =>
        CsMessageFormat(parseIcuMessage(icu), locale).format({'d': when});

    test('date styles', () {
      expect(f('{d, date}'), '3/9/2026');
      expect(f('{d, date, short}'), '3/9/26');
      expect(f('{d, date, medium}'), 'Mar 9, 2026');
      expect(f('{d, date, long}'), 'March 9, 2026');
      expect(f('{d, date, full}'), 'Monday, March 9, 2026');
      expect(f('{d, date, medium}', 'de'), '9. März 2026');
      expect(f('{d, date, ::yMMMd}'), 'Mar 9, 2026');
      expect(() => f('{d, date, ::GGGGyMMMd}'), throwsUnsupportedError);
    });

    test('time styles follow the locale hour cycle', () {
      expect(f('{d, time, short}'), contains('2:05'));
      expect(f('{d, time}'), contains('2:05:07'));
      expect(f('{d, time, short}', 'de'), '14:05');
    });

    test('DateTime values are accepted', () {
      expect(
        CsMessageFormat(
          parseIcuMessage('{d, date, long}'),
          'en',
        ).format({'d': DateTime.utc(2026, 1, 2)}),
        'January 2, 2026',
      );
    });
  });

  group('CLDR locale resolution and numbers', () {
    test('resolves like ICU', () {
      expect(csResolveCldrLocale('zh-TW', csCldrDateLocaleIds), 'zh-Hant');
      expect(csResolveCldrLocale('zh-CN', csCldrDateLocaleIds), 'zh');
      expect(csResolveCldrLocale('pt-BR', csCldrDateLocaleIds), 'pt');
      expect(csResolveCldrLocale('pt-PT', csCldrDateLocaleIds), 'pt-PT');
      expect(csResolveCldrLocale('en-US', csCldrDateLocaleIds), 'en');
      expect(csResolveCldrLocale('en-GB', csCldrDateLocaleIds), 'en-GB');
      expect(csResolveCldrLocale('xx-YY', csCldrDateLocaleIds), isNull);
      expect(
        csCldrDateDataFor('zh-HK')?.id,
        isNull,
      ); // zh-Hant-HK is not bundled
      expect(csCldrDateDataFor('th')!.calendar, 'buddhist');
    });

    test('minimum grouping digits (es/it/pl group from 5 digits)', () {
      String n(num v, String locale, [String style = '']) => CsMessageFormat(
        parseIcuMessage(style.isEmpty ? '{n, number}' : '{n, number, $style}'),
        locale,
      ).format({'n': v});
      expect(csMinimumGroupingDigits('es'), 2);
      expect(
        csMinimumGroupingDigits('es-MX'),
        csCldrNumberData['es-MX']!.minimumGroupingDigits,
      );
      expect(n(1234, 'es'), '1234');
      expect(n(12345, 'es'), '12.345');
      expect(n(1234, 'de'), '1.234');
      expect(n(1234, 'pl'), '1234');
    });

    test('time zone names: UTC, GMT offsets and the narrow-space rule', () {
      final data = csCldrDateData['en']!;
      final utc = DateTime.utc(2026, 3, 9, 14, 5, 7);
      expect(
        csFormatCldrPattern('h:mm a z', utc, data, utc: true),
        '2:05 PM UTC',
      );
      final pattern = csCldrPattern(data, time: true, style: 'short')!;
      expect(pattern.contains('\u202F'), isFalse);
      expect(
        csCldrPattern(csCldrDateData['zh-Hant']!, time: true, style: 'short'),
        contains('a'),
      );
      expect(
        csCldrPattern(csCldrDateData['zh-Hant']!, time: true, style: 'short'),
        isNot(contains('B')),
      );
    });
  });
}
