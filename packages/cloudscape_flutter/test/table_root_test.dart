import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

List<CsTableColumn> _columns(int n, {double width = 150}) => [
  for (var i = 0; i < n; i++)
    CsTableColumn(id: 'c$i', header: Text('H$i'), width: width),
];

Future<void> _pump(
  WidgetTester tester,
  Widget table, {
  Size size = const Size(600, 400),
  TextDirection direction = TextDirection.ltr,
}) async {
  tester.view.physicalSize = const Size(1000, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    CsApp(
      theme: const CsThemeData(motion: CsMotionMode.disabled),
      home: Directionality(
        textDirection: direction,
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox.fromSize(size: size, child: table),
        ),
      ),
    ),
  );
  await tester.pump();
}

Widget _table({
  int columns = 3,
  int rows = 100,
  double width = 150,
  int stickyFirst = 0,
  int stickyLast = 0,
  bool stickyHeader = true,
  bool resizable = false,
  ValueChanged<List<double>>? onWidths,
  ScrollController? vertical,
  ScrollController? horizontal,
  Widget Function(int r, int c)? cell,
}) => CsTableRoot(
  columns: _columns(columns, width: width),
  rowCount: rows,
  stickyColumnsFirst: stickyFirst,
  stickyColumnsLast: stickyLast,
  stickyHeader: stickyHeader,
  resizableColumns: resizable,
  onColumnWidthsChange: onWidths,
  verticalController: vertical,
  horizontalController: horizontal,
  ariaLabel: 'Instances',
  cellBuilder: (context, r, c) => cell?.call(r, c) ?? Text('R${r}C$c'),
);

Rect _rect(WidgetTester tester, String text) => tester.getRect(find.text(text));

