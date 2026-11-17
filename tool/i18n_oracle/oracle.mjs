// Produces i18n fixtures by formatting messages with upstream's
// intl-messageformat (the formatter Cloudscape's I18nProvider uses).
//
//   cd tool/i18n_oracle && npm ci --ignore-scripts && npm run fixtures
//
// (`npm run fixtures` sets TZ=UTC so dates are deterministic.)
// Output: ../../packages/cloudscape_flutter/test/fixtures/i18n_oracle.json.
// When it exists, packages/cloudscape_flutter/test/i18n_oracle_test.dart
// compares the Dart port against it.
import { createRequire } from 'node:module';
import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const require = createRequire(import.meta.url);
const { IntlMessageFormat } = require('intl-messageformat');
const here = dirname(fileURLToPath(import.meta.url));
const upstream = join(here, '../upstream');
const lock = JSON.parse(readFileSync(join(upstream, 'upstream.json'), 'utf8'));
const namespace = 'cloudscape-design-components';

if (process.env.TZ !== 'UTC') throw new Error('Run with TZ=UTC (use `npm run fixtures`).');

/** Formats with upstream semantics; errors become `{error: name}`. */
function run(message, locale, args) {
  try {
    const out = new IntlMessageFormat(message, locale).format(args);
    return typeof out === 'string' ? out : { parts: out.map(String) };
  } catch (e) {
    return { error: e.constructor?.name ?? 'Error' };
  }
}

// Tag handlers are encoded as `{"$tag": true}` in the fixture; the Dart test
// recreates the same handler: chunks => `<name>${chunks.join('')}</name>`.
function materialize(args) {
  const out = {};
  for (const [k, v] of Object.entries(args)) {
    out[k] = v && typeof v === 'object' && v.$tag ? chunks => `<${k}>${chunks.join('')}</${k}>` : v;
  }
  return out;
}

// --- A. Every upstream message, all locales -------------------------------
const pluralValues = [0, 1, 2, 3, 5, 11, 21, 100, 1.5];

function collect(nodes, vars) {
  for (const n of nodes) {
    if (n.type === 1) vars[n.value] ??= { kind: 'arg' };
    if (n.type === 5) {
      const v = (vars[n.value] = vars[n.value]?.kind === 'select' ? vars[n.value] : { kind: 'select', keys: new Set() });
      for (const [k, o] of Object.entries(n.options)) {
        v.keys.add(k);
        collect(o.value, vars);
      }
    }
    if (n.type === 6) {
      vars[n.value] = { kind: 'plural' };
      for (const o of Object.values(n.options)) collect(o.value, vars);
    }
    if (n.type === 8) {
      vars[n.value] = { kind: 'tag' };
      collect(n.children, vars);
    }
  }
}

function valuesOf(name, v) {
  switch (v.kind) {
    case 'arg':
      return [`<${name}>`];
    case 'plural':
      return pluralValues;
    case 'tag':
      return [{ $tag: true }];
    case 'select': {
      const keys = [...v.keys].filter(k => k !== 'other');
      const typed = keys.map(k => (k === 'true' ? true : k === 'false' ? false : k));
      return [...typed, '__unmatched__'];
    }
  }
}

function variants(vars) {
  const names = Object.keys(vars);
  const values = Object.fromEntries(names.map(n => [n, valuesOf(n, vars[n])]));
  const base = Object.fromEntries(names.map(n => [n, values[n][0]]));
  const out = [base];
  for (const n of names) {
    for (const v of values[n].slice(1)) out.push({ ...base, [n]: v });
  }
  return out;
}

const messages = [];
for (const locale of lock.locales) {
  const bundle = JSON.parse(readFileSync(join(upstream, 'i18n', `${locale}.json`), 'utf8'))[namespace][locale];
  for (const [component, keys] of Object.entries(bundle)) {
    for (const [key, ast] of Object.entries(keys)) {
      const vars = {};
      collect(ast, vars);
      for (const args of variants(vars)) {
        messages.push({ locale, component, key, args, output: run(ast, locale, materialize(args)) });
      }
    }
  }
}

