// Port of upstream theming-runtime `shared/theme/color-generation/*` and
// `processReferenceTokens` (theming-runtime 1.0.139): generates Cloudscape
// color palettes from a seed color using HCT.
import 'package:material_color_utilities/material_color_utilities.dart';

class _Position {
  const _Position(
    this.position,
    this.chromaFraction,
    this.minTone,
    this.maxTone,
  );

  final int position;
  final double chromaFraction;
  final double minTone;
  final double maxTone;
}

class _BaseInfo {
  _BaseInfo({
    required this.hue,
    required this.chroma,
    required this.basePosition,
    required this.toneRangePosition,
    required this.seedHex,
    required this.seedWasAdjusted,
    required this.exactSeedPosition,
  });

  final double hue;
  final double chroma;
  final _Position basePosition;
  final double toneRangePosition;
  final String seedHex;
  final bool seedWasAdjusted;
  final int? exactSeedPosition;
}

class _PaletteSpecification {
  _PaletteSpecification(this.specs, [double? maxChroma])
    : maxChroma = maxChroma ?? 200;

  final List<_Position> specs;
  final double maxChroma;

  _Position? findColorSpecification(Hct color) {
    final tone = _jsRound(color.tone);
    for (final p in specs) {
      if (tone <= p.maxTone && tone >= p.minTone) return p;
    }
    final nearest = findNearestValidTone(tone.toDouble());
    for (final p in specs) {
      if (nearest <= p.maxTone && nearest >= p.minTone) return p;
    }
    return null;
  }

  int findNearestValidTone(double inputTone) {
    var closest = inputTone;
    var minDistance = double.infinity;
    final preferDarker = inputTone < 50;
    for (final s in specs) {
      final mid = (s.minTone + s.maxTone) / 2;
      final distance = (inputTone - mid).abs();
      if (distance < minDistance) {
        minDistance = distance;
        closest = mid;
      } else if (distance == minDistance && preferDarker && mid < closest) {
        closest = mid;
      }
    }
    return _jsRound(closest);
  }

  double toneProportion(_Position p, Hct color) {
    final proportion = (color.tone - p.minTone) / (p.maxTone - p.minTone);
    return proportion.clamp(0, 1).toDouble();
  }

  double toneForProportion(_Position p, double proportion) {
    final base = p.minTone + (p.maxTone - p.minTone) * proportion;
    const bias = 0.5;
    if (p.position <= 500) return base + (p.maxTone - base) * bias;
    return base - (base - p.minTone) * bias;
  }

  Hct adjustSeedColor(Hct hct, String? mode) => hct;

  int? exactSeedPosition(Hct hct, String? mode) => null;

  Map<String, String> getPalette(
    String hexBaseColor,
    bool autoAdjust,
    String? mode,
  ) {
    var hex = hexBaseColor;
    var adjusted = false;
    if (autoAdjust) {
      final original = hex;
      hex = _hexFromArgb(adjustSeedColor(_hexToHct(hex), mode).toInt());
      adjusted = original != hex;
    }
    final hct = _hexToHct(hex);
    final exact = exactSeedPosition(hct, mode);
    final basePosition = exact != null
        ? specs.firstWhere((s) => s.position == exact)
        : findColorSpecification(hct);
    if (basePosition == null) {
      throw ArgumentError(
        'Seed color $hex does not match any palette position specification',
      );
    }
    final info = _BaseInfo(
      hue: hct.hue,
      chroma: maxChroma < 50
          ? hct.chroma
          : hct.chroma / basePosition.chromaFraction,
      basePosition: basePosition,
      toneRangePosition: exact != null
          ? 0.5
          : toneProportion(basePosition, hct),
      seedHex: hex,
      seedWasAdjusted: adjusted,
      exactSeedPosition: exact,
    );
    final colors = <String, String>{'seed': hex};
    for (final c in specs) {
      final tone = toneForProportion(c, info.toneRangePosition);
      final isBase = info.basePosition.position == c.position;
      final isExact = info.exactSeedPosition == c.position;
      var chroma = c.chromaFraction * info.chroma;
      if (chroma > maxChroma) chroma = maxChroma;
      colors['${c.position}'] = (isBase && !info.seedWasAdjusted) || isExact
          ? info.seedHex
          : _hexFromArgb(Hct.from(info.hue, chroma, tone).toInt());
    }
    return colors;
  }
}

