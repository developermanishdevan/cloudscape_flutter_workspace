// CLDR plural rules (cardinal + ordinal), evaluated like the browser's
// `Intl.PluralRules` that upstream (formatjs) uses.
import 'package:cloudscape_flutter/src/i18n/generated/plural_rules.g.dart';

/// CLDR plural operands of a decimal number
/// (https://unicode.org/reports/tr35/tr35-numbers.html#Operands).
class CsPluralOperands {
  CsPluralOperands._(this.n, this.i, this.v, this.w, this.f, this.t, this.e);

  /// Parses a plain or compact decimal like `1.50`, `-3`, `1.2c6`, `1.2e3`.
  factory CsPluralOperands.parse(String source) {
    var s = source.trim();
    if (s.startsWith('-')) s = s.substring(1);
    var exponent = 0;
    final exp = RegExp(r'^(.*)[ce](\d+)$').firstMatch(s);
    if (exp != null) {
      s = exp[1]!;
      exponent = int.parse(exp[2]!);
    }
    if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(s)) {
      throw FormatException('Not a plural operand number: $source');
    }
    var intPart = s.split('.').first;
    var fracPart = s.contains('.') ? s.split('.').last : '';
    // Apply the compact exponent by moving the decimal point.
    if (exponent > 0) {
      final shift = exponent.clamp(0, fracPart.length);
      intPart += fracPart.substring(0, shift);
      fracPart = fracPart.substring(shift);
      intPart += '0' * (exponent - shift);
    }
    intPart = intPart.replaceFirst(RegExp(r'^0+(?=\d)'), '');
    final trimmed = fracPart.replaceFirst(RegExp(r'0+$'), '');
    final i = BigInt.parse(intPart);
    final f = fracPart.isEmpty ? BigInt.zero : BigInt.parse(fracPart);
    final t = trimmed.isEmpty ? BigInt.zero : BigInt.parse(trimmed);
    final n = double.parse(fracPart.isEmpty ? intPart : '$intPart.$fracPart');
    return CsPluralOperands._(
      n,
      i,
      fracPart.length,
      trimmed.length,
      f,
      t,
      exponent,
    );
  }

  /// Operands of [value] as `Intl.PluralRules` sees it: at most 3 fraction
  /// digits (its default `maximumFractionDigits`), no trailing zeros.
  factory CsPluralOperands.ofNum(num value) =>
      CsPluralOperands.parse(csRoundDecimalString(value.abs(), 3));

  /// Absolute value.
  final double n;

  /// Integer digits.
  final BigInt i;

  /// Visible fraction digit count, with trailing zeros.
  final int v;

  /// Visible fraction digit count, without trailing zeros.
  final int w;

  /// Visible fraction digits, with trailing zeros.
  final BigInt f;

  /// Visible fraction digits, without trailing zeros.
  final BigInt t;

  /// Compact decimal exponent (`c`/`e`).
  final int e;

  num _get(String operand) => switch (operand) {
    'n' => n,
    'i' => i.toDouble(),
    'v' => v,
    'w' => w,
    'f' => f.toDouble(),
    't' => t.toDouble(),
    'e' || 'c' => e,
    _ => throw FormatException('Unknown plural operand "$operand"'),
  };
}

/// The shortest round-trip decimal of [value] (like JavaScript), rounded
/// half away from zero to at most [maxFraction] digits, without trailing
/// zeros — what `Intl` formatters see with `maximumFractionDigits`.
String csRoundDecimalString(num value, int maxFraction) {
  if (value is int) return '$value';
  if (!value.isFinite) {
    throw ArgumentError.value(value, 'value', 'Must be finite');
  }
  final negative = value < 0;
  var s = value.abs().toString();
  // Expand exponent notation (1e+21, 1.5e-7) into plain digits.
  final m = RegExp(r'^(\d+)(?:\.(\d+))?e([+-]\d+)$').firstMatch(s);
  if (m != null) {
    final digits = '${m[1]}${m[2] ?? ''}';
    final point = m[1]!.length + int.parse(m[3]!);
    s = point <= 0
        ? '0.${'0' * -point}$digits'
        : point >= digits.length
        ? '$digits${'0' * (point - digits.length)}'
        : '${digits.substring(0, point)}.${digits.substring(point)}';
  }
  var intPart = s.split('.').first;
  var frac = s.contains('.') ? s.split('.').last : '';
  if (frac.length > maxFraction) {
    final roundUp = frac.codeUnitAt(maxFraction) >= 0x35; // '5'
    frac = frac.substring(0, maxFraction);
    if (roundUp) {
      final joined = BigInt.parse('$intPart$frac') + BigInt.one;
      final str = joined.toString().padLeft(intPart.length + frac.length, '0');
      intPart = str.substring(0, str.length - frac.length);
      frac = str.substring(str.length - frac.length);
      if (intPart.isEmpty) intPart = '0';
    }
  }
  frac = frac.replaceFirst(RegExp(r'0+$'), '');
  final out = frac.isEmpty ? intPart : '$intPart.$frac';
  return negative && out != '0' ? '-$out' : out;
}

