// Catalog pages: the overview and one page per component.
import 'dart:math' as math;

import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cloudscape_flutter/preview.dart';
import 'package:cs_catalog/src/api_section.dart';
import 'package:cs_catalog/src/catalog_model.dart';
import 'package:cs_catalog/src/generated/catalog_data.g.dart';
import 'package:cs_catalog/src/widgets.dart';
import 'package:flutter/widgets.dart';

/// Size used by the golden matrix for previews without a declared size.
const catalogDefaultPreviewSize = Size(480, 360);

/// The registered previews of [entry], paired with their declared sizes.
List<(CsPreviewEntry, CatalogPreview?)> previewsOf(CatalogEntry entry) => [
  for (final r in csPreviewRegistry)
    if (r.group == entry.name)
      (r, entry.previews.where((p) => p.name == r.name).firstOrNull),
];

/// Overview: what the catalog holds and the status of each page.
class CatalogOverviewPage extends StatelessWidget {
  /// Creates the page.
  const CatalogOverviewPage({super.key, required this.onOpen});

  /// Opens a component page by id.
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final t = context.csTokens;
    final components = catalogEntries.where((e) => e.planNumber != null);
    return CsSpaceBetween(
      size: CsSpaceBetweenSize.l,
      children: [
        CsSpaceBetween(
          size: CsSpaceBetweenSize.xs,
          children: [
            Text(
              'Cloudscape for Flutter',
              style: context.heading((t) => t.headingXl),
            ),
            Text(
              'Every component built so far, with its live previews and the '
              'API generated from its dartdoc. Use the toggles at the top to '
              'switch light or dark mode, density and reading direction for '
              'every preview at once.',
              style: context.secondary,
            ),
          ],
        ),
        CatalogPanel(
          child: CsSpaceBetween(
            size: CsSpaceBetweenSize.s,
            children: [
              Text(
                '${components.length} components · '
                '${catalogEntries.length - components.length} internal '
                'primitives · ${csPreviewRegistry.length} previews',
                style: context.heading((t) => t.headingS),
              ),
              for (final category in catalogCategories)
                if (catalogEntries.any((e) => e.category == category))
                  CsSpaceBetween(
                    size: CsSpaceBetweenSize.xxs,
                    children: [
                      Text(category, style: context.small),
                      Wrap(
                        spacing: t.spaceL,
                        runSpacing: t.spaceXxs,
                        children: [
                          for (final e in catalogEntries.where(
                            (e) => e.category == category,
                          ))
                            CatalogLink(
                              text: e.name,
                              onFollow: () => onOpen(e.id),
                            ),
                        ],
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

/// One component page: header, live previews, API.
class CatalogComponentPage extends StatelessWidget {
  /// Creates the page.
  const CatalogComponentPage({
    super.key,
    required this.entry,
    required this.onOpenUrl,
    this.previewDirection = TextDirection.ltr,
  });

  /// Page data.
  final CatalogEntry entry;

  /// Opens an external URL.
  final ValueChanged<Uri> onOpenUrl;

  /// Reading direction of the live previews.
  final TextDirection previewDirection;

  @override
  Widget build(BuildContext context) {
    final url = entry.guidelineUrl;
    final meta = [
      entry.category,
      'Phase ${entry.phase}',
      if (entry.planNumber != null) 'Plan #${entry.planNumber}',
    ].join(' · ');
    return CsSpaceBetween(
      size: CsSpaceBetweenSize.xl,
      children: [
        CsSpaceBetween(
          size: CsSpaceBetweenSize.xs,
          children: [
            Text(meta, style: context.small),
            Semantics(
              header: true,
              child: Text(
                entry.name,
                style: context.heading((t) => t.headingXl),
              ),
            ),
            Text(entry.summary, style: context.secondary),
            if (url != null)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: CatalogLink(
                  text: 'Cloudscape guideline',
                  external: true,
                  onFollow: () => onOpenUrl(url),
                ),
              ),
          ],
        ),
        _Section(
          title: 'Examples',
          child: CsSpaceBetween(
            size: CsSpaceBetweenSize.l,
            children: [
              for (final (preview, info) in previewsOf(entry))
                _PreviewBlock(
                  preview: preview,
                  info: info,
                  direction: previewDirection,
                ),
            ],
          ),
        ),
        _Section(
          title: 'API',
          child: CatalogApiSection(entry: entry),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => CsSpaceBetween(
    size: CsSpaceBetweenSize.s,
    children: [
      Semantics(
        header: true,
        child: Text(title, style: context.heading((t) => t.headingL)),
      ),
      child,
    ],
  );
}

/// A live preview inside a panel, at its declared size (or natural height).
class _PreviewBlock extends StatelessWidget {
  const _PreviewBlock({
    required this.preview,
    required this.info,
    required this.direction,
  });

  final CsPreviewEntry preview;
  final CatalogPreview? info;
  final TextDirection direction;

  @override
  Widget build(BuildContext context) {
    final width = info?.width;
    final height = info?.height;
    return CsSpaceBetween(
      size: CsSpaceBetweenSize.xs,
      children: [
        Text(preview.name, style: context.heading((t) => t.headingS)),
        CatalogPanel(
          padding: false,
          child: Directionality(
            textDirection: direction,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Same 16 px inset as CsPreviewFrame; sized previews get the
                // size they declare (the golden matrix size), clamped to the
                // available width.
                final content = Padding(
                  padding: const EdgeInsets.all(16),
                  child: KeyedSubtree(
                    key: ValueKey('preview:${preview.group}/${preview.name}'),
                    child: preview.build(),
                  ),
                );
                if (width == null || height == null) {
                  return Align(
                    alignment: AlignmentDirectional.topStart,
                    child: content,
                  );
                }
                return Align(
                  alignment: AlignmentDirectional.topStart,
                  child: SizedBox(
                    width: math.min(width, constraints.maxWidth),
                    height: height,
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: content,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
