// Checks the generated tokens against upstream.
//
// The design-tokens package is an independent oracle: upstream resolves its
// values itself, so this does not re-use the generator's resolver.
import 'dart:convert';
import 'dart:io';

import 'package:cloudscape_tokens/cloudscape_tokens.dart';
import 'package:test/test.dart';
import 'package:token_gen/token_gen.dart';

void main() {
  final root = findWorkspaceRoot();
  Map<String, Object?> readJson(String path) =>
      (jsonDecode(File('${root.path}/$path').readAsStringSync()) as Map)
          .cast<String, Object?>();
  final preset = readJson(presetFile);
  final theme = (preset['theme']! as Map).cast<String, Object?>();
  final presetTokens = (theme['tokens']! as Map).cast<String, Object?>();
  final variables = (preset['variablesMap']! as Map).cast<String, String>();
  final byCss = {for (final e in variables.entries) e.value: e.key};
  final designTokens = readJson(designTokensFile);

  CsTokens forState(String state) => switch (state) {
    'light' => CsTokens.resolve(),
    'dark' => CsTokens.resolve(colorMode: CsColorMode.dark),
    'comfortable' => CsTokens.resolve(),
    'compact' => CsTokens.resolve(density: CsDensity.compact),
    'default' => CsTokens.resolve(),
    'disabled' => CsTokens.resolve(motion: CsMotionMode.disabled),
    _ => throw StateError(state),
  };

  test('upstream version matches the lock file', () {
    final lock = readJson(lockFile);
    expect(csTokensUpstreamVersion, (lock['components']! as Map)['version']);
    expect(csTokensThemeId, theme['id']);
  });

  test('every upstream token is generated, and nothing else', () {
    expect(csTokenInfo.keys.toSet(), presetTokens.keys.toSet());
    expect(csTokenInfo.length, presetTokens.length);
  });

  test('metadata matches the preset', () {
    final themeable = (preset['themeable']! as List).toSet();
    final exposed = (preset['exposed']! as List).toSet();
    for (final e in csTokenInfo.entries) {
      expect(e.value.cssVariable, variables[e.key], reason: e.key);
      expect(e.value.themeable, themeable.contains(e.key), reason: e.key);
      expect(e.value.exposed, exposed.contains(e.key), reason: e.key);
    }
  });

  test('every token is readable in all 8 mode combinations', () {
    for (final c in CsColorMode.values) {
      for (final d in CsDensity.values) {
        for (final m in CsMotionMode.values) {
          final t = CsTokens.resolve(colorMode: c, density: d, motion: m);
          for (final name in csTokenInfo.keys) {
            expect(() => t[name], returnsNormally, reason: name);
          }
        }
      }
    }
  });

  void checkAgainst(
    Map<String, Object?> dtTokens,
    CsTokens Function(CsTokens) adjust,
    String label,
  ) {
    var checked = 0;
    for (final e in dtTokens.entries) {
      final name = byCss[e.key];
      expect(
        name,
        isNotNull,
        reason: 'design-tokens has unknown token ${e.key}',
      );
      final value = (e.value! as Map)[r'$value'];
      final perState = value is String
          ? {'light': value}
          : (value! as Map).cast<String, String>();
      for (final s in perState.entries) {
        final expected = parseToken(name!, s.value);
        final actual = adjust(forState(s.key))[name];
        final normalized = actual is CsPx && expected.value is double
            ? actual.value
            : actual;
        expect(
          valueEquals(normalized, expected.value),
          isTrue,
          reason:
              '$label $name (${s.key}): generated $actual, upstream ${s.value}',
        );
        checked++;
      }
    }
    expect(checked, greaterThan(0));
  }

  test('exposed tokens equal the design-tokens package (base theme)', () {
    checkAgainst(
      (designTokens['tokens']! as Map).cast<String, Object?>(),
      (t) => t,
      'base',
    );
  });

  final dtContexts = (designTokens['contexts']! as Map).cast<String, Object?>();
  test('design-tokens and generator know the same visual contexts', () {
    expect(
      CsVisualContextId.values.map((c) => c.id).toSet(),
      dtContexts.keys.toSet(),
    );
  });
  for (final id in CsVisualContextId.values) {
    test(
      'exposed tokens equal the design-tokens package (context ${id.id})',
      () {
        final ctx = (dtContexts[id.id]! as Map).cast<String, Object?>();
        checkAgainst(
          (ctx['tokens']! as Map).cast<String, Object?>(),
          (t) => t.inContext(id),
          id.id,
        );
      },
    );
  }
}