class _PrimarySpec extends _PaletteSpecification {
  _PrimarySpec()
    : super(const [
        _Position(50, 0.2, 97, 98),
        _Position(100, 0.3, 91, 96),
        _Position(200, 0.5, 84, 91),
        _Position(300, 0.7, 75, 84),
        _Position(400, 1.0, 65, 75),
        _Position(500, 1.0, 48, 65),
        _Position(600, 1.0, 44, 47),
        _Position(700, 1.1, 34, 44),
        _Position(800, 1.15, 25, 34),
        _Position(900, 1.2, 11, 25),
        _Position(1000, 1.25, 3, 5),
      ]);

  _Position get _p600 => specs.firstWhere((s) => s.position == 600);
  _Position get _p400 => specs.firstWhere((s) => s.position == 400);

  @override
  Hct adjustSeedColor(Hct hct, String? mode) {
    final tone = hct.tone;
    if (mode == 'light' && tone > _p600.maxTone) {
      return Hct.from(hct.hue, hct.chroma, (_p600.minTone + _p600.maxTone) / 2);
    }
    if (mode == 'dark' && tone < _p400.minTone) {
      return Hct.from(hct.hue, hct.chroma, (_p400.minTone + _p400.maxTone) / 2);
    }
    return hct;
  }

  @override
  int? exactSeedPosition(Hct hct, String? mode) {
    if (mode == 'light' && hct.tone <= _p600.maxTone) return 600;
    if (mode == 'dark' && hct.tone >= _p400.minTone) return 400;
    return null;
  }
}

class _NeutralSpec extends _PaletteSpecification {
  _NeutralSpec()
    : super(const [
        _Position(50, 0.5, 98, 99),
        _Position(100, 0.5, 97, 98),
        _Position(150, 0.5, 96, 97),
        _Position(200, 0.5, 96, 96),
        _Position(250, 0.5, 93, 95),
        _Position(300, 0.5, 88, 92),
        _Position(350, 0.5, 80, 85),
        _Position(400, 0.75, 72, 76),
        _Position(450, 0.75, 68, 72),
        _Position(500, 0.75, 55, 58),
        _Position(550, 0.75, 46, 52),
        _Position(600, 0.75, 44, 46),
        _Position(650, 0.75, 28, 35),
        _Position(700, 0.75, 22, 27),
        _Position(750, 0.75, 14, 20),
        _Position(800, 0.75, 10, 14),
        _Position(850, 0.75, 5, 7),
        _Position(900, 0.75, 3, 5),
        _Position(950, 0.75, 2, 3),
        _Position(1000, 0.75, 1, 2),
      ], 15);

  @override
  Hct adjustSeedColor(Hct hct, String? mode) {
    if (hct.chroma > maxChroma) {
      return Hct.from(
        hct.hue,
        maxChroma,
        findNearestValidTone(hct.tone).toDouble(),
      );
    }
    return hct;
  }
}

class _WarningSpec extends _PaletteSpecification {
  _WarningSpec()
    : super(const [
        _Position(50, 0.5, 97, 98),
        _Position(100, 0.5, 95, 97),
        _Position(200, 0.5, 90, 95),
        _Position(300, 0.75, 86, 90),
        _Position(400, 1.5, 82, 86),
        _Position(500, 1.5, 75, 82),
        _Position(600, 1.0, 65, 75),
        _Position(700, 1.1, 55, 65),
        _Position(800, 1.15, 47, 55),
        _Position(900, 1.2, 41, 47),
        _Position(1000, 1.25, 5, 15),
      ]);
}

/// JavaScript `Math.round` (halves round towards +infinity).
int _jsRound(double v) => (v + 0.5).floor();

