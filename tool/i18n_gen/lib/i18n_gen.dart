/// Generates cloudscape_flutter i18n messages from upstream bundles.
library;

import 'dart:convert';
import 'dart:io';

const namespace = 'cloudscape-design-components';
const i18nDir = 'tool/upstream/i18n';
const lockFile = 'tool/upstream/upstream.json';
const messagesLibDir = 'packages/cloudscape_flutter/lib/i18n/messages';
const importFile =
    'packages/cloudscape_flutter/lib/src/i18n/generated/import_messages.g.dart';
const arbDir = 'packages/cloudscape_flutter/l10n';
const cldrPluralsFile = 'tool/upstream/cldr/plurals.json';
const cldrOrdinalsFile = 'tool/upstream/cldr/ordinals.json';
const pluralRulesFile =
    'packages/cloudscape_flutter/lib/src/i18n/generated/plural_rules.g.dart';
const cldrDataFile =
    'packages/cloudscape_flutter/lib/src/i18n/generated/cldr_data.g.dart';
const cldrDir = 'tool/upstream/cldr';

Map<String, Object?> _json(Directory root, String path) =>
    (jsonDecode(File('${root.path}/$path').readAsStringSync()) as Map)
        .cast<String, Object?>();

String _strList(Iterable<String> v) => '<String>[${v.map(_str).join(', ')}]';

/// Directory of the deferred per-locale date libraries.
const dateLibDir = 'packages/cloudscape_flutter/lib/src/i18n/generated/dates';

/// The deferred date loader.
const dateLoaderFile =
    'packages/cloudscape_flutter/lib/src/i18n/generated/cldr_date_loader.g.dart';

const _cldrHeader =
    '// GENERATED CODE - DO NOT MODIFY BY HAND.\n'
    '//\n'
    '// Source: cldr-core, cldr-dates-full, cldr-cal-buddhist-full,\n'
    '// cldr-cal-persian-full, cldr-numbers-full (Unicode-3.0).\n'
    '// Regenerate with: dart run melos run i18n:generate\n';

/// A CLDR pattern value: a string, or `{_value, _numbers}` when the pattern
/// names a numbering system override (ignored, like browsers' default).
String _pattern(Object? v) => v is Map ? v['_value']! as String : v! as String;

/// Pattern map with every value flattened by [_pattern].
Map<String, String> _patterns(Object? m) => {
  for (final e in (m! as Map).entries) e.key as String: _pattern(e.value),
};

