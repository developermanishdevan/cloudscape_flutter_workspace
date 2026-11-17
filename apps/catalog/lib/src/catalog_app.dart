// The catalog shell: a top bar with global mode, density and direction
// toggles, category navigation, and the selected page.
import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cs_catalog/src/catalog_model.dart';
import 'package:cs_catalog/src/generated/catalog_data.g.dart';
import 'package:cs_catalog/src/pages.dart';
import 'package:cs_catalog/src/widgets.dart';
import 'package:flutter/widgets.dart';

/// Below this width the navigation collapses behind a menu button.
const catalogNarrowWidth = 760.0;

/// Id of the overview page.
const catalogOverviewId = 'overview';

/// The catalog app.
class CatalogApp extends StatefulWidget {
  /// Creates the app.
  const CatalogApp({
    super.key,
    this.initialPage = catalogOverviewId,
    this.colorMode,
    this.density = CsDensity.comfortable,
    this.direction = TextDirection.ltr,
    this.onOpenUrl,
  });

  /// Page id to open first: [catalogOverviewId] or a [CatalogEntry.id].
  final String initialPage;

  /// Initial color mode; null follows the platform brightness.
  final CsColorMode? colorMode;

  /// Initial density.
  final CsDensity density;

  /// Initial reading direction.
  final TextDirection direction;

  /// Opens external links (guideline pages).
  final ValueChanged<Uri>? onOpenUrl;

  @override
  State<CatalogApp> createState() => _CatalogAppState();
}

class _CatalogAppState extends State<CatalogApp> {
  late String _page = widget.initialPage;
  late CsColorMode? _colorMode = widget.colorMode;
  late CsDensity _density = widget.density;
  late TextDirection _direction = widget.direction;
  bool _navOpen = false;
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _open(String id) => setState(() {
    _page = id;
    _navOpen = false;
    if (_scroll.hasClients) _scroll.jumpTo(0);
  });

