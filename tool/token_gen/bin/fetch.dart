// Downloads pinned Cloudscape npm packages, verifies their integrity, and
// vendors the generator inputs into tool/upstream/.
//
//   dart run token_gen:fetch --components 3.0.1416 --design-tokens 3.0.118 --cldr 47.0.0
//
// No upstream code is executed: files are copied, and the theming preset is
// read as JSON.
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:token_gen/token_gen.dart';

const _componentsPackage = '@cloudscape-design/components';
const _designTokensPackage = '@cloudscape-design/design-tokens';
const _presetPath = 'package/internal/generated/theming/index.js';
const _designTokensPath = 'package/index-visual-refresh.json';
const _cldrPackage = 'cldr-core';

/// CLDR files (Unicode-3.0) → vendored path.
const _cldrFiles = {
  'package/supplemental/plurals.json': cldrPluralsFile,
  'package/supplemental/ordinals.json': cldrOrdinalsFile,
  'package/supplemental/likelySubtags.json':
      '$upstreamDir/cldr/supplemental/likelySubtags.json',
  'package/supplemental/calendarPreferenceData.json':
      '$upstreamDir/cldr/supplemental/calendarPreferenceData.json',
  'package/supplemental/numberingSystems.json':
      '$upstreamDir/cldr/supplemental/numberingSystems.json',
};

/// Calendars with vendored data besides Gregorian (`cldr-cal-<name>-full`).
const _extraCalendars = ['buddhist', 'persian'];

/// CLDR locale id for a BCP 47 tag, the way ICU resolves it: exact, else
/// maximized (likely subtags) with subtags dropped from the right.
String? resolveCldrLocale(
  String tag,
  Set<String> available,
  Map<String, String> likely,
) {
  if (available.contains(tag)) return tag;
  final parts = tag.split('-');
  final lang = parts.first;
  final maximized = (likely[tag] ?? likely[lang] ?? tag).split('-');
  final script = maximized.length > 1 && maximized[1].length == 4
      ? maximized[1]
      : null;
  final region = parts.length > 1 && parts.last.length == 2 ? parts.last : null;
  final defaultScript = (likely[lang] ?? lang).split('-').elementAtOrNull(1);
  final candidates = [
    if (script != null && region != null) '$lang-$script-$region',
    if (script != null && script != defaultScript) '$lang-$script',
    if (region != null && (script == null || script == defaultScript))
      '$lang-$region',
    if (script == null || script == defaultScript) lang,
  ];
  for (final c in candidates) {
    if (available.contains(c)) return c;
  }
  return null;
}

/// Files copied verbatim from the components tarball → vendored path.
const _copied = {
  'package/icon/generated/icons.js': iconsFile,
  'package/icon/styles.scoped.css': iconStylesFile,
  'package/icon/internal.js': iconInternalFile,
};

final _messages = RegExp(r'^package/i18n/messages/all\.([A-Za-z-]+)\.json$');