/// The `CsCldrDateData(...)` expression for CLDR locale [id] (from the
/// compact file written by the fetch tool).
String dateDataSource(Directory root, String id) {
  final d = _json(root, '$cldrDir/dates/$id.json');
  final calName = d['calendar']! as String;
  String names(Map<String, Object?> group, List<String> keys) {
    final out = <String>[];
    for (final ctx in ['format', 'stand-alone']) {
      for (final width in ['abbreviated', 'wide', 'narrow']) {
        final m = ((group[ctx]! as Map)[width]! as Map).cast<String, Object?>();
        out.add("'$ctx-$width': ${_strList(keys.map((k) => m[k]! as String))}");
      }
    }
    return '{${out.join(', ')}}';
  }

  final eras = (d['eras']! as Map).cast<String, Object?>();
  String eraMap(String key) {
    final m = (eras[key]! as Map).cast<String, String>();
    return '{${m.entries.where((e) => !e.key.contains('alt')).map((e) => '${e.key}: ${_str(e.value)}').join(', ')}}';
  }

  // ICU's `a` reads AmPmMarkers, which is CLDR's format *wide* width.
  final periods =
      (((d['dayPeriods']! as Map)['format']! as Map)['wide']! as Map)
          .cast<String, String>();
  final af = <String, String>{};
  for (final e in _patterns(d['availableFormats']).entries) {
    if (e.key.contains('-alt-')) continue;
    // Non-Gregorian calendars spell full years `yyyy` in skeleton keys.
    final key = calName == 'gregorian' ? e.key : e.key.replaceAll('yyyy', 'y');
    af.putIfAbsent(key, () => e.value);
  }
  final timeFormats = _patterns(d['timeFormats']);
  final dateFormats = _patterns(d['dateFormats']);
  final dateSkeletons = _patterns(d['dateSkeletons']);
  String styles(Map<String, String> m) =>
      '{${['short', 'medium', 'long', 'full'].map((k) => "'$k': ${_str(m[k]!)}").join(', ')}}';
  return 'CsCldrDateData('
      'id: ${_str(id)}, '
      "calendar: '$calName', "
      'yearOffset: ${calName == 'buddhist' ? 543 : 0}, '
      'months: ${names((d['months']! as Map).cast(), [for (var i = 1; i <= 12; i++) '$i'])}, '
      "days: ${names((d['days']! as Map).cast(), ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'])}, "
      "quarters: ${names((d['quarters']! as Map).cast(), ['1', '2', '3', '4'])}, "
      "am: ${_str(periods['am']!)}, "
      "pm: ${_str(periods['pm']!)}, "
      "eras: {'abbreviated': ${eraMap('eraAbbr')}, 'wide': ${eraMap('eraNames')}, 'narrow': ${eraMap('eraNarrow')}}, "
      'availableFormats: {${af.entries.map((e) => '${_str(e.key)}: ${_str(e.value)}').join(', ')}}, '
      'timeFormats: ${styles(timeFormats)}, '
      'dateFormats: ${styles(dateFormats)}, '
      'dateSkeletons: ${styles(dateSkeletons)}, '
      "gmtFormat: ${_str(d['gmtFormat']! as String)}, "
      "gmtZeroFormat: ${_str(d['gmtZeroFormat']! as String)}, "
      "hourFormat: ${_str(d['hourFormat']! as String)})";
}

/// File-name key of a deferred date library for CLDR id [id].
String dateLibKey(String id) => id.replaceAll('-', '_').toLowerCase();

