import 'package:cloudscape_flutter/src/components/box/cs_box.dart';
import 'package:cloudscape_flutter/src/components/space_between/cs_space_between.dart';
import 'package:cloudscape_flutter/src/preview/cs_preview.dart';
import 'package:cloudscape_flutter/src/theme/spacing.dart';
import 'package:flutter/widgets.dart';

/// Box: every variant.
@CsPreview(group: 'Box', name: 'Variants')
Widget csBoxVariantsPreview() => CsSpaceBetween(
  size: CsSpaceBetweenSize.xs,
  children: [
    for (final v in CsBoxVariant.values)
      CsBox.text('${v.name}: The quick brown fox', variant: v),
  ],
);

/// Box: text colors.
@CsPreview(group: 'Box', name: 'Colors')
Widget csBoxColorsPreview() => CsSpaceBetween(
  size: CsSpaceBetweenSize.xxs,
  children: [
    for (final c in CsBoxColor.values) CsBox.text('color: ${c.name}', color: c),
  ],
);

/// Box: font sizes and weights.
@CsPreview(group: 'Box', name: 'Font sizes and weights')
Widget csBoxFontsPreview() => CsSpaceBetween(
  size: CsSpaceBetweenSize.xxs,
  children: [
    for (final s in CsBoxFontSize.values)
      CsBox.text('fontSize: ${s.name}', fontSize: s),
    for (final w in CsBoxFontWeight.values)
      CsBox.text('fontWeight: ${w.name}', fontWeight: w),
  ],
);

/// Box: padding and margin.
@CsPreview(group: 'Box', name: 'Spacing')
Widget csBoxSpacingPreview() => CsSpaceBetween(
  size: CsSpaceBetweenSize.s,
  children: [
    for (final s in [CsSpacing.xs, CsSpacing.m, CsSpacing.xl])
      CsBox(
        display: CsBoxDisplay.inlineBlock,
        padding: CsBoxSpacing.all(s),
        visualAccent: const CsVisualAccent(
          color: CsVisualAccentColor.grey,
          borderRadius: CsVisualAccentRadius.xs,
        ),
        child: Text('padding: ${s.name}'),
      ),
  ],
);

/// Box: visual accents.
@CsPreview(group: 'Box', name: 'Visual accents')
Widget csBoxAccentsPreview() => CsSpaceBetween(
  direction: CsSpaceBetweenDirection.horizontal,
  size: CsSpaceBetweenSize.xs,
  children: [
    for (final c in CsVisualAccentColor.values)
      CsBox.text(
        c.name,
        visualAccent: CsVisualAccent(
          color: c,
          borderRadius: CsVisualAccentRadius.s,
        ),
      ),
    CsBox.text(
      'A',
      visualAccent: const CsVisualAccent(
        color: CsVisualAccentColor.indigo,
        equalAspectRatio: true,
        borderRadius: CsVisualAccentRadius.full,
      ),
    ),
  ],
);

/// Box: display, float and alignment.
@CsPreview(group: 'Box', name: 'Display and alignment', size: Size(420, 220))
Widget csBoxLayoutPreview() => CsSpaceBetween(
  size: CsSpaceBetweenSize.xs,
  children: [
    CsBox.text('textAlign: left'),
    CsBox.text('textAlign: center', textAlign: CsBoxTextAlign.center),
    CsBox.text('textAlign: right', textAlign: CsBoxTextAlign.right),
    CsBox.text(
      'float: right',
      float: CsBoxFloat.right,
      display: CsBoxDisplay.inlineBlock,
    ),
    CsBox.text('awsui-inline-code', variant: CsBoxVariant.awsuiInlineCode),
  ],
);
