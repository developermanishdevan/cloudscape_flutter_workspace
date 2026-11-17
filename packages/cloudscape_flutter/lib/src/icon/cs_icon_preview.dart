import 'package:cloudscape_flutter/src/components/box/cs_box.dart';
import 'package:cloudscape_flutter/src/components/space_between/cs_space_between.dart';
import 'package:cloudscape_flutter/src/icon/cs_icon.dart';
import 'package:cloudscape_flutter/src/icon/cs_icon_provider.dart';
import 'package:cloudscape_flutter/src/icon/generated/icons.g.dart';
import 'package:cloudscape_flutter/src/preview/cs_preview.dart';
import 'package:flutter/widgets.dart';

/// Icon: every built-in icon.
@CsPreview(group: 'Icon', name: 'All icons', size: Size(720, 520))
Widget csIconAllPreview() => CsSpaceBetween(
  direction: CsSpaceBetweenDirection.horizontal,
  size: CsSpaceBetweenSize.xs,
  children: [
    for (final n in CsIconName.values)
      SizedBox(
        width: 32,
        height: 32,
        child: Center(
          child: CsIcon(name: n, size: CsIconSize.medium),
        ),
      ),
  ],
);

/// Icon: sizes.
@CsPreview(group: 'Icon', name: 'Sizes')
Widget csIconSizesPreview() => CsSpaceBetween(
  direction: CsSpaceBetweenDirection.horizontal,
  size: CsSpaceBetweenSize.m,
  alignItems: CsSpaceBetweenAlign.end,
  children: [
    for (final s in CsIconSize.values.where((s) => s != CsIconSize.inherit))
      CsSpaceBetween(
        size: CsSpaceBetweenSize.xxs,
        alignItems: CsSpaceBetweenAlign.center,
        children: [
          CsIcon(name: CsIconName.settings, size: s),
          CsBox.text(s.name, variant: CsBoxVariant.small),
        ],
      ),
    const DefaultTextStyle(
      style: TextStyle(fontSize: 20, height: 1.2),
      child: CsIcon(name: CsIconName.settings, size: CsIconSize.inherit),
    ),
  ],
);

/// Icon: color variants and badge.
@CsPreview(group: 'Icon', name: 'Variants and badge')
Widget csIconVariantsPreview() => CsSpaceBetween(
  direction: CsSpaceBetweenDirection.horizontal,
  size: CsSpaceBetweenSize.m,
  children: [
    for (final v in CsIconVariant.values)
      CsSpaceBetween(
        size: CsSpaceBetweenSize.xxs,
        alignItems: CsSpaceBetweenAlign.center,
        children: [
          CsIcon(name: CsIconName.statusPositive, variant: v),
          CsBox.text(v.name, variant: CsBoxVariant.small),
        ],
      ),
    const CsIcon(
      name: CsIconName.notification,
      badge: true,
      ariaLabel: 'Notifications',
    ),
  ],
);

/// Icon: directional icons (mirrored in the RTL variant).
@CsPreview(group: 'Icon', name: 'Directional icons')
Widget csIconDirectionalPreview() => CsSpaceBetween(
  direction: CsSpaceBetweenDirection.horizontal,
  size: CsSpaceBetweenSize.s,
  children: [
    for (final n in csRtlMirroredIcons)
      CsIcon(name: CsIconName.byId(n), size: CsIconSize.medium),
  ],
);

/// Icon provider: overrides and custom icons.
@CsPreview(group: 'Icon provider', name: 'Overrides and custom icons')
Widget csIconProviderPreview() => const CsIconProvider(
  icons: {'settings': Text('⚙'), 'my-custom-icon': Text('★')},
  child: CsSpaceBetween(
    direction: CsSpaceBetweenDirection.horizontal,
    size: CsSpaceBetweenSize.m,
    children: [
      CsIcon(name: CsIconName.settings),
      CsIcon(customName: 'my-custom-icon', size: CsIconSize.big),
      CsIconProvider(
        icons: {'settings': null},
        child: CsIcon(name: CsIconName.settings),
      ),
    ],
  ),
);