/// Emits the CLDR locale-resolution, number and date data: the eager data
/// file (Cloudscape's message locales + every locale's number data), one
/// deferred library per distinct date data set, and their loader.
Map<String, String> emitCldrData(
  Directory root,
  Map<String, String> dateLocales,
  String cldrVersion,
) {
  final files = <String, String>{};
  final b = StringBuffer()
    ..writeln(_cldrHeader)
    ..writeln(
      "import 'package:cloudscape_flutter/src/i18n/cldr_date_data.dart';",
    )
    ..writeln();

  final available = (jsonDecode(
    File('${root.path}/$cldrDir/dates/available.json').readAsStringSync(),
  ) as List).cast<String>();
  b
    ..writeln('/// Every CLDR locale id with date data.')
    ..writeln(
      'const Set<String> csCldrDateLocaleIds = {${available.map(_str).join(', ')}};',
    )
    ..writeln();

  // Numbers: one const per distinct data set, then id → const.
  final numberingSystems =
      ((_json(
                    root,
                    '$cldrDir/supplemental/numberingSystems.json',
                  )['supplemental']!
                  as Map)['numberingSystems']!
              as Map)
          .cast<String, Object?>();
  final numbers = _json(root, '$cldrDir/numbers-summary.json');
  final numberConsts = <String, String>{}; // source → const name
  final numberIds = <String, String>{};
  for (final e in numbers.entries) {
    final n = (e.value! as Map).cast<String, Object?>();
    final ns = n['defaultNumberingSystem']! as String;
    final digits = ns == 'latn'
        ? ''
        : ((numberingSystems[ns]! as Map)['_digits']! as String);
    final sym = (n['symbols']! as Map).cast<String, String>();
    final src =
        'CsCldrNumberData('
        'minimumGroupingDigits: ${n['minimumGroupingDigits']}, '
        'numberingSystem: ${_str(ns)}, '
        'digits: ${_str(digits)}, '
        "decimal: ${_str(sym['decimal']!)}, "
        "group: ${_str(sym['group']!)}, "
        "percentSign: ${_str(sym['percentSign']!)}, "
        "minusSign: ${_str(sym['minusSign']!)}, "
        "plusSign: ${_str(sym['plusSign']!)}, "
        "decimalPattern: ${_str(n['decimalPattern']! as String)}, "
        "percentPattern: ${_str(n['percentPattern']! as String)})";
    final name = numberConsts.putIfAbsent(
      src,
      () => '_n${numberConsts.length}',
    );
    numberIds[e.key] = name;
  }
  for (final e in numberConsts.entries) {
    b.writeln('const ${e.value} = ${e.key};');
  }
  b
    ..writeln()
    ..writeln('/// CLDR number data of every locale id with number data.')
    ..writeln('const Map<String, CsCldrNumberData> csCldrNumberData = {')
    ..writeAll([
      for (final e in numberIds.entries) '  ${_str(e.key)}: ${e.value},\n',
    ])
    ..writeln('};')
    ..writeln();

  final likely =
      ((_json(root, '$cldrDir/supplemental/likelySubtags.json')['supplemental']!
                  as Map)['likelySubtags']!
              as Map)
          .cast<String, String>();
  final defaults = <String, String>{};
  for (final e in likely.entries) {
    final parts = e.value.split('-');
    if (!e.key.contains('-') && parts.length >= 2 && parts[1].length == 4) {
      defaults[e.key] = parts[1];
    }
  }
  final regional = <String, String>{};
  for (final e in likely.entries) {
    final k = e.key.split('-');
    final v = e.value.split('-');
    if (k.length == 2 &&
        k[0] != 'und' &&
        RegExp(r'^([A-Z]{2}|\d{3})$').hasMatch(k[1]) &&
        v.length >= 2 &&
        v[1].length == 4 &&
        defaults[k[0]] != v[1]) {
      regional[e.key] = v[1];
    }
  }
  b
    ..writeln('/// Likely script of each language (from CLDR likely subtags).')
    ..writeln('const Map<String, String> csCldrDefaultScripts = {')
    ..writeAll([
      for (final e in defaults.entries) '  ${_str(e.key)}: ${_str(e.value)},\n',
    ])
    ..writeln('};')
    ..writeln()
    ..writeln(
      '/// `language-REGION` tags whose likely script differs from the default.',
    )
    ..writeln('const Map<String, String> csCldrRegionScripts = {')
    ..writeAll([
      for (final e in regional.entries) '  ${_str(e.key)}: ${_str(e.value)},\n',
    ])
    ..writeln('};')
    ..writeln();

  final eager = dateLocales.values.toSet().toList()..sort();
  b
    ..writeln(
      '/// Date data bundled eagerly: the locales Cloudscape ships messages',
    )
    ..writeln(
      '/// for. Other locales load on demand (cldr_date_loader.g.dart).',
    )
    ..writeln('const Map<String, CsCldrDateData> csCldrDateData = {');
  for (final id in eager) {
    b.writeln('  ${_str(id)}: ${dateDataSource(root, id)},');
  }
  b
    ..writeln('};')
    ..writeln()
    ..writeln('/// Cloudscape locale → CLDR date locale id.')
    ..writeln('const Map<String, String> csCldrMessageLocaleIds = {')
    ..writeAll([
      for (final e in dateLocales.entries)
        '  ${_str(e.key.toLowerCase())}: ${_str(e.value)},\n',
    ])
    ..writeln('};');
  files[cldrDataFile] = b.toString();

  // Deferred libraries: locales whose data matches (ignoring the id) share
  // one library, named after the first such id.
  final libraries = <String, String>{}; // body → key
  final libraryOf = <String, String>{}; // id → key
  final bodies = <String, String>{}; // key → source with the key's id
  for (final id in available) {
    if (eager.contains(id)) continue;
    final src = dateDataSource(root, id);
    final body = src.replaceFirst('id: ${_str(id)}, ', '');
    final key = libraries.putIfAbsent(body, () {
      final k = dateLibKey(id);
      bodies[k] = src;
      return k;
    });
    libraryOf[id] = key;
  }
  for (final e in bodies.entries) {
    files['$dateLibDir/${e.key}.g.dart'] =
        '$_cldrHeader\n'
        "import 'package:cloudscape_flutter/src/i18n/cldr_date_data.dart';\n\n"
        '/// CLDR date data.\n'
        'const CsCldrDateData data = ${e.value};\n';
  }
  final keys = bodies.keys.toList()..sort();
  final loader = StringBuffer()
    ..writeln(_cldrHeader)
    ..writeln(
      "import 'package:cloudscape_flutter/src/i18n/cldr_date_data.dart';",
    );
  for (final k in keys) {
    loader.writeln(
      "import 'package:cloudscape_flutter/src/i18n/generated/dates/$k.g.dart' deferred as d_$k;",
    );
  }
  loader
    ..writeln()
    ..writeln('/// CLDR date locale id → deferred library key (locales without')
    ..writeln('/// eager data).')
    ..writeln('const Map<String, String> csCldrDeferredDateLibraries = {')
    ..writeAll([
      for (final id in libraryOf.keys.toList()..sort())
        '  ${_str(id)}: ${_str(libraryOf[id]!)},\n',
    ])
    ..writeln('};')
    ..writeln()
    ..writeln('/// Loads the deferred date library [key].')
    ..writeln(
      'Future<CsCldrDateData> csLoadCldrDateLibrary(String key) async {',
    )
    ..writeln('  switch (key) {');
  for (final k in keys) {
    loader
      ..writeln("    case '$k':")
      ..writeln('      await d_$k.loadLibrary();')
      ..writeln('      return d_$k.data;');
  }
  loader
    ..writeln('  }')
    ..writeln(
      "  throw ArgumentError.value(key, 'key', 'No CLDR date library');",
    )
    ..writeln('}');
  files[dateLoaderFile] = loader.toString();
  return files;
}

