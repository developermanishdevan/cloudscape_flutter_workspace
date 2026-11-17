import 'package:cloudscape_flutter/src/i18n/cldr_dates.dart';
import 'package:cloudscape_flutter/src/i18n/i18n_formatter.dart';
import 'package:cloudscape_flutter/src/i18n/message_ast.dart';
import 'package:flutter/widgets.dart';

class _CsI18nMessagesScope extends InheritedTheme {
  const _CsI18nMessagesScope({required this.messages, required super.child});

  final CsI18nMessages messages;

  // An InheritedTheme so overlays inserted above the app (selection
  // handles, text context menus, magnifiers) keep the Cloudscape context.
  @override
  Widget wrap(BuildContext context, Widget child) =>
      _CsI18nMessagesScope(messages: messages, child: child);

  @override
  bool updateShouldNotify(_CsI18nMessagesScope old) =>
      !identical(old.messages, messages);
}

class _CsI18nScope extends InheritedTheme {
  const _CsI18nScope({required this.formatter, required super.child});

  final CsI18nFormatter formatter;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      _CsI18nScope(formatter: formatter, child: child);

  @override
  bool updateShouldNotify(_CsI18nScope old) =>
      !identical(old.formatter, formatter);
}

/// Provides translated component strings (upstream `I18nProvider`).
///
/// [messages] are merged with those of enclosing providers (later wins).
/// The locale is [locale], else the app locale from [Localizations], else
/// `en`; it is matched case-insensitively and widened (`en-GB` → `en`).
class CsI18nProvider extends StatefulWidget {
  /// Creates an i18n provider.
  const CsI18nProvider({
    super.key,
    this.locale,
    required this.messages,
    required this.child,
  });

  /// BCP 47 locale, e.g. `en-GB`. Null: use the app locale.
  final String? locale;

  /// Message sets, e.g. `[csMessagesEn]` or the result of
  /// [csImportMessages].
  final List<CsI18nMessages> messages;

  /// The subtree.
  final Widget child;

  /// Loads the CLDR date data for [locale] ahead of time (it is a deferred
  /// library for locales outside Cloudscape's message set). Optional: the
  /// provider loads it itself and rebuilds when it arrives.
  static Future<void> preload(String locale) => csLoadCldrDateData(locale);

  @override
  State<CsI18nProvider> createState() => _CsI18nProviderState();
}

class _CsI18nProviderState extends State<CsI18nProvider> {
  CsI18nMessages? _parent;
  List<CsI18nMessages>? _own;
  CsI18nMessages? _merged;
  CsI18nFormatter? _formatter;

  @override
  Widget build(BuildContext context) {
    final parent =
        context
            .dependOnInheritedWidgetOfExactType<_CsI18nMessagesScope>()
            ?.messages ??
        const {};
    if (!identical(parent, _parent) || !identical(widget.messages, _own)) {
      _parent = parent;
      _own = widget.messages;
      _merged = csNormalizeMessages([parent, ...widget.messages]);
      _formatter = null;
    }
    final locale =
        (widget.locale ??
                Localizations.maybeLocaleOf(context)?.toLanguageTag() ??
                'en')
            .toLowerCase();
    if (_formatter == null || _formatter!.locale != locale) {
      _formatter = CsI18nFormatter(locale, _merged!);
      if (!csCldrDateDataReady(locale)) {
        // Dates format in English until the locale's data arrives; then a
        // new formatter rebuilds every dependent.
        csLoadCldrDateData(locale).then((_) {
          if (mounted && _formatter?.locale == locale) {
            setState(() => _formatter = null);
          }
        });
      }
    }
    return _CsI18nMessagesScope(
      messages: _merged!,
      child: _CsI18nScope(formatter: _formatter!, child: widget.child),
    );
  }
}

/// String lookup for one component, bound to the nearest [CsI18nProvider]
/// (upstream `useInternalI18n` / `useCustomI18n`).
class CsI18n {
  const CsI18n._(this._lookup, this.namespace, this.component);

  final CsI18nFormatter? _lookup;

  /// Message namespace.
  final String namespace;

  /// Component name, e.g. `alert`.
  final String component;

  /// Cloudscape component strings (upstream `useInternalI18n`).
  static CsI18n of(BuildContext context, String component) =>
      custom(context, csI18nNamespace, component);

  /// Strings of another namespace (upstream `useCustomI18n`).
  static CsI18n custom(
    BuildContext context,
    String namespace,
    String component,
  ) => CsI18n._(
    context.dependOnInheritedWidgetOfExactType<_CsI18nScope>()?.formatter,
    namespace,
    component,
  );

  /// The provider's lowercased locale, or null without a provider
  /// (upstream `useLocale`).
  static String? localeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_CsI18nScope>()
      ?.formatter
      .locale;

  /// [provided] when not null, else the translated message for [key].
  String? call(String key, [String? provided]) => _lookup == null
      ? provided
      : _lookup.format(namespace, component, key, provided);

  /// [provided] when not null, else [handler] applied to the message (for
  /// messages with arguments or rich text). Null when there is no message.
  T? withHandler<T>(
    String key,
    T? provided,
    T Function(CsI18nBoundMessage message) handler,
  ) => _lookup == null
      ? provided
      : _lookup.formatWith(namespace, component, key, provided, handler);
}
