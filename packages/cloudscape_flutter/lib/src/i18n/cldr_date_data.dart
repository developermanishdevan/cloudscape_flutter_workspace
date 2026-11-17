// CLDR 47 date and number data for one locale (generated: cldr_data.g.dart
// and the deferred libraries in generated/dates/).

/// Date/time data for one CLDR locale.
final class CsCldrDateData {
  /// Creates the data.
  const CsCldrDateData({
    required this.id,
    required this.calendar,
    required this.yearOffset,
    required this.months,
    required this.days,
    required this.quarters,
    required this.am,
    required this.pm,
    required this.eras,
    required this.availableFormats,
    required this.timeFormats,
    required this.dateFormats,
    required this.dateSkeletons,
    required this.gmtFormat,
    required this.gmtZeroFormat,
    required this.hourFormat,
  });

  /// CLDR locale id, e.g. `zh-Hant`.
  final String id;

  /// Calendar used for dates: `gregorian` or `buddhist`.
  final String calendar;

  /// Years added to the Gregorian year (543 for the Buddhist era).
  final int yearOffset;

  /// `format-abbreviated`, `format-wide`, `format-narrow`,
  /// `stand-alone-abbreviated`, ... → 12 month names.
  final Map<String, List<String>> months;

  /// Same keys as [months] → 7 weekday names, Sunday first.
  final Map<String, List<String>> days;

  /// Same keys as [months] → 4 quarter names.
  final Map<String, List<String>> quarters;

  /// AM marker (`a`).
  final String am;

  /// PM marker (`a`).
  final String pm;

  /// `abbreviated` / `wide` / `narrow` → era index → name.
  final Map<String, Map<int, String>> eras;

  /// Skeleton → pattern for the date calendar (Buddhist `yyyy…` keys are
  /// normalized to `y…`).
  final Map<String, String> availableFormats;

  /// `short` / `medium` / `long` / `full` time patterns (Gregorian).
  final Map<String, String> timeFormats;

  /// `short` / `medium` / `long` / `full` date patterns (date calendar).
  final Map<String, String> dateFormats;

  /// CLDR skeletons of [dateFormats].
  final Map<String, String> dateSkeletons;

  /// Localized GMT format, e.g. `GMT{0}`.
  final String gmtFormat;

  /// Localized GMT format for zero offset, e.g. `GMT`.
  final String gmtZeroFormat;

  /// Offset format, e.g. `+HH:mm;-HH:mm`.
  final String hourFormat;
}

/// Number formatting data for one CLDR locale (its default numbering
/// system).
final class CsCldrNumberData {
  /// Creates the data.
  const CsCldrNumberData({
    required this.minimumGroupingDigits,
    required this.numberingSystem,
    required this.digits,
    required this.decimal,
    required this.group,
    required this.percentSign,
    required this.minusSign,
    required this.plusSign,
    required this.decimalPattern,
    required this.percentPattern,
  });

  /// CLDR `minimumGroupingDigits`.
  final int minimumGroupingDigits;

  /// Default numbering system, e.g. `latn`, `arab`, `deva`.
  final String numberingSystem;

  /// The ten digits of [numberingSystem]; empty for ASCII (`latn`).
  final String digits;

  /// Decimal separator.
  final String decimal;

  /// Grouping separator.
  final String group;

  /// Percent sign (may include bidi marks).
  final String percentSign;

  /// Minus sign (may include bidi marks).
  final String minusSign;

  /// Plus sign.
  final String plusSign;

  /// Standard decimal pattern, e.g. `#,##0.###` or `#,##,##0.###`.
  final String decimalPattern;

  /// Standard percent pattern, e.g. `#,##0%` or `#,##0 %`.
  final String percentPattern;
}
