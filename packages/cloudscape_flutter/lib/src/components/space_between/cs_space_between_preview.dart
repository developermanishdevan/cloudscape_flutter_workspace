import 'package:cloudscape_flutter/src/components/box/cs_box.dart';
import 'package:cloudscape_flutter/src/components/space_between/cs_space_between.dart';
import 'package:cloudscape_flutter/src/preview/cs_preview.dart';
import 'package:flutter/widgets.dart';

Widget _chip(String text, [double height = 0]) => CsBox(
  display: CsBoxDisplay.inlineBlock,
  visualAccent: const CsVisualAccent(
    color: CsVisualAccentColor.teal,
    borderRadius: CsVisualAccentRadius.xs,
  ),
  child: SizedBox(height: height == 0 ? null : height, child: Text(text)),
);

/// Space between: vertical sizes.
@CsPreview(group: 'Space between', name: 'Vertical sizes')
Widget csSpaceBetweenVerticalPreview() => CsSpaceBetween(
  direction: CsSpaceBetweenDirection.horizontal,
  size: CsSpaceBetweenSize.l,
  children: [
    for (final s in CsSpaceBetweenSize.values)
      SizedBox(
        width: 70,
        child: CsSpaceBetween(
          size: s,
          children: [
            CsBox.text(s.name, variant: CsBoxVariant.small),
            _chip('A'),
            _chip('B'),
          ],
        ),
      ),
  ],
);

/// Space between: horizontal wrapping.
@CsPreview(
  group: 'Space between',
  name: 'Horizontal wrap',
  size: Size(320, 200),
)
Widget csSpaceBetweenHorizontalPreview() => CsSpaceBetween(
  direction: CsSpaceBetweenDirection.horizontal,
  size: CsSpaceBetweenSize.xs,
  children: [for (var i = 1; i <= 12; i++) _chip('Item $i')],
);

/// Space between: alignment.
@CsPreview(group: 'Space between', name: 'Align items')
Widget csSpaceBetweenAlignPreview() => CsSpaceBetween(
  size: CsSpaceBetweenSize.m,
  children: [
    for (final a in [null, ...CsSpaceBetweenAlign.values])
      CsSpaceBetween(
        direction: CsSpaceBetweenDirection.horizontal,
        size: CsSpaceBetweenSize.xs,
        alignItems: a,
        children: [
          CsBox.text(a?.name ?? 'stretch', variant: CsBoxVariant.small),
          _chip('short'),
          _chip('tall', 48),
        ],
      ),
  ],
);