Future<void> main(List<String> args) async {
  String? arg(String name) {
    final i = args.indexOf(name);
    return i >= 0 && i + 1 < args.length ? args[i + 1] : null;
  }

  final componentsVersion = arg('--components');
  final designTokensVersion = arg('--design-tokens');
  final cldrVersion = arg('--cldr');
  if (componentsVersion == null ||
      designTokensVersion == null ||
      cldrVersion == null) {
    stderr.writeln(
      'Usage: dart run token_gen:fetch --components <version> --design-tokens <version> --cldr <version>',
    );
    exitCode = 64;
    return;
  }
  final root = findWorkspaceRoot();
  final client = HttpClient();
  try {
    final comp = await _fetch(client, _componentsPackage, componentsVersion);
    final archive = _open(comp.tarball);
    final preset = extractPreset(utf8.decode(_read(archive, _presetPath)));
    final dt = await _fetch(client, _designTokensPackage, designTokensVersion);
    final designTokens = jsonDecode(
      utf8.decode(_read(_open(dt.tarball), _designTokensPath)),
    );

    const encoder = JsonEncoder.withIndent('  ');
    void write(String path, List<int> bytes) {
      final f = File('${root.path}/$path');
      f.parent.createSync(recursive: true);
      f.writeAsBytesSync(bytes);
    }

    write(presetFile, utf8.encode('${encoder.convert(preset)}\n'));
    write(designTokensFile, utf8.encode('${encoder.convert(designTokens)}\n'));
    final files = <String, String>{
      _presetPath: presetFile,
      _designTokensPath: designTokensFile,
    };
    for (final e in _copied.entries) {
      write(e.value, _read(archive, e.key));
      files[e.key] = e.value;
    }
    final stale = Directory('${root.path}/$i18nDir');
    if (stale.existsSync()) stale.deleteSync(recursive: true);
    final locales = <String>[];
    for (final f in archive.files) {
      final m = _messages.firstMatch(f.name);
      if (m == null || m[1] == 'all') continue;
      final target = '$i18nDir/${m[1]}.json';
      write(target, f.readBytes()!);
      files[f.name] = target;
      locales.add(m[1]!);
    }
    if (locales.isEmpty) throw StateError('No i18n message bundles found');
    final cldr = await _fetch(client, _cldrPackage, cldrVersion);
    final cldrArchive = _open(cldr.tarball);
    final cldrVendored = <String, String>{};
    for (final e in _cldrFiles.entries) {
      write(e.value, _read(cldrArchive, e.key));
      cldrVendored[e.key] = e.value;
    }
    Map<String, Object?> json(Archive a, String path) =>
        (jsonDecode(utf8.decode(_read(a, path))) as Map)
            .cast<String, Object?>();
    final likely =
        ((json(
                      cldrArchive,
                      'package/supplemental/likelySubtags.json',
                    )['supplemental']!
                    as Map)['likelySubtags']!
                as Map)
            .cast<String, String>();
    final calendarPrefs =
        ((json(
                      cldrArchive,
                      'package/supplemental/calendarPreferenceData.json',
                    )['supplemental']!
                    as Map)['calendarPreferenceData']!
                as Map)
            .map((k, v) => MapEntry(k as String, (v as List).cast<String>()));

    // Dates: one compact file per CLDR locale with the fields the Dart
    // formatter reads, from the locale's preferred calendar (CLDR
    // calendarPreferenceData by region: buddhist for TH, persian for AF/IR)
    // plus the Gregorian time formats and the GMT formats.
    final dates = await _fetch(client, 'cldr-dates-full', cldrVersion);
    final datesArchive = _open(dates.tarball);
    final calendarPackages = {
      for (final c in _extraCalendars)
        c: await _fetch(client, 'cldr-cal-$c-full', cldrVersion),
    };
    final calendarArchives = {
      for (final e in calendarPackages.entries) e.key: _open(e.value.tarball),
    };
    final dateLocales = {
      for (final f in datesArchive.files)
        if (RegExp(r'^package/main/([^/]+)/ca-gregorian\.json$')
                .firstMatch(f.name)
            case final m?)
          m[1]!,
    };
    final sortedDateLocales = dateLocales.toList()..sort();
    final datesDir = Directory('${root.path}/$upstreamDir/cldr/dates');
    if (datesDir.existsSync()) datesDir.deleteSync(recursive: true);
    write(
      '$upstreamDir/cldr/dates/available.json',
      utf8.encode('${encoder.convert(sortedDateLocales)}\n'),
    );
    cldrVendored['cldr-dates-full/package/main/* (locale ids)'] =
        '$upstreamDir/cldr/dates/available.json';

    String preferredCalendar(String id) {
      final maximized = (likely[id] ?? likely[id.split('-').first] ?? id).split(
        '-',
      );
      final own = id
          .split('-')
          .skip(1)
          .where((p) => RegExp(r'^([A-Z]{2}|\d{3})$').hasMatch(p));
      final region = own.isNotEmpty ? own.last : maximized.last;
      final prefs = calendarPrefs[region] ?? calendarPrefs['001']!;
      return prefs.first;
    }

    Map<String, Object?> dateFile(Archive a, String id, String file) =>
        (((json(a, 'package/main/$id/$file')['main']! as Map)[id]!
                    as Map)['dates']!
                as Map)
            .cast<String, Object?>();
    final calendarsUsed = <String, int>{};
    for (final id in sortedDateLocales) {
      final calName = preferredCalendar(id);
      calendarsUsed[calName] = (calendarsUsed[calName] ?? 0) + 1;
      final greg =
          (dateFile(datesArchive, id, 'ca-gregorian.json')['calendars']!
                  as Map)['gregorian']!
              as Map;
      final Map<Object?, Object?> cal;
      if (calName == 'gregorian') {
        cal = greg;
      } else {
        final archive = calendarArchives[calName];
        if (archive == null) {
          throw StateError(
            '$id prefers the $calName calendar, which is not vendored',
          );
        }
        cal =
            (dateFile(archive, id, 'ca-$calName.json')['calendars']!
                    as Map)[calName]!
                as Map;
      }
      final tz =
          dateFile(datesArchive, id, 'timeZoneNames.json')['timeZoneNames']!
              as Map;
      final compact = {
        'calendar': calName,
        'months': cal['months'],
        'days': cal['days'],
        'quarters': cal['quarters'],
        'eras': cal['eras'],
        'dayPeriods': {
          'format': {
            'wide': (((cal['dayPeriods']! as Map)['format']! as Map)['wide']),
          },
        },
        'availableFormats':
            (cal['dateTimeFormats']! as Map)['availableFormats'],
        'dateFormats': cal['dateFormats'],
        'dateSkeletons': cal['dateSkeletons'],
        'timeFormats': greg['timeFormats'],
        'gmtFormat': tz['gmtFormat'],
        'gmtZeroFormat': tz['gmtZeroFormat'],
        'hourFormat': tz['hourFormat'],
      };
      write(
        '$upstreamDir/cldr/dates/$id.json',
        utf8.encode('${jsonEncode(compact)}\n'),
      );
    }
    cldrVendored['cldr-dates-full + cldr-cal-{${_extraCalendars.join(',')}}-full '
            '(main/*/{ca-*,timeZoneNames}.json, compacted)'] =
        '$upstreamDir/cldr/dates/<id>.json';
    final resolved = <String, String>{};
    for (final locale in locales) {
      final id = resolveCldrLocale(locale, dateLocales, likely);
      if (id == null) throw StateError('No CLDR dates for $locale');
      resolved[locale] = id;
    }

    // Numbers: grouping rule, numbering system, symbols and the decimal /
    // percent patterns of the default numbering system, for every locale.
    final numbers = await _fetch(client, 'cldr-numbers-full', cldrVersion);
    final numbersArchive = _open(numbers.tarball);
    final summary = <String, Object?>{};
    for (final f in numbersArchive.files) {
      final m = RegExp(r'^package/main/([^/]+)/numbers\.json$')
          .firstMatch(f.name);
      if (m == null) continue;
      final data =
          (((jsonDecode(utf8.decode(f.readBytes()!)) as Map)['main']!
                      as Map)[m[1]]!
                  as Map)['numbers']!
              as Map;
      final ns = data['defaultNumberingSystem'] as String;
      Map<String, Object?> forSystem(String key) =>
          ((data['$key-numberSystem-$ns'] ?? data['$key-numberSystem-latn'])!
                  as Map)
              .cast<String, Object?>();
      final symbols = forSystem('symbols');
      summary[m[1]!] = {
        'minimumGroupingDigits': int.parse('${data['minimumGroupingDigits']}'),
        'defaultNumberingSystem': ns,
        'symbols': {
          for (final k in [
            'decimal',
            'group',
            'percentSign',
            'minusSign',
            'plusSign',
          ])
            k: symbols[k],
        },
        'decimalPattern': forSystem('decimalFormats')['standard'],
        'percentPattern': forSystem('percentFormats')['standard'],
      };
    }
    final sortedSummary = {
      for (final k in summary.keys.toList()..sort()) k: summary[k],
    };
    write(
      '$upstreamDir/cldr/numbers-summary.json',
      utf8.encode('${encoder.convert(sortedSummary)}\n'),
    );
    cldrVendored['cldr-numbers-full/package/main/*/numbers.json (minimumGroupingDigits, defaultNumberingSystem, symbols, decimal/percent patterns)'] =
        '$upstreamDir/cldr/numbers-summary.json';
    stdout.writeln(
      'CLDR dates: ${sortedDateLocales.length} locales, calendars $calendarsUsed.',
    );
    final cldrPackages = {
      for (final f in [cldr, dates, ...calendarPackages.values, numbers])
        f.url.split('/-/').last.replaceFirst(RegExp(r'-\d.*$'), ''): {
          'tarball': f.url,
          'integrity': f.integrity,
        },
    };
    locales.sort();

    write(
      lockFile,
      utf8.encode(
        '${encoder.convert({
          'components': {'package': _componentsPackage, 'version': componentsVersion, 'tarball': comp.url, 'integrity': comp.integrity},
          'designTokens': {'package': _designTokensPackage, 'version': designTokensVersion, 'tarball': dt.url, 'integrity': dt.integrity},
          'cldr': {'version': cldrVersion, 'license': 'Unicode-3.0', 'packages': cldrPackages, 'dateLocales': resolved, 'files': cldrVendored},
          'locales': locales,
          'files': files,
        })}\n',
      ),
    );
    stdout.writeln(
      'Vendored $_componentsPackage@$componentsVersion (${files.length - 1} files, '
      '${locales.length} locales), $_designTokensPackage@$designTokensVersion and $_cldrPackage@$cldrVersion.',
    );
  } finally {
    client.close();
  }
}

