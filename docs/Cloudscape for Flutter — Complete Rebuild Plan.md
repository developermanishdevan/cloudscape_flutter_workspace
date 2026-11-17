# Cloudscape for Flutter — Complete Rebuild Plan

Nov 16, 2026 · @John Britto

## Goal and scope

Build a Flutter/Dart package, working name `cloudscape_flutter`, that reproduces the Cloudscape Design System end to end: tokens, themes, every component, every pattern, accessibility and i18n, built only on `package:flutter/widgets.dart` with no Material or Cupertino imports.

"Zero missing" is defined as four parity checks, each tracked in the completeness checklist at the end:

- **Component parity:** every public component in `cloudscape-design/components` has a Flutter widget with the same props, events and slots.
- **Token parity:** every design token in `cloudscape-design/components` style-dictionary output exists in Dart, for light, dark, comfortable and compact modes.
- **Behavior parity:** keyboard interaction, focus order, ARIA roles (mapped to Flutter `Semantics`) and i18n strings match the React version.
- **Visual parity:** golden tests compare each component state against screenshots of the React version.

Targets are Flutter web first (Cloudscape is a web console system), then desktop (macOS, Windows, Linux), then mobile where the components still make sense.

Licensing must be checked before any code is copied or ported. Section 2 records each repository's license as found on GitHub.

## Repository inventory (17 repos)

