// Compares the Dart i18n port with upstream's intl-messageformat.
//
// The fixture is produced by tool/i18n_oracle (Node, dev-only):
//   cd tool/i18n_oracle && npm ci --ignore-scripts && npm run fixtures
// Without the fixture these tests are skipped.
import 'dart:convert';
import 'dart:io';

import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter_test/flutter_test.dart';

const _fixture = 'test/fixtures/i18n_oracle.json';

Map<String, Object?> _args(Map<String, Object?> json) => {
  for (final e in json.entries)
    e.key: e.value is Map && (e.value! as Map)[r'$tag'] == true
        ? (List<Object> chunks) => '<${e.key}>${chunks.join()}</${e.key}>'
        : e.value,
};

/// Formats like the oracle: a string, or `{error: ...}` on failure.
Object _run(CsMessageFormat f, Map<String, Object?> args) {
  try {
    return f.format(args);
  } on Object catch (e) {
    return {'error': e.runtimeType.toString()};
  }
}

void main() {
  final file = File(_fixture);
  final skip = file.existsSync()
      ? null
      : 'No i18n oracle fixture; run tool/i18n_oracle (see oracle.mjs).';
  final data = file.existsSync()
      ? jsonDecode(file.readAsStringSync()) as Map<String, Object?>
      : const <String, Object?>{};
  List<Map<String, Object?>> list(String key) =>
      ((data[key] as List?) ?? const []).cast<Map<String, Object?>>();

  test('A. every upstream message in every locale formats like upstream', () async {
    final bundles = <String, Map<String, Map<String, Object>>>{};
    final mismatches = <String>[];
    for (final e in list('messages')) {
      final locale = e['locale']! as String;
      bundles[locale] ??= (await csImportMessages(locale))
          .single[csI18nNamespace]![locale]!;
      final nodes =
          bundles[locale]![e['component']! as String]![e['key']! as String]!
              as List<CsMessageNode>;
      final args = (e['args']! as Map).cast<String, Object?>();
      final got = _run(CsMessageFormat(nodes, locale), _args(args));
      final want = e['output'];
      final ok = want is String
          ? got == want
          : got is Map; // upstream error ⇔ ours
      if (!ok) {
        mismatches.add(
          '$locale ${e['component']}.${e['key']} $args: got $got, upstream $want',
        );
      }
    }
    expect(list('messages'), isNotEmpty);
    expect(mismatches, isEmpty, reason: mismatches.take(20).join('\n'));
  }, skip: skip);

  test('B. plural categories match Intl.PluralRules (cardinal and ordinal)', () {
    final mismatches = <String>[];
    var compared = 0;
    for (final e in list('plurals')) {
      if (e['supported'] != true) continue; // the runtime itself falls back
      final ordinal = e['ordinal']! as bool;
      final locale = e['locale']! as String;
      final n = e['n']! as num;
      final message =
          '{n, ${ordinal ? 'selectordinal' : 'plural'}, zero {zero} one {one} two {two} few {few} many {many} other {other}}';
      final got = _run(CsMessageFormat(parseIcuMessage(message), locale), {
        'n': n,
      });
      compared++;
      if (got != e['output']) {
        mismatches.add(
          '$locale ${ordinal ? 'ordinal' : 'cardinal'} $n: got $got, upstream ${e['output']}',
        );
      }
    }
    expect(compared, greaterThan(1000));
    expect(mismatches, isEmpty, reason: mismatches.take(30).join('\n'));
  }, skip: skip);

  // E. Every other CLDR locale (deferred date data; native digits; Persian
  // and Buddhist calendars). Older fixtures have no `formattedAll`: skipped.
  final all = list('formattedAll');
  test(
    'E. numbers and dates in every CLDR locale format like the browser',
    () async {
      CsMessageFormat.debugFormatDatesInUtc = true;
      addTearDown(() => CsMessageFormat.debugFormatDatesInUtc = false);
      final mismatches = <String>[];
      final locales = <String>{};
      for (final e in all) {
        final locale = e['locale']! as String;
        if (locales.add(locale)) await csLoadCldrDateData(locale);
        final message = e['message']! as String;
        final args = (e['args']! as Map).cast<String, Object?>();
        final got = _run(
          CsMessageFormat(parseIcuMessage(message), locale),
          args,
        );
        if (got != e['output']) {
          mismatches.add(
            '$locale $message $args: got ${jsonEncode(got)}, browser ${jsonEncode(e['output'])}',
          );
        }
      }
      final byLocale = <String>{for (final m in mismatches) m.split(' ').first};
      expect(
        mismatches,
        isEmpty,
        reason:
            '${mismatches.length} mismatches in ${byLocale.length} of ${locales.length} locales:\n'
            '${mismatches.take(60).join('\n')}',
      );
    },
    skip:
        skip ??
        (all.isEmpty
            ? 'Fixture predates step 5; rerun tool/i18n_oracle.'
            : null),
  );

  for (final group in ['number', 'date']) {
    test('${group == 'number' ? 'C. numbers' : 'D. dates and times'} format like upstream', () {
      CsMessageFormat.debugFormatDatesInUtc = true;
      addTearDown(() => CsMessageFormat.debugFormatDatesInUtc = false);
      final mismatches = <String>[];
      for (final e in list('formatted').where((e) => e['group'] == group)) {
        final locale = e['locale']! as String;
        final message = e['message']! as String;
        final args = (e['args']! as Map).cast<String, Object?>();
        final got = _run(
          CsMessageFormat(parseIcuMessage(message), locale),
          args,
        );
        if (got != e['output']) {
          mismatches.add(
            '$locale $message $args: got ${jsonEncode(got)}, upstream ${jsonEncode(e['output'])}',
          );
        }
      }
      expect(
        mismatches,
        isEmpty,
        reason:
            '${mismatches.length} mismatches:\n${mismatches.take(40).join('\n')}',
      );
    }, skip: skip);
  }
}
