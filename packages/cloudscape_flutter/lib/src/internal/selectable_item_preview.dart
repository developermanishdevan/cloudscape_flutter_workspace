import 'package:cloudscape_flutter/src/internal/selectable_item.dart';
import 'package:cloudscape_flutter/src/preview/cs_preview.dart';
import 'package:flutter/widgets.dart';

/// Selectable item: every visual state of an option / menu row.
@CsPreview(group: 'Selectable item', name: 'States', size: Size(320, 420))
Widget csSelectableItemStatesPreview() => const SizedBox(
  width: 280,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      CsSelectableItem(child: Text('Default')),
      CsSelectableItem(highlighted: true, child: Text('Highlighted (hover)')),
      CsSelectableItem(
        highlighted: true,
        highlightType: CsHighlightType.keyboard,
        child: Text('Highlighted (keyboard)'),
      ),
      CsSelectableItem(selected: true, child: Text('Selected')),
      CsSelectableItem(
        selected: true,
        highlighted: true,
        child: Text('Selected + hover'),
      ),
      CsSelectableItem(disabled: true, child: Text('Disabled')),
      CsSelectableItem(
        disabled: true,
        highlighted: true,
        child: Text('Disabled + hover'),
      ),
      CsSelectableItem(
        selected: true,
        isNextSelected: true,
        child: Text('Selected (joined)'),
      ),
      CsSelectableItem(
        selected: true,
        isPreviousSelected: true,
        child: Text('Selected (joined)'),
      ),
    ],
  ),
);

/// Selectable item: group header and indented group options.
@CsPreview(group: 'Selectable item', name: 'Groups', size: Size(320, 260))
Widget csSelectableItemGroupsPreview() => const SizedBox(
  width: 280,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      CsSelectableItem(child: Text('Top-level option')),
      CsSelectableItem(isParent: true, child: Text('Group')),
      CsSelectableItem(isChild: true, child: Text('Group option')),
      CsSelectableItem(
        isChild: true,
        highlighted: true,
        child: Text('Group option (hover)'),
      ),
      CsSelectableItem(
        isChild: true,
        padBottom: true,
        child: Text('Last group option'),
      ),
      CsSelectableItem(
        isParent: true,
        disabled: true,
        child: Text('Disabled group'),
      ),
    ],
  ),
);
