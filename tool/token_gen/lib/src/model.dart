// Loads the Cloudscape theming preset and resolves it into typed tokens.
import 'dart:convert';

import 'package:cloudscape_tokens/values.dart';
import 'package:cloudscape_tokens/css.dart';

/// The mode axes upstream defines, with their states in Dart enum order.
/// Generation fails if upstream adds or renames an axis or state.
const expectedModes = <String, List<String>>{
  'color': ['light', 'dark'],
  'density': ['comfortable', 'compact'],
  'motion': ['default', 'disabled'],
};

/// Key used in [Token.raw] / [Token.values] for mode-independent tokens.
const staticState = '*';

/// One resolved token.
class Token {
  Token({
    required this.name,
    required this.axis,
    required this.cssVariable,
    required this.themeable,
    required this.exposed,
    required this.description,
    required this.references,
    required this.raw,
    required this.values,
    required this.dartType,
  });

  final String name;
  final CsTokenAxis axis;
  final String cssVariable;
  final bool themeable;
  final bool exposed;
  final String? description;

  /// Direct reference per state (only for states whose value is a reference).
  final Map<String, String> references;

  /// Fully resolved raw string per state.
  final Map<String, String> raw;

  /// Typed value per state, already coerced to [dartType].
  final Map<String, Object> values;

  /// Dart type of the token, e.g. `CsColor` or `double`.
  final String dartType;
}

/// One visual context.
class VisualContext {
  VisualContext({
    required this.id,
    required this.selector,
    required this.overrides,
    required this.tokenNames,
    required this.assignments,
    required this.defaultMode,
    required this.classes,
  });

  final String id;
  final String selector;

  /// Resolved values that differ from the base theme: state → token → value.
  final Map<String, Map<String, Object>> overrides;

  /// Every token the context declares (upstream `context.tokens` keys).
  final List<String> tokenNames;

  /// Raw assignments that differ from the base theme's raw assignment:
  /// token → state → assignment.
  final Map<String, Map<String, CsTokenAssignment>> assignments;

  /// Upstream `defaultMode` (a color state), or null.
  final String? defaultMode;

  /// The `awsui-context-*` classes in the selector, outermost first.
  final List<String> classes;
}

/// The whole resolved theme.
class ResolvedTheme {
  ResolvedTheme(this.id, this.tokens, this.contexts, this.referencePalettes);

  final String id;
  final List<Token> tokens;
  final List<VisualContext> contexts;

  /// Upstream `referenceTokens.color`: palette category → steps.
  final Map<String, List<int>> referencePalettes;
}

/// Upstream `generateReferenceTokenName('color', category, step)`.
String referenceTokenName(String category, int step) =>
    'color${category[0].toUpperCase()}${category.substring(1)}$step';

/// Extracts the `preset` object from `internal/generated/theming/index.js`.
Map<String, Object?> extractPreset(String js) {
  const marker = 'export var preset = ';
  final start = js.indexOf(marker);
  if (start < 0) {
    throw const FormatException('No "export var preset" in theming/index.js');
  }
  var body = js.substring(start + marker.length).trim();
  if (body.endsWith(';')) body = body.substring(0, body.length - 1);
  return (jsonDecode(body) as Map).cast<String, Object?>();
}

final _ref = RegExp(r'^\{(\w+)\}$');

CsTokenAxis _axisFromName(String name) => switch (name) {
  'color' => CsTokenAxis.color,
  'density' => CsTokenAxis.density,
  'motion' => CsTokenAxis.motion,
  _ => throw FormatException('Unknown mode axis "$name"'),
};

List<String> statesOf(CsTokenAxis axis) =>
    axis == CsTokenAxis.none ? const [staticState] : expectedModes[axis.name]!;

