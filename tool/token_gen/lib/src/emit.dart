// Emits cloudscape_tokens Dart sources from a ResolvedTheme.
import 'package:cloudscape_tokens/values.dart';
import 'package:token_gen/src/model.dart';

/// Upstream provenance written into every generated file header.
class Provenance {
  const Provenance({
    required this.package,
    required this.version,
    required this.designTokensVersion,
  });

  final String package;
  final String version;
  final String designTokensVersion;
}

class _Group {
  const _Group(
    this.axis,
    this.className,
    this.enumName,
    this.doc,
    this.instances,
  );

  final CsTokenAxis axis;
  final String className;
  final String? enumName;
  final String doc;

  /// upstream state → (Dart instance name, Dart enum value name).
  final Map<String, (String, String)> instances;
}

const _groups = [
  _Group(
    CsTokenAxis.color,
    'CsColorModeTokens',
    'CsColorMode',
    'Tokens whose values depend on the color mode (light or dark).',
    {'light': ('light', 'light'), 'dark': ('dark', 'dark')},
  ),
  _Group(
    CsTokenAxis.density,
    'CsDensityModeTokens',
    'CsDensity',
    'Tokens whose values depend on content density (comfortable or compact).',
    {
      'comfortable': ('comfortable', 'comfortable'),
      'compact': ('compact', 'compact'),
    },
  ),
  _Group(
    CsTokenAxis.motion,
    'CsMotionModeTokens',
    'CsMotionMode',
    'Tokens whose values depend on the motion mode (normal or disabled).',
    {'default': ('normal', 'normal'), 'disabled': ('disabled', 'disabled')},
  ),
  _Group(
    CsTokenAxis.none,
    'CsStaticTokens',
    null,
    'Tokens whose values are the same in every mode.',
    {staticState: ('values', '')},
  ),
];

/// Members of [CsTokens] that token names must not collide with.
const _reserved = {
  'colorTokens',
  'densityTokens',
  'motionTokens',
  'staticTokens',
  'colorMode',
  'density',
  'motion',
  'resolve',
  'copyWith',
  'withOverrides',
  'inContext',
  'hashCode',
  'runtimeType',
  'toString',
  'noSuchMethod',
  'names',
  'of',
  'values',
  'light',
  'dark',
  'comfortable',
  'compact',
  'normal',
  'disabled',
  'copyWithMap',
};

/// Returns generated files keyed by path relative to `lib/src/generated/`.
Map<String, String> emitAll(ResolvedTheme theme, Provenance prov) {
  for (final t in theme.tokens) {
    if (_reserved.contains(t.name)) {
      throw StateError(
        'Token name "${t.name}" collides with a generated member',
      );
    }
  }
  final header = _header(theme, prov);
  return {
    for (final g in _groups)
      '${_snake(g.className)}.g.dart': _emitGroup(header, g, theme),
    'cs_tokens.g.dart': _emitFacade(header, theme),
    'visual_contexts.g.dart': _emitContexts(header, theme),
    'token_info.g.dart': _emitInfo(header, theme, prov),
  };
}

String _header(ResolvedTheme theme, Provenance prov) =>
    '''
// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Source: ${prov.package} ${prov.version} (theme: ${theme.id}),
// descriptions from @cloudscape-design/design-tokens ${prov.designTokensVersion}.
// Regenerate with: dart run melos run tokens:generate
//
// Cloudscape is Copyright Amazon.com, Inc. or its affiliates, Apache-2.0.
''';

String _snake(String className) => className
    .replaceFirst('Cs', 'cs')
    .replaceAllMapped(RegExp('[A-Z]'), (m) => '_${m[0]!.toLowerCase()}');

Iterable<Token> _tokensOf(ResolvedTheme theme, CsTokenAxis axis) =>
    theme.tokens.where((t) => t.axis == axis);