typedef _Condition = bool Function(CsPluralOperands o);

/// Parses a CLDR plural rule condition into a predicate.
_Condition _parseCondition(String rule) {
  final tokens = RegExp(r'\.\.|!=|[=%,]|[a-z]+|\d+(\.\d+)?')
      .allMatches(rule)
      .map((m) => m[0]!)
      .toList();
  final rebuilt = tokens.join();
  if (rebuilt != rule.replaceAll(' ', '')) {
    throw FormatException('Unsupported plural rule "$rule"');
  }
  var pos = 0;
  String? peek() => pos < tokens.length ? tokens[pos] : null;
  String next() => pos < tokens.length
      ? tokens[pos++]
      : throw FormatException('Unexpected end of "$rule"');

  _Condition relation() {
    final operand = next();
    num? mod;
    if (peek() == '%') {
      next();
      mod = num.parse(next());
    }
    final op = next();
    if (op != '=' && op != '!=') {
      throw FormatException('Expected = or != in "$rule"');
    }
    final ranges = <(num, num)>[];
    do {
      if (ranges.isNotEmpty) next(); // ','
      final lo = num.parse(next());
      var hi = lo;
      if (peek() == '..') {
        next();
        hi = num.parse(next());
      }
      ranges.add((lo, hi));
    } while (peek() == ',');
    final negate = op == '!=';
    return (o) {
      var x = o._get(operand);
      if (mod != null) x = x % mod;
      // Ranges are integer sets: a non-integer value matches none.
      final inRange = ranges.any(
        (r) => x == x.truncate() && x >= r.$1 && x <= r.$2,
      );
      return negate ? !inRange : inRange;
    };
  }

  _Condition and() {
    final parts = [relation()];
    while (peek() == 'and') {
      next();
      parts.add(relation());
    }
    return (o) => parts.every((p) => p(o));
  }

  final ors = [and()];
  while (peek() == 'or') {
    next();
    ors.add(and());
  }
  if (pos != tokens.length) throw FormatException('Trailing tokens in "$rule"');
  return (o) => ors.any((p) => p(o));
}

final Map<String, Map<String, Map<String, String>>> _lowercased = {};

Map<String, Map<String, String>> _table(bool ordinal) =>
    _lowercased[ordinal ? 'o' : 'c'] ??= {
      for (final e
          in (ordinal ? csOrdinalPluralRules : csCardinalPluralRules).entries)
        e.key.toLowerCase(): e.value,
    };

final Map<String, List<(String, _Condition)>> _compiled = {};

/// The CLDR rule set used for [locale]: widened like `Intl` locale
/// matching (`pt-BR` → `pt`), falling back to `en` (the usual host default).
String csPluralRulesLocale(String locale, {bool ordinal = false}) {
  final table = _table(ordinal);
  final tag = locale.toLowerCase().replaceAll('_', '-');
  final parts = tag.split('-');
  for (var i = parts.length; i > 0; i--) {
    final candidate = parts.sublist(0, i).join('-');
    if (table.containsKey(candidate)) return candidate;
  }
  return 'en';
}

/// CLDR plural category (`zero`, `one`, `two`, `few`, `many`, `other`) of
/// [operands] in [locale].
String csPluralCategoryOf(
  CsPluralOperands operands,
  String locale, {
  bool ordinal = false,
}) {
  final key = csPluralRulesLocale(locale, ordinal: ordinal);
  final rules = _compiled['${ordinal ? 'o' : 'c'}:$key'] ??= [
    for (final r in _table(ordinal)[key]!.entries)
      (r.key, _parseCondition(r.value)),
  ];
  for (final (category, condition) in rules) {
    if (condition(operands)) return category;
  }
  return 'other';
}

/// CLDR plural category of [value] in [locale], like
/// `new Intl.PluralRules(locale, {type}).select(value)`.
String csPluralCategory(num value, String locale, {bool ordinal = false}) =>
    csPluralCategoryOf(CsPluralOperands.ofNum(value), locale, ordinal: ordinal);
