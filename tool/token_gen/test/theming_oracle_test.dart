// Compares the Dart theming port with upstream theming-runtime output.
//
// The fixture is produced by tool/theming_oracle (Node, dev-only):
//   cd tool/theming_oracle && npm ci --ignore-scripts && npm run fixtures
// Without the fixture these tests are skipped.
import 'dart:convert';
import 'dart:io';

import 'package:cloudscape_tokens/cloudscape_tokens.dart';
import 'package:test/test.dart';
import 'package:token_gen/token_gen.dart';

/// Must match `scenarios` in tool/theming_oracle/oracle.mjs.
final oracleScenarios = <String, CsThemeOverride>{
  'none': const CsThemeOverride(),
  'tokens': CsThemeOverride(
    tokens: {
      'colorBackgroundButtonPrimaryDefault': '#ff0000',
      'colorTextLinkDefault': '{colorPrimary800}',
      'colorBackgroundLayoutMain': CsModeValues.color(light: '#eeeeee'),
      'colorTextAccent': CsModeValues.color(light: '#112233', dark: '#445566'),
      'borderRadiusButton': '4px',
      'fontFamilyBase': "'Inter', sans-serif",
      'fontSizeBodyM': '15px',
      'colorPrimary600': '#00ff00',
      'spaceScaledXs': '99px',
    },
  ),
  'contexts': CsThemeOverride(
    tokens: {
      'colorTextBodyDefault': '#010203',
      'colorBorderDividerDefault': '{colorNeutral500}',
    },
    contexts: {
      CsVisualContextId.topNavigation: {
        'colorBackgroundContainerContent': '#123456',
        'colorTextAccent': '#abcdef',
      },
      CsVisualContextId.flashbar: {
        'colorTextBodyDefault': CsModeValues.color(dark: '#fedcba'),
      },
      CsVisualContextId.compactTable: {'borderRadiusContainer': '2px'},
    },
  ),
  'palettes': CsThemeOverride(
    tokens: {'colorTextAccent': '{colorPrimary700}'},
    referencePalettes: {
      'primary': const CsPaletteInput(seed: '#7b2cbf'),
      'neutral': CsPaletteInput(
        seed: CsModeValues.color(light: '#5f6b7a', dark: '#8d99a8'),
      ),
      'warning': const CsPaletteInput(seed: '#ffcc00', steps: {600: '#aa7700'}),
      'success': const CsPaletteInput(steps: {500: '#00aa00'}),
    },
  ),
  'paletteModes': CsThemeOverride(
    referencePalettes: {
      'primary': CsPaletteInput(
        steps: {600: CsModeValues.color(light: '#111111', dark: '#222222')},
      ),
      'neutral': CsPaletteInput(
        seed: CsModeValues.color(light: '#5f6b7a', dark: '#8d99a8'),
        steps: {850: CsModeValues.color(dark: '#0a0b0c')},
      ),
    },
  ),
};

const _states = {
  CsTokenAxis.color: ['light', 'dark'],
  CsTokenAxis.density: ['comfortable', 'compact'],
  CsTokenAxis.motion: ['default', 'disabled'],
};

void main() {
  final fixture = File(
    '${findWorkspaceRoot().path}/tool/token_gen/test/fixtures/theming.json',
  );
  final skip = fixture.existsSync()
      ? null
      : 'No upstream fixture; run tool/theming_oracle (see oracle.mjs).';
  final data = fixture.existsSync()
      ? (jsonDecode(fixture.readAsStringSync()) as Map).cast<String, Object?>()
      : const <String, Object?>{};

  void compare(
    Map<String, Object?> expected,
    CsTokens Function(CsColorMode, CsDensity, CsMotionMode) actual,
    String label,
  ) {
    for (final e in expected.entries) {
      final info = csTokenInfo[e.key];
      if (info == null) continue; // generated palette steps with no token
      final raw = e.value;
      final perState = raw is String
          ? null
          : (raw! as Map).cast<String, String>();
      for (final c in CsColorMode.values) {
        for (final d in CsDensity.values) {
          for (final m in CsMotionMode.values) {
            final String css;
            if (perState == null) {
              css = raw! as String;
            } else {
              final idx = switch (info.axis) {
                CsTokenAxis.color => c.index,
                CsTokenAxis.density => d.index,
                CsTokenAxis.motion => m.index,
                CsTokenAxis.none => throw StateError(
                  'mode value for static ${e.key}',
                ),
              };
              css = perState[_states[info.axis]![idx]]!;
            }
            final want = parseToken(e.key, css).value;
            final got = actual(c, d, m)[e.key];
            final normalized = got is CsPx && want is double ? got.value : got;
            expect(
              valueEquals(normalized, want),
              isTrue,
              reason: '$label ${e.key} ($c, $d, $m): got $got, upstream $css',
            );
          }
        }
      }
    }
  }

  final scenarios =
      (data['scenarios'] as Map?)?.cast<String, Object?>() ?? const {};
  for (final name in oracleScenarios.keys) {
    final scenarioSkip =
        skip ??
        (scenarios.containsKey(name)
            ? null
            : 'Fixture predates scenario "$name"; rerun tool/theming_oracle.');
    group('scenario $name', () {
      test('base theme', () {
        final s = (scenarios[name]! as Map).cast<String, Object?>();
        final r = CsThemeResolver(oracleScenarios[name]!);
        compare(
          (s['base']! as Map).cast<String, Object?>(),
          (c, d, m) => r.resolve(colorMode: c, density: d, motion: m),
          name,
        );
      }, skip: scenarioSkip);
      for (final id in CsVisualContextId.values) {
        test('context ${id.id}', () {
          final s = (scenarios[name]! as Map).cast<String, Object?>();
          final ctx = ((s['contexts']! as Map)[id.id]! as Map)
              .cast<String, Object?>();
          final r = CsThemeResolver(oracleScenarios[name]!);
          compare(
            ctx,
            (c, d, m) =>
                r.resolve(colorMode: c, density: d, motion: m, contexts: [id]),
            '$name/${id.id}',
          );
        }, skip: scenarioSkip);
      }
    });
  }

  test('palettes match upstream exactly', () {
    for (final p in (data['palettes']! as List).cast<Map<String, Object?>>()) {
      final got = generatePaletteFromSeed(
        p['category']! as String,
        p['seed']! as String,
        mode: p['mode'] as String?,
      );
      expect(
        got,
        (p['palette']! as Map).cast<String, String>(),
        reason: '${p['category']} ${p['seed']} ${p['mode']}',
      );
    }
  }, skip: skip);
}
