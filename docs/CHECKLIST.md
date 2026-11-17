# Cloudscape for Flutter — Build Checklist

Tracks every item in [the rebuild plan](Cloudscape%20for%20Flutter%20—%20Complete%20Rebuild%20Plan.md). Tick a box only when the item meets the plan's definition of done. Every item here is generated from the plan; nothing is left out on purpose.

How to build the remaining items: [Development Guide](DEVELOPMENT_GUIDE.md).

Legend: `[x]` done · `[~]` started / partial (note says what remains) · `[ ]` not started.

Toolchain rule: Flutter **3.50.0** (Dart 3.14.0), pinned in `.fvmrc`.

## Build steps log

| Step | Scope | Status |
| --- | --- | --- |
| 1 | Monorepo scaffold: FVM pin, pub workspace, melos scripts, package/app skeletons, lints, no-Material check, LICENSE + NOTICE | Done |
| 2 | Token codegen: `tool/token_gen` fetches `@cloudscape-design/components` 3.0.1416 (integrity-verified), generates 1,173 typed tokens × 3 mode axes + 8 visual contexts into `cloudscape_tokens`; 34 tests incl. cross-check against `@cloudscape-design/design-tokens` 3.0.118 | Done |
| 3a | Theme layer: pure-Dart port of theming-runtime `applyTheme` (validate, merge, re-resolve dependents, context precedence, `defaultMode`, HCT palette generation) as `CsThemeResolver`; Flutter `CsTheme` / `CsVisualContext` (nested + combined contexts), CSS-exact conversions (shadows, gradients, lengths, curves) | Done — verified against upstream theming-runtime (see below) |
| 3b | Typography + font + root: Open Sans from global-styles (8 faces), `CsTypography` (component reset + type scale), `CsSpacing`, `CsMotion` (+ upstream keyframes), `CsApp` / `CsApp.router`, dark-mode utilities | Done |
| 3c | Icons: vendoring moved to shared `tool/upstream/`; `tool/icon_gen` parses upstream `icons.js` + `internal.js` + icon CSS → 148 icons as vector data + `CsIconName` enum + RTL list; `CsIconPainter` (CSS stroke/fill/join/cap/dash/clip semantics), `CsIcon` (6 sizes + inherit, 9 variants, url/svg, badge, RTL mirror, gen-ai small glyph, semantics), `CsIconProvider` (icons + componentIcons merge rules), wired into `CsApp`; 19 new tests + all-icons golden | Done |
| 3d | i18n: `tool/i18n_gen` turns the 15 upstream bundles (6,482 pre-compiled ICU messages) into Dart libraries (`package:cloudscape_flutter/i18n/messages/all_<locale>.dart`, deferred-loaded by `csImportMessages`) + ARB files (`l10n/`); runtime ICU parser + formatter (select, CLDR plural via `intl`, offset, `=N`, `#`, rich-text tags, number); port of upstream `I18nFormatter` (locale widening, provided-wins, graceful fallback) and `I18nProvider` (`CsI18nProvider`, nested merge, `CsI18n.of/custom/localeOf`); wired into `CsApp`; parity: generated Dart == upstream AST and ARB round-trip == upstream AST for all 6,482 messages | Done |
| 3e | i18n gaps closed and verified against upstream: CLDR 47 vendored (`cldr-core`, `cldr-dates-full`, `cldr-cal-buddhist-full`, `cldr-numbers-full`, integrity-pinned); runtime CLDR plural engine (cardinal + ordinal, all 219/104 locales, every Unicode sample passes); browser-exact dates/times for the 15 Cloudscape locales (ICU-like locale resolution, nearest-skeleton pattern matching with skeleton-relative adjustment, `timeFormats` for times, numeric hour in long times, `B`→`a`, U+202F→space, wide AM/PM, Buddhist calendar for `th`, `UTC`/GMT zone names); CLDR `minimumGroupingDigits` for all 739 locales. **`tool/i18n_oracle` (intl-messageformat 10.7.18, ICU 77.1) — all 4 groups pass: 8,240 messages, 11,305 plural checks, 360 numbers, 270 dates/times.** Remaining approximation: date/time in locales outside the 15 use the `intl` package's data | Done |
| 4a | Interaction primitives: `CsFocusVisible` (port of toolkit focus-visible: non-modifier keydown on, pointer down off, ref-counted), `CsFocusRing` (upstream ring geometry/tokens), `CsSingleTabStop` + provider (port of toolkit single-tab-stop), `CsPressable` (hover/pressed/focus/disabled, Enter-down / Space-up activation, link role, merged semantics); Live region (#67: controller throttle/dedupe/period-toggle, text extraction, hidden, sources, preventInitialAnnouncement, reannounce); Navigable group (#70: one tab stop, arrows/Home/End/wrap, RTL, disabled skip, modifier/off-axis ignore, refocus on removal); 14 tests | Done |
| 4b | Layout: `CsFlex` render object (CSS flexbox semantics: block width, column/row, wrap, gaps, align-items incl. stretch-to-line, RTL, unbounded safe); Box (#12: all 17 variants with upstream CSS defaults + prop precedence, logical spacing scaled-vertical/base-horizontal with later-size-wins, display/float/textAlign, visual accent incl. ellipse, inline-code, heading semantics, h1 focusable); Space between (#84: upstream gap tokens, wrap, alignItems, null children skipped); 11 tests | Done |
| 4c | Overlays: pure port of upstream `dropdown-fit-handler` (available space with 50/19/20px reserves across clipping ancestors + screen, start/end flip, biggest-side fallback, center alignment, 31px row cropping, maxHeight, stretchHeight, interior fly-out, flexible-width check; logical/RTL); `CsDropdown` (#42) on `OverlayPortal` + `CompositedTransformFollower`: width rules (content within min/max, `trigger`, match-trigger), drop-up, placement frozen per open like upstream (recomputed on its deps and on trigger resize), panel visuals (background, radius, dropdown/dropup shadow, 2px outline extending 1px, optional block borders, style API), fade + 4px slide (none when motion disabled), outside click (TapRegion), Escape (consumed), focus enter/leave, DOM-order Tab and loopFocus traps, `CsDropdownContext` placement; 15 tests | Done |
| 4-pv | Widget previews (user requirement 2026-11-17): `@CsPreview` multi-preview (light/dark/compact/RTL in a real `CsApp` frame), `CsPreviewButton` helper, 22 previews for every implemented component (Box ×6, Space between ×3, Icon ×4, Icon provider, Live region, Navigable group ×2, Dropdown ×4, Pressable); `package:cloudscape_flutter/preview.dart` registry; `test/preview_test.dart` (registry completeness + 88 renders); `melos run preview` | Done |
| 4-fix | User-reported fixes (2026-11-17): (1) Box equal-aspect visual accent rendered as a full-width circle → now a fit-content square (CSS `aspect-ratio:1; inline-size:fit-content`); (2) Dropdown mispositioned when hosted in a nested/offset/zoomed app (widget previewer) → all geometry now measured in the overlay's coordinate space (trigger, clipping ancestors, viewport = overlay bounds); (3) menu hover: `CsSelectableItem` ported from upstream selectable-item (default/highlighted mouse+keyboard/selected/selected+highlighted double ring/disabled/dimmed hover/joined selected corners, dividers, option padding) and used by a hover- and arrow-key-driven menu in the Dropdown previews; regression tests for nested zoomed hosting and item states; new Selectable item preview | Done |
| 4d | Internals: option list engine (highlight/selection logic on top of `CsSelectableItem`), virtual scroller. Done in `lib/src/internal/options/`: option model (`CsOptionDefinition`/`CsOptionGroup`, `CsDropdownOption` rows); upstream `flattenOptions`/`filterOptions` (substring or strict prefix; group-header rules)/`prepareOptions`/`unflattenOptions`/test indexes; `CsHighlightController` (useHighlightedOption: skips headers and disabled rows, Home/End, mouse vs keyboard, moveFocus), `csMenuKeyHandler`/`csTriggerKeyHandler`, `CsOpenStateController`; `CsOption` (icon, label prefix, label tag, description, tags, matching filtering tags, `CsHighlightMatch`); `CsOptionsList` (nearest scroll-to-highlight, load more within 80px, pointer move/up, virtual mode: lazy slivers + pinned sticky first row + measured extents + intrinsic width from the first 50 rows so `CsDropdown` can size it). `CsSelectableItem` gained group header (`isParent`) and group option (`isChild`) styling. Previews: Option list ×3 (groups, filtering, 1,000-row virtual) + Selectable item Groups; `test/options_test.dart` (33 tests) | Done |
| 4e | Spike: `CsEditableField` (text input base; risk "Text input fidelity"). Done in `lib/src/internal/editable_field/`: `CsEditableField` = upstream `input/internal.js` + input/textarea styles on `EditableText`, Material-free: field box (border, focus border + ring, disabled / read-only / invalid / warning with 8px start status border and compensated padding, status colors on text or adornments), italic placeholder, start icon / end icon slots with upstream offsets, prefix / suffix with dividers, inline content, no-border-radius, textarea via `maxLines`/`minLines`; controlled (`value` + `onChange`, rejected edits revert) or uncontrolled (`controller`); platform selection gestures (`TextSelectionGestureDetectorBuilder`), handle visibility rules, platform caret; `CsTextSelectionControls` (teardrop / iOS lollipop handles in the focus color), `CsTextContextMenu` (dropdown-styled vertical menu on desktop, bar on touch, `WidgetsLocalizations` labels, iOS system menu where supported), `CsTextMagnifier` (iOS/Android). Previews: Editable field ×3 (states incl. search + clear, prefix/suffix, textarea); `test/editable_field_test.dart` (23 tests). Bug found by tests and fixed: per-build selection controls / magnifier config made `EditableText` recreate its overlay and drop handles. Deferred to the Input/Textarea components (phase 1): debounced `onDelayedInput`, search type wiring with CsButton clear, inline label, textarea resize grip, spell check | Done |
| 4e-fix | User-reported (2026-11-17): Editable field preview crashed on focus / text selection ("CsTheme.of() called with a context that does not contain a CsTheme", context `_SelectionHandleOverlay`). Cause: selection handles, text context menus and magnifiers go into the root overlay, above a nested `CsApp` (widget previewer), and Flutter only carries `InheritedTheme`s there. Fix: the theme, icon and i18n scopes are now `InheritedTheme`s. Also fixed: the touch context menu overflowed narrow screens → `CsRowOrColumn` (a row when it fits, else a full-width column). Regression tests: nested-app handles + menu, row/column fallback | Done |
| 4f | Spike: `CsTableRoot` on `TwoDimensionalScrollView` (risk "Table performance"). Done in `lib/src/components/table/cs_table_root.dart`. Design: a custom `TwoDimensionalScrollView`/`RenderTwoDimensionalViewport` whose children are whole rows (header = row 0), so rows stay real render objects: table → row → column header / cell semantics validate, and rows can have any height. `RenderCsTableRow` lays cells out at column widths (last column fills the container, upstream width:auto) and paints sticky cells at their stuck position (CSS `position:sticky` equivalent) with the stuck shadows clipped outside (`shadow-sticky-column-first/last`), sticky-aware hit testing and paint transforms, RTL mirrored. Viewport: sticky or scrolling header painted above rows, lazily built rows with measured heights, `CsRowExtents` (Fenwick tree over measured-height corrections, O(log n) offsets and lookups), upstream sticky-enable rule (table scrolls and keeps 148 px of scrollable space). Resizing: header divider drag measured from pointer-down, ←/→ ±10 px, slider semantics, min width per upstream `getMinWidth`, `onColumnWidthsChange` on commit; widths kept by column id. Header/body cell paddings, colors and dividers from upstream header-cell/body-cell styles. Previews: Table root ×2 (10,000 rows sticky header + columns; resizable). `test/table_root_test.dart` (15 tests). Findings (debug-mode test env, 100k rows × 20 cols, sticky first+last): ~4 ms/frame vertical scroll, ~4.5 ms/frame horizontal scroll, ~85 ms for a deep jump, dominated by building ~500 fresh cells (same as the first build) — fine for 60 fps in release; follow-ups for phase 5: put sticky cells on their own layer so horizontal scroll repaints only them, auto (content) column widths via intrinsic measurement of header + visible rows, selection / hover / striped rows, keyboard grid navigation, VR first-cell inset parity check | Done |
| 4g | Test utils foundation (`cloudscape_flutter_test`): finders + drivers for everything so far (incl. Icon, Icon provider). Done: `find.csX()` finders (box, space between, icon by name/customName, icon provider, live region incl. hidden, navigable group, pressable by label/text, dropdown, selectable item, options list, option, editable field by label/placeholder/value, table root by label) and `CsXDriver` classes mirroring upstream test-utils wrappers: Box, SpaceBetween (items), Icon, IconProvider, LiveRegion, NavigableGroup (focus, arrows, focused item), Pressable (click/hover/focus/keys), Dropdown (trigger/header/content/footer, outside click, Escape), SelectableItem, Option + OptionsList (1-based `option(n)`, `optionInGroup(g, n)`, groups, highlighted/selected, filter matches), EditableField (value, setValue, focus/blur, submit, end icon, context menu items), TableRoot (headers, lazy `bodyCell(r, c)` with scroll-into-view, built rows, horizontal scroll, drag and keyboard column resize). `packages/cloudscape_flutter_test/test/drivers_test.dart` (9 tests) runs every driver on real widgets; part of `melos run verify`. Driver bug found and fixed: focus lookup registered an inherited dependency from test code and broke later builds → `Focus.of(..., createDependency: false)` from inside the scope | Done |
| 5 | Full-locale CLDR dates: date/time data for all ~740 CLDR locales as deferred libraries, native digits, Persian and Islamic Umm al-Qura calendars, oracle extended to all locales (decided 2026-11-17: after step 4). Done: fetch vendors compact date data for all 739 CLDR locales (726 Gregorian, 11 Persian, 2 Buddhist) + `numberingSystems.json` + per-locale number symbols/patterns; `i18n_gen` emits the 15 Cloudscape locales eagerly and the other 724 as 386 de-duplicated deferred libraries + `cldr_date_loader.g.dart`; `csLoadCldrDateData` / `CsI18nProvider.preload`, and `CsI18nProvider` loads a locale on demand and rebuilds (English for the first frame); Persian calendar = ICU's arithmetic 33-year algorithm; native digits in dates and numbers from each locale's default numbering system; new CLDR number formatter (symbols, Indian grouping, minimumGroupingDigits, percent, half-expand) replaces package:intl, which is removed (C/D oracle still 100% for the 15 locales). Umm al-Qura dropped: CLDR 47 calendarPreferenceData prefers Gregorian for SA, so no locale defaults to it (oracle E will confirm). Oracle section E added (every ICU-supported locale × number/date messages); `test/i18n_oracle_test.dart` E is skipped until `tool/i18n_oracle` is rerun (user). `test/cldr_full_locales_test.dart` (13 tests) | Done (oracle E pending user run) |
| 6a | Phase 0 gate: golden matrix harness (every preview × light/dark × comfortable/compact × LTR/RTL, `matchesGoldenFile`, no Material) for all phase-0 components and primitives. Done: `test/golden_matrix_test.dart` renders every registered preview at its declared `@CsPreview` size with the real Open Sans faces in all 8 combinations → 256 goldens under `test/goldens/matrix/<group>/` (5.6 MB); tolerant comparator (0.2 % pixels), macOS-only (`@TestOn('mac-os')`) since goldens are macOS-rasterized; part of `verify`. Self-written instead of `alchemist` (keeps Material out of the test graph). Bugs the goldens exposed and fixed: bundled font unresolved when the package is the root app (tests/previews) → plain `Open Sans` added as first fallback; autofocus showed an Android caret handle → programmatic selection changes never show handles; option-list filter preview used a raw `EditableText` → now `CsEditableField` | Done |
| 6a-note | `alchemist` vs own harness: decided own harness (2026-11-17) — same matrix, no Material dependency | Done |
| 6b | Phase 0 gate: catalog app pages for the phase-0 components (live previews, variants, API notes, guideline links) | Next |
| 7 | Phase 1 components (25), each with previews, driver, tests, goldens, catalog page | Not started |

**3a upstream verification (2026-11-16):** the user ran `tool/theming_oracle` (needed `register.mjs` for upstream's extensionless ESM imports). 35/37 matched at first; the 2 failures exposed an upstream quirk (reference-token names come from the palette input's keys, so seed-generated steps lose `defaultMode` pinning), now ported — **37/37 pass**, including all 126 palettes string-for-string. A 5th scenario (`paletteModes`: explicit mode-specific steps in `defaultMode` contexts) was added and rerun — **46/46 pass**. Fixture: `tool/token_gen/test/fixtures/theming.json` (keep in the repo so CI checks parity without Node).

## 1. Repository inventory (17 repos)

- [~] **components** (P0) → _tokens ported (step 2); theme and widgets pending_ → `cloudscape_flutter` core package (tokens, theme, all widgets)
- [x] **global-styles** (P0) → _Open Sans 300/400/700/800 + italics bundled; `CsApp` text reset + background; dark-mode show/hide utilities (normalize.css has no Flutter equivalent)_ → `CsApp` root: `DefaultTextStyle`, bundled font, base background
- [x] **theming-core** (P0) → _`CsThemeResolver` (applyTheme semantics incl. palettes/HCT, contexts, defaultMode) verified 37/37 against upstream; `CsThemeData`; scoped themes via nested `CsTheme`_ → `CsThemeData` + `applyTheme()` runtime override API, token codegen
- [~] **component-toolkit** (P0) → _visual-mode detection (platform brightness, reduced motion) done; focus-visible, RTL helpers, container queries, metrics pending_ → `internal/` primitives: `FocusVisible`, `ContainerQuery`, `Directionality` helpers
- [ ] **collection-hooks** (P1) → `CsCollectionController<T>` (ChangeNotifier)
- [~] **test-utils** (P1) → _foundation done (4g): finders + drivers for every component built so far; each new component adds its driver_ → `cloudscape_flutter_test`: finder extensions and component drivers for `WidgetTester`
- [ ] **board-components** (P2) → `cloudscape_board` package
- [ ] **chart-components** (P2) → `cloudscape_charts` package with `CustomPainter`
- [ ] **code-view** (P2) → `cloudscape_code_view` package
- [ ] **chat-components** (P2) → `cloudscape_chat` package
- [ ] **demos** (P1) → `example/` app reproducing every demo page
- [ ] **documenter** (P3) → Use dartdoc + a generated API JSON for the docs site
- [ ] **browser-test-tools** (P1) → `integration_test` + golden tooling (alchemist)
- [ ] **jest-preset** (P3) → `flutter_test` config, shared `dart_test.yaml`
- [~] **build-tools** (P3) → _melos scripts done (step 1–2); `build_runner` not needed yet_ → `melos` monorepo scripts + `build_runner`
- [ ] **actions** (P3) → GitHub Actions: analyze, test, golden diff, publish
- [ ] **.github** (P3) → Repo templates, CONTRIBUTING, issue templates

## 2. Foundations (16 topics + 2 cross-cutting)

- [x] **Design tokens** → _done as one class per mode axis (`CsColorModeTokens`, `CsDensityModeTokens`, `CsMotionModeTokens`, `CsStaticTokens`) composed by `CsTokens.resolve`_ → Codegen: parse `style-dictionary/` JSON → `cs_tokens.g.dart` with one `CsTokens` class per mode
- [x] **Colors** → _semantic tokens on `CsTokens`; `toColor()`/`toGradient()` conversions_ → `CsColorTokens` with semantic names only (`colorTextBodyDefault`, `colorBackgroundButtonPrimaryDefault`)
- [~] **Data visualization colors** → _all `colorCharts*` tokens generated; `CsChartPalette` with charts (phase 6)_ → `CsChartPalette` used by every chart painter
- [x] **Typography** → _upstream Open Sans faces bundled; `CsTypography` display/heading/body + monospace + component reset_ → Bundle Open Sans as a font asset; `CsTypography` with heading XL→XS, body M/S, display L, code
- [x] **Spacing** → _`CsSpacing` none…xxxl with base/scaled/static_ → `CsSpacing` enum → double; used by `SpaceBetween`, `Box` padding/margin
- [ ] **Layout** → `CsBreakpoints` + `CsBreakpointBuilder` (LayoutBuilder-based, container width not screen width)
- [x] **Content density** → _`CsThemeData.density`, nestable; `CsSpacing.scaled`_ → `CsDensity` enum in theme; spacing and control heights switch per density
- [x] **Visual modes** → _follows platform brightness by default; nestable `CsTheme`_ → `CsMode.light / dark`; follow `MediaQuery.platformBrightness` by default
- [x] **Visual context** → _`CsVisualContext` widget; nested contexts cascade; alert-in-header adds alert-header like the CSS_ → `CsVisualContext` InheritedWidget that overrides a token subset for its subtree
- [x] **Theming** → _`CsThemeOverride` (tokens, contexts, referencePalettes; typed values or CSS strings) + `CsThemeResolver`, verified against upstream theming-runtime_ → `CsTheme.override(tokens: {...}, contexts: {...})`, mirroring `applyTheme()`
- [x] **Visual style** → _radius/border tokens; CSS-exact `CsCssBoxShadow`, `CsCssLinearGradient`, `CsCssRadialGradient`_ → `CsShapeTokens`, `CsShadowTokens`
- [x] **Iconography** → _vector painters instead of an icon font (exact strokes per size, no extra package); `CsIconName` enum; `CsIconProvider` for overrides_ → Convert the SVGs to an icon font (or `flutter_svg` assets); `CsIconName` enum; `IconProvider` for overrides
- [x] **Motion** → _durations/easings from tokens (zero when disabled), `CsMotion` incl. upstream keyframes; follows `disableAnimations`, `CsThemeData.motion` is the global flag_ → `CsMotionTokens`; respect `MediaQuery.disableAnimations` and a global `disableMotion` flag
- [ ] **Accessibility and focus management** → `Semantics` on every widget; `CsFocusRing`; focus-return helper for modals, popovers, drawers
- [ ] **Responsive design** → Container-query style breakpoints per component, not only page-level
- [ ] **Bidirectionality** → `Directionality` + `EdgeInsetsDirectional` everywhere; mirror directional icons
- [x] **i18n** → port every message bundle to ARB; `CsI18nProvider` _— all 15 bundles; CLDR 47 plural rules for every locale; ICU date/time/number; verified string-for-string against upstream intl-messageformat (fixture `packages/cloudscape_flutter/test/fixtures/i18n_oracle.json`); date/time outside the 15 locales uses `intl` data (approximate)_
- [x] **Theme variants** → _visual refresh done. **Classic: dropped (decided 2026-11-16)** — not in any published npm release; the generator fails loudly if a secondary theme ever appears in the preset_ → visual refresh first; classic as a second token set
- [ ] Rule: no component hardcodes a color, size, font or duration

## 3. Components (114 entries)

Each component is done only when it has: full prop/event/slot parity, Semantics + keyboard, widget tests, **widget previews** (`<component>_preview.dart` with `@CsPreview` scenarios covering its variants/states, registered in `preview_registry.dart`; rendered in light/dark/compact/RTL by `test/preview_test.dart`), test-utils driver, goldens (state × light/dark × comfortable/compact × LTR/RTL), and a catalog page.

### Phase 0 (7)

- [~] #12 Box — `CsBox` (Display) _— ported and tested (4b); test-utils driver done (4g); golden matrix done (6a); catalog page pending_
- [~] #42 Dropdown — `CsDropdown` (Overlays) _— ported and tested (4c); test-utils driver done (4g); golden matrix done (6a); catalog page pending_
- [~] #60 Icon — `CsIcon` (Display) _— widget, all props, tests, golden done; test-utils driver done (4g); golden matrix done (6a); catalog page pending_
- [~] #61 Icon provider — `CsIconProvider` (Utility) _— widget, merge rules, componentIcons, tests done; test-utils driver done (4g); catalog page pending_
- [~] #67 Live region — `CsLiveRegion` (Utility) _— behavior ported and tested (4a); test-utils driver done (4g); catalog page pending_
- [~] #70 Navigable group — `CsNavigableGroup` (Utility) _— behavior ported and tested (4a); test-utils driver done (4g); catalog page pending_
- [~] #84 Space between — `CsSpaceBetween` (Layout) _— ported and tested (4b); test-utils driver done (4g); golden matrix done (6a); catalog page pending_

### Phase 1 (25)

- [ ] #1 Action card — `CsActionCard` (Display)
- [ ] #2 Alert — `CsAlert` (Feedback)
- [ ] #8 Badge — `CsBadge` (Display)
- [ ] #14 Button — `CsButton` (Actions)
- [ ] #31 Column layout — `CsColumnLayout` (Layout)
- [ ] #32 Container — `CsContainer` (Layout)
- [ ] #35 Copy to clipboard — `CsCopyToClipboard` (Actions)
- [ ] #40 Divider — `CsDivider` (Display)
- [ ] #44 Expandable section — `CsExpandableSection` (Display)
- [ ] #57 Grid — `CsGrid` (Layout)
- [ ] #58 Header — `CsHeader` (Display)
- [ ] #63 Item card — `CsItemCard` (Display)
- [ ] #64 Key-value pairs — `CsKeyValuePairs` (Display)
- [ ] #65 Link — `CsLink` (Actions)
- [ ] #66 List — `CsList<T>` (Display)
- [ ] #74 Progress bar — `CsProgressBar` (Feedback)
- [ ] #82 Skeleton — `CsSkeleton` (Feedback)
- [ ] #85 Spinner — `CsSpinner` (Feedback)
- [ ] #87 Status indicator — `CsStatusIndicator` (Feedback)
- [ ] #88 Steps — `CsSteps` (Display)
- [ ] #98 Text content — `CsTextContent` (Display)
- [ ] #104 Toggle button — `CsToggleButton` (Actions)
- [ ] #105 Token — `CsToken` (Display)
- [ ] #106 Token group — `CsTokenGroup` (Display)
- [ ] #110 Truncated text — `CsTruncatedText` (Display)

### Phase 2 (21)

- [ ] #6 Attribute editor — `CsAttributeEditor<T>` (Forms)
- [ ] #7 Autosuggest — `CsAutosuggest` (Forms)
- [ ] #17 Calendar — `CsCalendar` (Forms)
- [ ] #26 Checkbox — `CsCheckbox` (Forms)
- [ ] #34 Control group — `CsControlGroup` (Forms)
- [ ] #36 Date input — `CsDateInput` (Forms)
- [ ] #37 Date picker — `CsDatePicker` (Forms)
- [ ] #38 Date range picker — `CsDateRangePicker` (Forms)
- [ ] #50 Form — `CsForm` (Forms)
- [ ] #51 Form field — `CsFormField` (Forms)
- [ ] #62 Input — `CsInput` (Forms)
- [ ] #69 Multiselect — `CsMultiselect` (Forms)
- [ ] #76 Radio button — `CsRadioButton` (Forms)
- [ ] #77 Radio group — `CsRadioGroup<T>` (Forms)
- [ ] #79 Segmented control — `CsSegmentedControl<T>` (Forms)
- [ ] #80 Select — `CsSelect<T>` (Forms)
- [ ] #83 Slider — `CsSlider` (Forms)
- [ ] #100 Text area — `CsTextarea` (Forms)
- [ ] #101 Tiles — `CsTiles<T>` (Forms)
- [ ] #102 Time input — `CsTimeInput` (Forms)
- [ ] #103 Toggle — `CsToggle` (Forms)

### Phase 3 (7)

- [ ] #15 Button dropdown — `CsButtonDropdown` (Actions)
- [ ] #16 Button group — `CsButtonGroup` (Actions)
- [ ] #39 Dialog — `CsDialog` (Overlays)
- [ ] #49 Flashbar — `CsFlashbar` (Feedback)
- [ ] #68 Modal — `CsModal` (Overlays)
- [ ] #73 Popover — `CsPopover` (Overlays)
- [ ] #107 Tooltip — `CsTooltip` (Overlays)

### Phase 4 (15)

- [ ] #3 Anchor navigation — `CsAnchorNavigation` (Navigation)
- [ ] #4 App layout — `CsAppLayout` (Layout)
- [ ] #5 App layout toolbar — `CsAppLayoutToolbar` (Layout)
- [ ] #13 Breadcrumb group — `CsBreadcrumbGroup` (Navigation)
- [ ] #33 Content layout — `CsContentLayout` (Layout)
- [ ] #41 Drawer — `CsDrawer` (Layout)
- [ ] #43 Error boundary — `CsErrorBoundary` (Utility)
- [ ] #59 Help panel — `CsHelpPanel` (Layout)
- [ ] #72 Panel layout — `CsPanelLayout` (Layout)
- [ ] #81 Side navigation — `CsSideNavigation` (Navigation)
- [ ] #86 Split panel — `CsSplitPanel` (Layout)
- [ ] #96 Tabs — `CsTabs` (Navigation)
- [ ] #108 Top navigation — `CsTopNavigation` (Navigation)
- [ ] #109 Tree view — `CsTreeView<T>` (Navigation)
- [ ] #114 Wizard — `CsWizard` (Forms)

### Phase 5 (13)

- [ ] #18 Cards — `CsCards<T>` (Collections)
- [ ] #29 Collection preferences — `CsCollectionPreferences` (Collections)
- [ ] #30 Collection select filter — `CsCollectionSelectFilter` (Collections)
- [ ] #71 Pagination — `CsPagination` (Collections)
- [ ] #75 Property filter — `CsPropertyFilter` (Collections)
- [ ] #89 Table — `CsTable<T>` (Collections)
- [ ] #90 Table root — `CsTableRoot` (Collections)
- [ ] #91 Table head — `CsTableHead` (Collections)
- [ ] #92 Table header cell — `CsTableHeaderCell` (Collections)
- [ ] #93 Table body — `CsTableBody` (Collections)
- [ ] #94 Table row — `CsTableRow` (Collections)
- [ ] #95 Table body cell — `CsTableBodyCell` (Collections)
- [ ] #99 Text filter — `CsTextFilter` (Collections)

### Phase 6 (26)

- [ ] #9 Board — `CsBoard<T>` (Board)
- [ ] #10 Board item — `CsBoardItem` (Board)
- [ ] #11 Items palette — `CsItemsPalette<T>` (Board)
- [ ] #19 Cartesian charts — `CsCartesianChart` (Charts)
- [ ] #20 Pie and donut charts — `CsPieChart` (Charts)
- [ ] #21 Bar chart (legacy) — `CsBarChart` (Charts (legacy))
- [ ] #22 Line chart (legacy) — `CsLineChart` (Charts (legacy))
- [ ] #23 Area chart (legacy) — `CsAreaChart` (Charts (legacy))
- [ ] #24 Mixed line and bar chart (legacy) — `CsMixedLineBarChart` (Charts (legacy))
- [ ] #25 Pie and donut charts (legacy) — `CsPieChartLegacy` (Charts (legacy))
- [ ] #27 Code editor — `CsCodeEditor` (Advanced)
- [ ] #28 Code view — `CsCodeView` (Advanced)
- [ ] #45 File dropzone — `CsFileDropzone` (Files)
- [ ] #46 File token group — `CsFileTokenGroup` (Files)
- [ ] #47 File input — `CsFileInput` (Files)
- [ ] #48 File upload — `CsFileUpload` (Files)
- [ ] #52 Avatar — `CsAvatar` (Gen AI)
- [ ] #53 Chat bubble — `CsChatBubble` (Gen AI)
- [ ] #54 Loading bar — `CsLoadingBar` (Gen AI)
- [ ] #55 Prompt input — `CsPromptInput` (Gen AI)
- [ ] #56 Support prompt group — `CsSupportPromptGroup` (Gen AI)
- [ ] #78 S3 resource selector — `CsS3ResourceSelector` (Advanced)
- [ ] #97 Tag editor — `CsTagEditor` (Forms)
- [ ] #111 Annotation context — `CsAnnotationContext` (Tutorials)
- [ ] #112 Hotspot — `CsHotspot` (Tutorials)
- [ ] #113 Tutorial panel — `CsTutorialPanel` (Tutorials)

### Hidden internals

- [x] Option list engine (select, multiselect, autosuggest, property filter) _(4d: `internal/options/`)_
- [x] Virtual scroller _(4d: `CsOptionsList(virtualScroll: true)`; 4f: `CsRowExtents` for tables)_
- [ ] Focus lock
- [ ] Screen-reader-only text helper
- [ ] Chart core (scales, axes, legend, tooltip)
- [x] Dropdown positioning engine _(4c: `dropdown_geometry.dart`)_

## 4. Architecture rules and shared primitives

- [x] No Material, no Cupertino — build fails on import (incl. Flutter 3.50 `material_ui` / `cupertino_ui`)
- [x] `CsApp` wraps `WidgetsApp`, installs `CsTheme`, `CsI18nProvider`, `CsIconProvider`, `DefaultTextStyle`, `Directionality` _(i18n provider installed when `i18nMessages` is given, matching upstream's no-provider behavior)_
- [ ] Prop parity: React props → camelCase named params; `onX` → typed callbacks; slots → `Widget?`
- [ ] Controlled and uncontrolled support for stateful components
- [~] Visual contexts wrap top nav, flashbar, alert, dark header, compact table _— `CsVisualContext` ready; each component must use it_
- [ ] Layout by container width (`LayoutBuilder`), not screen width
- [ ] Accessibility built in: `Semantics`, Enter/Space/Esc/arrows via `Shortcuts` + `Actions`, focus ring on keyboard focus only

Seven shared primitives:

- [x] `CsPressable`
- [x] `CsFocusRing`
- [x] Dropdown positioning engine _(4c: `dropdown_geometry.dart`)_
- [x] Option list _(4d)_
- [x] Virtual scroller _(4d, 4f)_
- [x] `CsEditableField` _(4e)_
- [x] Live-region announcer _(`CsLiveRegionController`)_

## 5. Patterns, gen-AI patterns and demos

### General patterns (22 rows covering 36 pages)

- [ ] Actions: global actions, in-context actions → Example pages using `CsHeader` actions and `CsButtonDropdown`
- [ ] Announcing new features; announcing beta and preview features → Example with `CsBadge`, `CsFlashbar` info item, `CsPopover`
- [ ] Communicating unsaved changes → `CsUnsavedChangesGuard` widget using `PopScope` + confirm `CsModal`
- [ ] Data visualization; chart metric drill down → Chart example pages with drill-down navigation
- [ ] Density settings → `CsDensity` toggle persisted with `shared_preferences`
- [ ] Disabled and read-only states → `readOnly` + `disabled` on every form control, with `disabledReason` tooltip
- [ ] Drag-and-drop → Shared `CsDragHandle` + keyboard drag mode used by board, list and preferences
- [ ] Errors: error messages, validation → `CsFormField` error/warning, form-level error, focus-first-invalid helper
- [ ] Empty states → `CsEmptyState` helper for table/cards empty and no-match states
- [ ] Feedback mechanisms → Example combining flashbar, alert, status indicator, popover
- [ ] Filtering: saved filter sets, filter persistence in collection views → `CsCollectionController` serializes filter state to a query string via `go_router`
- [ ] Hero header → `CsContentLayout` high-contrast header example
- [ ] Help system → Tools panel + `CsHelpPanel` + info links wired through `CsAppLayout`
- [ ] Image magnifier → `CsImageMagnifier` using `InteractiveViewer` in a modal
- [ ] Loading and refreshing → Refresh button + last-updated timestamp + table loading state
- [ ] Onboarding; hands-on tutorials → Tutorial components example
- [ ] Selection in forms → Example comparing checkbox, radio, tiles, select, multiselect, toggle
- [ ] Service navigation: side navigation, top navigation → `CsAppLayout` + `CsTopNavigation` + `CsSideNavigation` shell
- [ ] Service dashboard: static, configurable, dashboard items → Static grid dashboard and `CsBoard` dashboard examples
- [ ] Secondary panels → Split panel, tools panel, drawers examples
- [ ] Timestamps → `CsTimestamp` formatter (relative and absolute, ISO 8601, timezone)
- [ ] User feedback → Feedback widget example (thumbs + comment modal)

### Resource-management patterns (5 rows covering 23 pages)

- [ ] Create: multipage, single page, sub resource, defaults → `CsWizard` page, `CsForm` page, attribute editor inside forms
- [ ] Delete: one-click, simple confirmation, additional confirmation → `showCsDeleteConfirmation()` helpers (type-to-confirm variant)
- [ ] Edit: page edit, inline edit, attribute editing → Edit page, `CsTable` inline edit, attribute editor
- [ ] View: table, card, split, nested resources, grouped resources → Table/cards pages; expandable rows; split panel detail
- [ ] Details: details page, with tabs, as a hub → Details pages with `CsKeyValuePairs`, `CsTabs`, related tables

### Generative-AI foundation and patterns (19)

- [ ] `CsGenAiTokens` subset (visual affordance, colors, iconography)
- [ ] Pattern abstraction
- [ ] Generative AI chat
- [ ] Ingress
- [ ] Output label
- [ ] Loading states
- [ ] Progressive steps
- [ ] Follow-up questions
- [ ] User authorized actions
- [ ] Variables
- [ ] Shortcut menus
- [ ] Response regeneration
- [ ] Artifact previews
- [ ] Conversational history
- [ ] Support prompts
- [ ] Thinking
- [ ] Timeline overview
- [ ] In-chat context
- [ ] Agent management
- [ ] In-flow user input

### Demo pages (33) — each is the acceptance test for its phase

- [ ] Card view
- [ ] Communicate unsaved changes
- [ ] Configurable dashboard
- [ ] Delete with additional confirmation
- [ ] Delete with simple confirmation
- [ ] One-click delete
- [ ] Density settings
- [ ] Details page
- [ ] Details page as a hub
- [ ] Details page with tabs
- [ ] Edit resource
- [ ] Form validation
- [ ] Generative AI chat
- [ ] Hands-on tutorials
- [ ] Manage tags
- [ ] Multipage create
- [ ] Product detail page
- [ ] Read from Amazon S3
- [ ] Write to Amazon S3
- [ ] Single page create
- [ ] Service dashboard
- [ ] Split view
- [ ] Split view with details comparison
- [ ] Table property filter
- [ ] Table property filter (server-side)
- [ ] Table with saved filter sets
- [ ] Table view
- [ ] Table view (server-side)
- [ ] Table view with date filter
- [ ] Table with select filter
- [ ] Table with inline edit
- [ ] Top navigation
- [ ] Table with expandable rows

## 6. Testing, documentation, tooling and release

Test infrastructure:

- [~] Unit and widget tests — `flutter_test`: Props, callbacks, controlled/uncontrolled state, keyboard handling _— every component and primitive built so far has them (306 tests in `cloudscape_flutter`); continues per component_
- [~] Test utils (public) — _foundation done (4g)_ — `cloudscape_flutter_test` package: `find.csButton(label)`, `CsTableDriver.sortBy()`, `CsSelectDriver.open()` — the Dart equivalent of `test-utils`
- [~] Visual regression — `alchemist` golden tests: Every state × light/dark × comfortable/compact × LTR/RTL _— own harness (6a): every preview × 8 variants; grows with each component's previews_
- [ ] Parity screenshots — Playwright screenshots of the React demos: Side-by-side diff against Flutter web goldens for the same page
- [ ] Accessibility — `flutter_test` semantics matchers + `accessibility_tools`: Labels, roles, focus order, contrast against tokens
- [ ] Integration — `integration_test` on web and desktop: Full demo pages: table filtering, wizard flow, board drag
- [ ] Motion — Golden frames at fixed animation ticks: Expand/collapse, flashbar stacking, modal open

Docs, repo and CI:

- [ ] Catalog app (Widgetbook): live playground, variants, dartdoc API table, link to Cloudscape guideline
- [x] `melos` monorepo with the package/app layout from the plan
- [x] `tool/token_gen` — style-dictionary JSON → Dart
- [x] `tool/icon_gen` — SVG icons → icon font + enum _(vector data + enum instead of a font; `icons:check` in CI)_
- [x] `tool/i18n_gen` — message bundles → ARB _(+ Dart libraries; `i18n:check` in CI)_
- [ ] `tool/parity_check` — compares component/prop lists with the React repo
- [ ] CI: `dart analyze`, all tests, golden diffs, parity check on every PR
- [ ] Publish to pub.dev with semantic versioning from a changelog

## 7. Completeness checklist (from the plan)

- [ ] All 17 repositories mapped to a Dart package, tool or decision (section 2)
- [x] Token codegen covers every token for light, dark, comfortable, compact and each visual context _(also motion normal/disabled)_
- [~] Visual refresh theme done; classic theme decided (build or drop) _— classic: **dropped**; VR tokens/theme done; VR widgets pending_
- [x] Full icon set converted, plus `CsIconProvider` overrides _(148 icons + gen-ai small glyph)_
- [~] All i18n message bundles ported to ARB, with RTL verified _— all 15 bundles ported and parity-tested; dates/numbers for all 739 CLDR locales (step 5); RTL verification happens per component (Arabic UI)_
- [ ] All 114 component entries in section 4 implemented with full prop parity
- [~] Hidden internals built: option list, virtual scroller, focus lock, dropdown positioning, chart core, screen-reader-only text _— option list, virtual scroller, dropdown positioning done (4c/4d); focus lock, chart core, screen-reader-only text pending_
- [ ] Collection controller ports filtering, property filtering, sorting, pagination, selection, expandable rows
- [ ] All 36 general and 23 resource-management pattern pages have an example
- [ ] All 19 gen-AI patterns have an example in the chat package
- [ ] All 33 demo pages reproduced and screenshot-diffed against the React versions
- [ ] Golden tests for every component state × mode × density × direction
- [~] Public test utilities for every component _— drivers for every component built so far (4g)_
- [ ] Catalog site live with API docs for every widget
- [x] Apache 2.0 LICENSE and NOTICE included, crediting Cloudscape

## 8. Risk mitigations

- [ ] Charts depend on Highcharts in React → Write the chart core from scratch with `CustomPainter`; match the visual output, not the implementation
- [x] Text input fidelity → Build one `CsEditableField` base early (phase 0) and reuse it in every input _(4e)_
- [x] Table performance → Prototype `CsTableRoot` on `TwoDimensionalScrollView` in phase 0 as a spike _(4f; findings in the build log)_
- [ ] Web accessibility → Test with real screen readers (NVDA, VoiceOver) on the demos each phase
- [~] Upstream drift → _pinned upstream + `tokens:check` in CI done; weekly `parity_check` pending_ → Run `parity_check` weekly against the latest npm release and track a pinned upstream version
- [ ] Brand and trademark → Name the package neutrally and keep AWS-specific widgets in an optional package
- [ ] Scope size → Ship phase by phase; each phase is releasable on its own
