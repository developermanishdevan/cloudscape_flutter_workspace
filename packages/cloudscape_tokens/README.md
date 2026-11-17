# cloudscape_tokens

All 1,173 Cloudscape design tokens as typed, pure Dart (no Flutter dependency), generated from the upstream theming preset. The generated files are in `lib/src/generated/` and must not be edited by hand.

```dart
final tokens = CsTokens.resolve(colorMode: CsColorMode.dark, density: CsDensity.compact);
tokens.colorTextBodyDefault;   // CsColor
tokens.spaceScaledXs;          // double (logical px)
tokens.motionDurationExtraFast // Duration
tokens.inContext(CsVisualContextId.topNavigation); // visual-context overrides
tokens.withOverrides({'colorPrimary600': CsColor(0xFF112233)}); // theming by name
csTokenInfo['colorPrimary600']; // axis, CSS variable, themeable, exposed, description, references
```

- **Modes:** color (light/dark), density (comfortable/compact), motion (normal/disabled). Each token belongs to one axis, and `CsTokens` composes one group per axis.
- **Visual contexts:** compact-table, top-navigation, header, app-layout-toolbar, flashbar, flashbar-warning, alert, alert-header.
- **Types:** `CsColor` / `CsColorValue` (gradients, `currentColor`), `double` px, `CsLength` (em, %, inherit, normal), `CsFontWeight`, `Duration`, `CsCubicBezier`, `List<CsShadow>`, `List<String>` font families, `String` keywords.

Regenerate with `dart run melos run tokens:generate`. CI runs `tokens:check`.
