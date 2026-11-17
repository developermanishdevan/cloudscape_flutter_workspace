import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cloudscape_flutter/src/i18n/generated/cldr_date_loader.g.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

String _fmt(String message, String locale, Map<String, Object?> args) =>
    CsMessageFormat(parseIcuMessage(message), locale).format(args);

final _date = DateTime.utc(2026, 3, 9, 14, 5, 7);

void main() {
  setUp(() => CsMessageFormat.debugFormatDatesInUtc = true);
  tearDown(() => CsMessageFormat.debugFormatDatesInUtc = false);

  group('deferred date data', () {
    test('every CLDR locale has eager or deferred data', () {
      for (final id in csCldrDateLocaleIds) {
        expect(
          csCldrDateData.containsKey(id) ||
              csCldrDeferredDateLibraries.containsKey(id),
          isTrue,
          reason: id,
        );
      }
    });

    test('a non-Cloudscape locale loads on demand', () async {
      expect(csCldrDateDataReady('sw'), isFalse);
      expect(csCldrDateDataFor('sw'), isNull);
      final data = await csLoadCldrDateData('sw-TZ'); // resolves to sw
      expect(data, isNotNull);
      expect(csCldrDateDataReady('sw'), isTrue);
      expect(csCldrDateDataReady('sw-UG'), isTrue); // shares sw's library
      expect(_fmt('{d, date, long}', 'sw', {'d': _date}), '9 Machi 2026');
    });

    test('every deferred library loads', () async {
      for (final key in csCldrDeferredDateLibraries.values.toSet()) {
        final d = await csLoadCldrDateLibrary(key);
        expect(d.months['format-wide'], hasLength(12));
      }
    });

    test('unknown locales have nothing to load', () async {
      expect(csCldrDateDataReady('xx-YY'), isTrue);
      expect(await csLoadCldrDateData('xx-YY'), isNull);
    });
  });

  group('calendars', () {
    test('Persian (ICU arithmetic calendar)', () {
      expect(csPersianDate(2021, 3, 21), (year: 1400, month: 1, day: 1));
      expect(csPersianDate(2024, 3, 20), (year: 1403, month: 1, day: 1));
      expect(csPersianDate(2025, 3, 21), (year: 1404, month: 1, day: 1));
      expect(csPersianDate(1979, 2, 11), (year: 1357, month: 11, day: 22));
      expect(csPersianDate(2000, 1, 1), (year: 1378, month: 10, day: 11));
    });

    test('fa and ps use the Persian calendar with native digits', () async {
      await csLoadCldrDateData('fa');
      expect(csCldrDateDataFor('fa')!.calendar, 'persian');
      final long = _fmt('{d, date, long}', 'fa', {'d': _date});
      expect(long, contains('۱۴۰۴')); // 1404 in Extended Arabic-Indic digits
      expect(long, contains('اسفند')); // Esfand, the 12th month
      await csLoadCldrDateData('ps');
      expect(csCldrDateDataFor('ps')!.calendar, 'persian');
    });

    test('th keeps the Buddhist era', () {
      expect(_fmt('{d, date, long}', 'th', {'d': _date}), contains('2569'));
    });
  });

  group('native digits', () {
    test('dates use the locale default numbering system', () async {
      await csLoadCldrDateData('ar-EG');
      expect(_fmt('{d, date, short}', 'ar-EG', {'d': _date}), contains('٩'));
      await csLoadCldrDateData('bn');
      expect(_fmt('{d, time, short}', 'bn', {'d': _date}), contains('২'));
      // ar (Cloudscape's) defaults to Latin digits in CLDR 47.
      expect(_fmt('{d, date, short}', 'ar', {'d': _date}), contains('9'));
    });

    test('numbers use native digits and symbols', () {
      expect(_fmt('{n, number}', 'ar-EG', {'n': 1234.5}), '١٬٢٣٤٫٥');
      expect(_fmt('{n, number}', 'fa', {'n': -42}), '‎−۴۲');
      expect(_fmt('{n, number, percent}', 'ar-EG', {'n': 0.25}), '٢٥٪؜');
    });
  });

  group('number formatting', () {
    String n(num v, String locale, [String? style]) =>
        csFormatNumber(v, locale, style: style);

    test('Indian grouping and minimum grouping digits', () {
      expect(n(12345678.9, 'en-IN'), '1,23,45,678.9');
      expect(n(1234, 'hi'), '1,234');
      expect(n(1234, 'es'), '1234');
      expect(n(12345, 'es'), '12.345');
    });

    test('fraction digits, rounding, integer and percent styles', () {
      expect(n(1234.5678, 'en'), '1,234.568');
      expect(n(0.125, 'en', 'percent'), '13%');
      expect(n(1234.5678, 'en', 'integer'), '1,235');
      expect(n(0.5, 'de', 'percent'), '50 %');
      expect(n(-1, 'en'), '-1');
      expect(n(double.nan, 'en'), 'NaN');
      expect(n(double.infinity, 'en'), '∞');
    });

    test('pattern parsing', () {
      final p = csParseNumberPattern('#,##,##0.###');
      expect((p.primaryGrouping, p.secondaryGrouping), (3, 2));
      final q = csParseNumberPattern('%#,##0');
      expect((q.prefix, q.suffix), ('%', ''));
    });
  });

  testWidgets('the provider loads a deferred locale and rebuilds', (
    tester,
  ) async {
    CsMessageFormat.debugFormatDatesInUtc = true;
    final messages = <CsI18nMessages>[
      {
        csI18nNamespace: {
          'zu': {
            'demo': {'when': '{d, date, long}'},
          },
          'en': {
            'demo': {'when': '{d, date, long}'},
          },
        },
      },
    ];
    await tester.pumpWidget(
      CsApp(
        home: CsI18nProvider(
          locale: 'zu-ZA',
          messages: messages,
          child: Builder(
            builder: (context) => Text(
              CsI18n.of(context, 'demo').withHandler<String>(
                    'when',
                    null,
                    (m) => m.format({'d': _date}),
                  ) ??
                  '',
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ),
    );
    // First frame: zu is not loaded yet, so dates fall back to English.
    expect(csCldrDateDataReady('zu'), isFalse);
    expect(find.text('March 9, 2026'), findsOneWidget);
    // The provider started the deferred load (completed by a timer in the
    // VM); advance time and rebuild.
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump();
    expect(csCldrDateDataReady('zu'), isTrue);
    final zu = _fmt('{d, date, long}', 'zu', {'d': _date});
    expect(zu, isNot('March 9, 2026'));
    expect(find.text(zu), findsOneWidget);
  });
}