/// CLDR rules: locale → category → condition (samples stripped).
typedef PluralRules = Map<String, Map<String, String>>;

/// Loads CLDR cardinal or ordinal rules.
PluralRules loadPluralRules(Directory root, {required bool ordinal}) {
  final file = ordinal ? cldrOrdinalsFile : cldrPluralsFile;
  final json = jsonDecode(
    File('${root.path}/$file').readAsStringSync(),
  ) as Map<String, Object?>;
  final key = ordinal ? 'plurals-type-ordinal' : 'plurals-type-cardinal';
  final data = ((json['supplemental']! as Map)[key]! as Map)
      .cast<String, Object?>();
  const order = ['zero', 'one', 'two', 'few', 'many', 'other'];
  return {
    for (final e in data.entries)
      e.key: () {
        final rules = (e.value! as Map).cast<String, String>();
        final out = <String, String>{};
        for (final r in rules.entries) {
          const prefix = 'pluralRule-count-';
          if (!r.key.startsWith(prefix)) {
            throw FormatException('Unexpected rule key ${r.key}');
          }
          final category = r.key.substring(prefix.length);
          if (!order.contains(category)) {
            throw FormatException('Unknown category $category');
          }
          final condition = r.value.split('@').first.trim();
          if (category == 'other') {
            if (condition.isNotEmpty) {
              throw FormatException('"other" with a condition in ${e.key}');
            }
            continue;
          }
          out[category] = condition;
        }
        return {
          for (final c in order)
            if (out.containsKey(c)) c: out[c]!,
        };
      }(),
  };
}

/// Finds the workspace root (the pubspec.yaml with a `workspace:` key).
Directory findWorkspaceRoot() {
  var dir = Directory.current.absolute;
  while (true) {
    final pubspec = File('${dir.path}/pubspec.yaml');
    if (pubspec.existsSync() &&
        RegExp(
          r'^workspace:',
          multiLine: true,
        ).hasMatch(pubspec.readAsStringSync())) {
      return dir;
    }
    if (dir.parent.path == dir.path) {
      throw StateError('No workspace root found');
    }
    dir = dir.parent;
  }
}