String _emitGroup(String header, _Group g, ResolvedTheme theme) {
  final tokens = _tokensOf(theme, g.axis).toList();
  final b = StringBuffer(header)
    ..writeln()
    ..writeln("import 'package:cloudscape_tokens/src/values.dart';")
    ..writeln()
    ..writeln('/// ${g.doc}')
    ..writeln('final class ${g.className} {')
    ..writeln('  /// Creates a token set. Prefer the predefined instances.')
    ..writeln('  const ${g.className}({');
  for (final t in tokens) {
    b.writeln('    required this.${t.name},');
  }
  b.writeln('  });');
  b.writeln();
  for (final entry in g.instances.entries) {
    final (instance, enumValue) = entry.value;
    b.writeln(
      g.enumName == null
          ? '  /// The token values.'
          : '  /// Values for [${g.enumName}.$enumValue].',
    );
    b.writeln('  static const ${g.className} $instance = ${g.className}(');
    for (final t in tokens) {
      b.writeln('    ${t.name}: ${literal(t.values[entry.key]!, t.dartType)},');
    }
    b.writeln('  );');
    b.writeln();
  }
  if (g.enumName != null) {
    b.writeln('  /// Returns the predefined instance for [mode].');
    b.writeln(
      '  static ${g.className} of(${g.enumName} mode) => switch (mode) {',
    );
    for (final (instance, enumValue) in g.instances.values) {
      b.writeln('    ${g.enumName}.$enumValue => $instance,');
    }
    b.writeln('  };');
    b.writeln();
  }
  b.writeln('  /// Names of the tokens in this group.');
  b.writeln('  static const Set<String> names = {');
  for (final t in tokens) {
    b.writeln("    '${t.name}',");
  }
  b.writeln('  };');
  b.writeln();
  for (final t in tokens) {
    b.writeln('  /// See [CsTokens].');
    b.writeln('  ///');
    b.writeln('  /// CSS: `--${t.cssVariable}`');
    b.writeln('  final ${t.dartType} ${t.name};');
    b.writeln();
  }
  b.writeln('  /// Returns the value of the token called [name].');
  b.writeln('  Object operator [](String name) => switch (name) {');
  for (final t in tokens) {
    b.writeln("    '${t.name}' => ${t.name},");
  }
  b.writeln(
    "    _ => throw ArgumentError.value(name, 'name', 'Not in ${g.className}'),",
  );
  b.writeln('  };');
  b.writeln();
  b.writeln('  /// Returns a copy with [overrides] applied.');
  b.writeln('  ///');
  b.writeln('  /// Every key must be in [names] and every value must have the');
  b.writeln("  /// token's type, otherwise this throws.");
  b.writeln('  ${g.className} copyWithMap(Map<String, Object> overrides) {');
  b.writeln('    if (overrides.isEmpty) return this;');
  b.writeln('    for (final key in overrides.keys) {');
  b.writeln('      if (!names.contains(key)) {');
  b.writeln(
    "        throw ArgumentError.value(key, 'overrides', 'Not in ${g.className}');",
  );
  b.writeln('      }');
  b.writeln('    }');
  b.writeln('    return ${g.className}(');
  for (final t in tokens) {
    b.writeln(
      "      ${t.name}: (overrides['${t.name}'] ?? ${t.name}) as ${t.dartType},",
    );
  }
  b.writeln('    );');
  b.writeln('  }');
  b.writeln('}');
  return b.toString();
}

