// CLDR number formatting with browser `Intl.NumberFormat` defaults (what
// formatjs uses for `{n, number}`, `{n, number, integer}` and
// `{n, number, percent}`): the locale's default numbering system, its
// symbols and grouping (incl. Indian `#,##,##0` and minimumGroupingDigits),
// half-expand rounding.
import 'package:cloudscape_flutter/src/i18n/cldr_date_data.dart';
import 'package:cloudscape_flutter/src/i18n/cldr_dates.dart';
import 'package:cloudscape_flutter/src/i18n/plural_rules.dart';

/// A parsed CLDR number pattern.
typedef CsNumberPattern = ({
  String prefix,
  String suffix,
  int primaryGrouping,
  int secondaryGrouping,
  bool grouping,
});

final _numberPart = RegExp(r'[#0,.@]+');

/// Parses the positive subpattern of a CLDR number [pattern].
CsNumberPattern csParseNumberPattern(String pattern) {
  final positive = pattern.split(';').first;
  final m = _numberPart.firstMatch(positive)!;
  final integer = m[0]!.split('.').first;
  final groups = integer.split(',');
  final primary = groups.length > 1 ? groups.last.length : 0;
  final secondary = groups.length > 2
      ? groups[groups.length - 2].length
      : primary;
  return (
    prefix: positive.substring(0, m.start),
    suffix: positive.substring(m.end),
    primaryGrouping: primary,
    secondaryGrouping: secondary,
    grouping: primary > 0,
  );
}

String _group(String digits, CsNumberPattern p, CsCldrNumberData d) {
  if (!p.grouping ||
      digits.length < p.primaryGrouping + d.minimumGroupingDigits) {
    return digits;
  }
  final parts = <String>[];
  var end = digits.length;
  var size = p.primaryGrouping;
  while (end > size) {
    parts.insert(0, digits.substring(end - size, end));
    end -= size;
    size = p.secondaryGrouping;
  }
  parts.insert(0, digits.substring(0, end));
  return parts.join(d.group);
}

String _affix(String a, CsCldrNumberData d) =>
    a.replaceAll('%', d.percentSign).replaceAll("'", '');

/// Formats [n] like `Intl.NumberFormat(locale, options)` for formatjs
/// number styles: null (decimal, up to 3 fraction digits), `integer`
/// (no fraction digits) or `percent` (×100, no fraction digits).
String csFormatCldrNumber(num n, CsCldrNumberData d, {String? style}) {
  final percent = style == 'percent';
  final pattern = csParseNumberPattern(
    percent ? d.percentPattern : d.decimalPattern,
  );
  if (n.isNaN) return 'NaN';
  final negative = n.isNegative;
  String body;
  if (n.isInfinite) {
    body = '∞';
  } else {
    final value = percent ? n.abs() * 100 : n.abs();
    final rounded = csRoundDecimalString(
      value,
      style == 'integer' || percent ? 0 : 3,
    );
    final parts = rounded.split('.');
    body = _group(parts.first, pattern, d);
    if (parts.length > 1) body = '$body${d.decimal}${parts[1]}';
    body = csLocalizeDigits(body, d.digits);
  }
  final out = '${_affix(pattern.prefix, d)}$body${_affix(pattern.suffix, d)}';
  return negative ? '${d.minusSign}$out' : out;
}

/// Formats [n] for [locale] (see [csFormatCldrNumber]).
String csFormatNumber(num n, String locale, {String? style}) =>
    csFormatCldrNumber(n, csCldrNumberDataFor(locale), style: style);
