// Port of upstream `applyTheme()` semantics (theming-runtime 1.0.139:
// validateOverride, merge, resolveTheme, resolveContext).
//
// - Overrides of tokens that are not themeable are ignored with a warning.
// - A single value applies to every state of the token's mode; a
//   [CsModeValues] only replaces the states it names.
// - Every token whose reference chain passes through an overridden token is
//   re-resolved.
// - Inside a visual context the precedence is: theme context override >
//   base context > theme override > base theme.
// - In contexts with a `defaultMode` (top navigation, header), palette
//   tokens resolve in that mode.
// - Palettes (`referenceTokens.color`) are generated from seeds with HCT.
import 'package:cloudscape_tokens/src/css_parse.dart';
import 'package:cloudscape_tokens/src/generated/cs_color_mode_tokens.g.dart';
import 'package:cloudscape_tokens/src/generated/cs_density_mode_tokens.g.dart';
import 'package:cloudscape_tokens/src/generated/cs_motion_mode_tokens.g.dart';
import 'package:cloudscape_tokens/src/generated/cs_static_tokens.g.dart';
import 'package:cloudscape_tokens/src/generated/cs_tokens.g.dart';
import 'package:cloudscape_tokens/src/generated/token_info.g.dart';
import 'package:cloudscape_tokens/src/generated/visual_contexts.g.dart';
import 'package:cloudscape_tokens/src/palette.dart';
import 'package:cloudscape_tokens/src/values.dart';

/// Per-state values for one token, like upstream `{ light: ..., dark: ... }`.
///
/// State names: `light`, `dark`, `comfortable`, `compact`, `default`,
/// `disabled`. Each value is a typed token value (e.g. [CsColor]), a CSS
/// string (`'#ff0000'`, `'4px'`), or a reference (`'{colorPrimary600}'`).
final class CsModeValues {
  /// Creates mode values from upstream state names.
  const CsModeValues(this.byState);

  /// Values for the color modes. Omitted modes keep their current value.
  factory CsModeValues.color({Object? light, Object? dark}) =>
      CsModeValues({'light': ?light, 'dark': ?dark});

  /// Values for the densities. Omitted densities keep their current value.
  factory CsModeValues.density({Object? comfortable, Object? compact}) =>
      CsModeValues({'comfortable': ?comfortable, 'compact': ?compact});

  /// Values for the motion modes. Omitted modes keep their current value.
  factory CsModeValues.motion({Object? normal, Object? disabled}) =>
      CsModeValues({'default': ?normal, 'disabled': ?disabled});

  /// Upstream state name → value.
  final Map<String, Object> byState;
}

/// Palette input for one category, like upstream
/// `referenceTokens.color.<category>`.
final class CsPaletteInput {
  /// A palette generated from [seed] (a color string, or a [CsModeValues]
  /// of color mode → seed), with explicit [steps] (50–1000 by 50) replacing
  /// generated colors. Step values are color strings or [CsModeValues].
  const CsPaletteInput({this.seed, this.steps = const {}});

  /// The seed: a color string or [CsModeValues] of color mode → seed.
  final Object? seed;

  /// Explicit palette steps.
  final Map<int, Object> steps;

  Object _toUpstream() {
    final s = seed;
    return <Object, Object?>{
      if (s != null) 'seed': s is CsModeValues ? s.byState : s,
      for (final e in steps.entries)
        e.key: e.value is CsModeValues
            ? (e.value as CsModeValues).byState
            : e.value,
    };
  }
}

/// A theme override, like the upstream `Theme` passed to `applyTheme()`.
///
/// Token values are typed values ([CsColor], `double`, ...), CSS strings,
/// references (`'{colorPrimary600}'`), or [CsModeValues].
final class CsThemeOverride {
  /// Creates a theme override.
  const CsThemeOverride({
    this.tokens = const {},
    this.contexts = const {},
    this.referencePalettes = const {},
  });

  /// Root token overrides.
  final Map<String, Object> tokens;