String _emitFacade(String header, ResolvedTheme theme) {
  final b = StringBuffer(header)
    ..writeln()
    ..writeln(
      "import 'package:cloudscape_tokens/src/generated/cs_color_mode_tokens.g.dart';",
    )
    ..writeln(
      "import 'package:cloudscape_tokens/src/generated/cs_density_mode_tokens.g.dart';",
    )
    ..writeln(
      "import 'package:cloudscape_tokens/src/generated/cs_motion_mode_tokens.g.dart';",
    )
    ..writeln(
      "import 'package:cloudscape_tokens/src/generated/cs_static_tokens.g.dart';",
    )
    ..writeln(
      "import 'package:cloudscape_tokens/src/generated/token_info.g.dart';",
    )
    ..writeln(
      "import 'package:cloudscape_tokens/src/generated/visual_contexts.g.dart';",
    )
    ..writeln("import 'package:cloudscape_tokens/src/values.dart';")
    ..writeln()
    ..writeln('/// Every Cloudscape design token for one combination of modes.')
    ..writeln('///')
    ..writeln(
      '/// Use [CsTokens.resolve] to pick modes, [inContext] for a visual',
    )
    ..writeln('/// context, and [withOverrides] for theme overrides.')
    ..writeln('final class CsTokens {')
    ..writeln('  /// Creates tokens from explicit groups.')
    ..writeln('  const CsTokens({')
    ..writeln('    this.colorMode = CsColorMode.light,')
    ..writeln('    this.density = CsDensity.comfortable,')
    ..writeln('    this.motion = CsMotionMode.normal,')
    ..writeln('    this.colorTokens = CsColorModeTokens.light,')
    ..writeln('    this.densityTokens = CsDensityModeTokens.comfortable,')
    ..writeln('    this.motionTokens = CsMotionModeTokens.normal,')
    ..writeln('    this.staticTokens = CsStaticTokens.values,')
    ..writeln('  });')
    ..writeln()
    ..writeln('  /// Returns the base tokens for the given modes.')
    ..writeln('  factory CsTokens.resolve({')
    ..writeln('    CsColorMode colorMode = CsColorMode.light,')
    ..writeln('    CsDensity density = CsDensity.comfortable,')
    ..writeln('    CsMotionMode motion = CsMotionMode.normal,')
    ..writeln('  }) => CsTokens(')
    ..writeln('    colorMode: colorMode,')
    ..writeln('    density: density,')
    ..writeln('    motion: motion,')
    ..writeln('    colorTokens: CsColorModeTokens.of(colorMode),')
    ..writeln('    densityTokens: CsDensityModeTokens.of(density),')
    ..writeln('    motionTokens: CsMotionModeTokens.of(motion),')
    ..writeln('  );')
    ..writeln()
    ..writeln('  /// The color mode these tokens were resolved for.')
    ..writeln('  final CsColorMode colorMode;')
    ..writeln()
    ..writeln('  /// The density these tokens were resolved for.')
    ..writeln('  final CsDensity density;')
    ..writeln()
    ..writeln('  /// The motion mode these tokens were resolved for.')
    ..writeln('  final CsMotionMode motion;')
    ..writeln()
    ..writeln('  /// Color-mode dependent tokens.')
    ..writeln('  final CsColorModeTokens colorTokens;')
    ..writeln()
    ..writeln('  /// Density dependent tokens.')
    ..writeln('  final CsDensityModeTokens densityTokens;')
    ..writeln()
    ..writeln('  /// Motion dependent tokens.')
    ..writeln('  final CsMotionModeTokens motionTokens;')
    ..writeln()
    ..writeln('  /// Mode-independent tokens.')
    ..writeln('  final CsStaticTokens staticTokens;')
    ..writeln();
  for (final t in theme.tokens) {
    final group = switch (t.axis) {
      CsTokenAxis.color => 'colorTokens',
      CsTokenAxis.density => 'densityTokens',
      CsTokenAxis.motion => 'motionTokens',
      CsTokenAxis.none => 'staticTokens',
    };
    for (final line in _docLines(t)) {
      b.writeln('  ///$line');
    }
    b.writeln('  ${t.dartType} get ${t.name} => $group.${t.name};');
    b.writeln();
  }
  b
    ..writeln('  /// Returns the value of the token called [name].')
    ..writeln(
      '  Object operator [](String name) => switch (csTokenInfo[name]?.axis) {',
    )
    ..writeln('    CsTokenAxis.color => colorTokens[name],')
    ..writeln('    CsTokenAxis.density => densityTokens[name],')
    ..writeln('    CsTokenAxis.motion => motionTokens[name],')
    ..writeln('    CsTokenAxis.none => staticTokens[name],')
    ..writeln(
      "    null => throw ArgumentError.value(name, 'name', 'Unknown token'),",
    )
    ..writeln('  };')
    ..writeln()
    ..writeln('  /// Returns a copy with some fields replaced.')
    ..writeln('  CsTokens copyWith({')
    ..writeln('    CsColorMode? colorMode,')
    ..writeln('    CsDensity? density,')
    ..writeln('    CsMotionMode? motion,')
    ..writeln('    CsColorModeTokens? colorTokens,')
    ..writeln('    CsDensityModeTokens? densityTokens,')
    ..writeln('    CsMotionModeTokens? motionTokens,')
    ..writeln('    CsStaticTokens? staticTokens,')
    ..writeln('  }) => CsTokens(')
    ..writeln('    colorMode: colorMode ?? this.colorMode,')
    ..writeln('    density: density ?? this.density,')
    ..writeln('    motion: motion ?? this.motion,')
    ..writeln('    colorTokens: colorTokens ?? this.colorTokens,')
    ..writeln('    densityTokens: densityTokens ?? this.densityTokens,')
    ..writeln('    motionTokens: motionTokens ?? this.motionTokens,')
    ..writeln('    staticTokens: staticTokens ?? this.staticTokens,')
    ..writeln('  );')
    ..writeln()
    ..writeln('  /// Returns a copy with token values replaced by name.')
    ..writeln('  ///')
    ..writeln(
      '  /// Only the named tokens change; tokens that reference them upstream',
    )
    ..writeln('  /// are not re-resolved here (see [CsTokenInfo.references]).')
    ..writeln('  CsTokens withOverrides(Map<String, Object> overrides) {')
    ..writeln('    if (overrides.isEmpty) return this;')
    ..writeln('    final byAxis = <CsTokenAxis, Map<String, Object>>{};')
    ..writeln('    for (final entry in overrides.entries) {')
    ..writeln('      final info = csTokenInfo[entry.key];')
    ..writeln('      if (info == null) {')
    ..writeln(
      "        throw ArgumentError.value(entry.key, 'overrides', 'Unknown token');",
    )
    ..writeln('      }')
    ..writeln('      (byAxis[info.axis] ??= {})[entry.key] = entry.value;')
    ..writeln('    }')
    ..writeln('    return copyWith(')
    ..writeln(
      '      colorTokens: colorTokens.copyWithMap(byAxis[CsTokenAxis.color] ?? const {}),',
    )
    ..writeln(
      '      densityTokens: densityTokens.copyWithMap(byAxis[CsTokenAxis.density] ?? const {}),',
    )
    ..writeln(
      '      motionTokens: motionTokens.copyWithMap(byAxis[CsTokenAxis.motion] ?? const {}),',
    )
    ..writeln(
      '      staticTokens: staticTokens.copyWithMap(byAxis[CsTokenAxis.none] ?? const {}),',
    )
    ..writeln('    );')
    ..writeln('  }')
    ..writeln()
    ..writeln(
      '  /// Returns these tokens with the overrides of visual context [id]',
    )
    ..writeln('  /// applied for the current modes.')
    ..writeln('  CsTokens inContext(CsVisualContextId id) {')
    ..writeln('    final ctx = csVisualContexts[id]!;')
    ..writeln('    return withOverrides({')
    ..writeln('      ...?ctx.color[colorMode],')
    ..writeln('      ...?ctx.density[density],')
    ..writeln('      ...?ctx.motion[motion],')
    ..writeln('      ...ctx.statics,')
    ..writeln('    });')
    ..writeln('  }')
    ..writeln('}');
  return b.toString();
}

