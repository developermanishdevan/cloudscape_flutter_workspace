// CLDR 47 date/time and number-grouping behavior matching the browser
// `Intl` APIs (V8 + ICU) that upstream's formatter uses.
import 'package:cloudscape_flutter/src/i18n/cldr_date_data.dart';
import 'package:cloudscape_flutter/src/i18n/generated/cldr_data.g.dart';
import 'package:cloudscape_flutter/src/i18n/generated/cldr_date_loader.g.dart';

/// Resolves a BCP 47 tag to a CLDR locale id in [available], the way ICU
/// does: exact match, else maximized with likely subtags and narrowed.
/// Returns null when none applies.
String? csResolveCldrLocale(String tag, Set<String> available) {
  final parts = tag.replaceAll('_', '-').split('-');
  final lang = parts.first.toLowerCase();
  String? script;
  String? region;
  for (final p in parts.skip(1)) {
    if (p.length == 4) {
      script = '${p[0].toUpperCase()}${p.substring(1).toLowerCase()}';
    }
    if (p.length == 2 || (p.length == 3 && int.tryParse(p) != null)) {
      region = p.toUpperCase();
    }
  }
  final exact = [lang, ?script, ?region].join('-');
  if (available.contains(exact)) return exact;
  final defaultScript = csCldrDefaultScripts[lang];
  script ??= region == null
      ? defaultScript
      : (csCldrRegionScripts['$lang-$region'] ?? defaultScript);
  final candidates = [
    if (script != null && region != null) '$lang-$script-$region',
    if (script != null && script != defaultScript) '$lang-$script',
    if (region != null && (script == null || script == defaultScript))
      '$lang-$region',
    if (script == null || script == defaultScript) lang,
  ];
  for (final c in candidates) {
    if (available.contains(c)) return c;
  }
  return null;
}

final Map<String, CsCldrDateData> _loaded = {};
final Map<String, Future<CsCldrDateData?>> _loading = {};

/// The CLDR date data for [locale] when available now: bundled eagerly (the
/// Cloudscape message locales) or already loaded by [csLoadCldrDateData].
/// Null otherwise.
CsCldrDateData? csCldrDateDataFor(String locale) {
  final id = csResolveCldrLocale(locale, csCldrDateLocaleIds);
  if (id == null) return null;
  return csCldrDateData[id] ?? _loaded[id];
}

/// Whether [locale]'s date data is available synchronously (or CLDR has
/// none for it, so there is nothing to load).
bool csCldrDateDataReady(String locale) {
  final id = csResolveCldrLocale(locale, csCldrDateLocaleIds);
  return id == null ||
      csCldrDateData.containsKey(id) ||
      _loaded.containsKey(id);
}

/// Loads [locale]'s date data (a deferred library on the web) and caches
/// it; completes with null when CLDR has no data for the locale.
Future<CsCldrDateData?> csLoadCldrDateData(String locale) {
  final id = csResolveCldrLocale(locale, csCldrDateLocaleIds);
  if (id == null) return Future.value();
  final ready = csCldrDateData[id] ?? _loaded[id];
  if (ready != null) return Future.value(ready);
  return _loading[id] ??= () async {
    final key = csCldrDeferredDateLibraries[id];
    if (key == null) return null;
    final data = await csLoadCldrDateLibrary(key);
    // Every locale sharing the library is ready now.
    for (final e in csCldrDeferredDateLibraries.entries) {
      if (e.value == key) _loaded[e.key] = data;
    }
    return data;
  }();
}

Set<String>? _numberIds;

/// The CLDR number data for [locale] (falls back to `en`).
CsCldrNumberData csCldrNumberDataFor(String locale) {
  final id = csResolveCldrLocale(
    locale,
    _numberIds ??= csCldrNumberData.keys.toSet(),
  );
  return csCldrNumberData[id] ?? csCldrNumberData['en']!;
}

