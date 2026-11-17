import 'package:cloudscape_tokens/cloudscape_tokens.dart';
import 'package:test/test.dart';

Iterable<(CsColorMode, CsDensity, CsMotionMode)> get _allModes sync* {
  for (final c in CsColorMode.values) {
    for (final d in CsDensity.values) {
      for (final m in CsMotionMode.values) {
        yield (c, d, m);
      }
    }
  }
}

bool _eq(Object a, Object b) {
  if (a is List && b is List) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!_eq(a[i] as Object, b[i] as Object)) return false;
    }
    return true;
  }
  return a == b;
}

/// Tokens whose direct reference in [state] is [target].
Iterable<String> _dependentsOf(String target, String state) => csTokenInfo
    .entries
    .where((e) => e.value.references[state] == target)
    .map((e) => e.key);

void main() {
  group('no override reproduces the generated tokens', () {
    final resolver = CsThemeResolver();
    test('base theme in all modes', () {
      for (final (c, d, m) in _allModes) {
        final t = resolver.resolve(colorMode: c, density: d, motion: m);
        final expected = CsTokens.resolve(colorMode: c, density: d, motion: m);
        for (final name in csTokenInfo.keys) {
          expect(_eq(t[name], expected[name]), isTrue, reason: name);
        }
      }
    });
    for (final id in CsVisualContextId.values) {
      test('context ${id.id} in all modes', () {
        for (final (c, d, m) in _allModes) {
          final t = resolver.resolve(
            colorMode: c,
            density: d,
            motion: m,
            contexts: [id],
          );
          final expected = CsTokens.resolve(
            colorMode: c,
            density: d,
            motion: m,
          ).inContext(id);
          for (final name in csTokenInfo.keys) {
            expect(
              _eq(t[name], expected[name]),
              isTrue,
              reason: '$name ($c, $d, $m): ${t[name]} vs ${expected[name]}',
            );
          }
        }
      });
    }
  });

  group('root overrides', () {
    test('a single value applies to every mode and re-resolves dependents', () {
      final dependents = _dependentsOf(
        'colorTextLinkDefault',
        'light',
      ).toList();
      expect(dependents, isNotEmpty);
      final r = CsThemeResolver(
        const CsThemeOverride(tokens: {'colorTextLinkDefault': '#ff0000'}),
      );
      for (final mode in CsColorMode.values) {
        final t = r.resolve(colorMode: mode);
        expect(t.colorTextLinkDefault, const CsColor(0xFFFF0000));
        if (mode == CsColorMode.light) {
          for (final d in dependents) {
            expect(t[d], const CsColor(0xFFFF0000), reason: d);
          }
        }
      }
    });

    test('CsModeValues only replaces the named states', () {
      final r = CsThemeResolver(
        CsThemeOverride(
          tokens: {
            'colorBackgroundLayoutMain': CsModeValues.color(light: '#eeeeee'),
          },
        ),
      );
      expect(r.resolve().colorBackgroundLayoutMain, const CsColor(0xFFEEEEEE));
      expect(
        r.resolve(colorMode: CsColorMode.dark).colorBackgroundLayoutMain,
        CsTokens.resolve(colorMode: CsColorMode.dark).colorBackgroundLayoutMain,
      );
    });

    test('references, typed values and CSS strings', () {
      final r = CsThemeResolver(
        const CsThemeOverride(
          tokens: {
            'colorTextAccent': '{colorPrimary800}',
            'borderRadiusButton': 4, // int is accepted for double tokens
            'fontFamilyBase': "'Inter', sans-serif",
            'fontSizeBodyM': '15px',
          },
        ),
      );
      final t = r.resolve();
      expect(t.colorTextAccent, t.colorPrimary800);
      expect(t.borderRadiusButton, 4.0);
      expect(t.fontFamilyBase, ['Inter', 'sans-serif']);
      expect(t.fontSizeBodyM, 15.0);
    });

    test('tokens that are not themeable are ignored with a warning', () {
      final warnings = <String>[];
      final r = CsThemeResolver(
        const CsThemeOverride(
          tokens: {'colorPrimary600': '#00ff00', 'spaceScaledXs': '99px'},
        ),
        warnings.add,
      );
      expect(r.resolve().colorPrimary600, CsTokens.resolve().colorPrimary600);
      expect(r.resolve().spaceScaledXs, CsTokens.resolve().spaceScaledXs);
      expect(warnings, hasLength(2));
      expect(warnings.first, contains('not themeable'));
    });

    test('invalid input throws', () {
      expect(
        () => CsThemeResolver(const CsThemeOverride(tokens: {'nope': '#fff'})),
        throwsArgumentError,
      );
      expect(
        () => CsThemeResolver(
          const CsThemeOverride(tokens: {'colorTextAccent': '4px'}),
        ),
        throwsFormatException,
      );
      expect(
        () => CsThemeResolver(
          const CsThemeOverride(tokens: {'colorTextAccent': 4.0}),
        ),
        throwsArgumentError,
      );
      expect(
        () => CsThemeResolver(
          const CsThemeOverride(tokens: {'colorTextAccent': '{nope}'}),
        ),
        throwsArgumentError,
      );
    });
  });

  group('visual contexts', () {
    test('base context beats a root override; unlisted tokens take it', () {
      const id = CsVisualContextId.topNavigation;
      final listed = csVisualContexts[id]!.tokenNames;
      expect(listed, contains('colorTextBodyDefault'));
      final r = CsThemeResolver(
        const CsThemeOverride(tokens: {'colorTextBodyDefault': '#010203'}),
      );
      expect(r.resolve().colorTextBodyDefault, const CsColor(0xFF010203));
      expect(
        r.resolve(contexts: [id]).colorTextBodyDefault,
        CsTokens.resolve().inContext(id).colorTextBodyDefault,
      );
      // borderRadiusButton is not declared by top-navigation.
      expect(listed, isNot(contains('borderRadiusButton')));
      final r2 = CsThemeResolver(
        const CsThemeOverride(tokens: {'borderRadiusButton': '4px'}),
      );
      expect(r2.resolve(contexts: [id]).borderRadiusButton, 4.0);
    });

    test('a context override beats everything inside that context only', () {
      final r = CsThemeResolver(
        const CsThemeOverride(
          tokens: {'colorTextBodyDefault': '#010203'},
          contexts: {
            CsVisualContextId.flashbar: {'colorTextBodyDefault': '#fedcba'},
          },
        ),
      );
      expect(
        r.resolve(contexts: [CsVisualContextId.flashbar]).colorTextBodyDefault,
        const CsColor(0xFFFEDCBA),
      );
      expect(
        r.resolve(contexts: [CsVisualContextId.alert]).colorTextBodyDefault,
        isNot(const CsColor(0xFFFEDCBA)),
      );
    });

    test('combined contexts follow the upstream selectors', () {
      expect(
        CsThemeResolver.contextStack([
          CsVisualContextId.header,
          CsVisualContextId.alert,
        ]),
        [
          CsVisualContextId.header,
          CsVisualContextId.alert,
          CsVisualContextId.alertHeader,
        ],
      );
      expect(CsThemeResolver.contextStack([CsVisualContextId.alert]), [
        CsVisualContextId.alert,
      ]);
      expect(
        CsThemeResolver.contextStack([
          CsVisualContextId.alert,
          CsVisualContextId.header,
        ]),
        [CsVisualContextId.alert, CsVisualContextId.header],
      );
    });

    test(
      'nested contexts cascade: inner declarations win, others come from outer',
      () {
        final r = CsThemeResolver();
        final stack = CsThemeResolver.contextStack([
          CsVisualContextId.header,
          CsVisualContextId.alert,
        ]);
        final nested = r.resolve(contexts: stack);
        final alertHeader = r.resolve(
          contexts: [CsVisualContextId.alertHeader],
        );
        final header = r.resolve(contexts: [CsVisualContextId.header]);
        for (final name
            in csVisualContexts[CsVisualContextId.alertHeader]!.tokenNames) {
          expect(_eq(nested[name], alertHeader[name]), isTrue, reason: name);
        }
        const notInAlertContexts = 'borderRadiusButton';
        expect(nested[notInAlertContexts], header[notInAlertContexts]);
      },
    );
  });

  group('palettes (referenceTokens)', () {
    test('a primary seed regenerates the palette and its dependents', () {
      final r = CsThemeResolver(
        const CsThemeOverride(
          referencePalettes: {'primary': CsPaletteInput(seed: '#7b2cbf')},
        ),
      );
      final t = r.resolve();
      final base = CsTokens.resolve();
      expect(t.colorPrimary600, isNot(base.colorPrimary600));
      // colorTextAccent references colorPrimary600 in light mode.
      expect(
        csTokenInfo['colorTextAccent']!.references['light'],
        'colorPrimary600',
      );
      expect(t.colorTextAccent, t.colorPrimary600);
      // A seed that is not adjusted is kept exactly at its base position.
      final palette = generatePaletteFromSeed('primary', '#7b2cbf');
      expect(palette.values, contains('#7b2cbf'));
    });

    test('light-mode primary seeds sit at step 600 after adjustment', () {
      final palette = generatePaletteFromSeed(
        'primary',
        '#0972d3',
        mode: 'light',
      );
      // Upstream darkens a too-light seed (tone > 47) first, then pins the
      // adjusted seed at step 600.
      expect(palette['600'], palette['seed']);
      expect(palette['seed'], isNot('#0972d3'));
      expect(palette.keys, containsAll(['50', '100', '500', '900', '1000']));
    });

    test('neutral chroma is capped and every step is valid', () {
      final palette = processPaletteInput('neutral', '#ff0000');
      for (final step in palette.keys) {
        expect(isValidPaletteStep(step), isTrue);
      }
      expect(palette.keys, containsAll([50, 150, 250, 950, 1000]));
    });

    test(
      'explicit steps replace generated ones; mode seeds give mode maps',
      () {
        final p = processPaletteInput('warning', {
          'seed': '#ffcc00',
          600: '#aa7700',
        });
        expect(p[600], '#aa7700');
        final m = processPaletteInput('neutral', {
          'seed': {'light': '#5f6b7a', 'dark': '#8d99a8'},
        });
        expect(m[850], isA<Map<String, String>>());
        expect((m[850]! as Map).keys, containsAll(['light', 'dark']));
      },
    );

    test('defaultMode contexts pin explicit palette steps to that mode', () {
      // Upstream derives reference tokens from the palette input's keys:
      // explicit steps count, seed-generated steps do not.
      final r = CsThemeResolver(
        CsThemeOverride(
          referencePalettes: {
            'primary': CsPaletteInput(
              steps: {
                600: CsModeValues.color(light: '#111111', dark: '#222222'),
              },
            ),
            'neutral': CsPaletteInput(
              seed: CsModeValues.color(light: '#5f6b7a', dark: '#8d99a8'),
            ),
          },
        ),
      );
      const id = CsVisualContextId.topNavigation;
      expect(id.defaultColorMode, CsColorMode.dark);
      // Explicit step: dark value inside top navigation even in light mode.
      expect(
        r.resolve(contexts: [id]).colorPrimary600,
        const CsColor(0xFF222222),
      );
      expect(r.resolve().colorPrimary600, const CsColor(0xFF111111));
      // Seed-only category: no longer reference tokens, so the context's own
      // (base) declaration wins over the generated root value.
      expect(
        r.resolve(contexts: [id]).colorNeutral850,
        CsTokens.resolve().inContext(id).colorNeutral850,
      );
      expect(
        r.resolve().colorNeutral850,
        isNot(CsTokens.resolve().colorNeutral850),
      );
    });
  });
}
