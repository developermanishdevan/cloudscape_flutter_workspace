import 'package:cloudscape_flutter/src/components/table/cs_table_root.dart';
import 'package:cloudscape_flutter/src/preview/cs_preview.dart';
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:flutter/widgets.dart';

const _names = [
  'Instance ID',
  'Name',
  'State',
  'Type',
  'Availability zone',
  'Public IPv4',
  'Monitoring',
  'Launch time',
  'Security group',
  'Actions',
];

Widget _frame(Widget table) => Builder(
  builder: (context) {
    final t = CsTheme.tokensOf(context);
    return Container(
      width: 680,
      height: 380,
      decoration: BoxDecoration(
        color: t.colorBackgroundContainerContent.toColor(),
        borderRadius: BorderRadius.circular(t.borderRadiusContainer),
        boxShadow: t.shadowContainer.toBoxShadows(),
      ),
      clipBehavior: Clip.antiAlias,
      child: table,
    );
  },
);

String _value(int r, int c) => switch (c) {
  0 => 'i-${(0x1a2b3c + r * 7919).toRadixString(16)}',
  1 => 'web-server-${r + 1}',
  2 => r % 5 == 0 ? 'Stopped' : 'Running',
  3 => const ['t3.micro', 'm5.large', 'c6g.xlarge'][r % 3],
  4 => 'us-east-1${'abc'[r % 3]}',
  5 => '54.${r % 255}.${(r * 7) % 255}.${(r * 13) % 255}',
  6 => r.isEven ? 'Enabled' : 'Disabled',
  7 =>
    '2026-11-${(r % 28 + 1).toString().padLeft(2, '0')} 10:${(r % 60).toString().padLeft(2, '0')}',
  8 => 'sg-${(r * 31).toRadixString(16)}',
  _ => 'Connect',
};

/// Table root: 10,000 lazily built rows, sticky header, first and last
/// columns sticky (scroll sideways to see the stuck shadows).
@CsPreview(
  group: 'Table root',
  name: 'Sticky header and columns (10,000 rows)',
  size: Size(720, 420),
)
Widget csTableRootStickyPreview() => _frame(
  CsTableRoot(
    ariaLabel: 'Instances',
    columns: [
      for (var i = 0; i < _names.length; i++)
        CsTableColumn(
          id: _names[i],
          header: Text(_names[i]),
          width: i == 0 ? 170 : 150,
        ),
    ],
    rowCount: 10000,
    stickyColumnsFirst: 1,
    stickyColumnsLast: 1,
    cellBuilder: (context, r, c) => Text(_value(r, c)),
  ),
);

/// Table root: drag the header dividers (or focus one and use ←/→) to
/// resize columns.
@CsPreview(group: 'Table root', name: 'Resizable columns', size: Size(720, 420))
Widget csTableRootResizablePreview() => _frame(
  CsTableRoot(
    ariaLabel: 'Instances',
    resizableColumns: true,
    columns: [
      for (var i = 0; i < 5; i++)
        CsTableColumn(
          id: _names[i],
          header: Text(_names[i]),
          width: 140,
          minWidth: 90,
        ),
    ],
    rowCount: 50,
    cellBuilder: (context, r, c) => Text(_value(r, c)),
  ),
);