List<String> _docLines(Token t) {
  final lines = <String>[];
  final desc = t.description?.trim();
  if (desc != null && desc.isNotEmpty) {
    lines.addAll(_wrap(desc, 74).map((l) => ' $l'));
    lines.add('');
  }
  lines.add(
    ' CSS: `--${t.cssVariable}` · axis: ${t.axis.name}'
    '${t.themeable ? ' · themeable' : ''}${t.exposed ? ' · exposed' : ''}',
  );
  return lines;
}

List<String> _wrap(String text, int width) {
  final out = <String>[];
  for (final para in text.split('\n')) {
    var line = StringBuffer();
    for (final word in para.split(RegExp(r'\s+')).where((w) => w.isNotEmpty)) {
      if (line.isNotEmpty && line.length + word.length + 1 > width) {
        out.add(line.toString());
        line = StringBuffer();
      }
      if (line.isNotEmpty) line.write(' ');
      line.write(word);
    }
    if (line.isNotEmpty) out.add(line.toString());
  }
  return out;
}

String _camel(String kebab) => kebab
    .split('-')
    .indexed
    .map(
      (e) => e.$1 == 0 ? e.$2 : '${e.$2[0].toUpperCase()}${e.$2.substring(1)}',
    )
    .join();

String _emitContexts(String header, ResolvedTheme theme) {
  final tokenByName = {for (final t in theme.tokens) t.name: t};
  final b = StringBuffer(header)
    ..writeln()
    ..writeln("import 'package:cloudscape_tokens/src/values.dart';")
    ..writeln()
    ..writeln(
      '/// Upstream visual contexts. Each overrides a subset of tokens for',
    )
    ..writeln('/// the subtree it wraps.')
    ..writeln('enum CsVisualContextId {');
  for (final c in theme.contexts) {
    b.writeln('  /// Upstream context `${c.id}`.');
    final mode = c.defaultMode == null
        ? 'null'
        : 'CsColorMode.${c.defaultMode}';
    final classes = c.classes.map(_str).join(', ');
    b.writeln(
      '  ${_camel(c.id)}(${_str(c.id)}, ${_str(c.selector)}, $mode, <String>[$classes]),',
    );
  }
  b
    ..writeln('  ;')
    ..writeln()
    ..writeln(
      '  const CsVisualContextId(this.id, this.cssSelector, this.defaultColorMode, this.cssClasses);',
    )
    ..writeln()
    ..writeln('  /// Upstream context id.')
    ..writeln('  final String id;')
    ..writeln()
    ..writeln('  /// Upstream CSS selector, for reference.')
    ..writeln('  final String cssSelector;')
    ..writeln()
    ..writeln(
      '  /// Upstream `defaultMode`: inside this context, palette (reference)',
    )
    ..writeln('  /// tokens always use this color mode. Null when not set.')
    ..writeln('  final CsColorMode? defaultColorMode;')
    ..writeln()
    ..writeln(
      '  /// The `awsui-context-*` class names in [cssSelector], outermost',
    )
    ..writeln(
      '  /// first. More than one means the context applies to the last class',
    )
    ..writeln(
      '  /// when nested inside the earlier ones (e.g. alert inside header).',
    )
    ..writeln('  final List<String> cssClasses;')
    ..writeln('}')
    ..writeln()
    ..writeln('/// The token overrides one visual context applies, per mode.')
    ..writeln('///')
    ..writeln(
      '/// Only tokens whose resolved value differs from the base theme are',
    )
    ..writeln('/// listed.')
    ..writeln('final class CsVisualContextTokens {')
    ..writeln('  /// Creates context overrides.')
    ..writeln('  const CsVisualContextTokens({')
    ..writeln('    this.color = const {},')
    ..writeln('    this.density = const {},')
    ..writeln('    this.motion = const {},')
    ..writeln('    this.statics = const {},')
    ..writeln('    this.tokenNames = const {},')
    ..writeln('    this.assignments = const {},')
    ..writeln('  });')
    ..writeln()
    ..writeln('  /// Overrides of color-mode tokens, per color mode.')
    ..writeln('  final Map<CsColorMode, Map<String, Object>> color;')
    ..writeln()
    ..writeln('  /// Overrides of density tokens, per density.')
    ..writeln('  final Map<CsDensity, Map<String, Object>> density;')
    ..writeln()
    ..writeln('  /// Overrides of motion tokens, per motion mode.')
    ..writeln('  final Map<CsMotionMode, Map<String, Object>> motion;')
    ..writeln()
    ..writeln('  /// Overrides of mode-independent tokens.')
    ..writeln('  final Map<String, Object> statics;')
    ..writeln()
    ..writeln(
      '  /// Every token the context declares upstream. Inside the context',
    )
    ..writeln('  /// these take precedence over root theme overrides.')
    ..writeln('  final Set<String> tokenNames;')
    ..writeln()
    ..writeln(
      '  /// Raw assignments that differ from the base theme, by token and',
    )
    ..writeln(
      '  /// mode state name (`light`, `compact`, `*`, ...). Used to resolve',
    )
    ..writeln('  /// the context against a themed base.')
    ..writeln(
      '  final Map<String, Map<String, CsTokenAssignment>> assignments;',
    )
    ..writeln('}')
    ..writeln()
    ..writeln('/// Overrides for every visual context.')
    ..writeln(
      'const Map<CsVisualContextId, CsVisualContextTokens> csVisualContexts = {',
    );
  for (final c in theme.contexts) {
    b.writeln('  CsVisualContextId.${_camel(c.id)}: CsVisualContextTokens(');
    b.writeln('    tokenNames: {');
    for (final n in c.tokenNames) {
      b.writeln("      '$n',");
    }
    b.writeln('    },');
    if (c.assignments.isNotEmpty) {
      b.writeln('    assignments: {');
      for (final e in c.assignments.entries) {
        b.writeln("      '${e.key}': {");
        for (final s in e.value.entries) {
          final a = s.value;
          final expr = a.isReference
              ? 'CsTokenAssignment.reference(${_str(a.reference!)})'
              : 'CsTokenAssignment.value(${literal(a.value!, tokenByName[e.key]!.dartType)})';
          b.writeln('        ${_str(s.key)}: $expr,');
        }
        b.writeln('      },');
      }
      b.writeln('    },');
    }
    for (final g in _groups) {
      final states = g.instances.keys
          .where((s) => c.overrides[s]?.isNotEmpty ?? false)
          .toList();
      if (states.isEmpty) continue;
      void entries(Map<String, Object> values) {
        for (final e in values.entries) {
          b.writeln(
            "      '${e.key}': ${literal(e.value, tokenByName[e.key]!.dartType)},",
          );
        }
      }

      if (g.enumName == null) {
        b.writeln('    statics: {');
        entries(c.overrides[staticState]!);
        b.writeln('    },');
      } else {
        b.writeln('    ${g.axis.name}: {');
        for (final s in states) {
          b.writeln('      ${g.enumName}.${g.instances[s]!.$2}: {');
          entries(c.overrides[s]!);
          b.writeln('      },');
        }
        b.writeln('    },');
      }
    }
    b.writeln('  ),');
  }
  b.writeln('};');
  return b.toString();
}