The Cloudscape GitHub organization has 17 public repositories; 15 are Apache License 2.0, `demos` is MIT No Attribution, and `.github` holds org config. Apache 2.0 allows porting, provided the Flutter package keeps the license and a NOTICE crediting Cloudscape. Source: [org repository list](https://github.com/orgs/cloudscape-design/repositories?type=all).

| Repo | What it does in Cloudscape | Flutter equivalent to build | Priority |
| --- | --- | --- | --- |
| [components](https://github.com/cloudscape-design/components) | All core React components, SCSS, design tokens, i18n messages | `cloudscape_flutter` core package (tokens, theme, all widgets) | P0 |
| [global-styles](https://github.com/cloudscape-design/global-styles) | Global CSS: fonts (Open Sans), base text, body reset | `CsApp` root: `DefaultTextStyle`, bundled font, base background | P0 |
| [theming-core](https://github.com/cloudscape-design/theming-core) | Token resolution, visual modes, runtime theme overrides | `CsThemeData` + `applyTheme()` runtime override API, token codegen | P0 |
| [component-toolkit](https://github.com/cloudscape-design/component-toolkit) | Shared internals: focus visible, direction (RTL), container queries, visual-mode detection, metrics | `internal/` primitives: `FocusVisible`, `ContainerQuery`, `Directionality` helpers | P0 |
| [collection-hooks](https://github.com/cloudscape-design/collection-hooks) | `useCollection`: filter, property filter, sort, paginate, select for tables/cards | `CsCollectionController<T>` (ChangeNotifier) | P1 |
| [test-utils](https://github.com/cloudscape-design/test-utils) | Test wrappers to find and drive components in tests | `cloudscape_flutter_test`: finder extensions and component drivers for `WidgetTester` | P1 |
| [board-components](https://github.com/cloudscape-design/board-components) | Board, BoardItem, ItemsPalette: drag/drop/resize dashboards | `cloudscape_board` package | P2 |
| [chart-components](https://github.com/cloudscape-design/chart-components) | New chart library (Cartesian and pie charts) | `cloudscape_charts` package with `CustomPainter` | P2 |
| [code-view](https://github.com/cloudscape-design/code-view) | Read-only syntax-highlighted code display | `cloudscape_code_view` package | P2 |
| [chat-components](https://github.com/cloudscape-design/chat-components) | Generative-AI chat UI: chat bubble, avatar, loading bar, support prompts | `cloudscape_chat` package | P2 |
| [demos](https://github.com/cloudscape-design/demos) | Full reference pages (tables, forms, dashboards, wizards) | `example/` app reproducing every demo page | P1 |
| [documenter](https://github.com/cloudscape-design/documenter) | Extracts component API docs from TypeScript | Use dartdoc + a generated API JSON for the docs site | P3 |
| [browser-test-tools](https://github.com/cloudscape-design/browser-test-tools) | Browser screenshot and integration test harness | `integration_test` + golden tooling (alchemist) | P1 |
| [jest-preset](https://github.com/cloudscape-design/jest-preset) | Jest config for Cloudscape packages | `flutter_test` config, shared `dart_test.yaml` | P3 |
| [build-tools](https://github.com/cloudscape-design/build-tools) | Build scripts, linting, release helpers | `melos` monorepo scripts + `build_runner` | P3 |
| [actions](https://github.com/cloudscape-design/actions) | Shared GitHub Actions workflows | GitHub Actions: analyze, test, golden diff, publish | P3 |
| [.github](https://github.com/cloudscape-design/.github) | Org profile, templates | Repo templates, CONTRIBUTING, issue templates | P3 |

P0 is the foundation everything else depends on; P3 is tooling with no runtime code.

## Foundations (build these before any component)

Cloudscape's [Foundation](https://cloudscape.design/foundation/) has 13 visual-foundation topics and 3 key principles; each one becomes a Dart module that every widget reads from. Nothing in a component may hardcode a color, size, font or duration.

| Foundation topic | What it defines | Flutter implementation |
| --- | --- | --- |
| [Design tokens](https://cloudscape.design/foundation/visual-foundation/design-tokens/) | Named abstractions for color, size, border, shadow, motion | Codegen: parse `style-dictionary/` JSON → `cs_tokens.g.dart` with one `CsTokens` class per mode |
| [Colors](https://cloudscape.design/foundation/visual-foundation/colors/) | Palette + semantic roles (text, background, border, status) | `CsColorTokens` with semantic names only (`colorTextBodyDefault`, `colorBackgroundButtonPrimaryDefault`) |
| [Data visualization colors](https://cloudscape.design/foundation/visual-foundation/data-vis-colors/) | Categorical, sequential, status palettes for charts | `CsChartPalette` used by every chart painter |
| [Typography](https://cloudscape.design/foundation/visual-foundation/typography/) | Font family, sizes, weights, line heights, heading scale | Bundle Open Sans as a font asset; `CsTypography` with heading XL→XS, body M/S, display L, code |
| [Spacing](https://cloudscape.design/foundation/visual-foundation/spacing/) | xxxs→xxxl spacing scale | `CsSpacing` enum → double; used by `SpaceBetween`, `Box` padding/margin |
| [Layout](https://cloudscape.design/foundation/visual-foundation/layout/) | Grid, breakpoints, page structure | `CsBreakpoints` + `CsBreakpointBuilder` (LayoutBuilder-based, container width not screen width) |
| [Content density](https://cloudscape.design/foundation/visual-foundation/content-density/) | Comfortable vs compact | `CsDensity` enum in theme; spacing and control heights switch per density |
| [Visual modes](https://cloudscape.design/foundation/visual-foundation/visual-modes/) | Light and dark | `CsMode.light / dark`; follow `MediaQuery.platformBrightness` by default |
| [Visual context](https://cloudscape.design/foundation/visual-foundation/visual-context/) | Different token values inside specific areas (top nav, dark header, flashbar, alert, compact table) | `CsVisualContext` InheritedWidget that overrides a token subset for its subtree |
| [Theming](https://cloudscape.design/foundation/visual-foundation/theming/) | Runtime token overrides by brand | `CsTheme.override(tokens: {...}, contexts: {...})`, mirroring `applyTheme()` |
| [Visual style](https://cloudscape.design/foundation/visual-foundation/visual-style/) | Radii, borders, shadows, overall look | `CsShapeTokens`, `CsShadowTokens` |
| [Iconography](https://cloudscape.design/foundation/visual-foundation/iconography/) | Built-in SVG icon set, sizes, variants | Convert the SVGs to an icon font (or `flutter_svg` assets); `CsIconName` enum; `IconProvider` for overrides |
| [Motion](https://cloudscape.design/foundation/visual-foundation/motion/) | Durations, easings, reduced-motion behavior | `CsMotionTokens`; respect `MediaQuery.disableAnimations` and a global `disableMotion` flag |
| [Accessibility](https://cloudscape.design/foundation/core-principles/accessibility/) and [focus management](https://cloudscape.design/foundation/core-principles/accessibility/focus-management-principles/) | ARIA roles, focus rings, focus return, keyboard support | `Semantics` on every widget; `CsFocusRing`; focus-return helper for modals, popovers, drawers |
| [Responsive design](https://cloudscape.design/foundation/core-principles/responsive-design/) | Behavior across viewport sizes | Container-query style breakpoints per component, not only page-level |
| [Bidirectionality](https://cloudscape.design/foundation/core-principles/bidirectionality/) | RTL layout and icon mirroring | `Directionality` + `EdgeInsetsDirectional` everywhere; mirror directional icons |

Two cross-cutting items also belong here. **i18n:** port every message bundle from the components repo into ARB files and expose a `CsI18nProvider`, matching Cloudscape's `I18nProvider`. **Theme variants:** Cloudscape ships a current "visual refresh" look and an older "classic" look; build visual refresh first and treat classic as a second token set.

The exact token values (spacing pixels, font sizes, breakpoints, colors) must come from the generated style-dictionary output, not from memory, so the token codegen script is the first piece of real code.

## Component inventory A–Z (114 entries)

The [Cloudscape components index](https://cloudscape.design/components/) lists 114 entries once sub-components (board, charts, file upload, gen AI, table atomic, tutorial) are counted separately; every one gets a Flutter widget with the `Cs` prefix. Phase numbers refer to the roadmap in section 7.

| # | Component | Category | Flutter widget | How to build it in Flutter | Phase |
| --- | --- | --- | --- | --- | --- |
| 1 | Action card | Display | `CsActionCard` | `CsPressable` + container tokens + header/description/actions slots | 1 |
| 2 | Alert | Feedback | `CsAlert` | Status-colored `DecoratedBox`, icon, dismiss button, action slot, `CsVisualContext(alert)` | 1 |
| 3 | Anchor navigation | Navigation | `CsAnchorNavigation` | Listens to `ScrollController`, uses `Scrollable.ensureVisible` on `GlobalKey`s; active-anchor tracking | 4 |
| 4 | App layout | Layout | `CsAppLayout` | Custom multi-child layout: navigation, content, tools, drawers, split panel, notifications, breadcrumbs; responsive collapse to overlays below breakpoint | 4 |
| 5 | App layout toolbar | Layout | `CsAppLayoutToolbar` | Toolbar variant of app layout; shares the same layout engine with a toolbar trigger strip | 4 |
| 6 | Attribute editor | Forms | `CsAttributeEditor<T>` | Dynamic row list of form fields + add/remove buttons, focus moves on remove | 2 |
| 7 | Autosuggest | Forms | `CsAutosuggest` | `CsInput` + `CsDropdown` overlay + virtualized option list + async loading states | 2 |
| 8 | Badge | Display | `CsBadge` | Colored pill, color enum → tokens | 1 |
| 9 | Board | Board | `CsBoard<T>` | Grid layout engine, drag via `Listener`/pointer events, resize handles, keyboard move mode, live announcements | 6 |
| 10 | Board item | Board | `CsBoardItem` | Container + drag handle + resize handle + settings slot | 6 |
| 11 | Items palette | Board | `CsItemsPalette<T>` | Draggable item list placed in split panel; drops onto `CsBoard` | 6 |
| 12 | Box | Display | `CsBox` | Variant (h1–h5, p, small, code, awsui-key-label…), color, font size/weight, padding/margin by spacing tokens | 0 |
| 13 | Breadcrumb group | Navigation | `CsBreadcrumbGroup` | Row of links + separators; collapses middle items into a dropdown when narrow | 4 |
| 14 | Button | Actions | `CsButton` | `CsPressable`; variants primary/normal/link/icon/inline-icon/inline-link; loading, disabled, external, `href` | 1 |
| 15 | Button dropdown | Actions | `CsButtonDropdown` | `CsButton` + `CsDropdown` menu; nested groups, checkbox items, main-action split button | 3 |
| 16 | Button group | Actions | `CsButtonGroup` | Row of icon buttons, toggle buttons, menu overflow; one tab stop via `CsNavigableGroup` | 3 |
| 17 | Calendar | Forms | `CsCalendar` | Month grid with arrow-key navigation, locale start-of-week, `isDateEnabled`, month/year granularity | 2 |
| 18 | Cards | Collections | `CsCards<T>` | Responsive grid of card items, selection (single/multi), header, filter, pagination, preferences slots | 5 |
| 19 | Cartesian charts | Charts | `CsCartesianChart` | `CustomPainter`: line, bar, area, scatter, bubble, mixed; axes, legend, tooltip, keyboard focus on points | 6 |
| 20 | Pie and donut charts | Charts | `CsPieChart` | `CustomPainter` arcs, labels, legend, inner metric | 6 |
| 21 | Bar chart (legacy) | Charts (legacy) | `CsBarChart` | Shares chart core; legacy API shape | 6 |
| 22 | Line chart (legacy) | Charts (legacy) | `CsLineChart` | Shares chart core | 6 |
| 23 | Area chart (legacy) | Charts (legacy) | `CsAreaChart` | Stacked area paths | 6 |
| 24 | Mixed line and bar chart (legacy) | Charts (legacy) | `CsMixedLineBarChart` | Bars + lines on shared axes | 6 |
| 25 | Pie and donut charts (legacy) | Charts (legacy) | `CsPieChartLegacy` | Shares pie painter | 6 |
| 26 | Checkbox | Forms | `CsCheckbox` | Painted box with checked/indeterminate/disabled/read-only; `Semantics(checked)` | 2 |
| 27 | Code editor | Advanced | `CsCodeEditor` | Wrap a Dart code-editor package (e.g. `re_editor`) with Cloudscape chrome, status bar, preferences | 6 |
| 28 | Code view | Advanced | `CsCodeView` | Read-only highlighted text (`highlight` package), line numbers, copy action, wrap toggle | 6 |
| 29 | Collection preferences | Collections | `CsCollectionPreferences` | Modal with page size radios, wrap lines, striped rows, content density, column visibility/reorder, sticky columns | 5 |
| 30 | Collection select filter | Collections | `CsCollectionSelectFilter` | Text filter + one or two `CsSelect`s in a row | 5 |
| 31 | Column layout | Layout | `CsColumnLayout` | 1–4 columns, variants default/text-grid, borders, breakpoint-driven column count | 1 |
| 32 | Container | Layout | `CsContainer` | Header, footer, media slot, variants (default/stacked/full-page), fit-height, sticky header | 1 |
| 33 | Content layout | Layout | `CsContentLayout` | Page header area with optional high-contrast background, overlap, max width | 4 |
| 34 | Control group | Forms | `CsControlGroup` | Joins adjacent controls into one visual unit; shared borders | 2 |
| 35 | Copy to clipboard | Actions | `CsCopyToClipboard` | `Clipboard.setData` + popover feedback; button / icon / inline variants | 1 |
| 36 | Date input | Forms | `CsDateInput` | Masked `EditableText` (YYYY/MM/DD), locale formats | 2 |
| 37 | Date picker | Forms | `CsDatePicker` | `CsDateInput` + calendar in `CsDropdown` | 2 |
| 38 | Date range picker | Forms | `CsDateRangePicker` | Absolute (two calendars + time inputs) and relative modes, validation, custom relative options | 2 |
| 39 | Dialog | Overlays | `CsDialog` | Non-modal floating panel via `OverlayPortal`; header, pagination, actions | 3 |
| 40 | Divider | Display | `CsDivider` | Border token line, horizontal/vertical | 1 |
| 41 | Drawer | Layout | `CsDrawer` | Panel content (header, footer, sticky) used inside app layout drawers | 4 |
| 42 | Dropdown | Overlays | `CsDropdown` | Shared positioning engine: `CompositedTransformFollower`, flip/fit to viewport, min/max width, focus trap | 0 |
| 43 | Error boundary | Utility | `CsErrorBoundary` | Catch build errors with a custom `ErrorWidget.builder` scope + `FlutterError.onError`; fallback UI + retry | 4 |
| 44 | Expandable section | Display | `CsExpandableSection` | Animated size/opacity; variants default/footer/container/stacked/inline; controlled and uncontrolled | 1 |
| 45 | File dropzone | Files | `CsFileDropzone` | `desktop_drop` / web drag events; highlighted drop area | 6 |
| 46 | File token group | Files | `CsFileTokenGroup` | Tokens showing name, size, date, thumbnail, error/warning, loading | 6 |
| 47 | File input | Files | `CsFileInput` | Button that opens `file_picker`; multiple, accept filters | 6 |
| 48 | File upload | Files | `CsFileUpload` | File input + dropzone + file token group, constraint and error text | 6 |
| 49 | Flashbar | Feedback | `CsFlashbar` | Stack of notifications, collapsible stacking with counts, animations, `CsVisualContext(flashbar)` | 3 |
| 50 | Form | Forms | `CsForm` | Header, content, actions, secondary actions, error text, form-level error | 2 |
| 51 | Form field | Forms | `CsFormField` | Label, info link, description, constraint, error, warning, secondary control, stretch; wires `Semantics` labels to control | 2 |
| 52 | Avatar | Gen AI | `CsAvatar` | Circle with initials/icon/image, gen-AI color variant, loading animation | 6 |
| 53 | Chat bubble | Gen AI | `CsChatBubble` | Message container (incoming/outgoing), avatar slot, actions, loading | 6 |
| 54 | Loading bar | Gen AI | `CsLoadingBar` | Indeterminate animated gradient bar | 6 |
| 55 | Prompt input | Gen AI | `CsPromptInput` | Auto-growing textarea, action button, secondary actions, file tokens, max rows | 6 |
| 56 | Support prompt group | Gen AI | `CsSupportPromptGroup` | Selectable prompt chips, keyboard navigable | 6 |
| 57 | Grid | Layout | `CsGrid` | 12-column responsive grid with per-breakpoint colspan/offset/push/pull | 1 |
| 58 | Header | Display | `CsHeader` | h1/h2/h3 variants, counter, description, info slot, actions slot; awsui-h1-sticky | 1 |
| 59 | Help panel | Layout | `CsHelpPanel` | Tools-panel content: header, rich text body, footer, loading | 4 |
| 60 | Icon | Display | `CsIcon` | Built-in icon set by name, size (small/normal/medium/big/large), variant colors, custom SVG/URL | 0 |
| 61 | Icon provider | Utility | `CsIconProvider` | InheritedWidget mapping icon names → custom widgets | 0 |
| 62 | Input | Forms | `CsInput` | `EditableText` with Cloudscape border/focus, types (text, search, number, email, url, password), clear button, invalid/warning states | 2 |
| 63 | Item card | Display | `CsItemCard` | Single structured card: media, header, description, metadata | 1 |
| 64 | Key-value pairs | Display | `CsKeyValuePairs` | Responsive columns of label/value, info link, nested groups | 1 |
| 65 | Link | Actions | `CsLink` | Text with hover/focus, external icon, variants primary/secondary/info/awsui-value-large, `url_launcher` | 1 |
| 66 | List | Display | `CsList<T>` | Items with icon/content/secondary/actions, sortable variant with drag reorder | 1 |
| 67 | Live region | Utility | `CsLiveRegion` | `SemanticsService.announce` + `Semantics(liveRegion: true)`, polite/assertive | 0 |
| 68 | Modal | Overlays | `CsModal` | `ModalRoute`/`RawDialogRoute`, sizes (small→max), header/footer, focus trap and focus return, Esc to close | 3 |
| 69 | Multiselect | Forms | `CsMultiselect` | Select engine with checkbox options, groups, token group of selected, select-all, filtering | 2 |
| 70 | Navigable group | Utility | `CsNavigableGroup` | One tab stop, arrow keys between children (`FocusTraversalGroup` + `Shortcuts`) | 0 |
| 71 | Pagination | Collections | `CsPagination` | Page buttons with ellipsis, open-ended mode, jump-to-page | 5 |
| 72 | Panel layout | Layout | `CsPanelLayout` | Two panels side by side with draggable resize handle | 4 |
| 73 | Popover | Overlays | `CsPopover` | Trigger + positioned body with arrow, sizes, dismiss button, header | 3 |
| 74 | Progress bar | Feedback | `CsProgressBar` | Value, label, description, result states (success/error), flash/key-value variants | 1 |
| 75 | Property filter | Collections | `CsPropertyFilter` | Token-based query builder: property → operator → value autosuggest, AND/OR, token groups, custom forms, async options, i18n | 5 |
| 76 | Radio button | Forms | `CsRadioButton` | Standalone painted radio | 2 |
| 77 | Radio group | Forms | `CsRadioGroup<T>` | Vertical/horizontal radios, descriptions, arrow-key selection | 2 |
| 78 | S3 resource selector | Advanced | `CsS3ResourceSelector` | Input + browse modal with bucket/object/version tables; data via callbacks | 6 |
| 79 | Segmented control | Forms | `CsSegmentedControl<T>` | Joined buttons with selected state; collapses to `CsSelect` when narrow | 2 |
| 80 | Select | Forms | `CsSelect<T>` | Trigger + `CsDropdown` + virtualized options, groups, filtering, async loading, empty/error states | 2 |
| 81 | Side navigation | Navigation | `CsSideNavigation` | Header, links, sections, expandable groups, dividers, info badges, active href | 4 |
| 82 | Skeleton | Feedback | `CsSkeleton` | Shimmer placeholder blocks honoring reduced motion | 1 |
| 83 | Slider | Forms | `CsSlider` | Custom painted track/thumb, ticks, reference values, keyboard steps | 2 |
| 84 | Space between | Layout | `CsSpaceBetween` | Vertical/horizontal spacing by token, alignment | 0 |
| 85 | Spinner | Feedback | `CsSpinner` | Animated arc painter, sizes, inverted/disabled colors | 1 |
| 86 | Split panel | Layout | `CsSplitPanel` | Bottom or side panel inside app layout, resizable, preferences popover, closed state | 4 |
| 87 | Status indicator | Feedback | `CsStatusIndicator` | Icon + text per status type (success, error, warning, info, pending, in-progress, stopped, loading, not-started) | 1 |
| 88 | Steps | Display | `CsSteps` | Vertical list of steps with status indicators and connectors | 1 |
| 89 | Table | Collections | `CsTable<T>` | Built on table atomic parts: sticky header/columns, resizable columns, sorting, selection, inline edit, expandable rows, wrap lines, striped rows, loading/empty, virtualized body | 5 |
| 90 | Table root | Collections | `CsTableRoot` | `TwoDimensionalScrollView`/custom render: column widths + table semantics | 5 |
| 91 | Table head | Collections | `CsTableHead` | Sticky header row container | 5 |
| 92 | Table header cell | Collections | `CsTableHeaderCell` | Label, sort button, resize handle, `aria-sort` → `Semantics(sortKey)` | 5 |
| 93 | Table body | Collections | `CsTableBody` | Lazily built rows | 5 |
| 94 | Table row | Collections | `CsTableRow` | Selected and shaded states | 5 |
| 95 | Table body cell | Collections | `CsTableBodyCell` | Cell padding/alignment, row-header option, inline edit trigger | 5 |
| 96 | Tabs | Navigation | `CsTabs` | Tab header with scroll arrows, disabled tabs, dismissible tabs, action slot, keyboard arrows; variants default/container/stacked | 4 |
| 97 | Tag editor | Forms | `CsTagEditor` | Attribute editor + key/value autosuggest + AWS tag validation rules (as configurable rules) | 6 |
| 98 | Text content | Display | `CsTextContent` | Rich text styling for h1–h5, p, lists, code, links (render from a small HTML/Markdown subset) | 1 |
| 99 | Text filter | Collections | `CsTextFilter` | Search input + results count text | 5 |
| 100 | Text area | Forms | `CsTextarea` | Multi-line `EditableText`, rows, auto-grow, invalid/warning | 2 |
| 101 | Tiles | Forms | `CsTiles<T>` | Radio cards with image, label, description, responsive columns | 2 |
| 102 | Time input | Forms | `CsTimeInput` | Masked hh:mm:ss input, 12/24h | 2 |
| 103 | Toggle | Forms | `CsToggle` | Painted switch with animation, description | 2 |
| 104 | Toggle button | Actions | `CsToggleButton` | Button with pressed state + pressed icon | 1 |
| 105 | Token | Display | `CsToken` | Label, icon, description, tags, dismiss; inline variant | 1 |
| 106 | Token group | Display | `CsTokenGroup` | Wrap of tokens, limit + "show more", dismiss with focus management | 1 |
| 107 | Tooltip | Overlays | `CsTooltip` | Hover/focus overlay with delay, shares dropdown positioning | 3 |
| 108 | Top navigation | Navigation | `CsTopNavigation` | Identity, search, utilities (buttons, menus), overflow menu on narrow widths, `CsVisualContext(top-navigation)` | 4 |
| 109 | Tree view | Navigation | `CsTreeView<T>` | Expandable nested items, connector lines, keyboard tree navigation, lazily built children | 4 |
| 110 | Truncated text | Display | `CsTruncatedText` | `TextPainter` overflow detection + tooltip with full text | 1 |
| 111 | Annotation context | Tutorials | `CsAnnotationContext` | InheritedNotifier tracking tutorial step; renders annotation popovers and hotspot icons | 6 |
| 112 | Hotspot | Tutorials | `CsHotspot` | Marker widget registered with annotation context | 6 |
| 113 | Tutorial panel | Tutorials | `CsTutorialPanel` | Tutorial list + step view in the tools panel | 6 |
| 114 | Wizard | Forms | `CsWizard` | Step navigation pane, header, content, previous/next/cancel/submit, optional steps, skip-to, loading | 4 |

Hidden internals also need building even though they are not listed on the website: the option list engine (shared by select, multiselect, autosuggest, property filter), the virtual scroller, the focus-lock, the screen-reader-only text helper, and the chart core (scales, axes, legend, tooltip).

## Patterns, gen-AI patterns and demos

Patterns are not new widgets; each one becomes an example page in `example/` plus, where useful, a helper API. Cloudscape has 36 general pattern pages and 23 resource-management pattern pages (counting sub-pages), 19 generative-AI patterns and 33 demo pages ([patterns](https://cloudscape.design/patterns/), [gen AI](https://cloudscape.design/gen-ai/), [demos](https://cloudscape.design/demos/)).

### General patterns

| Pattern | Flutter deliverable |
| --- | --- |
| Actions: global actions, in-context actions | Example pages using `CsHeader` actions and `CsButtonDropdown` |
| Announcing new features; announcing beta and preview features | Example with `CsBadge`, `CsFlashbar` info item, `CsPopover` |
| Communicating unsaved changes | `CsUnsavedChangesGuard` widget using `PopScope` + confirm `CsModal` |
| Data visualization; chart metric drill down | Chart example pages with drill-down navigation |
| Density settings | `CsDensity` toggle persisted with `shared_preferences` |
| Disabled and read-only states | `readOnly` + `disabled` on every form control, with `disabledReason` tooltip |
| Drag-and-drop | Shared `CsDragHandle` + keyboard drag mode used by board, list and preferences |
| Errors: error messages, validation | `CsFormField` error/warning, form-level error, focus-first-invalid helper |
| Empty states | `CsEmptyState` helper for table/cards empty and no-match states |
| Feedback mechanisms | Example combining flashbar, alert, status indicator, popover |
| Filtering: saved filter sets, filter persistence in collection views | `CsCollectionController` serializes filter state to a query string via `go_router` |
| Hero header | `CsContentLayout` high-contrast header example |
| Help system | Tools panel + `CsHelpPanel` + info links wired through `CsAppLayout` |
| Image magnifier | `CsImageMagnifier` using `InteractiveViewer` in a modal |
| Loading and refreshing | Refresh button + last-updated timestamp + table loading state |
| Onboarding; hands-on tutorials | Tutorial components example |
| Selection in forms | Example comparing checkbox, radio, tiles, select, multiselect, toggle |
| Service navigation: side navigation, top navigation | `CsAppLayout` + `CsTopNavigation` + `CsSideNavigation` shell |
| Service dashboard: static, configurable, dashboard items | Static grid dashboard and `CsBoard` dashboard examples |
| Secondary panels | Split panel, tools panel, drawers examples |
| Timestamps | `CsTimestamp` formatter (relative and absolute, ISO 8601, timezone) |
| User feedback | Feedback widget example (thumbs + comment modal) |

### Resource-management patterns

| Pattern | Flutter deliverable |
| --- | --- |
| Create: multipage, single page, sub resource, defaults | `CsWizard` page, `CsForm` page, attribute editor inside forms |
| Delete: one-click, simple confirmation, additional confirmation | `showCsDeleteConfirmation()` helpers (type-to-confirm variant) |
| Edit: page edit, inline edit, attribute editing | Edit page, `CsTable` inline edit, attribute editor |
| View: table, card, split, nested resources, grouped resources | Table/cards pages; expandable rows; split panel detail |
| Details: details page, with tabs, as a hub | Details pages with `CsKeyValuePairs`, `CsTabs`, related tables |

### Generative-AI patterns and foundation

Gen-AI foundation adds its own visual affordance, colors and iconography; these become a `CsGenAiTokens` subset. The 19 patterns become chat examples: pattern abstraction, generative AI chat, ingress, output label, loading states, progressive steps, follow-up questions, user authorized actions, variables, shortcut menus, response regeneration, artifact previews, conversational history, support prompts, thinking, timeline overview, in-chat context, agent management, and in-flow user input.

### Demo pages to reproduce (33)

Card view; communicate unsaved changes; configurable dashboard; delete with additional confirmation; delete with simple confirmation; one-click delete; density settings; details page; details page as a hub; details page with tabs; edit resource; form validation; generative AI chat; hands-on tutorials; manage tags; multipage create; product detail page; read from Amazon S3; write to Amazon S3; single page create; service dashboard; split view; split view with details comparison; table property filter; table property filter (server-side); table with saved filter sets; table view; table view (server-side); table view with date filter; table with select filter; table with inline edit; top navigation; table with expandable rows.

Each demo is the acceptance test for its phase: a phase is done only when its demos render and behave like the React originals.

## Flutter architecture and core primitives

The library is seven layers, each depending only on the one below; the shared-primitives layer is the one that makes 114 components consistent, so it is built first.

&#91;embedded content: package architecture · 7 layers\]

Architecture rules that every package follows:

- **No Material, no Cupertino.** A custom lint rule fails the build on any `package:flutter/material.dart` or `cupertino.dart` import.
- **Root widget.** `CsApp` wraps `WidgetsApp` and installs `CsTheme`, `CsI18nProvider`, `CsIconProvider`, `DefaultTextStyle` and `Directionality`.
- **Prop parity.** Each React prop maps to a Dart named parameter with the same name in camelCase; each `onX` event maps to a typed callback; each slot (`header`, `footer`, `actions`) maps to a `Widget?` parameter.
- **Controlled and uncontrolled.** Stateful components accept an optional controller or value + `onChange`, matching React's controlled/uncontrolled behavior.
- **Visual contexts.** Top navigation, flashbar, alert, dark header and compact table wrap their subtree in `CsVisualContext`, so children automatically pick up the context's token overrides.
- **Layout by container width.** Responsive components use `LayoutBuilder` on their own width, matching Cloudscape's container-query behavior rather than screen breakpoints.
- **Accessibility built in.** Every interactive primitive sets `Semantics`, handles Enter/Space/Esc/arrow keys through `Shortcuts` + `Actions`, and draws `CsFocusRing` only for keyboard focus.

The seven shared primitives in the accent layer are: `CsPressable` (hover, pressed, focus, disabled states), `CsFocusRing`, the dropdown positioning engine (anchor, flip, fit to viewport), the option list (grouping, filtering, highlight, keyboard), the virtual scroller, `CsEditableField` (the one text-input base), and the live-region announcer.

## Roadmap: build order and dependencies

Build in seven phases; a phase closes only when its gate (the diamond on the right) passes, and phase 0 must finish before anything else starts because every component depends on its tokens and primitives.

&#91;embedded content: build roadmap · 7 phases with exit gates\]

After phase 0, phases 1 to 3 can run in parallel with separate developers, since they share only the primitives. Phase 4 needs overlays from phase 3 (drawers and split panel use them), and phase 5 needs both form controls and overlays. Phase 6 packages are independent of each other and can be split across people once phase 5 is done. The phase number for each of the 114 components is in the last column of the section 4 table.

## Testing, documentation, tooling and release

Every component ships with five kinds of test before it counts as done; this mirrors Cloudscape's own unit, integration, visual and motion test configs in the components repo.

| Area | Tooling | What it covers |
| --- | --- | --- |
| Unit and widget tests | `flutter_test` | Props, callbacks, controlled/uncontrolled state, keyboard handling |
| Test utils (public) | `cloudscape_flutter_test` package | `find.csButton(label)`, `CsTableDriver.sortBy()`, `CsSelectDriver.open()` — the Dart equivalent of `test-utils` |
| Visual regression | `alchemist` golden tests | Every state × light/dark × comfortable/compact × LTR/RTL |
| Parity screenshots | Playwright screenshots of the React demos | Side-by-side diff against Flutter web goldens for the same page |
| Accessibility | `flutter_test` semantics matchers + `accessibility_tools` | Labels, roles, focus order, contrast against tokens |
| Integration | `integration_test` on web and desktop | Full demo pages: table filtering, wizard flow, board drag |
| Motion | Golden frames at fixed animation ticks | Expand/collapse, flashbar stacking, modal open |

Documentation runs as a Flutter web catalog app (Widgetbook) with one page per component: live playground, every variant, API table generated from dartdoc, and the matching link to the Cloudscape guideline page.

Repository layout uses a `melos` monorepo:

```
cloudscape_flutter/
  packages/
    cloudscape_tokens/        # generated tokens, no Flutter dependency on widgets
    cloudscape_flutter/       # theme, primitives, all core components
    cloudscape_collection/    # collection controller (collection-hooks port)
    cloudscape_charts/        # chart-components port
    cloudscape_board/         # board-components port
    cloudscape_chat/          # chat-components port
    cloudscape_code_view/     # code-view port
    cloudscape_flutter_test/  # test-utils port
  apps/
    catalog/                  # Widgetbook docs site
    demos/                    # the 33 demo pages
  tool/
    token_gen/                # style-dictionary JSON → Dart
    icon_gen/                 # SVG icons → icon font + enum
    i18n_gen/                 # message bundles → ARB
    parity_check/             # compares component/prop lists with the React repo
```

CI runs `dart analyze`, all tests, golden diffs and the parity check on every pull request, then publishes to pub.dev with semantic versioning from a changelog. The `parity_check` tool is what enforces "zero missing": it reads the React package's component list and documented props and fails the build if any is absent from the Dart API.

## Completeness checklist and risks

The build is complete when every box below is ticked and the `parity_check` tool reports zero gaps.

- [ ] All 17 repositories mapped to a Dart package, tool or decision (section 2)
- [ ] Token codegen covers every token for light, dark, comfortable, compact and each visual context
- [ ] Visual refresh theme done; classic theme decided (build or drop)
- [ ] Full icon set converted, plus `CsIconProvider` overrides
- [ ] All i18n message bundles ported to ARB, with RTL verified
- [ ] All 114 component entries in section 4 implemented with full prop parity
- [ ] Hidden internals built: option list, virtual scroller, focus lock, dropdown positioning, chart core, screen-reader-only text
- [ ] Collection controller ports filtering, property filtering, sorting, pagination, selection, expandable rows
- [ ] All 36 general and 23 resource-management pattern pages have an example
- [ ] All 19 gen-AI patterns have an example in the chat package
- [ ] All 33 demo pages reproduced and screenshot-diffed against the React versions
- [ ] Golden tests for every component state × mode × density × direction
- [ ] Public test utilities for every component
- [ ] Catalog site live with API docs for every widget
- [ ] Apache 2.0 LICENSE and NOTICE included, crediting Cloudscape

| Risk | Why it matters | Mitigation |
| --- | --- | --- |
| Charts depend on Highcharts in React | The [new Cloudscape charts](https://cloudscape.design/components/charts/) are built on Highcharts, which is not open source for commercial use and has no Dart port | Write the chart core from scratch with `CustomPainter`; match the visual output, not the implementation |
| Text input fidelity | `EditableText` selection handles, IME and context menus need custom work without Material | Build one `CsEditableField` base early (phase 0) and reuse it in every input |
| Table performance | Sticky columns, resizable columns and virtualization together are hard in Flutter | Prototype `CsTableRoot` on `TwoDimensionalScrollView` in phase 0 as a spike |
| Web accessibility | Flutter web's semantics tree differs from native HTML ARIA | Test with real screen readers (NVDA, VoiceOver) on the demos each phase |
| Upstream drift | Cloudscape releases frequently; the components repo was updated on Nov 16, 2026 | Run `parity_check` weekly against the latest npm release and track a pinned upstream version |
| Brand and trademark | Code is Apache 2.0, but "AWS" and AWS-specific components (S3 resource selector, tag rules) carry AWS branding | Name the package neutrally and keep AWS-specific widgets in an optional package |
| Scope size | 114 components + patterns + demos is a multi-person, multi-month effort | Ship phase by phase; each phase is releasable on its own |
