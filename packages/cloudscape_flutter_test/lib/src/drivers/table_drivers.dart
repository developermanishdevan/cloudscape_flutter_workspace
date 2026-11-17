// Driver for the table root (upstream `TableWrapper` basics).
import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cloudscape_flutter_test/src/driver.dart';
import 'package:cloudscape_flutter_test/src/drivers/basic_drivers.dart';
import 'package:cloudscape_flutter_test/src/finders.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Drives a [CsTableRoot].
///
/// Body rows are built lazily: [bodyCell] and [scrollToRow] scroll the
/// table until the row exists. Row and column indexes are 0-based here; the
/// `find*` helpers mirror upstream names.
class CsTableRootDriver extends CsDriver<CsTableRoot> {
  /// Drives the first table matched by [finder].
  CsTableRootDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csTableRoot());

  CsTableRootState get _state => tester.state<CsTableRootState>(finder);

  TwoDimensionalScrollableState get _scrollable =>
      tester.state<TwoDimensionalScrollableState>(
        descendant(find.byType(TwoDimensionalScrollable)),
      );

  /// Number of body rows (the `rowCount` prop).
  int get rowCount => widget.rowCount;

  /// Number of columns.
  int get columnCount => widget.columns.length;

  /// Current column widths.
  List<double> get columnWidths => _state.columnWidths;

  /// Row elements by body row index (header = -1), for built rows.
  Map<int, Element> get _rows {
    final out = <int, Element>{};
    for (final e in descendant(find.byType(CsTableRow)).evaluate()) {
      final slot = e.slot;
      if (slot is ChildVicinity) out[slot.yIndex - 1] = e;
    }
    return out;
  }

  /// Indexes of the body rows currently built (visible plus cache).
  List<int> get builtRows => [..._rows.keys.where((r) => r >= 0)]..sort();

  List<Element> _cellsOf(Element row) {
    final out = <Element>[];
    row.visitChildren(out.add);
    return out;
  }

  Finder _elementFinder(Element e) =>
      find.byElementPredicate((x) => identical(x, e));

  /// The header cell of [column] (upstream `findColumnHeaders()[i]`).
  Finder columnHeader(int column) =>
      _elementFinder(_cellsOf(_rows[-1]!)[column]);

  /// Header texts, in column order.
  List<String> get columnHeaderTexts => [
    for (final c in _cellsOf(_rows[-1]!)) csExtractTextContent(c),
  ];

  /// The body cell at [row], [column] (upstream `findBodyCell(row, col)`,
  /// 0-based here). Scrolls the row into view first.
  Future<Finder> bodyCell(int row, int column) async {
    await scrollToRow(row);
    return _elementFinder(_cellsOf(_rows[row]!)[column]);
  }

  /// Text of the body cell at [row], [column].
  Future<String> bodyCellText(int row, int column) async =>
      csExtractTextContent(tester.element(await bodyCell(row, column)));

  /// Scrolls vertically until [row] is fully visible below the header.
  Future<void> scrollToRow(int row) async {
    final v = _scrollable.verticalScrollable.position;
    for (var attempt = 0; attempt < 8; attempt++) {
      final rows = _rows;
      final view = rect;
      final headerRect = tester.getRect(_elementFinder(rows[-1]!));
      final e = rows[row];
      if (e != null) {
        final r = tester.getRect(_elementFinder(e));
        final top = widget.stickyHeader ? headerRect.bottom : view.top;
        var delta = 0.0;
        if (r.top < top) delta = r.top - top;
        if (r.bottom > view.bottom) delta = r.bottom - view.bottom;
        if (delta == 0) return;
        v.jumpTo(
          (v.pixels + delta).clamp(v.minScrollExtent, v.maxScrollExtent),
        );
        await tester.pump();
        continue;
      }
      // Not built: jump by the average built row height.
      final built = [
        for (final entry in rows.entries)
          if (entry.key >= 0)
            (entry.key, tester.getRect(_elementFinder(entry.value))),
      ];
      final avg = built.isEmpty
          ? 40.0
          : built.map((b) => b.$2.height).reduce((a, b) => a + b) /
                built.length;
      final target = row * avg;
      v.jumpTo(target.clamp(v.minScrollExtent, v.maxScrollExtent));
      await tester.pump();
    }
    if (_rows[row] == null) {
      throw StateError('Row $row could not be scrolled into view');
    }
  }

  /// Scrolls horizontally to [offset] from the inline start.
  Future<void> scrollHorizontallyTo(double offset) async {
    final h = _scrollable.horizontalScrollable.position;
    h.jumpTo(offset.clamp(h.minScrollExtent, h.maxScrollExtent));
    await tester.pump();
  }

  /// Drags the resize handle of [column] by [dx] (inline direction).
  Future<void> resizeColumn(int column, double dx) async {
    final header = tester.getRect(columnHeader(column));
    final rtl = Directionality.of(tester.element(finder)) == TextDirection.rtl;
    final t = tester.element(finder).csTokens;
    final x = rtl ? header.left + t.spaceXl / 4 : header.right - t.spaceXl / 4;
    await tester.dragFrom(
      Offset(x, header.center.dy),
      Offset(rtl ? -dx : dx, 0),
    );
    await tester.pump();
  }

  /// Focuses the resize handle of [column] and presses arrows: positive
  /// [steps] widen, negative narrow (10 px each).
  Future<void> resizeColumnWithKeyboard(int column, int steps) async {
    final resizer = find
        .descendant(
          of: columnHeader(column),
          matching: find.byWidgetPredicate(
            (w) => w is Focus && w.onKeyEvent != null,
          ),
        )
        .first;
    csFocusNodeOf(tester.element(resizer)).requestFocus();
    await tester.pump();
    final rtl = Directionality.of(tester.element(finder)) == TextDirection.rtl;
    final widen = rtl
        ? LogicalKeyboardKey.arrowLeft
        : LogicalKeyboardKey.arrowRight;
    final narrow = rtl
        ? LogicalKeyboardKey.arrowRight
        : LogicalKeyboardKey.arrowLeft;
    for (var i = 0; i < steps.abs(); i++) {
      await tester.sendKeyEvent(steps > 0 ? widen : narrow);
    }
    await tester.pump();
  }
}
