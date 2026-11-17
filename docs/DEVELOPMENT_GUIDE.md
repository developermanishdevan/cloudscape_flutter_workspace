# Cloudscape for Flutter — Development Guide

How to keep building this project: set up the toolchain, port a component the way the finished ones were ported, verify it, and work through the remaining phases.

- **Source of scope:** [Complete Rebuild Plan](Cloudscape%20for%20Flutter%20—%20Complete%20Rebuild%20Plan.md). It lists every component, pattern and demo.
- **Source of status:** [CHECKLIST.md](CHECKLIST.md). It tracks every plan item; update it after every step (see [§9](#9-the-checklist-rule)).

---

## 1. Ground rules

These are fixed decisions. Every change must respect them.

| Rule | Detail |
| --- | --- |
| Flutter **3.50.0** / Dart 3.14 | Pinned in `.fvmrc`. Always run tools through FVM (`.fvm/flutter_sdk/bin/...`). |
| **No Material, no Cupertino** | Not even `material_ui` / `cupertino_ui`. `melos run check:imports` fails the build. Third-party packages that pull Material in (Widgetbook, alchemist) are not used; we build our own equivalents. |
| **Port, don't reinvent** | Behavior, geometry and colors come from the pinned upstream `@cloudscape-design/components` 3.0.1416. Read its JS and CSS and port them. Where upstream relies on the browser (text selection, context menus), use Cloudscape tokens and platform conventions, and say so in a comment. |
| **Tokens only** | No hard-coded colors, sizes, radii or durations. Read everything from `CsTheme.tokensOf(context)`. |
| **Prop parity** | Each React prop becomes a camelCase named parameter. Each `onX` event becomes a typed callback. Slots (`header`, `footer`, `actions`) become `Widget?`. Support controlled use (`value` + `onChange`) and uncontrolled use (controller or internal state). |
| **Upstream is vendored, never executed** | `tool/upstream/` holds integrity-verified copies. Node oracle scripts are run by a person, not by automation. |
| **No commits from automation** | Changes stay in the working tree for review. |
| Visual refresh only | The classic theme was dropped on 2026-11-16. |

---

## 2. Setup

```bash
# one time
dart pub global activate fvm          # if not installed
fvm install                           # installs 3.50.0 from .fvmrc
.fvm/flutter_sdk/bin/flutter pub get  # resolves the whole pub workspace

# day to day (from the repo root)
export PATH="$PWD/.fvm/flutter_sdk/bin:$PATH"
dart run melos run verify             # everything CI runs
```

### Melos scripts

| Script | What it does |
| --- | --- |
| `verify` | `check:imports` → `tokens:check` → `icons:check` → `i18n:check` → `catalog:check` → `format:check` → `analyze` → `test`. Must be green before a step counts as done. |
| `check:imports` | Fails on any Material or Cupertino import. |
| `analyze` | `dart analyze --fatal-infos`. Infos are errors too. |
| `format` / `format:check` | Dart format. |
| `test`, `test:dart`, `test:flutter` | All tests, pure-Dart packages, Flutter packages. |
| `tokens:fetch` | Re-downloads and re-vendors upstream. Versions are pinned in the root `pubspec.yaml`. |
| `tokens:generate` / `tokens:check` | Design tokens → `cloudscape_tokens`. |
| `icons:generate` / `icons:check` | Upstream icons → vector data + `CsIconName`. |
| `i18n:generate` / `i18n:check` | Message bundles, plural rules and CLDR date/number data. |
| `catalog:generate` / `catalog:check` | Catalog data (API tables from dartdoc, preview sizes) → `apps/catalog/lib/src/generated/`. |
| `preview` | Starts the Flutter widget previewer for `cloudscape_flutter`. |

Run a single test file with:

```bash
cd packages/cloudscape_flutter
../../.fvm/flutter_sdk/bin/flutter test test/<file>_test.dart
```

---

## 3. Repository map

```
apps/
  catalog/                 component catalog (Cloudscape-built shell; step 6b)
                           run: cd apps/catalog && flutter run -d chrome (or macos)
  demos/                   the 33 demo pages (acceptance tests per phase)
packages/
  cloudscape_tokens/       generated tokens, theme resolver (pure Dart)
  cloudscape_flutter/      theme, primitives, every core component
    lib/cloudscape_flutter.dart   public exports (add every new public file)
    lib/preview.dart              preview registry export
    lib/src/
      app/                 CsApp
      theme/               CsTheme, conversions (token → Flutter), typography, spacing, motion
      icon/                CsIcon, CsIconProvider, generated icon data
      i18n/                CsI18nProvider, ICU formatter, CLDR plurals/dates/numbers, generated data
      internal/            shared primitives (see §4)
      components/<name>/   one folder per component: cs_<name>.dart + cs_<name>_preview.dart
      preview/             CsPreview annotation, CsPreviewFrame, preview_registry.dart
    test/                  unit/widget tests, oracle tests, golden matrix, goldens/
  cloudscape_flutter_test/ public test utilities: find.csX() finders + CsXDriver classes
  cloudscape_collection/   collection-hooks port (phase 5)
  cloudscape_charts/ cloudscape_board/ cloudscape_chat/ cloudscape_code_view/   phase 6
tool/
  upstream/                vendored upstream inputs (+ upstream.json lock, README)
  token_gen/               fetch (all vendoring) + token generator
  icon_gen/  i18n_gen/     generators
  catalog_gen/             dartdoc → catalog data; lib/src/manifest.dart lists every catalog page
  theming_oracle/  i18n_oracle/   Node oracles (run by a person; produce test fixtures)
  check_no_material.dart
docs/
  Cloudscape for Flutter — Complete Rebuild Plan.md
  CHECKLIST.md             status of every plan item + build-steps log
  DEVELOPMENT_GUIDE.md     this file
```

---

## 4. What already exists (reuse it)

Build new components on top of these. Don't write a second version of any of them.

| Need | Use | File |
| --- | --- | --- |
| Tokens / theme modes / visual contexts | `CsTheme`, `CsVisualContext`, `context.csTokens` | `theme/cs_theme.dart` |
| Token → Flutter values (CSS semantics) | `.toColor()`, `.toBoxShadows()`, `CsCssLinearGradient`, `.resolve()` | `theme/conversions.dart` |
| Text styles | `CsTypography(tokens).bodyM / headingXl / reset ...` | `theme/typography.dart` |
| App root | `CsApp` / `CsApp.router` | `app/cs_app.dart` |
| Icons | `CsIcon(name: CsIconName.x)`, `CsIconProvider` | `icon/` |
| Translated strings | `CsI18n.of(context, 'component')('key', provided)` | `i18n/cs_i18n_provider.dart` |
| Hover / press / focus / disabled | `CsPressable(builder: (ctx, state) => ...)` | `internal/pressable.dart` |
| Keyboard-only focus ring | `CsFocusRing`, `CsFocusVisible` | `internal/focus_ring.dart`, `focus_visible.dart` |
| One Tab stop + arrow keys | `CsSingleTabStop*`, `CsNavigableGroup` | `internal/single_tab_stop.dart`, `components/navigable_group/` |
| Screen-reader announcements | `CsLiveRegion` | `components/live_region/` |
| Layout helpers | `CsBox`, `CsSpaceBetween`, `internal/flex.dart` | `components/box/`, `components/space_between/` |
| Anchored overlays (fit, flip, width rules) | `CsDropdown` + `dropdown_geometry.dart` | `components/dropdown/` |
| Option / menu rows | `CsSelectableItem` (states, group header/child) | `internal/selectable_item.dart` |
| Option lists (select, multiselect, autosuggest, property filter) | `csPrepareOptions`, `csFilterOptions`, `CsHighlightController`, `csMenuKeyHandler`, `CsOpenStateController`, `CsOption`, `CsOptionsList` (virtual mode) | `internal/options/` |
| Every text input | `CsEditableField` (input + textarea chrome, selection, handles, context menu) | `internal/editable_field/` |
| Tables | `CsTableRoot` spike (sticky header/columns, resize, lazy rows, `CsRowExtents`) | `components/table/cs_table_root.dart` |
| Previews | `@CsPreview`, `CsPreviewFrame`, `CsPreviewButton` | `preview/cs_preview.dart` |

The build-steps log in CHECKLIST.md describes each of these in detail, including which upstream files they port.

---

## 5. Porting workflow (how every component was built)

### 5.1 Read upstream

The pinned components tarball is listed in `tool/upstream/upstream.json`. To read the sources, extract it into a scratch folder outside the repo. **Read only; never run it.**

```bash
mkdir -p /tmp/cs-upstream && cd /tmp/cs-upstream
curl -sLO https://registry.npmjs.org/@cloudscape-design/components/-/components-3.0.1416.tgz
tar -xzf components-3.0.1416.tgz package/<component> package/internal/components/<dep>
```

For each component, read:

1. **`package/<component>/internal.js`** (and `index.js`): props, defaults, events, which internal components it composes.
2. **`package/<component>/styles.scoped.css`**: the real geometry and the state rules.
3. **`interfaces.d.ts`**: the full prop list (parity).
4. **`package/i18n/messages/...`**: its i18n keys. They're already generated for you; look them up via `CsI18n.of(context, '<component>')`.

The CSS is minified with hashed class names and CSS variables. A small Python helper makes it readable: strip the hashes, turn `var(--token-name-xxxxxx, fallback)` into the token name, and print `selector → declarations`. Earlier steps used exactly this to port the input, selectable-item, table and resizer styles.

Each CSS variable maps to a token getter in camelCase, for example `--color-border-input-focused-ppoq5z` → `t.colorBorderInputFocused`. Check that a token exists with:

```bash
grep -o " [A-Za-z<>]* get colorBorderInputFocused" packages/cloudscape_tokens/lib/src/generated/cs_tokens.g.dart
```

### 5.2 Translate CSS → Flutter

| CSS | Flutter |
| --- | --- |
| `padding-inline-start` / `-end` | `EdgeInsetsDirectional` (RTL for free) |
| `inset 0 0 0 Npx color` box-shadow ring | Paint it (see `CsSelectableItemPainter`); `BoxDecoration` can't do inset shadows |
| `border-inline-start-width: 8px` (status) | `BorderDirectional(start: ...)`. Non-uniform widths with one color and a radius are fine |
| `:focus-within` box-shadow ring | `BoxShadow(spreadRadius: spread)` while focused |
| `:focus-visible` outline | `CsFocusRing` (keyboard focus only) |
| `position: sticky` | Paint-time offset in a custom render object (see `RenderCsTableRow`) |
| `aspect-ratio`, `fit-content` | Custom render object (see `_FitContentSquare` in `cs_box.dart`) |
| `cursor: pointer` / `text` / `col-resize` | `MouseRegion(cursor: SystemMouseCursors...)` |
| `aria-*` / roles | `Semantics(...)`; tables use `SemanticsRole.table / row / cell / columnHeader` |
| Container queries | `LayoutBuilder` on the component's own width, not screen breakpoints |

### 5.3 Write the component

- **Location:** `lib/src/components/<name>/cs_<name>.dart`. Export it from `lib/cloudscape_flutter.dart`.
- **Headers and docs:** start the file with a header comment naming the upstream files it ports. Every public member needs a `///` doc (the analyzer runs with `--fatal-infos`).
- **Strings:** use `CsI18n` for every user-visible default string. An explicitly provided prop wins over the translated default.
- **Internal pieces:** keep private ones private. If another component will need a piece, put it in `internal/` and export it.

### 5.4 Definition of done (per component)

A component is done only when it has **all** of the following (from the plan, §6 of CHECKLIST.md):

1. **Prop / event / slot parity** with upstream `interfaces.d.ts`. Write down any prop that doesn't apply, and why.
2. **Semantics and keyboard:** roles, labels, states, focus order, keys.
3. **Widget tests** in `packages/cloudscape_flutter/test/<name>_test.dart`: props, callbacks, controlled and uncontrolled use, keyboard, RTL, and geometry taken from tokens. Use `tester.view.physicalSize` and `devicePixelRatio = 1`.
4. **Previews:** `cs_<name>_preview.dart` with `@CsPreview(group: '<Name>', name: '<scenario>', size: Size(w, h))` functions covering every variant and state.
   - Register each one in `lib/src/preview/preview_registry.dart`.
   - `test/preview_test.dart` fails if one is missing, and renders each in light, dark, compact and RTL.
5. **Test-utils driver** in `packages/cloudscape_flutter_test`:
   - A `find.cs<Name>()` finder in `lib/src/finders.dart`.
   - A `Cs<Name>Driver extends CsDriver<Cs<Name>>` mirroring upstream's `test-utils` wrapper (`findX()` → getters, actions → async methods).
   - A test in `test/drivers_test.dart` that exercises it on a real widget.
6. **Goldens:** run `flutter test test/golden_matrix_test.dart --update-goldens` (macOS) and **look at the PNGs** before accepting them. Each preview gets 8 images under `test/goldens/matrix/<group>/`.
7. **Catalog page** in `apps/catalog` (from step 6b on):
   - Add a `ManifestEntry` to `tool/catalog_gen/lib/src/manifest.dart` (`name` = the preview group, category and phase from the plan, plan number, guideline `slug`, and the classes for the API table).
   - Run `dart run melos run catalog:generate`. It fails if a preview group has no entry or a listed class is missing.
   - The page, its previews and its API table appear automatically; `apps/catalog/test/app_test.dart` renders it in all 8 mode combinations. Public members without `///` docs show empty descriptions, so document them.
8. **`melos run verify` green**, and **CHECKLIST.md updated** (see §9).

---

## 6. Testing toolkit

| Kind | Where | Notes |
| --- | --- | --- |
| Unit / widget | `packages/*/test/` | `flutter_test` only. Pump inside `CsApp(theme: CsThemeData(motion: CsMotionMode.disabled), ...)`. |
| Previews render | `test/preview_test.dart` | Automatic for every registry entry. |
| Golden matrix | `test/golden_matrix_test.dart` | Every preview × light/dark × comfortable/compact × LTR/RTL, with the real Open Sans loaded. macOS only (`@TestOn('mac-os')`), with a 0.2% pixel tolerance. |
| Drivers | `packages/cloudscape_flutter_test/test/drivers_test.dart` | One test per driver. |
| Theming oracle | `tool/theming_oracle` → `tool/token_gen/test/fixtures/theming.json` | A person runs `npm ci --ignore-scripts && npm run fixtures`. Without the fixture, the tests skip. |
| i18n oracle | `tool/i18n_oracle` → `packages/cloudscape_flutter/test/fixtures/i18n_oracle.json` | Same procedure. Sections A–D: 15 Cloudscape locales. Section E: every CLDR locale. E skips until the fixture is regenerated after step 5. |

### Pitfalls already hit (don't repeat them)

- **Tap targets:** a `GestureDetector` around an empty `SizedBox` never registers hits. Use `HitTestBehavior.opaque` or `CsPressable`.
- **Focus lookups in tests and drivers:** `Focus.of(context)` registers an inherited dependency, and outside a build that breaks later rebuilds. Use `Focus.of(ctx, createDependency: false)` from inside the scope (`csFocusNodeOf`).
- **Deferred libraries:** in widget tests, `loadLibrary()` completes on a timer. Use `await tester.pump(const Duration(milliseconds: 100))`. Never await, inside `runAsync`, a future that was created in the fake zone; it hangs.
- **Overlay content** (selection handles, context menus, magnifiers) lives in the root overlay, which can sit above `CsApp`. Every Cloudscape scope must be an `InheritedTheme` (theme, icons and i18n already are).
- **Object identity in `EditableText`:** passing a new `selectionControls` or `magnifierConfiguration` instance on every build recreates the selection overlay. Cache them in the State.
- **2D viewport delegates** wrap children in `RepaintBoundary` by default. Pass `addRepaintBoundaries: false` when the viewport needs the child's own render object.
- **Drags:** measure from pointer-down (`DragStartBehavior.down` + `globalPosition`), or the touch slop is lost.
- **Fonts in package-root contexts** (own tests and previews) register as plain `Open Sans`. `csFontFamily` already adds it as a fallback.
- **Ahem boxes in a golden** mean some text skipped `CsTypography`. Fix the widget, not the golden.

---

## 7. Generators and upstream bumps

All generated files have a `--check` mode, which `verify` runs. **Never edit generated files by hand.**

| Generator | Inputs (`tool/upstream/`) | Outputs |
| --- | --- | --- |
| `token_gen:fetch` | npm tarballs (sha512-verified) | everything under `tool/upstream/` + `upstream.json` |
| `token_gen:generate` | `visual-refresh.preset.json` | `packages/cloudscape_tokens/lib/src/generated/` |
| `icon_gen:generate` | `icons/` | `cloudscape_flutter/lib/src/icon/generated/` |
| `catalog_gen:generate` | `tool/catalog_gen/lib/src/manifest.dart` + `packages/cloudscape_flutter/lib/src/**` (dartdoc, `@CsPreview`) | `apps/catalog/lib/src/generated/catalog_data.g.dart` |
| `i18n_gen:generate` | `i18n/*.json`, `cldr/**` | message libraries, ARB files, plural rules, `cldr_data.g.dart` (15 eager locales + number data for every locale), `cldr_date_loader.g.dart` + `generated/dates/*.g.dart` (386 deferred libraries for the other 724 locales) |

**To bump upstream:**

1. Change the versions in the root `pubspec.yaml` (`tokens:fetch`).
2. Run `tokens:fetch`, then all `*:generate`.
3. Have the oracles rerun.
4. Run `verify`.
5. Review the diff of the generated files: a changed token or message is a visible change.

---

## 8. Roadmap: what's left, in order

Phase 0's gate is closed (6a goldens, 6b catalog); the leftovers below can be built when phase 3 needs them. After that, phases 1–3 can run in parallel; phase 4 needs phase 3's overlays; phase 5 needs phases 2 and 3; phase 6 packages are independent.

### Phase 0: finish the gate

| Step | Work |
| --- | --- |
| ~~6b~~ | **Catalog app — done (2026-11-17).** Shell from our own widgets, category navigation, a page per preview group with live previews and global mode/density/direction toggles (direction applies to previews only), API tables generated by `tool/catalog_gen`, guideline links, smoke test over every page. See the 6b row in CHECKLIST.md. |
| Phase 0 leftovers | **Focus lock** (modals, drawers), **screen-reader-only text** helper (hidden internals). Build them when phase 3 needs them, or here. |
| Oracle | A person reruns `tool/i18n_oracle` to activate section E (all-locale dates and numbers). Fix any mismatches it reports. |

### Phase 1: display, layout, simple actions (25)

Recommended order (dependencies first):

1. **Spinner, Status indicator, Badge, Divider, Skeleton.** Status indicator uses icons and Spinner.
2. **Button** (the most reused). Variants: primary, normal, link, icon, inline-icon, inline-link. Also loading and disabled-reason states, `href`, and external-link icons. It then replaces `CsPreviewButton` and the inline icon button in the editable-field preview.
3. **Link, Copy to clipboard** (uses Button and a popover-like status; a temporary status is fine until Popover lands), **Toggle button**.
4. **Container, Header, Column layout, Grid, Text content, Key-value pairs.** These need container-query `LayoutBuilder`s and the column-layout and grid breakpoints from CSS.
5. **Alert** (uses `CsVisualContext` `alert`, Button, dismiss), **Expandable section** (variants, expand animation using motion tokens), **Progress bar**, **Steps**.
6. **Token, Token group, Truncated text, List** (sortable variant: drag reorder), **Item card, Action card**.

### Phase 2: forms (21)

- **Form field** first (label, description, constraint, error/warning, and form-field context that passes `invalid`/`warning`/`controlId` to its control).
- Then **Input** (wraps `CsEditableField`; adds types, search and clear button via Button, debounced `onDelayedInput`, inline label), **Textarea** (rows, auto-grow, resize grip), **Checkbox, Radio button/group, Toggle, Tiles, Segmented control, Slider**.
- **Select, Multiselect, Autosuggest** reuse the option-list engine plus `CsDropdown`. Use `csPrepareOptions` / `CsHighlightController` / `CsOptionsList` with `virtualScroll`.
- **Calendar, Date input, Date picker, Date range picker, Time input** use the CLDR date data (`csCldrDateDataFor` / `csLoadCldrDateData`, which covers every locale, including the Persian and Buddhist calendars).
- **Attribute editor, Control group, Form.**

### Phase 3: overlays (7)

**Popover, Tooltip** (anchored like `CsDropdown`), **Modal, Dialog** (focus lock, backdrop, motion), **Flashbar** (stacking, motion goldens), **Button dropdown** (option list + Dropdown), **Button group**.

### Phase 4: navigation and app layout (15)

**App layout** (drawers, split panel, notifications, sticky header offsets) and its toolbar, **Side/Top navigation** (`CsVisualContext` `top-navigation`), **Breadcrumbs, Tabs, Content/Panel layout, Drawer, Help panel, Split panel, Anchor navigation, Tree view, Wizard, Error boundary**.

### Phase 5: collections (13) + `cloudscape_collection`

**Table** grows from the 4f spike. The spike's findings (in CHECKLIST.md) list the follow-ups:
- put sticky cells on their own layer;
- size columns from their content;
- selection, hover and striped rows;
- keyboard grid navigation;
- inline edit and expandable rows.

Also: **Table head / header cell / body / row / body cell** as atomic parts, **Cards, Pagination, Text filter, Property filter, Collection preferences / select filter**, and `CsCollectionController<T>` (the collection-hooks port).

### Phase 6: extension packages (26)

Each package is independent:
- **Charts:** chart core (scales, axes, legend, tooltip) with `CustomPainter`; match the visual output, not Highcharts.
- **Board** (drag layout).
- **Code view / Code editor.**
- **Chat** (gen-AI): Avatar, Chat bubble, Loading bar, Prompt input, Support prompt group.
- **Files**, **Tutorials**, **Tag editor**, **S3 resource selector**.

### Cross-cutting, every phase

- Rebuild the phase's **demo pages** in `apps/demos`. They are the acceptance test for the phase.
- Accessibility checks with real screen readers.
- `tool/parity_check` (component/prop list vs the React repo).
- CI and publishing (CHECKLIST.md §6).

---

## 9. The checklist rule

After **every** step, before saying it is done:

1. Add or update a row in **Build steps log** (CHECKLIST.md). Include:
   - what was built, and which upstream files it ports;
   - the test counts;
   - bugs found and fixed;
   - decisions, with dates;
   - what was deferred, and to which step.
2. Tick or annotate the item in its section: `[x]` done, `[~]` partial with a note saying what's left.
3. Mark the next step `Next`.
4. Never skip a plan item silently. If something is dropped (like the classic theme or Umm al-Qura), record the decision and the reason.

---

## 10. Step checklist (copy for each new component)

```
[ ] Read upstream internal.js, styles.scoped.css, interfaces.d.ts, i18n keys
[ ] Map every CSS variable to a token; note any missing token
[ ] lib/src/components/<name>/cs_<name>.dart (+ export)
[ ] Semantics + keyboard
[ ] test/<name>_test.dart (props, events, controlled/uncontrolled, keys, RTL, geometry)
[ ] cs_<name>_preview.dart (+ preview_registry.dart entries)
[ ] find.cs<Name>() + Cs<Name>Driver + drivers_test.dart case
[ ] --update-goldens, then LOOK at the PNGs (light/dark/compact/RTL)
[ ] Catalog page: manifest entry + catalog:generate
[ ] dart run melos run verify  → green
[ ] CHECKLIST.md: build-steps row + component row + next step
```