// --- B. Plural categories --------------------------------------------------
const pluralNumbers = [
  0, 1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 12, 13, 14, 19, 20, 21, 22, 23, 25, 100, 101, 102, 103, 111, 1000, 1000000,
  0.5, 1.5, 2.5, 1.25, 0.0005, 1.0005, -1, -2,
];
const cardinalLocales = Object.keys(JSON.parse(readFileSync(join(upstream, 'cldr/plurals.json'), 'utf8')).supplemental['plurals-type-cardinal']).filter(l => l !== 'root');
const ordinalLocales = Object.keys(JSON.parse(readFileSync(join(upstream, 'cldr/ordinals.json'), 'utf8')).supplemental['plurals-type-ordinal']).filter(l => l !== 'root');
const categories = 'zero {zero} one {one} two {two} few {few} many {many} other {other}';
const plurals = [];
for (const [ordinal, locales] of [[false, cardinalLocales], [true, ordinalLocales]]) {
  const message = `{n, ${ordinal ? 'selectordinal' : 'plural'}, ${categories}}`;
  for (const locale of locales) {
    // Only locales the runtime really supports; others fall back to the host default.
    const supported = Intl.PluralRules.supportedLocalesOf([locale]).length > 0;
    for (const n of pluralNumbers) {
      plurals.push({ locale, ordinal, supported, n, output: run(message, locale, { n }) });
    }
  }
}

// --- C. Numbers and D. dates/times (15 locales) ---------------------------
const numberMessages = ['{n, number}', '{n, number, integer}', '{n, number, percent}', '{n, plural, other {#}}'];
const numberValues = [0, 1, 1234.5678, 1000000, -42, 0.125];
const dateMessages = [
  '{d, date}', '{d, date, short}', '{d, date, medium}', '{d, date, long}', '{d, date, full}',
  '{d, time}', '{d, time, short}', '{d, time, medium}', '{d, time, long}',
];
const dateValues = [Date.UTC(2026, 2, 9, 14, 5, 7), Date.UTC(2026, 11, 31, 0, 0, 0)];
const formatted = [];
for (const locale of lock.locales) {
  for (const message of numberMessages) {
    for (const n of numberValues) formatted.push({ group: 'number', locale, message, args: { n }, output: run(message, locale, { n }) });
  }
  for (const message of dateMessages) {
    for (const d of dateValues) formatted.push({ group: 'date', locale, message, args: { d }, output: run(message, locale, { d }) });
  }
}

// --- E. Numbers and dates in every CLDR locale (step 5: full-locale data) --
// Only locales the runtime's ICU supports; others would fall back to the
// host default and say nothing about CLDR.
const allLocales = JSON.parse(readFileSync(join(upstream, 'cldr/dates/available.json'), 'utf8'));
const formattedAll = [];
for (const locale of allLocales) {
  if (lock.locales.includes(locale)) continue; // covered by C and D
  const supported =
    Intl.DateTimeFormat.supportedLocalesOf([locale]).length > 0 &&
    Intl.NumberFormat.supportedLocalesOf([locale]).length > 0;
  if (!supported) continue;
  for (const message of numberMessages) {
    for (const n of numberValues) formattedAll.push({ group: 'number', locale, message, args: { n }, output: run(message, locale, { n }) });
  }
  for (const message of dateMessages) {
    for (const d of dateValues) formattedAll.push({ group: 'date', locale, message, args: { d }, output: run(message, locale, { d }) });
  }
}

const target = join(here, '../../packages/cloudscape_flutter/test/fixtures/i18n_oracle.json');
mkdirSync(dirname(target), { recursive: true });
const version = JSON.parse(readFileSync(join(here, 'node_modules/intl-messageformat/package.json'), 'utf8')).version;
writeFileSync(
  target,
  JSON.stringify({ intlMessageformat: version, icu: process.versions.icu, cldr: process.versions.cldr, messages, plurals, formatted, formattedAll }) + '\n',
);
console.log(
  `Wrote ${target}: ${messages.length} messages, ${plurals.length} plural checks, ${formatted.length} number/date checks, ` +
    `${formattedAll.length} all-locale number/date checks ` +
    `(intl-messageformat ${version}, ICU ${process.versions.icu}, CLDR ${process.versions.cldr}).`,
);