String _emitInfo(String header, ResolvedTheme theme, Provenance prov) {
  final b = StringBuffer(header)
    ..writeln()
    ..writeln("import 'package:cloudscape_tokens/src/values.dart';")
    ..writeln()
    ..writeln('/// Upstream package the tokens were generated from.')
    ..writeln('const String csTokensUpstreamPackage = ${_str(prov.package)};')
    ..writeln()
    ..writeln('/// Upstream version the tokens were generated from.')
    ..writeln('const String csTokensUpstreamVersion = ${_str(prov.version)};')
    ..writeln()
    ..writeln('/// Upstream theme id.')
    ..writeln('const String csTokensThemeId = ${_str(theme.id)};')
    ..writeln()
    ..writeln(
      '/// Upstream palette (reference) tokens: category → palette steps.',
    )
    ..writeln(
      '/// Token names are `color<Category><step>`, e.g. `colorPrimary600`.',
    )
    ..writeln('const Map<String, List<int>> csReferencePalettes = {');
  for (final e in theme.referencePalettes.entries) {
    b.writeln("  '${e.key}': <int>[${e.value.join(', ')}],");
  }
  b
    ..writeln('};')
    ..writeln()
    ..writeln('/// Names of all palette (reference) tokens.')
    ..writeln('const Set<String> csReferenceTokenNames = {');
  for (final e in theme.referencePalettes.entries) {
    for (final step in e.value) {
      b.writeln("  '${referenceTokenName(e.key, step)}',");
    }
  }
  b
    ..writeln('};')
    ..writeln()
    ..writeln('/// Metadata for every token, keyed by token name.')
    ..writeln('const Map<String, CsTokenInfo> csTokenInfo = {');
  for (final t in theme.tokens) {
    b.writeln("  '${t.name}': CsTokenInfo(");
    b.writeln('    axis: CsTokenAxis.${t.axis.name},');
    b.writeln('    cssVariable: ${_str(t.cssVariable)},');
    b.writeln('    themeable: ${t.themeable},');
    b.writeln('    exposed: ${t.exposed},');
    if (t.description != null) {
      b.writeln('    description: ${_str(t.description!)},');
    }
    if (t.references.isNotEmpty) {
      b.writeln('    references: {');
      for (final e in t.references.entries) {
        b.writeln('      ${_str(e.key)}: ${_str(e.value)},');
      }
      b.writeln('    },');
    }
    b.writeln('  ),');
  }
  b.writeln('};');
  return b.toString();
}

