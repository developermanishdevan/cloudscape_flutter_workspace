import 'package:cloudscape_tokens/cloudscape_tokens.dart';
import 'package:test/test.dart';

void main() {
  test('resolve picks the group for each mode', () {
    final light = CsTokens.resolve();
    final dark = CsTokens.resolve(colorMode: CsColorMode.dark);
    expect(light.colorPrimary600, const CsColor(0xFF006CE0));
    expect(light.colorTextBodyDefault, isNot(dark.colorTextBodyDefault));
    expect(dark.colorMode, CsColorMode.dark);
    expect(identical(dark.colorTokens, CsColorModeTokens.dark), isTrue);
  });

  test('density changes scaled spacing', () {
    final comfortable = CsTokens.resolve();
    final compact = CsTokens.resolve(density: CsDensity.compact);
    expect(comfortable.spaceScaledXs, 8);
    expect(compact.spaceScaledXs, 4);
  });

  test('disabled motion zeroes durations', () {
    final normal = CsTokens.resolve();
    final disabled = CsTokens.resolve(motion: CsMotionMode.disabled);
    expect(normal.motionDurationExtraFast, const Duration(milliseconds: 45));
    expect(disabled.motionDurationExtraFast, Duration.zero);
  });

  test('operator [] matches the typed getter', () {
    final t = CsTokens.resolve();
    expect(t['colorPrimary600'], t.colorPrimary600);
    expect(t['spaceScaledXs'], t.spaceScaledXs);
    expect(() => t['notAToken'], throwsArgumentError);
  });

  group('withOverrides', () {
    final base = CsTokens.resolve();

    test('replaces named tokens across groups', () {
      final t = base.withOverrides({
        'colorPrimary600': const CsColor(0xFF112233),
        'spaceScaledXs': 10.0,
      });
      expect(t.colorPrimary600, const CsColor(0xFF112233));
      expect(t.spaceScaledXs, 10);
      expect(t.colorPrimary500, base.colorPrimary500);
    });

    test('rejects unknown names and wrong types', () {
      expect(() => base.withOverrides({'nope': 1.0}), throwsArgumentError);
      expect(
        () => base.withOverrides({'colorPrimary600': 1.0}),
        throwsA(isA<TypeError>()),
      );
    });

    test('empty overrides return the same instance', () {
      expect(identical(base.withOverrides(const {}), base), isTrue);
    });
  });

  test('every visual context is defined and changes something', () {
    expect(csVisualContexts.keys.toSet(), CsVisualContextId.values.toSet());
    for (final id in CsVisualContextId.values) {
      final ctx = csVisualContexts[id]!;
      final count =
          ctx.color.values.fold(0, (n, m) => n + m.length) +
          ctx.density.values.fold(0, (n, m) => n + m.length) +
          ctx.motion.values.fold(0, (n, m) => n + m.length) +
          ctx.statics.length;
      expect(count, greaterThan(0), reason: id.id);
    }
  });

  test('compact-table context switches to compact spacing', () {
    final t = CsTokens.resolve().inContext(CsVisualContextId.compactTable);
    expect(
      t.spaceScaledXs,
      CsTokens.resolve(density: CsDensity.compact).spaceScaledXs,
    );
  });

  test('every token has a group and metadata', () {
    final groups = {
      ...CsColorModeTokens.names,
      ...CsDensityModeTokens.names,
      ...CsMotionModeTokens.names,
      ...CsStaticTokens.names,
    };
    expect(groups, csTokenInfo.keys.toSet());
    expect(
      CsColorModeTokens.names.length +
          CsDensityModeTokens.names.length +
          CsMotionModeTokens.names.length +
          CsStaticTokens.names.length,
      csTokenInfo.length,
    );
  });
}