/// Resolves [preset] (the `preset` object) into a [ResolvedTheme].
///
/// [descriptions] maps CSS variable names (kebab case) to descriptions from
/// the `design-tokens` package.
ResolvedTheme resolvePreset(
  Map<String, Object?> preset, {
  Map<String, String> descriptions = const {},
}) {
  final theme = (preset['theme']! as Map).cast<String, Object?>();
  final secondary = preset['secondary']! as List;
  if (secondary.isNotEmpty) {
    throw FormatException(
      'Preset has ${secondary.length} secondary theme(s); the generator must '
      'be extended to emit them.',
    );
  }

  // Modes must match exactly what the Dart enums model.
  final modes = (theme['modes']! as Map).cast<String, Object?>();
  final actualModes = {
    for (final e in modes.entries)
      e.key: ((e.value! as Map)['states']! as Map).keys.cast<String>().toList(),
  };
  if (jsonEncode(actualModes) != jsonEncode(expectedModes)) {
    throw FormatException('Upstream modes changed: $actualModes');
  }

  final base = (theme['tokens']! as Map).cast<String, Object?>();
  final modeMap = (theme['tokenModeMap']! as Map).cast<String, String>();
  final variables = (preset['variablesMap']! as Map).cast<String, String>();
  final themeable = (preset['themeable']! as List).cast<String>().toSet();
  final exposed = (preset['exposed']! as List).cast<String>().toSet();

  for (final n in [...themeable, ...exposed, ...modeMap.keys]) {
    if (!base.containsKey(n)) {
      throw FormatException('Unknown token "$n" in preset lists');
    }
  }
  if (variables.length != base.length) {
    throw const FormatException('variablesMap does not cover every token');
  }

  // Effective axis: declared axis, else the axis of what it references.
  final axisCache = <String, CsTokenAxis>{};
  CsTokenAxis axisOf(String name, [Set<String> seen = const {}]) {
    final cached = axisCache[name];
    if (cached != null) return cached;
    if (seen.contains(name)) throw FormatException('Reference cycle at $name');
    final declared = modeMap[name];
    CsTokenAxis axis;
    final v = base[name];
    if (v == null) throw FormatException('Unknown token "$name"');
    if (declared != null) {
      axis = _axisFromName(declared);
    } else if (v is String && _ref.hasMatch(v)) {
      axis = axisOf(_ref.firstMatch(v)![1]!, {...seen, name});
    } else if (v is String) {
      axis = CsTokenAxis.none;
    } else {
      throw FormatException(
        'Token $name has mode values but no tokenModeMap entry',
      );
    }
    return axisCache[name] = axis;
  }

  String valueFor(Map<String, Object?> table, String name, String state) {
    final v = table[name];
    if (v == null) throw FormatException('Unknown token "$name"');
    if (v is String) return v;
    final map = (v as Map).cast<String, String>();
    final expected = statesOf(axisOf(name));
    if (!_sameKeys(map.keys, expected)) {
      throw FormatException(
        'Token $name has states ${map.keys}, expected $expected',
      );
    }
    final s = map[state];
    if (s == null) {
      throw FormatException(
        'Token $name has no "$state" value (states: ${map.keys})',
      );
    }
    return s;
  }

  String resolve(
    Map<String, Object?> table,
    String name,
    String state, [
    Set<String> seen = const {},
  ]) {
    if (seen.contains(name)) {
      throw FormatException('Reference cycle: ${[...seen, name].join(' -> ')}');
    }
    final v = valueFor(table, name, state);
    final m = _ref.firstMatch(v);
    if (m == null) {
      if (v.contains('{')) {
        throw FormatException('Embedded reference in $name: "$v"');
      }
      return v;
    }
    final target = m[1]!;
    final targetAxis = axisOf(target);
    // A reference may point at a mode-independent token, or at one on the
    // same axis. Anything else would need a cross-axis product.
    if (targetAxis != CsTokenAxis.none &&
        targetAxis != axisOf(name) &&
        state != staticState) {
      throw FormatException(
        '$name ($state) references $target on another axis',
      );
    }
    final targetState = targetAxis == CsTokenAxis.none ? staticState : state;
    return resolve(table, target, targetState, {...seen, name});
  }

  // Parse base values and every context value, then pick one type per token.
  final contextsRaw = (theme['contexts']! as Map).cast<String, Object?>();
  final parsedBase = <String, Map<String, ParsedValue>>{};
  final rawBase = <String, Map<String, String>>{};
  final kinds = <String, Set<ValueKind>>{};
  for (final name in base.keys) {
    final axis = axisOf(name);
    for (final state in statesOf(axis)) {
      final raw = resolve(base, name, state);
      final parsed = parseToken(name, raw);
      (rawBase[name] ??= {})[state] = raw;
      (parsedBase[name] ??= {})[state] = parsed;
      (kinds[name] ??= {}).add(parsed.kind);
    }
  }

  final parsedContexts = <String, Map<String, Map<String, ParsedValue>>>{};
  for (final entry in contextsRaw.entries) {
    final ctx = (entry.value! as Map).cast<String, Object?>();
    final ctxTokens = (ctx['tokens']! as Map).cast<String, Object?>();
    final merged = {...base, ...ctxTokens};
    final perState = <String, Map<String, ParsedValue>>{};
    for (final name in ctxTokens.keys) {
      if (!base.containsKey(name)) {
        throw FormatException(
          'Context ${entry.key} defines unknown token $name',
        );
      }
      final axis = axisOf(name);
      for (final state in statesOf(axis)) {
        final parsed = parseToken(name, resolve(merged, name, state));
        (perState[state] ??= {})[name] = parsed;
        kinds[name]!.add(parsed.kind);
      }
    }
    parsedContexts[entry.key] = perState;
  }

  final types = {for (final n in base.keys) n: _unify(n, kinds[n]!)};

  final tokens = <Token>[
    for (final name in base.keys)
      () {
        final axis = axisOf(name);
        final v = base[name];
        final refs = <String, String>{};
        for (final state in statesOf(axis)) {
          final rawValue = v is String ? v : (v! as Map)[state] as String;
          final m = _ref.firstMatch(rawValue);
          if (m != null) refs[state] = m[1]!;
        }
        final css = variables[name]!;
        return Token(
          name: name,
          axis: axis,
          cssVariable: css,
          themeable: themeable.contains(name),
          exposed: exposed.contains(name),
          description: descriptions[css],
          references: refs,
          raw: rawBase[name]!,
          values: {
            for (final e in parsedBase[name]!.entries)
              e.key: coerce(e.value, types[name]!),
          },
          dartType: types[name]!,
        );
      }(),
  ];

  final contexts = <VisualContext>[
    for (final entry in contextsRaw.entries)
      () {
        final ctx = (entry.value! as Map).cast<String, Object?>();
        final overrides = <String, Map<String, Object>>{};
        for (final stateEntry in parsedContexts[entry.key]!.entries) {
          for (final tokenEntry in stateEntry.value.entries) {
            final name = tokenEntry.key;
            final value = coerce(tokenEntry.value, types[name]!);
            final baseValue = coerce(
              parsedBase[name]![stateEntry.key]!,
              types[name]!,
            );
            if (!valueEquals(value, baseValue)) {
              (overrides[stateEntry.key] ??= {})[name] = value;
            }
          }
        }
        final ctxTokens = (ctx['tokens']! as Map).cast<String, Object?>();
        final assignments = <String, Map<String, CsTokenAssignment>>{};
        for (final name in ctxTokens.keys) {
          for (final state in statesOf(axisOf(name))) {
            final raw = valueFor(ctxTokens, name, state);
            if (raw == valueFor(base, name, state)) continue;
            final ref = _ref.firstMatch(raw);
            (assignments[name] ??= {})[state] = ref != null
                ? CsTokenAssignment.reference(ref[1]!)
                : CsTokenAssignment.value(
                    coerce(parseToken(name, raw), types[name]!),
                  );
          }
        }
        final selector = ctx['selector']! as String;
        final defaultMode = ctx['defaultMode'] as String?;
        if (defaultMode != null &&
            !expectedModes.values.any((s) => s.contains(defaultMode))) {
          throw FormatException('Context ${entry.key} has unknown defaultMode');
        }
        if (defaultMode != null &&
            !expectedModes['color']!.contains(defaultMode)) {
          throw FormatException(
            'Context ${entry.key} defaultMode "$defaultMode" is not a color '
            'state; the runtime only supports color defaultMode.',
          );
        }
        return VisualContext(
          id: entry.key,
          selector: selector,
          overrides: overrides,
          tokenNames: ctxTokens.keys.toList(),
          assignments: assignments,
          defaultMode: defaultMode,
          classes: [
            for (final m in RegExp(
              r'\.awsui-context-([a-z-]+)',
            ).allMatches(selector.split(':where(').first))
              m[1]!,
          ],
        );
      }(),
  ];

  final refTokens = (theme['referenceTokens'] as Map?)?.cast<String, Object?>();
  final palettes = <String, List<int>>{};
  for (final e in ((refTokens?['color'] as Map?) ?? const {}).entries) {
    final steps = [
      for (final k in (e.value as Map).keys) int.parse(k as String),
    ]..sort();
    for (final step in steps) {
      final name = referenceTokenName(e.key as String, step);
      if (!base.containsKey(name)) {
        throw FormatException('Reference token $name is not a theme token');
      }
    }
    palettes[e.key as String] = steps;
  }
  if (refTokens != null && refTokens.keys.any((k) => k != 'color')) {
    throw FormatException(
      'Unsupported referenceTokens categories: ${refTokens.keys}',
    );
  }

  return ResolvedTheme(theme['id']! as String, tokens, contexts, palettes);
}

