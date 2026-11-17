import 'package:cloudscape_flutter/src/components/box/cs_box.dart';
import 'package:cloudscape_flutter/src/components/live_region/cs_live_region.dart';
import 'package:cloudscape_flutter/src/components/space_between/cs_space_between.dart';
import 'package:cloudscape_flutter/src/preview/cs_preview.dart';
import 'package:flutter/widgets.dart';

/// Live region: content changes are announced to screen readers.
@CsPreview(group: 'Live region', name: 'Announcing updates')
Widget csLiveRegionPreview() => const _Counter();

class _Counter extends StatefulWidget {
  const _Counter();

  @override
  State<_Counter> createState() => _CounterState();
}

class _CounterState extends State<_Counter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) => CsSpaceBetween(
    size: CsSpaceBetweenSize.s,
    children: [
      CsPreviewButton('Add item', onPressed: () => setState(() => _count++)),
      CsLiveRegion(child: CsBox.text('$_count items selected')),
      CsLiveRegion(hidden: true, child: Text('Hidden region: $_count')),
      CsBox.text(
        'The hidden region is announced but not shown.',
        variant: CsBoxVariant.small,
      ),
    ],
  );
}