  /// Per-visual-context token overrides.
  final Map<CsVisualContextId, Map<String, Object>> contexts;

  /// Generated palettes by category (`primary`, `neutral`, `error`,
  /// `success`, `warning`, `info`). Upstream `referenceTokens.color`.
  final Map<String, CsPaletteInput> referencePalettes;

  /// Whether this override changes nothing.
  bool get isEmpty =>
      tokens.isEmpty && contexts.isEmpty && referencePalettes.isEmpty;
}

/// Mode state names per axis, in Dart enum order.
const _colorStates = ['light', 'dark'];
const _densityStates = ['comfortable', 'compact'];
const _motionStates = ['default', 'disabled'];
const _staticState = '*';

List<String> _statesOf(CsTokenAxis axis) => switch (axis) {
  CsTokenAxis.color => _colorStates,
  CsTokenAxis.density => _densityStates,
  CsTokenAxis.motion => _motionStates,
  CsTokenAxis.none => const [_staticState],
};

final _reference = RegExp(r'^\{(\w+)\}$');

/// Resolves [CsTokens] for any modes and visual-context stack under a
/// [CsThemeOverride]. Results are cached.
final class CsThemeResolver {
  /// Validates and compiles [override]. Invalid values throw
  /// [ArgumentError]; ignored entries (not themeable, unsupported shapes) are
  /// reported to [onWarning] and listed in [warnings].
  CsThemeResolver([
    this.override = const CsThemeOverride(),
    void Function(String)? onWarning,
  ]) : _onWarning = onWarning {
    _compile();
  }

  /// The override this resolver applies.
  final CsThemeOverride override;
  final void Function(String)? _onWarning;

  /// Warnings produced while compiling the override.
  final List<String> warnings = [];

  final Map<String, Map<String, CsTokenAssignment>> _root = {};
  final Map<CsVisualContextId, Map<String, Map<String, CsTokenAssignment>>>
  _contexts = {};
  final Set<String> _referenceNames = {...csReferenceTokenNames};
  final Map<String, CsTokens> _cache = {};

  void _warn(String message) {
    warnings.add(message);
    _onWarning?.call(message);
  }

  void _compile() {
    // validateOverride: drop tokens that are not themeable.
    final rootTokens = <String, Object>{};
    for (final e in override.tokens.entries) {
      if (_isThemeable(e.key)) rootTokens[e.key] = e.value;
    }
    // Reference tokens are added after filtering and win over explicit ones.
    for (final e in override.referencePalettes.entries) {
      final prefix = 'color${e.key[0].toUpperCase()}${e.key.substring(1)}';
      // Upstream merges `referenceTokens.color` per category wholesale and
      // derives the reference-token names from the *input's keys*: the
      // category's base steps stop being reference tokens, and only explicit
      // steps become ones (a seed adds no real token name). This matters for
      // `defaultMode` contexts (top navigation, header).
      for (final step in csReferencePalettes[e.key] ?? const <int>[]) {
        _referenceNames.remove('$prefix$step');
      }
      for (final step in e.value.steps.keys) {
        _referenceNames.add('$prefix$step');
      }
      final palette = processPaletteInput(e.key, e.value._toUpstream());
      for (final step in palette.entries) {
        final name = '$prefix${step.key}';
        if (!csTokenInfo.containsKey(name)) continue; // no such token: unused
        final v = step.value;
        rootTokens[name] = v is Map
            ? CsModeValues(v.cast<String, Object>())
            : v;
      }
    }
    // merge: root tokens.
    for (final e in rootTokens.entries) {
      _apply(_root, e.key, e.value, null);
    }
    // merge: context tokens.
    for (final c in override.contexts.entries) {
      final target = _contexts[c.key] = {};
      for (final e in c.value.entries) {
        if (_isThemeable(e.key)) _apply(target, e.key, e.value, c.key);
      }
    }
  }

  final Set<String> _warnedUnthemeable = {};

