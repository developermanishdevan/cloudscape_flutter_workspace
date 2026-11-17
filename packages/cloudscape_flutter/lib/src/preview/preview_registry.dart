// Every widget preview, for tests and the catalog app. Add new component
// previews here as well as annotating them with @CsPreview.
import 'package:cloudscape_flutter/src/components/box/cs_box_preview.dart';
import 'package:cloudscape_flutter/src/components/dropdown/cs_dropdown_preview.dart';
import 'package:cloudscape_flutter/src/components/live_region/cs_live_region_preview.dart';
import 'package:cloudscape_flutter/src/components/navigable_group/cs_navigable_group_preview.dart';
import 'package:cloudscape_flutter/src/components/space_between/cs_space_between_preview.dart';
import 'package:cloudscape_flutter/src/components/table/cs_table_root_preview.dart';
import 'package:cloudscape_flutter/src/icon/cs_icon_preview.dart';
import 'package:cloudscape_flutter/src/internal/editable_field/cs_editable_field_preview.dart';
import 'package:cloudscape_flutter/src/internal/options/options_preview.dart';
import 'package:cloudscape_flutter/src/internal/pressable_preview.dart';
import 'package:cloudscape_flutter/src/internal/selectable_item_preview.dart';
import 'package:flutter/widgets.dart';

/// One registered preview.
typedef CsPreviewEntry = ({String group, String name, Widget Function() build});

/// All previews, grouped by component.
final List<CsPreviewEntry> csPreviewRegistry = [
  (group: 'Box', name: 'Variants', build: csBoxVariantsPreview),
  (group: 'Box', name: 'Colors', build: csBoxColorsPreview),
  (group: 'Box', name: 'Font sizes and weights', build: csBoxFontsPreview),
  (group: 'Box', name: 'Spacing', build: csBoxSpacingPreview),
  (group: 'Box', name: 'Visual accents', build: csBoxAccentsPreview),
  (group: 'Box', name: 'Display and alignment', build: csBoxLayoutPreview),
  (
    group: 'Space between',
    name: 'Vertical sizes',
    build: csSpaceBetweenVerticalPreview,
  ),
  (
    group: 'Space between',
    name: 'Horizontal wrap',
    build: csSpaceBetweenHorizontalPreview,
  ),
  (
    group: 'Space between',
    name: 'Align items',
    build: csSpaceBetweenAlignPreview,
  ),
  (group: 'Icon', name: 'All icons', build: csIconAllPreview),
  (group: 'Icon', name: 'Sizes', build: csIconSizesPreview),
  (group: 'Icon', name: 'Variants and badge', build: csIconVariantsPreview),
  (group: 'Icon', name: 'Directional icons', build: csIconDirectionalPreview),
  (
    group: 'Icon provider',
    name: 'Overrides and custom icons',
    build: csIconProviderPreview,
  ),
  (
    group: 'Live region',
    name: 'Announcing updates',
    build: csLiveRegionPreview,
  ),
  (
    group: 'Navigable group',
    name: 'Horizontal toolbar',
    build: csNavigableGroupHorizontalPreview,
  ),
  (
    group: 'Navigable group',
    name: 'Vertical list',
    build: csNavigableGroupVerticalPreview,
  ),
  (group: 'Dropdown', name: 'Interactive', build: csDropdownInteractivePreview),
  (group: 'Dropdown', name: 'Header and footer', build: csDropdownSlotsPreview),
  (group: 'Dropdown', name: 'Widths', build: csDropdownWidthsPreview),
  (group: 'Dropdown', name: 'Centered', build: csDropdownCenteredPreview),
  (group: 'Pressable', name: 'States', build: csPressableStatesPreview),
  (
    group: 'Selectable item',
    name: 'States',
    build: csSelectableItemStatesPreview,
  ),
  (
    group: 'Selectable item',
    name: 'Groups',
    build: csSelectableItemGroupsPreview,
  ),
  (
    group: 'Option list',
    name: 'Options and groups',
    build: csOptionListGroupsPreview,
  ),
  (
    group: 'Option list',
    name: 'Filtering',
    build: csOptionListFilteringPreview,
  ),
  (
    group: 'Option list',
    name: 'Virtual scroll (1,000 options)',
    build: csOptionListVirtualPreview,
  ),
  (
    group: 'Editable field',
    name: 'States',
    build: csEditableFieldStatesPreview,
  ),
  (
    group: 'Editable field',
    name: 'Prefix and suffix',
    build: csEditableFieldAdornmentsPreview,
  ),
  (
    group: 'Editable field',
    name: 'Textarea',
    build: csEditableFieldTextareaPreview,
  ),
  (
    group: 'Table root',
    name: 'Sticky header and columns (10,000 rows)',
    build: csTableRootStickyPreview,
  ),
  (
    group: 'Table root',
    name: 'Resizable columns',
    build: csTableRootResizablePreview,
  ),
];