  @override
  Widget build(BuildContext context) => CsApp(
    title: 'Cloudscape Catalog',
    debugShowCheckedModeBanner: false,
    theme: CsThemeData(colorMode: _colorMode, density: _density),
    home: Builder(
      builder: (context) {
        // Resolve "follow platform" to the mode actually shown.
        final mode =
            _colorMode ??
            (MediaQuery.platformBrightnessOf(context) == Brightness.dark
                ? CsColorMode.dark
                : CsColorMode.light);
        // The shell and docs stay LTR (English text and Dart code); the
        // direction toggle applies to the live previews only.
        return Directionality(
          textDirection: TextDirection.ltr,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final narrow = constraints.maxWidth < catalogNarrowWidth;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _TopBar(
                    narrow: narrow,
                    navOpen: _navOpen,
                    onToggleNav: () => setState(() => _navOpen = !_navOpen),
                    colorMode: mode,
                    onColorMode: (m) => setState(() => _colorMode = m),
                    density: _density,
                    onDensity: (d) => setState(() => _density = d),
                    direction: _direction,
                    onDirection: (d) => setState(() => _direction = d),
                  ),
                  Expanded(
                    child: narrow
                        ? (_navOpen
                              ? _Navigation(page: _page, onOpen: _open)
                              : _content())
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                width: 260,
                                child: _Navigation(page: _page, onOpen: _open),
                              ),
                              const CatalogDivider(vertical: true),
                              Expanded(child: _content()),
                            ],
                          ),
                  ),
                ],
              );
            },
          ),
        );
      },
    ),
  );

  Widget _content() {
    final entry = catalogEntries.where((e) => e.id == _page).firstOrNull;
    return Builder(
      builder: (context) {
        final t = context.csTokens;
        return SingleChildScrollView(
          controller: _scroll,
          padding: EdgeInsets.symmetric(
            horizontal: t.spaceLayoutContentHorizontal,
            vertical: t.spaceScaledL,
          ),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040),
              child: entry == null
                  ? CatalogOverviewPage(onOpen: _open)
                  : CatalogComponentPage(
                      key: ValueKey(entry.id),
                      entry: entry,
                      onOpenUrl: widget.onOpenUrl ?? (_) {},
                      previewDirection: _direction,
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.narrow,
    required this.navOpen,
    required this.onToggleNav,
    required this.colorMode,
    required this.onColorMode,
    required this.density,
    required this.onDensity,
    required this.direction,
    required this.onDirection,
  });

  final bool narrow;
  final bool navOpen;
  final VoidCallback onToggleNav;
  final CsColorMode colorMode;
  final ValueChanged<CsColorMode> onColorMode;
  final CsDensity density;
  final ValueChanged<CsDensity> onDensity;
  final TextDirection direction;
  final ValueChanged<TextDirection> onDirection;

  @override
  Widget build(BuildContext context) => CsVisualContext(
    id: CsVisualContextId.topNavigation,
    child: Builder(
      builder: (context) {
        final t = context.csTokens;
        // Icons take their color from the default text style, so give the
        // bar the top-navigation context's text color.
        return ColoredBox(
          color: t.colorBackgroundContainerContent.toColor(),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: t.colorTextInteractiveDefault.toColor()),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: t.spaceL,
                vertical: t.spaceXs,
              ),
              child: Wrap(
                spacing: t.spaceL,
                runSpacing: t.spaceXs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (narrow) ...[
                        CsPressable(
                          semanticLabel: navOpen
                              ? 'Close navigation'
                              : 'Open navigation',
                          onPressed: onToggleNav,
                          builder: (context, _) => CsIcon(
                            name: navOpen ? CsIconName.close : CsIconName.menu,
                          ),
                        ),
                        SizedBox(width: t.spaceS),
                      ],
                      Text(
                        'Cloudscape Catalog',
                        style: context.heading((t) => t.headingS),
                      ),
                    ],
                  ),
                  CatalogSegmented<CsColorMode>(
                    label: 'Color mode',
                    value: colorMode,
                    onChange: onColorMode,
                    segments: const [
                      (value: CsColorMode.light, label: 'Light'),
                      (value: CsColorMode.dark, label: 'Dark'),
                    ],
                  ),
                  CatalogSegmented<CsDensity>(
                    label: 'Density',
                    value: density,
                    onChange: onDensity,
                    segments: const [
                      (value: CsDensity.comfortable, label: 'Comfortable'),
                      (value: CsDensity.compact, label: 'Compact'),
                    ],
                  ),
                  CatalogSegmented<TextDirection>(
                    label: 'Direction',
                    value: direction,
                    onChange: onDirection,
                    segments: const [
                      (value: TextDirection.ltr, label: 'LTR'),
                      (value: TextDirection.rtl, label: 'RTL'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

class _Navigation extends StatelessWidget {
  const _Navigation({required this.page, required this.onOpen});

  final String page;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final t = context.csTokens;
    return ColoredBox(
      color: t.colorBackgroundContainerContent.toColor(),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(t.spaceL),
        child: CsSpaceBetween(
          size: CsSpaceBetweenSize.m,
          children: [
            CatalogLink(
              text: 'Overview',
              active: page == catalogOverviewId,
              onFollow: () => onOpen(catalogOverviewId),
            ),
            for (final category in catalogCategories)
              if (catalogEntries.any((e) => e.category == category))
                Semantics(
                  container: true,
                  label: category,
                  child: CsSpaceBetween(
                    size: CsSpaceBetweenSize.xs,
                    children: [
                      Text(
                        category,
                        style: context.heading((t) => t.headingXs),
                      ),
                      for (final CatalogEntry e in catalogEntries.where(
                        (e) => e.category == category,
                      ))
                        CatalogLink(
                          text: e.name,
                          active: page == e.id,
                          onFollow: () => onOpen(e.id),
                        ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
