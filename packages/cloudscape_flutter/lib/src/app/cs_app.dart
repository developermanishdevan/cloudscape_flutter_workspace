import 'package:cloudscape_flutter/src/i18n/cs_i18n_provider.dart';
import 'package:cloudscape_flutter/src/i18n/message_ast.dart';
import 'package:cloudscape_flutter/src/icon/cs_icon_provider.dart';
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:cloudscape_flutter/src/theme/typography.dart';
import 'package:flutter/widgets.dart';

/// The root of a Cloudscape app: a [WidgetsApp] (no Material, no Cupertino)
/// with [CsTheme], the component text reset as [DefaultTextStyle], and the
/// layout background.
///
/// Mirrors upstream global-styles + component root resets: Open Sans,
/// body M size and line height, `color-text-body-default`.
class CsApp extends StatelessWidget {
  /// Creates an app that uses a [Navigator].
  const CsApp({
    super.key,
    this.theme = const CsThemeData(),
    this.icons,
    this.componentIcons,
    this.i18nMessages,
    this.i18nLocale,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.backgroundColor,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
  }) : routerConfig = null;

  /// Creates an app that uses a [Router].
  const CsApp.router({
    super.key,
    this.theme = const CsThemeData(),
    this.icons,
    this.componentIcons,
    this.i18nMessages,
    this.i18nLocale,
    required RouterConfig<Object> this.routerConfig,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.backgroundColor,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
  }) : navigatorKey = null,
       home = null,
       routes = const <String, WidgetBuilder>{},
       initialRoute = null,
       onGenerateRoute = null,
       onGenerateInitialRoutes = null,
       onUnknownRoute = null,
       navigatorObservers = const <NavigatorObserver>[];

  /// Theme settings for the whole app.
  final CsThemeData theme;

  /// App-wide icon overrides and custom icons (see [CsIconProvider]).
  final Map<String, Widget?>? icons;

  /// App-wide component icons (see [CsIconProvider]).
  final CsComponentIcons? componentIcons;

  /// Component message sets, e.g. `[csMessagesEn]` or the result of
  /// `csImportMessages`. When set, a [CsI18nProvider] is installed (like
  /// upstream, without one components use only the strings passed to them).
  final List<CsI18nMessages>? i18nMessages;

  /// Locale for [i18nMessages]. Null: the app's [locale].
  final String? i18nLocale;

  /// See [WidgetsApp.navigatorKey].
  final GlobalKey<NavigatorState>? navigatorKey;

  /// See [WidgetsApp.home].
  final Widget? home;

  /// See [WidgetsApp.routes].
  final Map<String, WidgetBuilder> routes;

  /// See [WidgetsApp.initialRoute].
  final String? initialRoute;

  /// See [WidgetsApp.onGenerateRoute].
  final RouteFactory? onGenerateRoute;

  /// See [WidgetsApp.onGenerateInitialRoutes].
  final InitialRouteListFactory? onGenerateInitialRoutes;

  /// See [WidgetsApp.onUnknownRoute].
  final RouteFactory? onUnknownRoute;

  /// See [WidgetsApp.navigatorObservers].
  final List<NavigatorObserver> navigatorObservers;

  /// See [WidgetsApp.routerConfig].
  final RouterConfig<Object>? routerConfig;

  /// See [WidgetsApp.builder]. Runs inside the theme.
  final TransitionBuilder? builder;

  /// See [WidgetsApp.title].
  final String title;

  /// See [WidgetsApp.onGenerateTitle].
  final GenerateAppTitle? onGenerateTitle;

  /// Root background. Defaults to `color-background-layout-main`.
  final Color? backgroundColor;

  /// See [WidgetsApp.locale].
  final Locale? locale;

  /// See [WidgetsApp.localizationsDelegates].
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// See [WidgetsApp.localeListResolutionCallback].
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// See [WidgetsApp.localeResolutionCallback].
  final LocaleResolutionCallback? localeResolutionCallback;

  /// See [WidgetsApp.supportedLocales].
  final Iterable<Locale> supportedLocales;

  /// See [WidgetsApp.debugShowCheckedModeBanner].
  final bool debugShowCheckedModeBanner;

  /// See [WidgetsApp.shortcuts].
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// See [WidgetsApp.actions].
  final Map<Type, Action<Intent>>? actions;

  /// See [WidgetsApp.restorationScopeId].
  final String? restorationScopeId;

  /// The color WidgetsApp uses for the OS task switcher.
  static const Color _taskColor = Color(0xFF006CE0);

  Widget _builder(BuildContext context, Widget? child) => CsTheme(
    data: theme,
    child: Builder(
      builder: (context) {
        final tokens = CsTheme.tokensOf(context);
        final content =
            builder?.call(context, child) ?? child ?? const SizedBox.shrink();
        return ColoredBox(
          color: backgroundColor ?? tokens.colorBackgroundLayoutMain.toColor(),
          child: DefaultTextStyle(
            style: CsTypography(tokens).reset,
            child: CsIconProvider(
              icons: icons,
              componentIcons: componentIcons,
              child: i18nMessages == null
                  ? content
                  : CsI18nProvider(
                      locale: i18nLocale,
                      messages: i18nMessages!,
                      child: content,
                    ),
            ),
          ),
        );
      },
    ),
  );

  static PageRoute<T> _pageRoute<T>(
    RouteSettings settings,
    WidgetBuilder builder,
  ) => PageRouteBuilder<T>(
    settings: settings,
    pageBuilder: (context, _, _) => builder(context),
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );

  @override
  Widget build(BuildContext context) {
    if (routerConfig != null) {
      return WidgetsApp.router(
        routerConfig: routerConfig,
        builder: _builder,
        title: title,
        onGenerateTitle: onGenerateTitle,
        color: _taskColor,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        supportedLocales: supportedLocales,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        shortcuts: shortcuts,
        actions: actions,
        restorationScopeId: restorationScopeId,
      );
    }
    return WidgetsApp(
      navigatorKey: navigatorKey,
      home: home,
      routes: routes,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      navigatorObservers: navigatorObservers,
      pageRouteBuilder: _pageRoute,
      builder: _builder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: _taskColor,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
    );
  }
}