bool _sameKeys(Iterable<String> a, List<String> b) =>
    a.length == b.length && b.every(a.contains);

String _unify(String name, Set<ValueKind> k) {
  if (k.length == 1) {
    return switch (k.single) {
      ValueKind.color => 'CsColor',
      ValueKind.colorOther => 'CsColorValue',
      ValueKind.px || ValueKind.number => 'double',
      ValueKind.length => 'CsLength',
      ValueKind.numberList => 'List<double>',
      ValueKind.duration => 'Duration',
      ValueKind.easing => 'CsCubicBezier',
      ValueKind.shadow => 'List<CsShadow>',
      ValueKind.fontFamily => 'List<String>',
      ValueKind.fontWeight => 'CsFontWeight',
      ValueKind.keyword => 'String',
    };
  }
  if (k.difference({ValueKind.color, ValueKind.colorOther}).isEmpty) {
    return 'CsColorValue';
  }
  if (k.difference({ValueKind.px, ValueKind.number}).isEmpty) return 'double';
  if (k.difference({ValueKind.px, ValueKind.length}).isEmpty) return 'CsLength';
  throw FormatException('Token $name mixes value kinds $k');
}

/// Converts [p] to a value of [dartType].
Object coerce(ParsedValue p, String dartType) {
  if (dartType == 'CsLength' && p.kind == ValueKind.px) {
    return CsPx(p.value as double);
  }
  return p.value;
}

/// Deep equality for generated values (lists compare element-wise).
bool valueEquals(Object a, Object b) {
  if (a is List && b is List) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!valueEquals(a[i] as Object, b[i] as Object)) return false;
    }
    return true;
  }
  return a == b;
}