/// One locale bundle: component → key → formatjs AST.
class LocaleBundle {
  LocaleBundle(this.locale, this.components);

  /// Upstream locale name (e.g. `en-GB`).
  final String locale;

  /// component → key → AST elements.
  final Map<String, Map<String, List<Object?>>> components;

  /// `en-GB` → `EnGb`.
  String get pascal => locale
      .split('-')
      .map((p) => '${p[0].toUpperCase()}${p.substring(1).toLowerCase()}')
      .join();

  /// `en-GB` → `en_gb`.
  String get snake => locale.toLowerCase().replaceAll('-', '_');
}

/// Loads every vendored bundle, validating its shape.
List<LocaleBundle> loadBundles(Directory root) {
  final lock = jsonDecode(
    File('${root.path}/$lockFile').readAsStringSync(),
  ) as Map<String, Object?>;
  final locales = (lock['locales']! as List).cast<String>();
  return [
    for (final locale in locales)
      () {
        final json = jsonDecode(
          File('${root.path}/$i18nDir/$locale.json').readAsStringSync(),
        ) as Map<String, Object?>;
        if (json.keys.single != namespace) {
          throw FormatException(
            'Unexpected namespaces ${json.keys} in $locale',
          );
        }
        final byLocale = (json[namespace]! as Map).cast<String, Object?>();
        if (byLocale.keys.single != locale) {
          throw FormatException('Bundle $locale contains ${byLocale.keys}');
        }
        final comps = (byLocale[locale]! as Map).cast<String, Object?>();
        return LocaleBundle(locale, {
          for (final c in comps.entries)
            c.key: {
              for (final m in (c.value! as Map).cast<String, Object?>().entries)
                m.key: (m.value! as List).cast<Object?>(),
            },
        });
      }(),
  ];
}

String _str(String s) =>
    "'${s.replaceAll(r'\', r'\\').replaceAll("'", r"\'").replaceAll(r'$', r'\$').replaceAll('\n', r'\n').replaceAll('\r', r'\r')}'";

/// Dart source for a formatjs AST element list.
String dartNodes(List<Object?> nodes) =>
    '<CsMessageNode>[${nodes.map((n) => _dartNode((n! as Map).cast<String, Object?>())).join(', ')}]';

String _options(Map<String, Object?> n) {
  final opts = (n['options']! as Map).cast<String, Object?>();
  return '{${opts.entries.map((o) => '${_str(o.key)}: ${dartNodes(((o.value! as Map)['value']! as List).cast<Object?>())}').join(', ')}}';
}

String _dartNode(Map<String, Object?> n) {
  final type = n['type']! as int;
  final value = n['value'];
  String? style() {
    final s = n['style'];
    if (s == null) return null;
    if (s is String) return s;
    throw FormatException('Unsupported style object $s');
  }

  switch (type) {
    case 0:
      return 'CsLiteralNode(${_str(value! as String)})';
    case 1:
      return 'CsArgumentNode(${_str(value! as String)})';
    case 2 || 3 || 4:
      final kind = ['number', 'date', 'time'][type - 2];
      final st = style();
      return 'CsFormattedNode(CsFormattedKind.$kind, ${_str(value! as String)}${st == null ? '' : ', ${_str(st)}'})';
    case 5:
      return 'CsSelectNode(${_str(value! as String)}, ${_options(n)})';
    case 6:
      final pluralType = n['pluralType'];
      if (pluralType != 'cardinal' && pluralType != 'ordinal') {
        throw FormatException('Bad pluralType $pluralType');
      }
      final offset = (n['offset'] as num?) ?? 0;
      return 'CsPluralNode(${_str(value! as String)}, ${_options(n)}'
          '${offset == 0 ? '' : ', offset: $offset'}${pluralType == 'ordinal' ? ', ordinal: true' : ''})';
    case 7:
      return 'CsPoundNode()';
    case 8:
      return 'CsTagNode(${_str(value! as String)}, ${dartNodes((n['children']! as List).cast<Object?>())})';
  }
  throw FormatException('Unknown message element type $type');
}

