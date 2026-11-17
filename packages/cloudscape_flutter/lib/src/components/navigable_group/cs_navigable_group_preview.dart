import 'package:cloudscape_flutter/src/components/box/cs_box.dart';
import 'package:cloudscape_flutter/src/components/navigable_group/cs_navigable_group.dart';
import 'package:cloudscape_flutter/src/components/space_between/cs_space_between.dart';
import 'package:cloudscape_flutter/src/preview/cs_preview.dart';
import 'package:flutter/widgets.dart';

/// Navigable group: one Tab stop, arrow keys between items.
@CsPreview(group: 'Navigable group', name: 'Horizontal toolbar')
Widget csNavigableGroupHorizontalPreview() => CsSpaceBetween(
  size: CsSpaceBetweenSize.xs,
  children: [
    CsBox.text(
      'Tab into the group, then use ←/→, Home, End.',
      variant: CsBoxVariant.small,
    ),
    const CsNavigableGroup(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CsPreviewButton('Cut'),
          SizedBox(width: 8),
          CsPreviewButton('Copy'),
          SizedBox(width: 8),
          CsPreviewButton('Disabled', disabled: true),
          SizedBox(width: 8),
          CsPreviewButton('Paste'),
        ],
      ),
    ),
  ],
);

/// Navigable group: vertical navigation.
@CsPreview(group: 'Navigable group', name: 'Vertical list')
Widget csNavigableGroupVerticalPreview() => const CsNavigableGroup(
  navigationDirection: CsNavigationDirection.vertical,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CsPreviewButton('First'),
      SizedBox(height: 8),
      CsPreviewButton('Second'),
      SizedBox(height: 8),
      CsPreviewButton('Third'),
    ],
  ),
);
