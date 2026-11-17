import 'package:cloudscape_flutter/src/components/box/cs_box.dart';
import 'package:cloudscape_flutter/src/components/space_between/cs_space_between.dart';
import 'package:cloudscape_flutter/src/internal/pressable.dart';
import 'package:cloudscape_flutter/src/preview/cs_preview.dart';
import 'package:flutter/widgets.dart';

/// Pressable + focus ring: live interaction states (press Tab for the ring).
@CsPreview(group: 'Pressable', name: 'States')
Widget csPressableStatesPreview() => CsSpaceBetween(
  direction: CsSpaceBetweenDirection.horizontal,
  size: CsSpaceBetweenSize.m,
  children: [
    for (final disabled in [false, true])
      CsPressable(
        disabled: disabled,
        onPressed: () {},
        builder: (context, s) => CsBox(
          visualAccent: const CsVisualAccent(
            color: CsVisualAccentColor.grey,
            borderRadius: CsVisualAccentRadius.xs,
          ),
          child: Text(
            [
              if (s.disabled) 'disabled',
              if (s.hovered) 'hovered',
              if (s.pressed) 'pressed',
              if (s.focusVisible) 'focus-visible' else if (s.focused) 'focused',
            ].join(' · ').ifEmpty('idle'),
          ),
        ),
      ),
    const CsPreviewButton('Preview button'),
  ],
);

extension on String {
  String ifEmpty(String fallback) => isEmpty ? fallback : this;
}