/// ICU source for a formatjs AST (independent of the runtime parser, so the
/// ARB round trip cross-checks both).
String icu(List<Object?> nodes, {bool inPlural = false}) {
  final b = StringBuffer();
  for (final raw in nodes) {
    final n = (raw! as Map).cast<String, Object?>();
    final value = n['value'];
    String opts() => ((n['options']! as Map).cast<String, Object?>()).entries
        .map(
          (o) =>
              '${o.key} {${icu(((o.value! as Map)['value']! as List).cast<Object?>(), inPlural: n['type'] == 6 || inPlural && n['type'] != 6)}}',
        )
        .join(' ');
    switch (n['type']) {
      case 0:
        var text = (value! as String).replaceAll("'", "''");
        text = text.replaceAllMapped(
          RegExp(inPlural ? '[{}#<>|]' : '[{}<>|]'),
          (m) => "'${m[0]}'",
        );
        b.write(text);
      case 1:
        b.write('{$value}');
      case 2 || 3 || 4:
        final kind = ['number', 'date', 'time'][(n['type']! as int) - 2];
        final s = n['style'];
        b.write(s == null ? '{$value, $kind}' : '{$value, $kind, $s}');
      case 5:
        b.write('{$value, select, ${opts()}}');
      case 6:
        final offset = (n['offset'] as num?) ?? 0;
        final kind = n['pluralType'] == 'ordinal' ? 'selectordinal' : 'plural';
        b.write(
          '{$value, $kind, ${offset == 0 ? '' : 'offset:$offset '}${opts()}}',
        );
      case 7:
        b.write('#');
      case 8:
        b.write(
          '<$value>${icu((n['children']! as List).cast<Object?>(), inPlural: inPlural)}</$value>',
        );
      default:
        throw FormatException('Unknown message element type ${n['type']}');
    }
  }
  return b.toString();
}

String _header(String version) =>
    '''
// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Source: @cloudscape-design/components $version (i18n/messages).
// Regenerate with: dart run melos run i18n:generate
//
// Cloudscape is Copyright Amazon.com, Inc. or its affiliates, Apache-2.0.
''';

String _rulesTable(String name, String doc, PluralRules rules) {
  final b = StringBuffer()
    ..writeln('/// $doc')
    ..writeln('const Map<String, Map<String, String>> $name = {');
  for (final e in rules.entries) {
    b.writeln(
      '  ${_str(e.key)}: {${e.value.entries.map((r) => '${_str(r.key)}: ${_str(r.value)}').join(', ')}},',
    );
  }
  b.writeln('};');
  return b.toString();
}

