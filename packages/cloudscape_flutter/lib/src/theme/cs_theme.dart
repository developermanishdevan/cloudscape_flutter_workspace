import 'package:cloudscape_tokens/cloudscape_tokens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Theme settings for [CsTheme].
///
/// Null fields inherit from the enclosing [CsTheme]. At the root, a null
/// [colorMode] follows the platform brightness and a null [motion] follows
/// [MediaQueryData.disableAnimations], like Cloudscape's visual modes.
@immutable
class CsThemeData {
  /// Creates theme settings.
  const CsThemeData({
    this.colorMode,
    this.density,
    this.motion,
    this.themeOverride,
  });

  /// Light or dark. Null: inherit, or follow the platform at the root.
  final CsColorMode? colorMode;

  /// Comfortable or compact. Null: inherit, or comfortable at the root.
  final CsDensity? density;

  /// Normal or disabled motion. Null: inherit, or follow
  /// [MediaQueryData.disableAnimations] at the root.
  final CsMotionMode? motion;

  /// Runtime theme (upstream `applyTheme()`). Null: inherit, or none at
  /// the root.
  final CsThemeOverride? themeOverride;

  /// Returns a copy with some fields replaced.
  CsThemeData copyWith({
    CsColorMode? colorMode,
    CsDensity? density,
    CsMotionMode? motion,
    CsThemeOverride? themeOverride,
  }) => CsThemeData(
    colorMode: colorMode ?? this.colorMode,
    density: density ?? this.density,
    motion: motion ?? this.motion,
    themeOverride: themeOverride ?? this.themeOverride,
  );

  @override
  bool operator ==(Object other) =>
      other is CsThemeData &&
      other.colorMode == colorMode &&
      other.density == density &&
      other.motion == motion &&
      identical(other.themeOverride, themeOverride);

  @override
  int get hashCode =>
      Object.hash(colorMode, density, motion, identityHashCode(themeOverride));
}

/// The resolved theme for a subtree: every token for the current modes and
/// visual contexts, plus the settings that produced them.
@immutable
class CsResolvedTheme {
  const CsResolvedTheme._({
    required this.tokens,
    required this.colorMode,
    required this.density,
    required this.motion,
    required this.contexts,
    required this.resolver,
  });

  /// Every design token for this subtree.
  final CsTokens tokens;

  /// The active color mode.
  final CsColorMode colorMode;

  /// The active density.
  final CsDensity density;

  /// The active motion mode.
  final CsMotionMode motion;

  /// Visual contexts enclosing this subtree, outermost first.
  final List<CsVisualContextId> contexts;

  /// The resolver for the active [CsThemeOverride].
  final CsThemeResolver resolver;

  /// Whether dark mode is active.
  bool get isDark => colorMode == CsColorMode.dark;

  /// Whether motion is disabled (durations are zero).
  bool get motionDisabled => motion == CsMotionMode.disabled;

  @override
  bool operator ==(Object other) =>
      other is CsResolvedTheme &&
      identical(other.tokens, tokens) &&
      listEquals(other.contexts, contexts);

  @override
  int get hashCode =>
      Object.hash(identityHashCode(tokens), Object.hashAll(contexts));
}

class _CsThemeScope extends InheritedTheme {
  const _CsThemeScope({required this.theme, required super.child});

  final CsResolvedTheme theme;

  // An InheritedTheme so overlays inserted above the app (selection
  // handles, text context menus, magnifiers) keep the Cloudscape context.
  @override
  Widget wrap(BuildContext context, Widget child) =>
      _CsThemeScope(theme: theme, child: child);

  @override
  bool updateShouldNotify(_CsThemeScope oldWidget) => oldWidget.theme != theme;
}

/// Provides Cloudscape tokens to a subtree.
///
/// Nest a [CsTheme] to switch modes for part of the tree, like upstream's
/// `.awsui-dark-mode` / `.awsui-compact-mode` classes.
class CsTheme extends StatefulWidget {
  /// Creates a theme scope.
  const CsTheme({
    super.key,
    this.data = const CsThemeData(),
    required this.child,
  });

