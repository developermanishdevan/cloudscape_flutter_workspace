# Vendored upstream inputs

Do not edit these files by hand. They are written by `dart run melos run tokens:fetch` from integrity-verified npm tarballs (see `upstream.json` for versions, tarball URLs, `sha512` integrity and the source path of every file).

| File | Source (in `@cloudscape-design/components` unless noted) | Used by |
| --- | --- | --- |
| `visual-refresh.preset.json` | `preset` object from `internal/generated/theming/index.js` (style-dictionary output: tokens, modes, contexts, themeable/exposed lists, CSS variable names) | `tool/token_gen` |
| `design-tokens.visual-refresh.json` | `index-visual-refresh.json` in `@cloudscape-design/design-tokens` (descriptions; independent oracle in tests) | `tool/token_gen` |
| `icons/icons.js` | `icon/generated/icons.js` (the icon artwork) | `tool/icon_gen` |
| `icons/internal.js` | `icon/internal.js` (the small `gen-ai` glyph) | `tool/icon_gen` |
| `icons/styles.scoped.css` | `icon/styles.scoped.css` (RTL-mirrored icon list) | `tool/icon_gen` |
| `i18n/<locale>.json` | `i18n/messages/all.<locale>.json` (pre-compiled ICU message ASTs) | `tool/i18n_gen` |
| `cldr/plurals.json`, `cldr/ordinals.json` | `cldr-core` `supplemental/` (CLDR plural rules) | `tool/i18n_gen` |
| `cldr/supplemental/{likelySubtags,calendarPreferenceData,numberingSystems}.json` | `cldr-core` `supplemental/` (locale resolution, preferred calendar, native digits) | `tool/i18n_gen`, fetch |
| `cldr/dates/<id>.json` | every locale in `cldr-dates-full` (739), compacted to the fields the formatter reads: the preferred calendar's names and patterns (`ca-gregorian`, or `cldr-cal-buddhist-full` / `cldr-cal-persian-full` where CLDR prefers them), Gregorian time formats, GMT formats | `tool/i18n_gen` |
| `cldr/dates/available.json` | locale ids in `cldr-dates-full` | `tool/i18n_gen` |
| `cldr/numbers-summary.json` | per locale in `cldr-numbers-full`: `minimumGroupingDigits`, `defaultNumberingSystem`, its symbols and standard decimal / percent patterns (derived) | `tool/i18n_gen` |

Cloudscape files are Copyright Amazon.com, Inc. or its affiliates, Apache-2.0; CLDR files are Copyright Unicode, Inc., Unicode-3.0. See the root `NOTICE`. No upstream code is executed: files are copied, and the theming preset is read as JSON.

To bump upstream: change the versions in the `tokens:fetch` script in the root `pubspec.yaml`, run `tokens:fetch`, then every `*:generate` script, then `verify`. The generators fail loudly on anything they do not understand.

Classic theme: dropped (decided 2026-11-16). npm releases ship only the `visual-refresh` preset.
