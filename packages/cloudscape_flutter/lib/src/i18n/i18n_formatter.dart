// Port of upstream `i18n/utils/{i18n-formatter,locales,messages}.js`.
import 'package:cloudscape_flutter/src/i18n/icu_parser.dart';
import 'package:cloudscape_flutter/src/i18n/message_ast.dart';
import 'package:cloudscape_flutter/src/i18n/message_format.dart';
import 'package:flutter/foundation.dart';

/// The namespace of Cloudscape's own component messages.
const String csI18nNamespace = 'cloudscape-design-components';

/// Upstream `getMatchableLocales`: `en-gb` → `[en-gb, en]`.
List<String> csMatchableLocales(String tag) {
  final parts = tag.split('-');
  if (parts.length == 1) return [tag];
  return [for (var i = parts.length; i > 0; i--) parts.sublist(0, i).join('-')];
}

/// Upstream `normalizeMessages`: merges sources (later wins) with
/// lowercased locales.
CsI18nMessages csNormalizeMessages(Iterable<CsI18nMessages> sources) {
  final result = <String, Map<String, Map<String, Map<String, Object>>>>{};
  for (final messages in sources) {
    for (final ns in messages.entries) {
      final byLocale = result[ns.key] ??= {};
      for (final loc in ns.value.entries) {
        final byComponent = byLocale[loc.key.toLowerCase()] ??= {};
        for (final comp in loc.value.entries) {
          (byComponent[comp.key] ??= {}).addAll(comp.value);
        }
      }
    }
  }
  return result;
}

/// The value passed to a `customHandler`: formats the resolved message.
/// Both methods catch formatting errors (warning once), like upstream.
class CsI18nBoundMessage {
  CsI18nBoundMessage._(this._format, this._cacheKey, this._locale);

  final CsMessageFormat _format;
  final String _cacheKey;
  final String _locale;

  /// Formats to a string; returns '' on error.
  String format([Map<String, Object?> args = const {}]) {
    try {
      return _format.format(args);
    } on Object catch (e) {
      _warnOnce(
        'Failed to format message "$_cacheKey" for locale "$_locale": $e',
      );
      return '';
    }
  }

  /// Formats to rich parts; returns [] on error.
  List<Object> formatToParts([Map<String, Object?> args = const {}]) {
    try {
      return _format.formatToParts(args);
    } on Object catch (e) {
      _warnOnce(
        'Failed to format message "$_cacheKey" for locale "$_locale": $e',
      );
      return const [];
    }
  }
}

final Set<String> _warned = {};

void _warnOnce(String message) {
  if (kDebugMode && _warned.add(message)) {
    debugPrint('[AwsUi] [I18nProvider] $message');
  }
}

/// Upstream `I18nFormatter`: resolves `namespace.component.key` for a
/// locale, widening the locale (`en-gb` → `en`), caching formatters.
class CsI18nFormatter {
  /// Creates a formatter. [messages] must already be normalized.
  CsI18nFormatter(String locale, this.messages) : locale = locale.toLowerCase();

  /// Lowercased locale.
  final String locale;

  /// Normalized messages.
  final CsI18nMessages messages;

  final Map<String, CsMessageFormat?> _cache = {};

  CsMessageFormat? _resolve(String namespace, String component, String key) {
    final cacheKey = '$namespace.$component.$key';
    if (_cache.containsKey(cacheKey)) return _cache[cacheKey];
    Object? message;
    for (final l in csMatchableLocales(locale)) {
      message = messages[namespace]?[l]?[component]?[key];
      if (message != null) break;
    }
    if (message == null) return null; // not cached: messages may arrive later
    try {
      final nodes = message is String
          ? parseIcuMessage(message)
          : message is List<CsMessageNode>
          ? message
          : throw FormatException(
              'Unsupported message type ${message.runtimeType}',
            );
      return _cache[cacheKey] = CsMessageFormat(nodes, locale);
    } on Object catch (e) {
      _warnOnce('Malformed message "$cacheKey" for locale "$locale": $e');
      return _cache[cacheKey] = null;
    }
  }

  /// Upstream `format(namespace, component, key, provided)` without a
  /// custom handler: [provided] wins when not null; otherwise the message is
  /// formatted without arguments, or [provided] is returned on any failure.
  String? format(
    String namespace,
    String component,
    String key,
    String? provided,
  ) {
    if (provided != null) return provided;
    final f = _resolve(namespace, component, key);
    if (f == null) return provided;
    try {
      return f.format();
    } on Object catch (e) {
      _warnOnce(
        'Failed to format message "$namespace.$component.$key" for locale "$locale": $e',
      );
      return provided;
    }
  }

  /// Upstream `format(..., customHandler)`: [provided] wins when not null;
  /// otherwise [customHandler] receives the bound message (for arguments and
  /// rich text). Returns [provided] when no message exists.
  T? formatWith<T>(
    String namespace,
    String component,
    String key,
    T? provided,
    T Function(CsI18nBoundMessage message) customHandler,
  ) {
    if (provided != null) return provided;
    final f = _resolve(namespace, component, key);
    if (f == null) return provided;
    return customHandler(
      CsI18nBoundMessage._(f, '$namespace.$component.$key', locale),
    );
  }
}