String _str(String s) {
  final escaped = s
      .replaceAll(r'\', r'\\')
      .replaceAll("'", r"\'")
      .replaceAll(r'$', r'\$')
      .replaceAll('\n', r'\n');
  return "'$escaped'";
}

String _double(double d) => d.toString();

/// Dart source for [v] as a value of [dartType] (used for list literals).
String literal(Object v, [String? dartType]) => switch (v) {
  final double d => _double(d),
  final int i => '$i',
  final String s => _str(s),
  final Duration d =>
    d.inMicroseconds % 1000 == 0
        ? 'Duration(milliseconds: ${d.inMilliseconds})'
        : 'Duration(microseconds: ${d.inMicroseconds})',
  final CsColor c =>
    'CsColor(0x${c.argb.toRadixString(16).padLeft(8, '0').toUpperCase()})',
  CsCurrentColor() => 'CsCurrentColor()',
  final CsLinearGradient g =>
    'CsLinearGradient(angleDegrees: ${_double(g.angleDegrees)}, '
        'stops: ${literal(g.stops, 'List<CsGradientStop>')})',
  final CsRadialGradient g =>
    'CsRadialGradient(circle: ${g.circle}, extent: ${_str(g.extent)}, '
        'centerX: ${_double(g.centerX)}, centerY: ${_double(g.centerY)}, '
        'stops: ${literal(g.stops, 'List<CsGradientStop>')})',
  final CsGradientStop s =>
    s.position == null
        ? 'CsGradientStop(${literal(s.color)})'
        : 'CsGradientStop(${literal(s.color)}, ${_double(s.position!)})',
  final CsPx p => 'CsPx(${_double(p.value)})',
  final CsEm e => 'CsEm(${_double(e.value)})',
  final CsPercent p => 'CsPercent(${_double(p.fraction)})',
  final CsLengthKeyword k => 'CsLengthKeyword.${k.keyword}',
  final CsFontWeight w =>
    w.isInherit ? 'CsFontWeight.inherit' : 'CsFontWeight(${w.value})',
  final CsShadow s =>
    'CsShadow(offsetX: ${_double(s.offsetX)}, offsetY: ${_double(s.offsetY)}, '
        'blur: ${_double(s.blur)}, spread: ${_double(s.spread)}, '
        'color: ${literal(s.color)}${s.inset ? ', inset: true' : ''})',
  final CsCubicBezier c =>
    'CsCubicBezier(${_double(c.x1)}, ${_double(c.y1)}, ${_double(c.x2)}, ${_double(c.y2)})',
  final List<Object?> l => () {
    final m = RegExp(r'^List<(.+)>$').firstMatch(dartType ?? '');
    if (m == null) {
      throw StateError('List value needs a List<T> type, got $dartType');
    }
    return '<${m[1]}>[${l.map((e) => literal(e!)).join(', ')}]';
  }(),
  _ => throw StateError('No literal for ${v.runtimeType}: $v'),
};
