// What the catalog lists. Each entry is one page; its `name` is the preview
// registry group (`csPreviewRegistry`), so the page shows those previews.
//
// Add an entry here whenever a component gets previews, then run
// `dart run melos run catalog:generate`. Generation fails if a preview group
// has no entry, or an entry names a class that does not exist.

/// Where a page's API table comes from.
class ApiSource {
  /// Creates a source.
  const ApiSource(this.file, this.classes);

  /// Path relative to `packages/cloudscape_flutter/lib/src/`.
  final String file;

  /// Public classes documented from [file], in display order.
  final List<String> classes;
}

/// One catalog page.
class ManifestEntry {
  /// Creates an entry.
  const ManifestEntry({
    required this.id,
    required this.name,
    required this.category,
    required this.phase,
    required this.api,
    this.planNumber,
    this.slug,
    this.summary,
  });

  /// URL-safe id, e.g. `space-between`.
  final String id;

  /// Display name; equals the preview registry group.
  final String name;

  /// Navigation group: a plan category or [internalCategory].
  final String category;

  /// Roadmap phase (rebuild plan §4, last column).
  final int phase;

  /// Row number in the rebuild plan's component inventory, if it has one.
  final int? planNumber;

  /// `https://cloudscape.design/components/<slug>/`, when upstream documents
  /// the component.
  final String? slug;

  /// Overrides the first sentence of the main class's doc comment.
  final String? summary;

  /// API table sources.
  final List<ApiSource> api;
}

/// Category for shared primitives that are not upstream components.
const internalCategory = 'Internal primitives';

/// Navigation order of categories.
const categoryOrder = [
  'Actions',
  'Collections',
  'Display',
  'Feedback',
  'Forms',
  'Layout',
  'Navigation',
  'Overlays',
  'Utility',
  internalCategory,
];

/// Every catalog page.
const manifest = <ManifestEntry>[
  // ---- Phase 0 components (rebuild plan §4) ----
  ManifestEntry(
    id: 'box',
    name: 'Box',
    category: 'Display',
    phase: 0,
    planNumber: 12,
    slug: 'box',
    api: [
      ApiSource('components/box/cs_box.dart', [
        'CsBox',
        'CsBoxSpacing',
        'CsVisualAccent',
      ]),
    ],
  ),
  ManifestEntry(
    id: 'dropdown',
    name: 'Dropdown',
    category: 'Overlays',
    phase: 0,
    planNumber: 42,
    slug: 'dropdown',
    api: [
      ApiSource('components/dropdown/cs_dropdown.dart', [
        'CsDropdown',
        'CsDropdownStyle',
        'CsDropdownContext',
      ]),
    ],
  ),
  ManifestEntry(
    id: 'icon',
    name: 'Icon',
    category: 'Display',
    phase: 0,
    planNumber: 60,
    slug: 'icon',
    api: [
      ApiSource('icon/cs_icon.dart', ['CsIcon']),
    ],
  ),
  ManifestEntry(
    id: 'icon-provider',
    name: 'Icon provider',
    category: 'Utility',
    phase: 0,
    planNumber: 61,
    slug: 'icon-provider',
    api: [
      ApiSource('icon/cs_icon_provider.dart', [
        'CsIconProvider',
        'CsComponentIcons',
        'CsTableIcons',
        'CsExpandToggleIcons',
      ]),
    ],
  ),
  ManifestEntry(
    id: 'live-region',
    name: 'Live region',
    category: 'Utility',
    phase: 0,
    planNumber: 67,
    slug: 'live-region',
    api: [
      ApiSource('components/live_region/cs_live_region.dart', [
        'CsLiveRegion',
        'CsLiveRegionController',
      ]),
    ],
  ),
  ManifestEntry(
    id: 'navigable-group',
    name: 'Navigable group',
    category: 'Utility',
    phase: 0,
    planNumber: 70,
    slug: 'navigable-group',
    api: [
      ApiSource('components/navigable_group/cs_navigable_group.dart', [
        'CsNavigableGroup',
      ]),
    ],
  ),
  ManifestEntry(
    id: 'space-between',
    name: 'Space between',
    category: 'Layout',
    phase: 0,
    planNumber: 84,
    slug: 'space-between',
    api: [
      ApiSource('components/space_between/cs_space_between.dart', [
        'CsSpaceBetween',
      ]),
    ],
  ),
  // ---- Phase 0 spike for a phase 5 component ----
  ManifestEntry(
    id: 'table-root',
    name: 'Table root',
    category: 'Collections',
    phase: 5,
    planNumber: 90,
    slug: 'table',
    api: [
      ApiSource('components/table/cs_table_root.dart', [
        'CsTableRoot',
        'CsTableColumn',
      ]),
    ],
  ),
  // ---- Shared primitives (rebuild plan §5) ----
  ManifestEntry(
    id: 'pressable',
    name: 'Pressable',
    category: internalCategory,
    phase: 0,
    api: [
      ApiSource('internal/pressable.dart', ['CsPressable', 'CsPressableState']),
    ],
  ),
  ManifestEntry(
    id: 'selectable-item',
    name: 'Selectable item',
    category: internalCategory,
    phase: 0,
    api: [
      ApiSource('internal/selectable_item.dart', ['CsSelectableItem']),
    ],
  ),
  ManifestEntry(
    id: 'option-list',
    name: 'Option list',
    category: internalCategory,
    phase: 0,
    api: [
      ApiSource('internal/options/cs_options_list.dart', ['CsOptionsList']),
      ApiSource('internal/options/cs_option.dart', ['CsOption']),
    ],
  ),
  ManifestEntry(
    id: 'editable-field',
    name: 'Editable field',
    category: internalCategory,
    phase: 0,
    api: [
      ApiSource('internal/editable_field/cs_editable_field.dart', [
        'CsEditableField',
      ]),
    ],
  ),
];