  bool _isThemeable(String token) {
    final info = csTokenInfo[token];
    if (info == null) {
      throw ArgumentError.value(token, 'token', 'Unknown Cloudscape token');
    }
    if (!info.themeable && _warnedUnthemeable.add(token)) {
      _warn('$token is not themeable and will be ignored during theming');
    }
    return info.themeable;
  }

  /// upstream `withTokenApplied`.
  void _apply(
    Map<String, Map<String, CsTokenAssignment>> target,
    String token,
    Object update,
    CsVisualContextId? context,
  ) {
    final axis = csTokenInfo[token]!.axis;
    final states = _statesOf(axis);
    final entry = target[token] ??= {};
    if (update is CsModeValues) {
      if (axis == CsTokenAxis.none) {
        _warn(
          'The value for this token cannot be merged into the theme: $token',
        );
        target.remove(token);
        return;
      }
      for (final s in update.byState.entries) {
        if (!states.contains(s.key)) {
          _warn(
            '$token has no "${s.key}" state (states: ${states.join(', ')}); ignored',
          );
          continue;
        }
        entry[s.key] = _assignment(token, s.value, s.key);
      }
    } else {
      for (final s in states) {
        entry[s] = _assignment(token, update, s);
      }
    }
    if (entry.isEmpty) target.remove(token);
  }

  CsTokenAssignment _assignment(String token, Object value, String state) {
    if (value is String) {
      final ref = _reference.firstMatch(value);
      if (ref != null) {
        if (!csTokenInfo.containsKey(ref[1])) {
          throw ArgumentError.value(
            value,
            token,
            'References an unknown token',
          );
        }
        return CsTokenAssignment.reference(ref[1]!);
      }
    }
    final exemplar = _baseValue(
      token,
      state == _staticState ? _defaultState(token) : state,
    );
    final Object typed;
    if (value is String && exemplar is! String) {
      typed = parseToken(token, value).value;
    } else if (value is int && exemplar is double) {
      typed = value.toDouble();
    } else {
      typed = value;
    }
    final coerced = exemplar is CsLength && typed is double
        ? CsPx(typed)
        : typed;
    if (!_compatible(coerced, exemplar)) {
      throw ArgumentError.value(
        value,
        token,
        'Expected a value like ${exemplar.runtimeType} ($exemplar)',
      );
    }
    return CsTokenAssignment.value(coerced);
  }

  static bool _compatible(Object value, Object exemplar) => switch (exemplar) {
    CsColorValue() => value is CsColorValue,
    CsLength() => value is CsLength,
    List<CsShadow>() => value is List<CsShadow>,
    List<String>() => value is List<String>,
    List<double>() => value is List<double>,
    _ => value.runtimeType == exemplar.runtimeType,
  };

  static String _defaultState(String token) =>
      _statesOf(csTokenInfo[token]!.axis).first;

  /// The base theme's literal value of [token] in [state].
  static Object _baseValue(String token, String state) =>
      switch (csTokenInfo[token]!.axis) {
        CsTokenAxis.color => CsColorModeTokens.of(
          CsColorMode.values[_colorStates.indexOf(state)],
        )[token],
        CsTokenAxis.density => CsDensityModeTokens.of(
          CsDensity.values[_densityStates.indexOf(state)],
        )[token],
        CsTokenAxis.motion => CsMotionModeTokens.of(
          CsMotionMode.values[_motionStates.indexOf(state)],
        )[token],
        CsTokenAxis.none => CsStaticTokens.values[token],
      };

  static CsTokenAssignment _baseAssignment(String token, String state) {
    final ref = csTokenInfo[token]!.references[state];
    if (ref != null) return CsTokenAssignment.reference(ref);
    return CsTokenAssignment.value(_baseValue(token, state));
  }

