// Formats CsMessageNode lists like formatjs `IntlMessageFormat`.
import 'package:cloudscape_flutter/src/i18n/cldr_dates.dart';
import 'package:cloudscape_flutter/src/i18n/cldr_numbers.dart';
import 'package:cloudscape_flutter/src/i18n/generated/cldr_data.g.dart';
import 'package:cloudscape_flutter/src/i18n/message_ast.dart';
import 'package:cloudscape_flutter/src/i18n/plural_rules.dart';
import 'package:flutter/foundation.dart';

/// A rich-text tag handler: receives the formatted children, returns a
/// string, any object (e.g. a widget), or a list of those.
typedef CsTagHandler = Object Function(List<Object> chunks);

/// Thrown when a message needs an argument that was not provided.
class CsMissingValueError extends Error {
  /// Creates the error.
  CsMissingValueError(this.name);

  /// The missing argument.
  final String name;

  @override
  String toString() =>
      'The intl string context variable "$name" was not provided';
}

/// Thrown when an argument has the wrong type or no option matches.
class CsInvalidValueError extends Error {
  /// Creates the error.
  CsInvalidValueError(this.message);

  /// Details.
  final String message;

  @override
  String toString() => message;
}

/// JavaScript `String(value)` for numbers.
String csJsNumberString(num v) {
  if (v is int) return '$v';
  if (v.isNaN) return 'NaN';
  if (v.isInfinite) return v > 0 ? 'Infinity' : '-Infinity';
  if (v == v.truncateToDouble() && v.abs() < 1e21) return v.toInt().toString();
  return v.toString();
}

String _formatNumber(num n, String locale, [String? style]) => switch (style) {
  null ||
  '' ||
  'integer' ||
  'percent' => csFormatNumber(n, locale, style: style),
  // formatjs: a style name it does not know yields the default formatter.
  _ when !style.startsWith('::') => csFormatNumber(n, locale),
  _ => throw UnsupportedError('Number skeleton "$style" is not supported'),
};

DateTime _dateArg(Object? v, String name) {
  final DateTime dt;
  if (v is DateTime) {
    dt = v;
  } else if (v is num) {
    dt = DateTime.fromMillisecondsSinceEpoch(v.round(), isUtc: true);
  } else {
    throw CsInvalidValueError(
      '"$name" must be a DateTime or epoch milliseconds',
    );
  }
  return CsMessageFormat.debugFormatDatesInUtc ? dt.toUtc() : dt.toLocal();
}

String _formatDate(
  DateTime dt,
  CsFormattedKind kind,
  String? style,
  String locale,
) {
  // Locales whose deferred data is not loaded yet (CsI18nProvider loads it
  // and rebuilds) format with English for that first frame.
  final cldr = csCldrDateDataFor(locale) ?? csCldrDateData['en']!;
  final pattern = csCldrPattern(
    cldr,
    time: kind == CsFormattedKind.time,
    style: style,
  );
  if (pattern == null) {
    throw UnsupportedError('Date style "$style" is not supported for $locale');
  }
  return csFormatCldrPattern(
    pattern,
    dt,
    cldr,
    utc: dt.isUtc,
    digits: csCldrNumberDataFor(locale).digits,
  );
}

/// A compiled message bound to a locale (upstream `IntlMessageFormat`).
class CsMessageFormat {
  /// Creates a formatter for [message] in [locale].
  const CsMessageFormat(this.message, this.locale);

  /// Formats dates in UTC instead of local time (tests only; browsers use
  /// the local time zone).
  @visibleForTesting
  static bool debugFormatDatesInUtc = false;

  /// The message.
  final List<CsMessageNode> message;

  /// The locale (BCP 47, any case).
  final String locale;

  /// Formats to a string. Throws if a tag handler returns non-strings.
  String format([Map<String, Object?> args = const {}]) {
    final parts = formatToParts(args);
    if (parts.every((p) => p is String)) return parts.join();
    throw CsInvalidValueError('Message has rich parts; use formatToParts');
  }

  /// Formats to parts: strings, and whatever tag handlers / object
  /// arguments return. Adjacent strings are merged.
  List<Object> formatToParts([Map<String, Object?> args = const {}]) {
    final out = <Object>[];
    _format(message, args, null, out);
    final merged = <Object>[];
    for (final p in out) {
      if (p is String && merged.isNotEmpty && merged.last is String) {
        merged[merged.length - 1] = '${merged.last}$p';
      } else {
        merged.add(p);
      }
    }
    return merged;
  }

  void _format(
    List<CsMessageNode> nodes,
    Map<String, Object?> args,
    num? pluralValue,
    List<Object> out,
  ) {
    for (final node in nodes) {
      switch (node) {
        case CsLiteralNode(:final value):
          out.add(value);
        case CsPoundNode():
          if (pluralValue != null) out.add(_formatNumber(pluralValue, locale));
        case CsArgumentNode(:final name):
          if (!args.containsKey(name)) throw CsMissingValueError(name);
          final v = args[name];
          if (v is String) {
            out.add(v);
          } else if (v is num) {
            out.add(csJsNumberString(v));
          } else if (v == null || v == false) {
            out.add('');
          } else {
            out.add(v);
          }
        case CsFormattedNode(:final kind, :final name, :final style):
          if (!args.containsKey(name)) throw CsMissingValueError(name);
          final v = args[name];
          switch (kind) {
            case CsFormattedKind.number:
              if (v is! num) {
                throw CsInvalidValueError('"$name" must be a number');
              }
              out.add(_formatNumber(v, locale, style));
            case CsFormattedKind.date || CsFormattedKind.time:
              out.add(_formatDate(_dateArg(v, name), kind, style, locale));
          }
        case CsSelectNode(:final name, :final options):
          if (!args.containsKey(name)) throw CsMissingValueError(name);
          final v = args[name];
          final key = v is num ? csJsNumberString(v) : '$v';
          final opt = options[key] ?? options['other'];
          if (opt == null) {
            throw CsInvalidValueError('No option for "$key" in select "$name"');
          }
          _format(opt, args, pluralValue, out);
        case CsPluralNode(
          :final name,
          :final options,
          :final offset,
          :final ordinal,
        ):
          if (!args.containsKey(name)) throw CsMissingValueError(name);
          final v = args[name];
          if (v is! num) {
            throw CsInvalidValueError('"$name" must be a number for plural');
          }
          var opt = options['=${csJsNumberString(v)}'];
          opt ??=
              options[csPluralCategory(v - offset, locale, ordinal: ordinal)] ??
              options['other'];
          if (opt == null) {
            throw CsInvalidValueError('No option for $v in plural "$name"');
          }
          _format(opt, args, v - offset, out);
        case CsTagNode(:final name, :final children):
          final handler = args[name];
          if (handler is! CsTagHandler) {
            throw CsInvalidValueError(
              'Tag <$name> needs a CsTagHandler argument "$name"',
            );
          }
          final inner = <Object>[];
          _format(children, args, pluralValue, inner);
          final chunks = handler(inner);
          if (chunks is List) {
            out.addAll(chunks.cast<Object>());
          } else {
            out.add(chunks);
          }
      }
    }
  }
}