/// CLDR `minimumGroupingDigits` for [locale] (1 when unknown).
int csMinimumGroupingDigits(String locale) {
  final id = csResolveCldrLocale(
    locale,
    _numberIds ??= csCldrNumberData.keys.toSet(),
  );
  return id == null ? 1 : csCldrNumberData[id]!.minimumGroupingDigits;
}

/// Replaces ASCII digits in [s] with [digits] (a numbering system's ten
/// digits; empty keeps ASCII).
String csLocalizeDigits(String s, String digits) {
  if (digits.isEmpty) return s;
  final native = digits.runes.toList();
  return String.fromCharCodes([
    for (final c in s.runes) c >= 0x30 && c <= 0x39 ? native[c - 0x30] : c,
  ]);
}

/// A date in a non-Gregorian calendar.
typedef CsCalendarDate = ({int year, int month, int day});

int _floorDiv(int a, int b) => (a / b).floor();

/// Julian day number of a proleptic Gregorian date.
int _julianDay(int y, int m, int d) {
  final a = _floorDiv(14 - m, 12);
  final yy = y + 4800 - a;
  final mm = m + 12 * a - 3;
  return d +
      _floorDiv(153 * mm + 2, 5) +
      365 * yy +
      _floorDiv(yy, 4) -
      _floorDiv(yy, 100) +
      _floorDiv(yy, 400) -
      32045;
}

/// ICU `PersianCalendar` (arithmetic 33-year cycle) for a Gregorian date.
CsCalendarDate csPersianDate(int year, int month, int day) {
  const epoch = 1948320; // Julian day of 1 Farvardin 1 AP
  const cumulative = [0, 31, 62, 93, 124, 155, 186, 216, 246, 276, 306, 336];
  final days = _julianDay(year, month, day) - epoch;
  final y = 1 + _floorDiv(33 * days + 3, 12053);
  final farvardin1 = 365 * (y - 1) + _floorDiv(8 * y + 21, 33);
  final dayOfYear = days - farvardin1; // 0-based
  final m = dayOfYear < 216 ? dayOfYear ~/ 31 : (dayOfYear - 6) ~/ 30;
  return (year: y, month: m + 1, day: dayOfYear - cumulative[m] + 1);
}

/// The year / month / day of [dt] in [d]'s calendar.
CsCalendarDate csCalendarDate(DateTime dt, CsCldrDateData d) =>
    switch (d.calendar) {
      'persian' => csPersianDate(dt.year, dt.month, dt.day),
      _ => (year: dt.year + d.yearOffset, month: dt.month, day: dt.day),
    };

final _token = RegExp(r"'(?:[^']|'')*'|([A-Za-z])\1*|[^A-Za-z']+");

/// Splits a CLDR pattern into literal and field tokens.
List<String> csPatternTokens(String pattern) => [
  for (final m in _token.allMatches(pattern)) m[0]!,
];

bool _isField(String t) => RegExp('^[A-Za-z]').hasMatch(t);

bool _isText(String t) => t.length >= 3;

/// Changes field lengths of [pattern] to those in [request] (e.g. `yy`),
/// keeping numeric/text category (ICU does not turn `M` into `MMMM`).
String _adjust(String pattern, Map<String, int> request) {
  final out = StringBuffer();
  for (final t in csPatternTokens(pattern)) {
    final want = _isField(t) ? request[t[0]] : null;
    if (want == null || want == t.length) {
      out.write(t);
    } else if (t[0] == 'E') {
      // E..EEE abbreviated, EEEE wide, EEEEE narrow: always text.
      out.write(t[0] * want);
    } else if ('MLc'.contains(t[0])) {
      // Text ↔ numeric would change the field's category; only widen text.
      out.write(_isText(t) && want >= 3 ? t[0] * want : t);
    } else {
      out.write(t[0] * want);
    }
  }
  return out.toString();
}

String _hourToNumeric(String pattern) => [
  for (final t in csPatternTokens(pattern))
    _isField(t) && 'hHkK'.contains(t[0]) ? t[0] : t,
].join();