  /// Theme settings; null fields inherit.
  final CsThemeData data;

  /// The subtree.
  final Widget child;

  /// The resolved theme of the nearest [CsTheme], or null.
  static CsResolvedTheme? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_CsThemeScope>()?.theme;

  /// The resolved theme of the nearest [CsTheme].
  static CsResolvedTheme of(BuildContext context) {
    final theme = maybeOf(context);
    if (theme == null) {
      throw FlutterError.fromParts([
        ErrorSummary(
          'CsTheme.of() called with a context that does not contain a CsTheme.',
        ),
        ErrorHint('Wrap the app in CsApp, or the subtree in CsTheme.'),
        context.describeElement('The context used was'),
      ]);
    }
    return theme;
  }

  /// The tokens of the nearest [CsTheme].
  static CsTokens tokensOf(BuildContext context) => of(context).tokens;

  @override
  State<CsTheme> createState() => _CsThemeState();
}

class _CsThemeState extends State<CsTheme> {
  CsThemeResolver? _ownResolver;
  CsThemeOverride? _ownOverride;

  CsThemeResolver _resolverFor(CsThemeOverride override) {
    if (_ownResolver == null || !identical(_ownOverride, override)) {
      _ownOverride = override;
      _ownResolver = CsThemeResolver(
        override,
        (w) => debugPrint('Cloudscape theme: $w'),
      );
    }
    return _ownResolver!;
  }

  @override
  Widget build(BuildContext context) {
    final parent = CsTheme.maybeOf(context);
    final data = widget.data;
    final colorMode =
        data.colorMode ??
        parent?.colorMode ??
        (MediaQuery.maybePlatformBrightnessOf(context) == Brightness.dark
            ? CsColorMode.dark
            : CsColorMode.light);
    final density = data.density ?? parent?.density ?? CsDensity.comfortable;
    final motion =
        data.motion ??
        parent?.motion ??
        ((MediaQuery.maybeDisableAnimationsOf(context) ?? false)
            ? CsMotionMode.disabled
            : CsMotionMode.normal);
    final resolver = data.themeOverride != null
        ? _resolverFor(data.themeOverride!)
        : parent?.resolver ?? _resolverFor(const CsThemeOverride());
    final contexts = parent?.contexts ?? const <CsVisualContextId>[];
    final tokens = resolver.resolve(
      colorMode: colorMode,
      density: density,
      motion: motion,
      contexts: CsThemeResolver.contextStack(contexts),
    );
    return _CsThemeScope(
      theme: CsResolvedTheme._(
        tokens: tokens,
        colorMode: colorMode,
        density: density,
        motion: motion,
        contexts: contexts,
        resolver: resolver,
      ),
      child: widget.child,
    );
  }
}

/// Applies an upstream visual context (top navigation, header, flashbar,
/// alert, compact table, ...) to a subtree.
///
/// Contexts nest like the upstream CSS: an alert inside a header also gets
/// the `alert-header` context.
class CsVisualContext extends StatelessWidget {
  /// Creates a visual context scope.
  const CsVisualContext({super.key, required this.id, required this.child});

  /// The context to apply.
  final CsVisualContextId id;

  /// The subtree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final parent = CsTheme.of(context);
    final contexts = [...parent.contexts, id];
    final tokens = parent.resolver.resolve(
      colorMode: parent.colorMode,
      density: parent.density,
      motion: parent.motion,
      contexts: CsThemeResolver.contextStack(contexts),
    );
    return _CsThemeScope(
      theme: CsResolvedTheme._(
        tokens: tokens,
        colorMode: parent.colorMode,
        density: parent.density,
        motion: parent.motion,
        contexts: contexts,
        resolver: parent.resolver,
      ),
      child: child,
    );
  }
}

/// Shorthand for reading the theme.
extension CsThemeContext on BuildContext {
  /// The tokens of the nearest [CsTheme].
  CsTokens get csTokens => CsTheme.tokensOf(this);

  /// The resolved theme of the nearest [CsTheme].
  CsResolvedTheme get csTheme => CsTheme.of(this);
}