  /// Expands declared (nested, outermost first) contexts with the combined
  /// contexts that apply, e.g. `[header, alert]` → `[header, alert,
  /// alertHeader]`, mirroring the upstream CSS selectors.
  static List<CsVisualContextId> contextStack(
    List<CsVisualContextId> declared,
  ) {
    final result = <CsVisualContextId>[];
    for (final id in declared) {
      result.add(id);
      if (id.cssClasses.length != 1) continue;
      final ancestorClasses = {
        for (final a in result.sublist(0, result.length - 1)) ...a.cssClasses,
      };
      for (final combined in CsVisualContextId.values) {
        final classes = combined.cssClasses;
        if (classes.length > 1 &&
            classes.last == id.cssClasses.single &&
            classes
                .sublist(0, classes.length - 1)
                .every(ancestorClasses.contains)) {
          result.add(combined);
        }
      }
    }
    return result;
  }

  /// Resolves every token for the given modes inside [contexts] (outermost
  /// first; use [contextStack] to add combined contexts).
  CsTokens resolve({
    CsColorMode colorMode = CsColorMode.light,
    CsDensity density = CsDensity.comfortable,
    CsMotionMode motion = CsMotionMode.normal,
    List<CsVisualContextId> contexts = const [],
  }) {
    final key =
        '${colorMode.index}${density.index}${motion.index}${contexts.map((c) => c.index).join(',')}';
    return _cache[key] ??= _resolveAll(colorMode, density, motion, contexts);
  }

  CsTokens _resolveAll(
    CsColorMode colorMode,
    CsDensity density,
    CsMotionMode motion,
    List<CsVisualContextId> contexts,
  ) {
    final base = CsTokens.resolve(
      colorMode: colorMode,
      density: density,
      motion: motion,
    );
    if (override.isEmpty && contexts.isEmpty) return base;
    String stateOf(CsTokenAxis axis) => switch (axis) {
      CsTokenAxis.color => _colorStates[colorMode.index],
      CsTokenAxis.density => _densityStates[density.index],
      CsTokenAxis.motion => _motionStates[motion.index],
      CsTokenAxis.none => _staticState,
    };
    final memo = <String, Object>{};
    final changes = <String, Object>{};
    for (final token in csTokenInfo.keys) {
      final value = _resolveToken(
        token,
        stateOf(csTokenInfo[token]!.axis),
        stateOf,
        contexts,
        memo,
        const [],
      );
      if (!_valueEquals(value, base[token])) changes[token] = value;
    }
    return base.withOverrides(changes);
  }

  Object _resolveToken(
    String token,
    String state,
    String Function(CsTokenAxis) stateOf,
    List<CsVisualContextId> contexts,
    Map<String, Object> memo,
    List<String> path,
  ) {
    final memoKey = '$token@$state';
    final cached = memo[memoKey];
    if (cached != null) return cached;
    if (path.contains(token)) {
      throw StateError(
        'Token $token has a circular dependency: ${[...path, token].join(' -> ')}',
      );
    }
    final a = _assignmentFor(token, state, contexts);
    final Object value;
    if (a.isReference) {
      final ref = a.reference!;
      value = _resolveToken(
        ref,
        stateOf(csTokenInfo[ref]!.axis),
        stateOf,
        contexts,
        memo,
        [...path, token],
      );
    } else {
      value = a.value!;
    }
    return memo[memoKey] = value;
  }

  CsTokenAssignment _rootAssignment(String token, String state) =>
      _root[token]?[state] ?? _baseAssignment(token, state);

  CsTokenAssignment _assignmentFor(
    String token,
    String state,
    List<CsVisualContextId> contexts,
  ) {
    for (final id in contexts.reversed) {
      final themed = _contexts[id]?[token]?[state];
      if (themed != null) return themed;
      final defaultMode = id.defaultColorMode;
      if (defaultMode != null && _referenceNames.contains(token)) {
        return _rootAssignment(token, _colorStates[defaultMode.index]);
      }
      final ctx = csVisualContexts[id]!;
      if (ctx.tokenNames.contains(token)) {
        return ctx.assignments[token]?[state] ?? _baseAssignment(token, state);
      }
    }
    return _rootAssignment(token, state);
  }
}

bool _valueEquals(Object a, Object b) {
  if (a is List && b is List) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!_valueEquals(a[i] as Object, b[i] as Object)) return false;
    }
    return true;
  }
  return a == b;
}