/// V8 drops the flexible day period (`B`) when no day period was requested.
String _noFlexibleDayPeriod(String pattern) => [
  for (final t in csPatternTokens(pattern))
    _isField(t) && t[0] == 'B' ? 'a' : t,
].join();

/// Field runs of a skeleton, e.g. `yMMMd` → {y: 1, M: 3, d: 1}.
Map<String, int> _fields(String skeleton) => {
  for (final t in csPatternTokens(skeleton))
    if (_isField(t)) t[0]: t.length,
};

bool _textField(String letter, int length) => switch (letter) {
  'M' || 'L' || 'Q' || 'q' => length >= 3,
  'E' => true,
  'c' || 'e' => length >= 3,
  _ => false,
};

/// ICU-like best pattern for [skeleton]: among pool entries with the same
/// fields, the smallest distance (length change 1, numeric↔text 0x100),
/// first one on ties; then field lengths are adjusted to the request.
String? _best(CsCldrDateData d, String skeleton) {
  final want = _fields(skeleton);
  final pool = <(Map<String, int>, String)>[
    for (final e in d.availableFormats.entries) (_fields(e.key), e.value),
    for (final k in const ['full', 'long', 'medium', 'short'])
      if (d.dateSkeletons[k] != null)
        (_fields(d.dateSkeletons[k]!), d.dateFormats[k]!),
  ];
  (int, String, Map<String, int>)? best;
  for (final (fields, pattern) in pool) {
    if (fields.length != want.length || !fields.keys.every(want.containsKey)) {
      continue;
    }
    var distance = 0;
    for (final e in want.entries) {
      final have = fields[e.key]!;
      if (have == e.value) continue;
      distance += _textField(e.key, have) == _textField(e.key, e.value)
          ? 1
          : 0x100;
    }
    if (best == null || distance < best.$1) best = (distance, pattern, fields);
    if (distance == 0) break;
  }
  if (best == null) return null;
  // Adjust only the fields whose requested length differs from the matched
  // skeleton (ICU adjustFieldTypes), not from the pattern itself.
  final changed = {
    for (final e in want.entries)
      if (best.$3[e.key] != e.value) e.key: e.value,
  };
  return _adjust(best.$2, changed);
}

/// The pattern the browser uses for an ICU `{x, date|time, style}` argument
/// (formatjs style table), or for a `::skeleton`. Null when unsupported.
String? csCldrPattern(CsCldrDateData d, {required bool time, String? style}) {
  final af = d.availableFormats;
  String? pattern;
  if (style != null && style.startsWith('::')) {
    pattern = af[style.substring(2).trim()];
  } else if (!time) {
    pattern = _best(d, switch (style) {
      'short' => 'yyMd',
      'medium' => 'yMMMd',
      'long' => 'yMMMMd',
      'full' => 'yMMMMEEEEd',
      _ => 'yMd',
    });
  } else {
    pattern = switch (style) {
      'short' => d.timeFormats['short'],
      null || 'medium' => d.timeFormats['medium'],
      'long' || 'full' => _hourToNumeric(d.timeFormats['long']!),
      _ => af['yMd'], // formatjs: unknown time style → default date
    };
  }
  // V8 replaces CLDR's narrow no-break space (U+202F) with a plain space.
  return pattern == null
      ? null
      : _noFlexibleDayPeriod(pattern).replaceAll('\u202F', ' ');
}

String _pad(int v, int width) => v.toString().padLeft(width, '0');