final _hex = RegExp(r'^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$');
final _rgb = RegExp(r'rgba?\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)');

Hct _hexToHct(String color) {
  final trimmed = color.trim();
  if (trimmed.startsWith('#')) {
    if (!_hex.hasMatch(trimmed)) {
      throw ArgumentError('Invalid hex color: $color');
    }
    var hex = trimmed.substring(1);
    if (hex.length == 3) hex = hex.split('').map((c) => '$c$c').join();
    return Hct.fromInt(0xFF000000 | int.parse(hex, radix: 16));
  }
  final m = _rgb.firstMatch(trimmed);
  if (m != null) {
    final r = int.parse(m[1]!) & 0xFF,
        g = int.parse(m[2]!) & 0xFF,
        b = int.parse(m[3]!) & 0xFF;
    return Hct.fromInt(0xFF000000 | (r << 16) | (g << 8) | b);
  }
  throw ArgumentError(
    'Unsupported color format: $color. Supported formats: #hex, rgb(), rgba()',
  );
}

String _hexFromArgb(int argb) =>
    '#${(argb & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

/// Upstream `generatePaletteFromSeed(category, seed, autoAdjust, mode)`.
///
/// Returns hex colors keyed by palette step (`'50'`, `'100'`, ...) plus
/// `'seed'` (the possibly adjusted seed).
Map<String, String> generatePaletteFromSeed(
  String category,
  String seed, {
  bool autoAdjust = true,
  String? mode,
}) {
  final spec = switch (category) {
    'neutral' => _NeutralSpec(),
    'warning' => _WarningSpec(),
    _ => _PrimarySpec(),
  };
  return spec.getPalette(seed, autoAdjust, mode);
}

/// Upstream `isValidPaletteStep`.
bool isValidPaletteStep(int step) =>
    step >= 50 && step <= 1000 && step % 50 == 0;

/// Upstream `processColorPaletteInput`: the palette for one category.
///
/// [input] is a seed string, or a map with optional `'seed'` (a string, or a
/// map of color mode → seed) and explicit steps (`50`/`'50'` → value, where a
/// value is a color string or a map of color mode → color string).
///
/// Returns step → value, where a value is a hex string or a mode map.
Map<int, Object> processPaletteInput(String category, Object input) {
  if (input is String) {
    final palette = generatePaletteFromSeed(category, input);
    return {
      for (final e in palette.entries)
        if (e.key != 'seed') int.parse(e.key): e.value,
    };
  }
  if (input is! Map) {
    throw ArgumentError.value(
      input,
      'input',
      'Expected a seed string or a map',
    );
  }
  final generated = <int, Object>{};
  final seed = input['seed'];
  if (seed is String) {
    for (final e in generatePaletteFromSeed(category, seed).entries) {
      if (e.key != 'seed') generated[int.parse(e.key)] = e.value;
    }
  } else if (seed is Map) {
    for (final m in seed.entries) {
      final seedColor = m.value;
      if (seedColor is! String) continue;
      final mode = m.key as String;
      final palette = generatePaletteFromSeed(category, seedColor, mode: mode);
      for (final e in palette.entries) {
        final step = int.tryParse(e.key);
        if (step == null || !isValidPaletteStep(step)) continue;
        final existing = generated[step];
        generated[step] = existing is Map<String, String>
            ? {...existing, mode: e.value}
            : <String, String>{mode: e.value};
      }
    }
  } else if (seed != null) {
    throw ArgumentError.value(seed, 'seed', 'Expected a string or a mode map');
  }
  final result = {...generated};
  for (final e in input.entries) {
    if (e.key == 'seed') continue;
    final step = e.key is int ? e.key as int : int.tryParse('${e.key}');
    final value = e.value as Object?;
    if (step == null || value == null || !isValidPaletteStep(step)) continue;
    final g = generated[step];
    result[step] = g is Map && value is Map
        ? <String, String>{
            ...g.cast<String, String>(),
            ...value.cast<String, String>(),
          }
        : value;
  }
  return result;
}
