// Produces theming fixtures from upstream @cloudscape-design/theming-runtime.
//
//   cd tool/theming_oracle && npm ci --ignore-scripts && npm run fixtures
// (npm run fixtures loads register.mjs, which resolves upstream's
// extensionless ESM imports.)
//
// Output: ../token_gen/test/fixtures/theming.json. When that file exists,
// tool/token_gen/test/theming_oracle_test.dart compares the Dart theming port
// against it. Rerun after bumping the preset or theming-runtime.
import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { validateOverride, merge, resolveTheme, resolveContext } from '@cloudscape-design/theming-runtime/shared/theme/index.js';
import { getContexts } from '@cloudscape-design/theming-runtime/shared/theme/validate.js';
import { generatePaletteFromSeed } from '@cloudscape-design/theming-runtime/shared/theme/color-generation/palette-generator.js';

const here = dirname(fileURLToPath(import.meta.url));
const preset = JSON.parse(readFileSync(join(here, '../upstream/visual-refresh.preset.json'), 'utf8'));
const runtimeVersion = JSON.parse(
  readFileSync(join(here, 'node_modules/@cloudscape-design/theming-runtime/package.json'), 'utf8'),
).version;

// Each scenario is a Cloudscape `Theme` object, exactly as passed to applyTheme().
// Keep in sync with `oracleScenarios` in tool/token_gen/test/theming_oracle_test.dart.
const scenarios = {
  none: { tokens: {} },
  tokens: {
    tokens: {
      colorBackgroundButtonPrimaryDefault: '#ff0000',
      colorTextLinkDefault: '{colorPrimary800}',
      colorBackgroundLayoutMain: { light: '#eeeeee' },
      colorTextAccent: { light: '#112233', dark: '#445566' },
      borderRadiusButton: '4px',
      fontFamilyBase: "'Inter', sans-serif",
      fontSizeBodyM: '15px',
      colorPrimary600: '#00ff00',
      spaceScaledXs: '99px',
    },
  },
  contexts: {
    tokens: {
      colorTextBodyDefault: '#010203',
      colorBorderDividerDefault: '{colorNeutral500}',
    },
    contexts: {
      'top-navigation': { tokens: { colorBackgroundContainerContent: '#123456', colorTextAccent: '#abcdef' } },
      flashbar: { tokens: { colorTextBodyDefault: { dark: '#fedcba' } } },
      'compact-table': { tokens: { borderRadiusContainer: '2px' } },
    },
  },
  palettes: {
    tokens: { colorTextAccent: '{colorPrimary700}' },
    referenceTokens: {
      color: {
        primary: '#7b2cbf',
        neutral: { seed: { light: '#5f6b7a', dark: '#8d99a8' } },
        warning: { seed: '#ffcc00', 600: '#aa7700' },
        success: { 500: '#00aa00' },
      },
    },
  },
  paletteModes: {
    tokens: {}, // upstream requires the field, even when empty
    referenceTokens: {
      color: {
        primary: { 600: { light: '#111111', dark: '#222222' } },
        neutral: { seed: { light: '#5f6b7a', dark: '#8d99a8' }, 850: { dark: '#0a0b0c' } },
      },
    },
  },
};

function run(override) {
  const validated = validateOverride(override, preset.themeable, getContexts(preset));
  const theme = merge(preset.theme, validated);
  const base = resolveTheme(theme);
  const contexts = {};
  for (const id of Object.keys(theme.contexts)) {
    contexts[id] = resolveContext(theme, theme.contexts[id]);
  }
  return { base, contexts };
}

const palettes = [];
for (const category of ['primary', 'neutral', 'warning', 'error', 'success', 'info']) {
  for (const seed of ['#0972d3', '#7b2cbf', '#ffcc00', '#5f6b7a', '#e0e0e0', '#101010', '#00aa00']) {
    for (const mode of [undefined, 'light', 'dark']) {
      palettes.push({ category, seed, mode: mode ?? null, palette: generatePaletteFromSeed(category, seed, true, mode) });
    }
  }
}

const out = {
  runtimeVersion,
  scenarios: Object.fromEntries(Object.entries(scenarios).map(([k, v]) => [k, { override: v, ...run(v) }])),
  palettes,
};
const target = join(here, '../token_gen/test/fixtures/theming.json');
mkdirSync(dirname(target), { recursive: true });
writeFileSync(target, JSON.stringify(out, null, 1) + '\n');
console.log(`Wrote ${target} (theming-runtime ${runtimeVersion}).`);