String _zoneName(CsCldrDateData d, DateTime dt, bool utc) {
  if (utc) return 'UTC';
  final offset = dt.timeZoneOffset;
  if (offset == Duration.zero) return d.gmtZeroFormat;
  // US metazone abbreviations are what en-US shows for short names.
  const us = {
    'PST',
    'PDT',
    'MST',
    'MDT',
    'CST',
    'CDT',
    'EST',
    'EDT',
    'AKST',
    'AKDT',
    'HST',
  };
  if (d.id == 'en' && us.contains(dt.timeZoneName)) return dt.timeZoneName;
  final negative = offset.isNegative;
  final minutes = offset.inMinutes.abs();
  final parts = d.hourFormat.split(';');
  var f = negative && parts.length > 1 ? parts[1] : parts.first;
  // Short localized GMT: single-digit hours, minutes only when non-zero.
  f = f.replaceAll('HH', 'H');
  if (minutes % 60 == 0) f = f.replaceAll(RegExp(r'[:.]?mm'), '');
  final h = minutes ~/ 60, m = minutes % 60;
  final offsetText = f.replaceAll('H', '$h').replaceAll('mm', _pad(m, 2));
  return d.gmtFormat.replaceAll('{0}', offsetText);
}

/// Formats [dt] with a CLDR [pattern] and [d]'s symbols. [utc] marks the
/// time zone as UTC (`z` → `UTC`).
String csFormatCldrPattern(
  String pattern,
  DateTime dt,
  CsCldrDateData d, {
  required bool utc,
  String digits = '',
}) {
  final cal = csCalendarDate(dt, d);
  String num(String s) => csLocalizeDigits(s, digits);
  final out = StringBuffer();
  for (final t in csPatternTokens(pattern)) {
    if (t.startsWith("'")) {
      out.write(
        t == "''" ? "'" : t.substring(1, t.length - 1).replaceAll("''", "'"),
      );
      continue;
    }
    if (!_isField(t)) {
      out.write(t);
      continue;
    }
    final n = t.length;
    final width = n == 4
        ? 'wide'
        : n == 5
        ? 'narrow'
        : 'abbreviated';
    final weekday = dt.weekday % 7; // Sunday = 0
    switch (t[0]) {
      case 'G':
        final names = d.eras[width]!;
        out.write(
          names[d.calendar == 'gregorian' ? (dt.year > 0 ? 1 : 0) : 0] ??
              names.values.last,
        );
      case 'y':
        final y = cal.year;
        out.write(num(n == 2 ? _pad(y % 100, 2) : _pad(y, n)));
      case 'M' || 'L':
        final ctx = t[0] == 'M' ? 'format' : 'stand-alone';
        out.write(
          n <= 2
              ? num(_pad(cal.month, n))
              : d.months['$ctx-$width']![cal.month - 1],
        );
      case 'Q' || 'q':
        final q = (cal.month - 1) ~/ 3;
        final ctx = t[0] == 'Q' ? 'format' : 'stand-alone';
        out.write(n <= 2 ? num(_pad(q + 1, n)) : d.quarters['$ctx-$width']![q]);
      case 'd':
        out.write(num(_pad(cal.day, n)));
      case 'E':
        out.write(d.days['format-$width']![weekday]);
      case 'c':
        out.write(
          n <= 2
              ? num('${weekday + 1}')
              : d.days['stand-alone-$width']![weekday],
        );
      case 'a':
        out.write(dt.hour < 12 ? d.am : d.pm);
      case 'h':
        out.write(num(_pad(dt.hour % 12 == 0 ? 12 : dt.hour % 12, n)));
      case 'H':
        out.write(num(_pad(dt.hour, n)));
      case 'K':
        out.write(num(_pad(dt.hour % 12, n)));
      case 'k':
        out.write(num(_pad(dt.hour == 0 ? 24 : dt.hour, n)));
      case 'm':
        out.write(num(_pad(dt.minute, n)));
      case 's':
        out.write(num(_pad(dt.second, n)));
      case 'S':
        out.write(
          num(
            _pad(
              dt.millisecond,
              3,
            ).substring(0, n.clamp(1, 3)).padRight(n, '0'),
          ),
        );
      case 'z':
        out.write(num(_zoneName(d, dt, utc)));
      default:
        throw UnsupportedError('Date pattern field "$t" is not supported');
    }
  }
  return out.toString();
}