class _Fetched {
  _Fetched(this.url, this.integrity, this.tarball);

  final String url;
  final String integrity;
  final Uint8List tarball;
}

Future<_Fetched> _fetch(
  HttpClient client,
  String package,
  String version,
) async {
  final encoded = package.replaceFirst('/', '%2F');
  final meta = jsonDecode(
    utf8.decode(
      await _get(client, 'https://registry.npmjs.org/$encoded/$version'),
    ),
  ) as Map<String, Object?>;
  final dist = (meta['dist']! as Map).cast<String, Object?>();
  final url = dist['tarball']! as String;
  final integrity = dist['integrity']! as String;
  stdout.writeln('Downloading $url');
  final bytes = await _get(client, url);
  if (!integrity.startsWith('sha512-')) {
    throw StateError('Unsupported integrity $integrity');
  }
  final actual = 'sha512-${base64.encode(sha512.convert(bytes).bytes)}';
  if (actual != integrity) {
    throw StateError(
      'Integrity mismatch for $package@$version: $actual != $integrity',
    );
  }
  return _Fetched(url, integrity, bytes);
}

Future<Uint8List> _get(HttpClient client, String url) async {
  final request = await client.getUrl(Uri.parse(url));
  final response = await request.close();
  if (response.statusCode != 200) {
    throw HttpException('GET $url -> ${response.statusCode}');
  }
  final builder = BytesBuilder(copy: false);
  await response.forEach(builder.add);
  return builder.takeBytes();
}

Archive _open(Uint8List tgz) =>
    TarDecoder().decodeBytes(const GZipDecoder().decodeBytes(tgz));

Uint8List _read(Archive archive, String path) {
  final file = archive.findFile(path);
  if (file == null) throw StateError('$path not found in tarball');
  return file.readBytes()!;
}