void main() {
  testWidgets('header and only the visible rows are built', (tester) async {
    await _pump(tester, _table(rows: 10000));
    expect(find.text('H0'), findsOneWidget);
    expect(find.text('R0C0'), findsOneWidget);
    expect(find.text('R9999C0'), findsNothing);
    final built = find.textContaining(RegExp(r'^R\d+C0$')).evaluate().length;
    expect(built, lessThan(40)); // 400 px viewport + cache extent
  });

  testWidgets('sticky header stays; rows scroll under it', (tester) async {
    final v = ScrollController();
    addTearDown(v.dispose);
    await _pump(tester, _table(vertical: v));
    final headerTop = _rect(tester, 'H0').top;
    v.jumpTo(300);
    await tester.pump();
    expect(_rect(tester, 'H0').top, headerTop);
    expect(find.text('R0C0').hitTestable(), findsNothing);
  });

  testWidgets('non-sticky header scrolls away', (tester) async {
    final v = ScrollController();
    addTearDown(v.dispose);
    await _pump(tester, _table(vertical: v, stickyHeader: false));
    final headerTop = _rect(tester, 'H0').top;
    v.jumpTo(100);
    await tester.pump();
    expect(_rect(tester, 'H0').top, headerTop - 100);
  });

  testWidgets('columns use their widths; the last one fills the container', (
    tester,
  ) async {
    await _pump(tester, _table(columns: 2, width: 150));
    final row = tester.renderObject<RenderCsTableRow>(
      find.ancestor(of: find.text('H0'), matching: find.byType(CsTableRow)),
    );
    expect(row.size.width, 600);
    final c0 = tester.getRect(
      find
          .ancestor(of: find.text('R0C0'), matching: find.byType(Semantics))
          .first,
    );
    expect(c0.width, 150);
    final c1 = tester.getRect(
      find
          .ancestor(of: find.text('R0C1'), matching: find.byType(Semantics))
          .first,
    );
    expect(c1.width, 450);
  });

  testWidgets('sticky first / last columns stay put while the middle scrolls', (
    tester,
  ) async {
    final h = ScrollController();
    addTearDown(h.dispose);
    await _pump(
      tester,
      _table(columns: 8, stickyFirst: 1, stickyLast: 1, horizontal: h),
    );
    final first = _rect(tester, 'R0C0').left;
    final headerFirst = _rect(tester, 'H0').left;
    final mid = _rect(tester, 'R0C3').left;
    // Last column (natural x = 1050) is stuck to the viewport end.
    final last = tester.getTopRight(
      find
          .ancestor(of: find.text('R0C7'), matching: find.byType(Semantics))
          .first,
    );
    expect(last.dx, 600);
    h.jumpTo(200);
    await tester.pump();
    expect(_rect(tester, 'R0C0').left, first);
    expect(_rect(tester, 'R0C3').left, mid - 200);
    expect(_rect(tester, 'H0').left, headerFirst);
    expect(_rect(tester, 'H3').left, lessThan(mid));
    h.jumpTo(h.position.maxScrollExtent);
    await tester.pump();
    final lastAtEnd = tester.getTopRight(
      find
          .ancestor(of: find.text('R0C7'), matching: find.byType(Semantics))
          .first,
    );
    expect(lastAtEnd.dx, 600);
    expect(_rect(tester, 'R0C0').left, first);
  });

  testWidgets('sticky columns turn off without 148 px of scrollable space', (
    tester,
  ) async {
    final h = ScrollController();
    addTearDown(h.dispose);
    // 600 - (300 + 200) = 100 < 148: disabled.
    await _pump(
      tester,
      CsTableRoot(
        columns: const [
          CsTableColumn(id: 'a', header: Text('A'), width: 300),
          CsTableColumn(id: 'b', header: Text('B'), width: 300),
          CsTableColumn(id: 'c', header: Text('C'), width: 200),
        ],
        rowCount: 5,
        stickyColumnsFirst: 1,
        stickyColumnsLast: 1,
        horizontalController: h,
        cellBuilder: (context, r, c) => Text('R${r}C$c'),
      ),
    );
    final first = _rect(tester, 'R0C0').left;
    h.jumpTo(100);
    await tester.pump();
    expect(_rect(tester, 'R0C0').left, first - 100);
  });

  testWidgets('sticky columns are off when the table fits', (tester) async {
    await _pump(tester, _table(columns: 3, stickyFirst: 1));
    final row = tester.renderObject<RenderCsTableRow>(
      find.ancestor(of: find.text('H0'), matching: find.byType(CsTableRow)),
    );
    expect(row.size.width, 600); // no horizontal scroll
  });

  testWidgets('a stuck sticky cell receives taps over scrolled content', (
    tester,
  ) async {
    final h = ScrollController();
    addTearDown(h.dispose);
    final taps = <String>[];
    await _pump(
      tester,
      _table(
        columns: 8,
        stickyFirst: 1,
        horizontal: h,
        cell: (r, c) => GestureDetector(
          onTap: () => taps.add('R${r}C$c'),
          child: Text('R${r}C$c'),
        ),
      ),
    );
    h.jumpTo(140);
    await tester.pump();
    // Column 1 now scrolls under the stuck column 0.
    await tester.tapAt(_rect(tester, 'R0C0').center);
    expect(taps, ['R0C0']);
  });

  testWidgets('rows take the height of their tallest cell', (tester) async {
    await _pump(
      tester,
      _table(
        cell: (r, c) => r == 1 && c == 1
            ? const SizedBox(height: 80, child: Text('tall'))
            : Text('R${r}C$c'),
      ),
    );
    final r1 = _rect(tester, 'R1C0');
    final r2 = _rect(tester, 'R2C0');
    expect(r2.top - r1.top, greaterThan(80));
  });

  testWidgets('jumping deep into a large table builds the target rows', (
    tester,
  ) async {
    final v = ScrollController();
    addTearDown(v.dispose);
    await _pump(tester, _table(rows: 100000, vertical: v));
    v.jumpTo(v.position.maxScrollExtent);
    await tester.pumpAndSettle();
    expect(find.text('R99999C0'), findsOneWidget);
    final built = find.textContaining(RegExp(r'^R\d+C0$')).evaluate().length;
    expect(built, lessThan(40));
  });

  group('row extents', () {
    test('estimate until measured; offsets and lookup', () {
      final e = CsRowExtents(estimate: 10)..count = 100;
      expect(e.total, 1000);
      expect(e.indexAt(25), 2);
      e.record({0: 20, 1: 40}); // first batch fixes the estimate: 30
      expect(e.estimate, 30);
      expect(e.offsetOf(2), 60);
      expect(e.offsetOf(3), 90);
      expect(e.total, 60 + 98 * 30);
      e.record({50: 100});
      expect(e.offsetOf(51), 60 + 48 * 30 + 100);
      expect(e.indexAt(60 + 48 * 30 + 50), 50);
      expect(e.indexAt(1e9), 100);
      e.count = 40; // drops measurements past the end
      expect(e.total, 60 + 38 * 30);
    });
  });

  group('resizing', () {
    testWidgets(
      'drag the header divider; clamped to the minimum; commit on end',
      (tester) async {
        final commits = <List<double>>[];
        await _pump(
          tester,
          _table(columns: 4, resizable: true, onWidths: commits.add),
        );
        final state = tester.state<CsTableRootState>(find.byType(CsTableRoot));
        final h0 = _rect(tester, 'H0');
        final t = tester.element(find.text('H0')).csTokens;
        final grip = Offset(
          tester
                  .getTopRight(
                    find
                        .ancestor(
                          of: find.text('H0'),
                          matching: find.byType(Semantics),
                        )
                        .first,
                  )
                  .dx -
              t.spaceXl / 4,
          h0.center.dy,
        );
        await tester.dragFrom(grip, const Offset(60, 0));
        await tester.pump();
        expect(state.columnWidths[0], 210);
        expect(commits.single.first, 210);
        await tester.dragFrom(
          grip + const Offset(60, 0),
          const Offset(-500, 0),
        );
        await tester.pump();
        expect(state.columnWidths[0], csDefaultColumnWidth);
      },
    );

    testWidgets('arrow keys resize by 10 px', (tester) async {
      await _pump(tester, _table(columns: 4, resizable: true));
      final state = tester.state<CsTableRootState>(find.byType(CsTableRoot));
      final resizers = find.descendant(
        of: find.byType(CsTableRoot),
        matching: find.byWidgetPredicate(
          (w) => w is Focus && w.onKeyEvent != null,
        ),
      );
      final grip = find
          .descendant(of: resizers.at(1), matching: find.byType(MouseRegion))
          .first;
      Focus.of(tester.element(grip)).requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      expect(state.columnWidths[1], 160);
    });
  });

  testWidgets('RTL: columns run from the right; sticky start is on the right', (
    tester,
  ) async {
    final h = ScrollController();
    addTearDown(h.dispose);
    await _pump(
      tester,
      _table(columns: 8, stickyFirst: 1, horizontal: h),
      direction: TextDirection.rtl,
    );
    final c0 = tester.getTopRight(
      find
          .ancestor(of: find.text('R0C0'), matching: find.byType(Semantics))
          .first,
    );
    expect(c0.dx, 600);
    final mid = _rect(tester, 'R0C3').right;
    h.jumpTo(200);
    await tester.pump();
    expect(
      tester
          .getTopRight(
            find
                .ancestor(
                  of: find.text('R0C0'),
                  matching: find.byType(Semantics),
                )
                .first,
          )
          .dx,
      600,
    );
    expect(_rect(tester, 'R0C3').right, mid + 200);
  });

  testWidgets('semantics: table > row > column header / cell', (tester) async {
    final handle = tester.ensureSemantics();
    await _pump(tester, _table(rows: 3));
    final table = tester.getSemantics(find.byType(CsTableRoot));
    final roles = <SemanticsRole>[];
    void walk(SemanticsNode n) {
      roles.add(n.getSemanticsData().role);
      n.visitChildren((c) {
        walk(c);
        return true;
      });
    }

    walk(table);
    expect(roles, contains(SemanticsRole.table));
    expect(roles.where((r) => r == SemanticsRole.row).length, 4);
    expect(roles.where((r) => r == SemanticsRole.columnHeader).length, 3);
    expect(roles.where((r) => r == SemanticsRole.cell).length, 9);
    expect(tester.takeException(), isNull);
    handle.dispose();
  });
}