/// Every generated file: workspace-relative path → contents.
Map<String, String> emitAll(
  List<LocaleBundle> bundles,
  String version, {
  required PluralRules cardinal,
  required PluralRules ordinal,
  required String cldrVersion,
  Map<String, String> cldrData = const {},
}) {
  final files = <String, String>{...cldrData};
  files[pluralRulesFile] = [
    '// GENERATED CODE - DO NOT MODIFY BY HAND.',
    '//',
    '// Source: cldr-core $cldrVersion (supplemental/plurals.json, ordinals.json),',
    '// Unicode-3.0. Regenerate with: dart run melos run i18n:generate',
    '',
    '/// CLDR version of the plural rules.',
    "const String csCldrVersion = '$cldrVersion';",
    '',
    _rulesTable(
      'csCardinalPluralRules',
      'CLDR cardinal plural rules: locale → category → condition. `other` is implied.',
      cardinal,
    ),
    _rulesTable(
      'csOrdinalPluralRules',
      'CLDR ordinal plural rules: locale → category → condition. `other` is implied.',
      ordinal,
    ),
  ].join('\n');
  for (final bundle in bundles) {
    final b = StringBuffer(_header(version))
      ..writeln()
      ..writeln('/// Cloudscape component messages for `${bundle.locale}`.')
      ..writeln('library;')
      ..writeln()
      ..writeln(
        "import 'package:cloudscape_flutter/src/i18n/message_ast.dart';",
      )
      ..writeln()
      ..writeln(
        '/// Upstream `@cloudscape-design/components/i18n/messages/all.${bundle.locale}`.',
      )
      ..writeln('const CsI18nMessages csMessages${bundle.pascal} = {')
      ..writeln("  '$namespace': {")
      ..writeln("    '${bundle.locale}': {");
    for (final c in bundle.components.entries) {
      b.writeln('      ${_str(c.key)}: {');
      for (final m in c.value.entries) {
        b.writeln('        ${_str(m.key)}: ${dartNodes(m.value)},');
      }
      b.writeln('      },');
    }
    b
      ..writeln('    },')
      ..writeln('  },')
      ..writeln('};');
    files['$messagesLibDir/all_${bundle.snake}.dart'] = b.toString();

    final arb = <String, Object?>{
      '@@locale': bundle.locale.replaceAll('-', '_'),
    };
    for (final c in bundle.components.entries) {
      for (final m in c.value.entries) {
        arb['${c.key}.${m.key}'] = icu(m.value);
      }
    }
    files['$arbDir/cloudscape_${bundle.snake}.arb'] =
        '${const JsonEncoder.withIndent('  ').convert(arb)}\n';
  }

  final imp = StringBuffer(_header(version))
    ..writeln()
    ..writeln(
      "import 'package:cloudscape_flutter/src/i18n/i18n_formatter.dart';",
    )
    ..writeln("import 'package:cloudscape_flutter/src/i18n/message_ast.dart';")
    ..writeln("import 'package:flutter/foundation.dart';");
  for (final bundle in bundles) {
    imp.writeln(
      "import 'package:cloudscape_flutter/i18n/messages/all_${bundle.snake}.dart' deferred as ${bundle.snake};",
    );
  }
  imp
    ..writeln()
    ..writeln('/// Locales with built-in messages.')
    ..writeln(
      'const List<String> csI18nLocales = [${bundles.map((b) => _str(b.locale)).join(', ')}];',
    )
    ..writeln()
    ..writeln('final Set<String> _warned = {};')
    ..writeln()
    ..writeln(
      '/// Loads the built-in messages for [locale] (upstream `importMessages`).',
    )
    ..writeln('///')
    ..writeln(
      '/// The locale is widened (`en-AU` → `en`). Each locale is a deferred',
    )
    ..writeln(
      '/// library, so on the web it is downloaded only when requested.',
    )
    ..writeln(
      'Future<List<CsI18nMessages>> csImportMessages(String locale) async {',
    )
    ..writeln('  for (final l in csMatchableLocales(locale)) {')
    ..writeln('    switch (l.toLowerCase()) {');
  for (final bundle in bundles) {
    imp
      ..writeln("      case '${bundle.locale.toLowerCase()}':")
      ..writeln('        await ${bundle.snake}.loadLibrary();')
      ..writeln('        return [${bundle.snake}.csMessages${bundle.pascal}];');
  }
  imp
    ..writeln('    }')
    ..writeln('  }')
    ..writeln('  if (kDebugMode && _warned.add(locale)) {')
    ..writeln(
      r'''    debugPrint('[AwsUi] [importMessages] Unknown locale "$locale" provided to importMessages');''',
    )
    ..writeln('  }')
    ..writeln('  return const [];')
    ..writeln('}');
  files[importFile] = imp.toString();
  return files;
}

/// Writes [files] under [root] and formats the Dart ones.
Future<void> writeAll(Directory root, Map<String, String> files) async {
  final dart = <String>[];
  for (final e in files.entries) {
    final f = File('${root.path}/${e.key}')..parent.createSync(recursive: true);
    f.writeAsStringSync(e.value);
    if (e.key.endsWith('.dart')) dart.add(f.path);
  }
  final r = await Process.run(Platform.resolvedExecutable, ['format', ...dart]);
  if (r.exitCode != 0) {
    throw StateError('dart format failed: ${r.stdout}${r.stderr}');
  }
}
