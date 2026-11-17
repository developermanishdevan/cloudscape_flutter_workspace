// Spike (plan risk "Table performance"): the table root on a
// TwoDimensionalScrollView with a sticky header, sticky first / last
// columns, resizable columns and lazily built rows.
//
// Structure: each child of the 2D viewport is a whole row (header = row 0),
// so rows stay real render objects with table / row / cell semantics and
// can have any height (wrapped lines, expandable content). Rows lay their
// cells out at the column widths and paint sticky cells at their stuck
// positions, like CSS `position: sticky` in upstream's DOM table.
//
// Upstream sources: table/use-column-widths.tsx (DEFAULT_COLUMN_WIDTH,
// minimum widths, last column fills the container), table/resizer (drag and
// ±10 px arrow keys), table/sticky-columns (enable rule: the table scrolls
// and keeps 148 px of scrollable space; stuck shadows), header-cell and
// body-cell styles.
import 'dart:math' as math;

import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:cloudscape_tokens/cloudscape_tokens.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Upstream `DEFAULT_COLUMN_WIDTH`.
const double csDefaultColumnWidth = 120;

/// Upstream `MINIMUM_SCROLLABLE_SPACE`: sticky columns turn off unless this
/// much horizontal space is left for the scrolling columns.
const double csMinimumScrollableSpace = 148;

/// Upstream keyboard resize step.
const double csColumnResizeStep = 10;

/// A column of a [CsTableRoot].
@immutable
class CsTableColumn {
  /// Creates a column.
  const CsTableColumn({
    required this.id,
    required this.header,
    this.width,
    this.minWidth,
  });

  /// Stable id (upstream `columnDefinition.id`).
  final String id;

  /// Header content.
  final Widget header;

  /// Initial width; [csDefaultColumnWidth] when null.
  final double? width;

  /// Minimum width when resizing (upstream `getMinWidth`).
  final double? minWidth;

  /// Upstream `getMinWidth`: minWidth, else width when below the default,
  /// else the default.
  double get effectiveMinWidth =>
      minWidth ??
      (width != null && width! < csDefaultColumnWidth
          ? width!
          : csDefaultColumnWidth);
}

/// The table root: header row, lazily built body rows, sticky header and
/// columns, resizable columns.
class CsTableRoot extends StatefulWidget {
  /// Creates the table.
  const CsTableRoot({
    super.key,
    required this.columns,
    required this.rowCount,
    required this.cellBuilder,
    this.stickyHeader = true,
    this.stickyColumnsFirst = 0,
    this.stickyColumnsLast = 0,
    this.resizableColumns = false,
    this.onColumnWidthsChange,
    this.ariaLabel,
    this.verticalController,
    this.horizontalController,
  });

  /// Columns.
  final List<CsTableColumn> columns;

  /// Number of body rows.
  final int rowCount;

  /// Builds the content of a body cell.
  final Widget Function(BuildContext context, int row, int column) cellBuilder;

  /// Keep the header row visible while scrolling.
  final bool stickyHeader;

  /// Columns pinned to the inline start.
  final int stickyColumnsFirst;

  /// Columns pinned to the inline end.
  final int stickyColumnsLast;

  /// Columns can be resized by dragging the header dividers.
  final bool resizableColumns;

  /// Widths after a resize is committed (upstream `onColumnWidthsChange`).
  final ValueChanged<List<double>>? onColumnWidthsChange;

  /// Accessible table name.
  final String? ariaLabel;

  /// Vertical scroll controller.
  final ScrollController? verticalController;

  /// Horizontal scroll controller.
  final ScrollController? horizontalController;

  @override
  State<CsTableRoot> createState() => CsTableRootState();
}

/// State of [CsTableRoot].
class CsTableRootState extends State<CsTableRoot> {
  late List<double> _widths = _initialWidths();

  /// Current column widths (before the last column fills the container).
  List<double> get columnWidths => List.unmodifiable(_widths);

  List<double> _initialWidths() => [
    for (final c in widget.columns)
      math.max(c.width ?? csDefaultColumnWidth, c.effectiveMinWidth),
  ];

  @override
  void didUpdateWidget(CsTableRoot oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldIds = [for (final c in oldWidget.columns) c.id];
    final ids = [for (final c in widget.columns) c.id];
    if (!_listEquals(oldIds, ids)) {
      // Keep resized widths of columns that stay; new columns get defaults.
      final byId = {
        for (var i = 0; i < oldIds.length; i++) oldIds[i]: _widths[i],
      };
      _widths = [
        for (final c in widget.columns)
          byId[c.id] ??
              math.max(c.width ?? csDefaultColumnWidth, c.effectiveMinWidth),
      ];
    }
  }

  /// Resizes column [index] to [width] (clamped to its minimum).
  void resizeColumn(int index, double width, {bool commit = true}) {
    final w = math.max(width, widget.columns[index].effectiveMinWidth);
    if (_widths[index] != w) setState(() => _widths[index] = w);
    if (commit) widget.onColumnWidthsChange?.call(columnWidths);
  }

  @override
  Widget build(BuildContext context) {
    final cols = widget.columns.length;
    final first = widget.stickyColumnsFirst.clamp(0, cols);
    final last = widget.stickyColumnsLast.clamp(0, cols - first);
    return Semantics(
      label: widget.ariaLabel,
      container: true,
      child: _CsTableScrollView(
        verticalController: widget.verticalController,
        horizontalController: widget.horizontalController,
        stickyHeader: widget.stickyHeader,
        delegate: TwoDimensionalChildBuilderDelegate(
          maxXIndex: 0,
          maxYIndex: widget.rowCount,
          // Rows are repaint boundaries themselves, and the viewport talks
          // to their render objects directly.
          addRepaintBoundaries: false,
          builder: (context, v) => v.yIndex == 0
              ? CsTableRow(
                  widths: _widths,
                  header: true,
                  stickyColumnsFirst: first,
                  stickyColumnsLast: last,
                  children: [
                    for (var c = 0; c < cols; c++)
                      _HeaderCell(
                        column: widget.columns[c],
                        index: c,
                        isLast: c == cols - 1,
                        sticky: widget.stickyHeader,
                        resizable: widget.resizableColumns,
                        state: this,
                      ),
                  ],
                )
              : CsTableRow(
                  widths: _widths,
                  stickyColumnsFirst: first,
                  stickyColumnsLast: last,
                  children: [
                    for (var c = 0; c < cols; c++)
                      _BodyCell(
                        isFirst: c == 0,
                        isLast: c == cols - 1,
                        child: widget.cellBuilder(context, v.yIndex - 1, c),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

bool _listEquals(List<String> a, List<String> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

// ---------------------------------------------------------------------------
// Cells

class _HeaderCell extends StatelessWidget {
  const _HeaderCell({
    required this.column,
    required this.index,
    required this.isLast,
    required this.sticky,
    required this.resizable,
    required this.state,
  });

  final CsTableColumn column;
  final int index;
  final bool isLast;
  final bool sticky;
  final bool resizable;
  final CsTableRootState state;

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    final content = Padding(
      // header-cell padding + header-cell-content padding.
      padding: EdgeInsetsDirectional.only(
        top: 2 * t.spaceScaledXxs,
        bottom: 2 * t.spaceScaledXxs,
        start: t.spaceScaledXs + t.spaceS,
        end: (isLast ? t.spaceXs : t.spaceScaledXs) + t.spaceS,
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: t.colorTextColumnHeader.toColor(),
          fontWeight: t.fontWeightHeadingS.toFontWeight(),
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        child: column.header,
      ),
    );
    return Semantics(
      role: SemanticsRole.columnHeader,
      container: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: t.colorBackgroundTableHeader.toColor(),
          border: Border(
            bottom: BorderSide(
              color: t.colorBorderDividerDefault.toColor(),
              width: sticky
                  ? t.borderTableStickyWidth
                  : t.borderDividerListWidth,
            ),
          ),
        ),
        child: Stack(
          children: [
            content,
            if (resizable)
              PositionedDirectional(
                end: 0,
                top: 0,
                bottom: 0,
                width: t.spaceXl / 2,
                child: _Resizer(state: state, index: index),
              )
            else if (!isLast)
              PositionedDirectional(
                end: 0,
                top: 0,
                bottom: 0,
                child: _Divider(color: t.colorBorderDividerDefault.toColor()),
              ),
          ],
        ),
      ),
    );
  }
}

/// The vertical divider between header cells (upstream `.divider`):
/// at least heading-xs line height, at most the cell height minus
/// `2 * space-xs + space-xxxs`, vertically centered.
class _Divider extends StatelessWidget {
  const _Divider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    return LayoutBuilder(
      builder: (context, c) {
        final h = math.max(
          t.lineHeightHeadingXs,
          c.maxHeight - (2 * t.spaceXs + t.spaceXxxs),
        );
        return Align(
          alignment: AlignmentDirectional.centerEnd,
          child: SizedBox(
            width: t.borderDividerListWidth,
            height: math.min(h, c.maxHeight),
            child: ColoredBox(color: color),
          ),
        );
      },
    );
  }
}

class _Resizer extends StatefulWidget {
  const _Resizer({required this.state, required this.index});

  final CsTableRootState state;
  final int index;

  @override
  State<_Resizer> createState() => _ResizerState();
}

class _ResizerState extends State<_Resizer> {
  bool _active = false;
  bool _focused = false;
  double _start = 0;
  double _startX = 0;

  double get _width => widget.state._widths[widget.index];

  bool get _rtl => Directionality.of(context) == TextDirection.rtl;

  KeyEventResult _onKey(FocusNode node, KeyEvent e) {
    if (e is! KeyDownEvent && e is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final k = e.logicalKey;
    final grow = _rtl
        ? LogicalKeyboardKey.arrowLeft
        : LogicalKeyboardKey.arrowRight;
    final shrink = _rtl
        ? LogicalKeyboardKey.arrowRight
        : LogicalKeyboardKey.arrowLeft;
    if (k == grow || k == shrink) {
      widget.state.resizeColumn(
        widget.index,
        _width + (k == grow ? csColumnResizeStep : -csColumnResizeStep),
      );
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    final color = _active || _focused
        ? t.colorBorderDividerActive
        : t.colorBorderDividerInteractiveDefault;
    final column = widget.state.widget.columns[widget.index];
    return Semantics(
      slider: true,
      label: 'Resize ${column.id}',
      value: '${_width.round()}',
      increasedValue: '${(_width + csColumnResizeStep).round()}',
      decreasedValue:
          '${math.max(column.effectiveMinWidth, _width - csColumnResizeStep).round()}',
      onIncrease: () =>
          widget.state.resizeColumn(widget.index, _width + csColumnResizeStep),
      onDecrease: () =>
          widget.state.resizeColumn(widget.index, _width - csColumnResizeStep),
      child: Focus(
        onKeyEvent: _onKey,
        onFocusChange: (f) => setState(() => _focused = f),
        child: MouseRegion(
          cursor: SystemMouseCursors.resizeColumn,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            // Measure from pointer-down like upstream (no slop lost).
            dragStartBehavior: DragStartBehavior.down,
            onHorizontalDragStart: (d) {
              _start = _width;
              _startX = d.globalPosition.dx;
              setState(() => _active = true);
            },
            onHorizontalDragUpdate: (d) {
              final dx = d.globalPosition.dx - _startX;
              widget.state.resizeColumn(
                widget.index,
                _start + (_rtl ? -dx : dx),
                commit: false,
              );
            },
            onHorizontalDragEnd: (_) {
              setState(() => _active = false);
              widget.state.resizeColumn(widget.index, _width);
            },
            onHorizontalDragCancel: () => setState(() => _active = false),
            child: _Divider(color: color.toColor()),
          ),
        ),
      ),
    );
  }
}

class _BodyCell extends StatelessWidget {
  const _BodyCell({
    required this.isFirst,
    required this.isLast,
    required this.child,
  });

  final bool isFirst;
  final bool isLast;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    final d = t.borderDividerListWidth;
    final inline = t.spaceS + t.spaceScaledXs - d;
    return Semantics(
      role: SemanticsRole.cell,
      container: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: t.colorBorderDividerSecondary.toColor(),
              width: d,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            top: t.spaceTableCellVertical - d,
            bottom: t.spaceTableCellVertical + t.borderItemWidth - 2 * d,
            // First / last cells: border-item-width transparent border +
            // space-l inset (upstream body-cell:first-child / :last-child).
            start: isFirst ? t.spaceL - d : inline,
            end: isLast ? t.spaceL - d : inline,
          ),
          child: DefaultTextStyle.merge(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            child: child,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Row

/// One table row: lays its cells out at [widths] and paints sticky cells at
/// their stuck position for the viewport's horizontal scroll.
class CsTableRow extends MultiChildRenderObjectWidget {
  /// Creates a row.
  const CsTableRow({
    super.key,
    required this.widths,
    this.header = false,
    this.stickyColumnsFirst = 0,
    this.stickyColumnsLast = 0,
    super.children,
  });

  /// Column widths (the last column also fills any remaining space).
  final List<double> widths;

  /// The header row (sticky cells use the header background).
  final bool header;

  /// Columns pinned to the inline start.
  final int stickyColumnsFirst;

  /// Columns pinned to the inline end.
  final int stickyColumnsLast;

  CsTableRowStyle _style(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    return CsTableRowStyle(
      background:
          (header
                  ? t.colorBackgroundTableHeader
                  : t.colorBackgroundContainerContent)
              .toColor(),
      shadowFirst: t.shadowStickyColumnFirst,
      shadowLast: t.shadowStickyColumnLast,
    );
  }

  @override
  RenderCsTableRow createRenderObject(BuildContext context) => RenderCsTableRow(
    widths: widths,
    stickyColumnsFirst: stickyColumnsFirst,
    stickyColumnsLast: stickyColumnsLast,
    textDirection: Directionality.of(context),
    style: _style(context),
    header: header,
  );

  @override
  void updateRenderObject(BuildContext context, RenderCsTableRow renderObject) {
    renderObject
      ..widths = widths
      ..stickyColumnsFirst = stickyColumnsFirst
      ..stickyColumnsLast = stickyColumnsLast
      ..textDirection = Directionality.of(context)
      ..style = _style(context)
      ..header = header;
  }
}

/// Paint settings of a [RenderCsTableRow], resolved from tokens.
@immutable
class CsTableRowStyle {
  /// Creates the style.
  const CsTableRowStyle({
    required this.background,
    required this.shadowFirst,
    required this.shadowLast,
  });

  /// Background behind sticky cells.
  final Color background;

  /// Shadow of the last start-sticky column while stuck.
  final List<CsShadow> shadowFirst;

  /// Shadow of the first end-sticky column while stuck.
  final List<CsShadow> shadowLast;

  @override
  bool operator ==(Object other) =>
      other is CsTableRowStyle &&
      other.background == background &&
      identical(other.shadowFirst, shadowFirst) &&
      identical(other.shadowLast, shadowLast);

  @override
  int get hashCode => Object.hash(background, shadowFirst, shadowLast);
}

class _RowParentData extends ContainerBoxParentData<RenderBox> {}

/// Render object of [CsTableRow].
class RenderCsTableRow extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _RowParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _RowParentData> {
  /// Creates the row.
  RenderCsTableRow({
    required this._widths,
    required int stickyColumnsFirst,
    required int stickyColumnsLast,
    required this._textDirection,
    required this._style,
    required this._header,
  }) : _stickyFirst = stickyColumnsFirst,
       _stickyLast = stickyColumnsLast;

  List<double> _widths;
  set widths(List<double> v) {
    _widths = v;
    markNeedsLayout();
  }

  int _stickyFirst;
  set stickyColumnsFirst(int v) {
    if (v == _stickyFirst) return;
    _stickyFirst = v;
    markNeedsLayout();
  }

  int _stickyLast;
  set stickyColumnsLast(int v) {
    if (v == _stickyLast) return;
    _stickyLast = v;
    markNeedsLayout();
  }

  TextDirection _textDirection;
  set textDirection(TextDirection v) {
    if (v == _textDirection) return;
    _textDirection = v;
    markNeedsLayout();
  }

  CsTableRowStyle _style;
  set style(CsTableRowStyle v) {
    if (v == _style) return;
    _style = v;
    markNeedsPaint();
  }

  bool _header;
  set header(bool v) => _header = v;

  /// Whether this is the header row.
  bool get isHeader => _header;

  // Set by the viewport on every layout.
  double _scroll = 0; // horizontal scroll from the inline start
  double _maxScroll = 0;
  double _viewportWidth = double.infinity;
  bool _stickyEnabled = false;

  /// Viewport state for sticky cells (called by the table viewport).
  void updateSticky({
    required double scroll,
    required double maxScroll,
    required double viewportWidth,
    required bool enabled,
  }) {
    if (scroll == _scroll &&
        maxScroll == _maxScroll &&
        viewportWidth == _viewportWidth &&
        enabled == _stickyEnabled) {
      return;
    }
    _scroll = scroll;
    _maxScroll = maxScroll;
    _viewportWidth = viewportWidth;
    _stickyEnabled = enabled;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  final List<double> _starts = []; // inline-start offsets (logical)
  final List<double> _cellWidths = [];

  /// Width of the row's columns before the last one fills the container.
  double get naturalWidth => _widths.fold(0.0, (a, b) => a + b);

  /// Sum of the widths of the start-sticky columns.
  double stickyWidthStart() {
    var w = 0.0;
    for (var i = 0; i < math.min(_stickyFirst, _cellWidths.length); i++) {
      w += _cellWidths[i];
    }
    return w;
  }

  /// Sum of the widths of the last sticky columns.
  double stickyWidthEnd() {
    var w = 0.0;
    final n = _cellWidths.length;
    for (var i = 0; i < math.min(_stickyLast, n); i++) {
      w += _cellWidths[n - 1 - i];
    }
    return w;
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _RowParentData) {
      child.parentData = _RowParentData();
    }
  }

  List<RenderBox> get _cells {
    final out = <RenderBox>[];
    var c = firstChild;
    while (c != null) {
      out.add(c);
      c = childAfter(c);
    }
    return out;
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void performLayout() {
    final cells = _cells;
    _starts.clear();
    _cellWidths.clear();
    var x = 0.0;
    for (var i = 0; i < cells.length; i++) {
      var w = i < _widths.length ? _widths[i] : csDefaultColumnWidth;
      if (i == cells.length - 1 && constraints.hasBoundedWidth) {
        // The last column fills the container (upstream: width auto).
        w = math.max(w, constraints.maxWidth - x);
      }
      _starts.add(x);
      _cellWidths.add(w);
      x += w;
    }
    var height = 0.0;
    for (var i = 0; i < cells.length; i++) {
      cells[i].layout(
        BoxConstraints.tightFor(width: _cellWidths[i]),
        parentUsesSize: true,
      );
      height = math.max(height, cells[i].size.height);
    }
    for (var i = 0; i < cells.length; i++) {
      if (cells[i].size.height != height) {
        cells[i].layout(
          BoxConstraints.tightFor(width: _cellWidths[i], height: height),
          parentUsesSize: true,
        );
      }
      (cells[i].parentData! as _RowParentData).offset = Offset(
        _physicalX(i, _starts[i]),
        0,
      );
    }
    size = constraints.constrain(Size(x, height));
  }

  double get _rowWidth =>
      _cellWidths.isEmpty ? 0 : _starts.last + _cellWidths.last;

  double _physicalX(int i, double logicalStart) =>
      _textDirection == TextDirection.ltr
      ? logicalStart
      : _rowWidth - logicalStart - _cellWidths[i];

  /// Kind of column [i]: -1 sticky start, 1 sticky end, 0 scrolling.
  int _stickySide(int i) {
    if (!_stickyEnabled) return 0;
    if (i < _stickyFirst) return -1;
    if (i >= _cellWidths.length - _stickyLast) return 1;
    return 0;
  }

  /// The logical inline-start offset where cell [i] is painted.
  double _effectiveStart(int i) {
    final natural = _starts[i];
    switch (_stickySide(i)) {
      case -1:
        var before = 0.0;
        for (var k = 0; k < i; k++) {
          before += _cellWidths[k];
        }
        return math.max(natural, _scroll + before);
      case 1:
        var after = 0.0;
        for (var k = i + 1; k < _cellWidths.length; k++) {
          after += _cellWidths[k];
        }
        return math.min(
          natural,
          _scroll + _viewportWidth - after - _cellWidths[i],
        );
      default:
        return natural;
    }
  }

  Offset _offsetOf(int i) => Offset(_physicalX(i, _effectiveStart(i)), 0);

  bool get _stuckStart => _stickyEnabled && _stickyFirst > 0 && _scroll > 0;

  bool get _stuckEnd =>
      _stickyEnabled && _stickyLast > 0 && _scroll.ceil() < _maxScroll;

  @override
  void paint(PaintingContext context, Offset offset) {
    final cells = _cells;
    // Scrolling cells first, sticky cells on top.
    for (var i = 0; i < cells.length; i++) {
      if (_stickySide(i) == 0) {
        context.paintChild(cells[i], offset + _offsetOf(i));
      }
    }
    final canvas = context.canvas;
    for (var i = 0; i < cells.length; i++) {
      final side = _stickySide(i);
      if (side == 0) continue;
      final o = offset + _offsetOf(i);
      final rect = o & cells[i].size;
      // Shadow on the boundary cell while stuck, clipped to the outside
      // (upstream clip-path: inset(0 -24px 0 0)).
      final boundaryStart = side == -1 && i == _stickyFirst - 1 && _stuckStart;
      final boundaryEnd =
          side == 1 && i == cells.length - _stickyLast && _stuckEnd;
      if (boundaryStart || boundaryEnd) {
        final towardsEnd =
            boundaryStart == (_textDirection == TextDirection.ltr);
        final clip = towardsEnd
            ? Rect.fromLTRB(rect.right, rect.top, rect.right + 24, rect.bottom)
            : Rect.fromLTRB(rect.left - 24, rect.top, rect.left, rect.bottom);
        final shadows = (boundaryStart ? _style.shadowFirst : _style.shadowLast)
            .toBoxShadows();
        canvas
          ..save()
          ..clipRect(clip);
        for (final s in shadows) {
          canvas.drawRect(
            rect.shift(s.offset).inflate(s.spreadRadius),
            s.toPaint(),
          );
        }
        canvas.restore();
      }
      canvas.drawRect(rect, Paint()..color = _style.background);
      context.paintChild(cells[i], o);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final cells = _cells;
    // Reverse paint order: sticky cells, then scrolling cells.
    final order = [
      for (var i = cells.length - 1; i >= 0; i--)
        if (_stickySide(i) != 0) i,
      for (var i = cells.length - 1; i >= 0; i--)
        if (_stickySide(i) == 0) i,
    ];
    for (final i in order) {
      final o = _offsetOf(i);
      final hit = result.addWithPaintOffset(
        offset: o,
        position: position,
        hitTest: (result, transformed) =>
            cells[i].hitTest(result, position: transformed),
      );
      if (hit) return true;
    }
    return false;
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    final i = _cells.indexOf(child);
    final o = i < 0 ? Offset.zero : _offsetOf(i);
    transform.translateByDouble(o.dx, o.dy, 0, 1);
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..isSemanticBoundary = true
      ..role = SemanticsRole.row;
  }

  @override
  double computeMinIntrinsicWidth(double height) =>
      _widths.fold(0.0, (a, b) => a + b);

  @override
  double computeMaxIntrinsicWidth(double height) =>
      computeMinIntrinsicWidth(height);
}

// ---------------------------------------------------------------------------
// Viewport

class _CsTableScrollView extends TwoDimensionalScrollView {
  _CsTableScrollView({
    required super.delegate,
    required this.stickyHeader,
    ScrollController? verticalController,
    ScrollController? horizontalController,
  }) : super(
         verticalDetails: ScrollableDetails.vertical(
           controller: verticalController,
         ),
         horizontalDetails: ScrollableDetails.horizontal(
           controller: horizontalController,
         ),
         diagonalDragBehavior: DiagonalDragBehavior.free,
       );

  final bool stickyHeader;

  @override
  Widget buildViewport(
    BuildContext context,
    ViewportOffset verticalOffset,
    ViewportOffset horizontalOffset,
  ) => _CsTableViewport(
    verticalOffset: verticalOffset,
    verticalAxisDirection: AxisDirection.down,
    horizontalOffset: horizontalOffset,
    // Logical: scroll offset 0 is the inline start in both directions.
    horizontalAxisDirection: Directionality.of(context) == TextDirection.rtl
        ? AxisDirection.left
        : AxisDirection.right,
    delegate: delegate as TwoDimensionalChildBuilderDelegate,
    mainAxis: Axis.vertical,
    stickyHeader: stickyHeader,
  );
}

class _CsTableViewport extends TwoDimensionalViewport {
  const _CsTableViewport({
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required TwoDimensionalChildBuilderDelegate super.delegate,
    required super.mainAxis,
    required this.stickyHeader,
  });

  final bool stickyHeader;

  @override
  RenderTwoDimensionalViewport createRenderObject(BuildContext context) =>
      _RenderCsTableViewport(
        horizontalOffset: horizontalOffset,
        horizontalAxisDirection: horizontalAxisDirection,
        verticalOffset: verticalOffset,
        verticalAxisDirection: verticalAxisDirection,
        mainAxis: mainAxis,
        delegate: delegate,
        childManager: context as TwoDimensionalChildManager,
        stickyHeader: stickyHeader,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderCsTableViewport renderObject,
  ) {
    renderObject
      ..horizontalOffset = horizontalOffset
      ..horizontalAxisDirection = horizontalAxisDirection
      ..verticalOffset = verticalOffset
      ..verticalAxisDirection = verticalAxisDirection
      ..mainAxis = mainAxis
      ..delegate = delegate
      ..stickyHeader = stickyHeader;
  }
}

class _RenderCsTableViewport extends RenderTwoDimensionalViewport {
  _RenderCsTableViewport({
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.delegate,
    required super.mainAxis,
    required super.childManager,
    required this._stickyHeader,
  });

  bool _stickyHeader;
  set stickyHeader(bool v) {
    if (v == _stickyHeader) return;
    _stickyHeader = v;
    markNeedsLayout();
  }

  /// Body row offsets: measured heights over a fixed estimate.
  final CsRowExtents _extents = CsRowExtents();

  @override
  TwoDimensionalChildBuilderDelegate get delegate =>
      super.delegate as TwoDimensionalChildBuilderDelegate;

  @override
  void layoutChildSequence() {
    final rows = delegate.maxYIndex ?? 0; // body rows (header is y = 0)
    final w = viewportDimension.width;
    final h = viewportDimension.height;
    final scrollX = horizontalOffset.pixels;
    final scrollY = verticalOffset.pixels;
    // Header first: its height offsets the body. The table is as wide as
    // its columns or the viewport, whichever is wider (the last column
    // fills leftover space).
    final header = buildOrObtainChildFor(
      const ChildVicinity(xIndex: 0, yIndex: 0),
    )!;
    final headerRow = header as RenderCsTableRow;
    final tableWidth = math.max(headerRow.naturalWidth, w);
    header.layout(
      BoxConstraints.tightFor(width: tableWidth),
      parentUsesSize: true,
    );
    final hh = header.size.height;

    final cache = scrollCacheExtent.value;
    final windowTop = scrollY + (_stickyHeader ? hh : 0) - cache;
    final windowBottom = scrollY + h + cache;
    final laidOut = <RenderBox>[];
    final ext = _extents..count = rows;
    // O(log² n): first row whose bottom is below the window top.
    var r = ext.indexAt(windowTop - hh);
    var y = hh + ext.offsetOf(r);
    final measured = <int, double>{};
    while (r < rows && y < windowBottom) {
      final row = buildOrObtainChildFor(
        ChildVicinity(xIndex: 0, yIndex: r + 1),
      )!;
      row.layout(
        BoxConstraints.tightFor(width: tableWidth),
        parentUsesSize: true,
      );
      measured[r] = row.size.height;
      parentDataOf(row).layoutOffset = Offset(-scrollX, y - scrollY);
      laidOut.add(row);
      y += row.size.height;
      r++;
    }
    ext.record(measured);
    final total = hh + ext.total;

    parentDataOf(header).layoutOffset = Offset(
      -scrollX,
      _stickyHeader ? 0 : -scrollY,
    );
    laidOut.add(header);

    final maxX = math.max(0.0, tableWidth - w);
    // Upstream isEnabled: the table scrolls and leaves 148 px scrollable.
    final stickySpace =
        headerRow.stickyWidthStart() + headerRow.stickyWidthEnd();
    final enabled =
        stickySpace > 0 &&
        tableWidth > w &&
        csMinimumScrollableSpace < w - stickySpace;
    for (final row in laidOut) {
      if (row is RenderCsTableRow) {
        row.updateSticky(
          scroll: scrollX,
          maxScroll: maxX,
          viewportWidth: w,
          enabled: enabled,
        );
      }
    }
    _stickyEnabled = enabled;

    verticalOffset.applyContentDimensions(0, math.max(0, total - h));
    horizontalOffset.applyContentDimensions(0, maxX);
  }

  bool _stickyEnabled = false;

  /// Whether sticky columns are active (tests).
  bool get stickyColumnsEnabled => _stickyEnabled;

  final LayerHandle<ClipRectLayer> _clip = LayerHandle<ClipRectLayer>();

  @override
  void dispose() {
    _clip.layer = null;
    super.dispose();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Body rows, then the header on top of the rows scrolling under it.
    _clip.layer = context.pushClipRect(
      needsCompositing,
      offset,
      Offset.zero & viewportDimension,
      (context, offset) {
        const headerAt = ChildVicinity(xIndex: 0, yIndex: 0);
        RenderBox? header;
        var child = firstChild;
        while (child != null) {
          final pd = parentDataOf(child);
          if (pd.vicinity == headerAt) {
            header = child;
          } else if (pd.isVisible) {
            context.paintChild(child, offset + pd.paintOffset!);
          }
          child = childAfter(child);
        }
        if (header != null && parentDataOf(header).isVisible) {
          context.paintChild(
            header,
            offset + parentDataOf(header).paintOffset!,
          );
        }
      },
      oldLayer: _clip.layer,
    );
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    // The header paints last; test it first.
    final header = getChildFor(const ChildVicinity(xIndex: 0, yIndex: 0));
    if (header != null && parentDataOf(header).isVisible) {
      final hit = result.addWithPaintOffset(
        offset: parentDataOf(header).paintOffset,
        position: position,
        hitTest: (result, transformed) =>
            header.hitTest(result, position: transformed),
      );
      if (hit) return true;
    }
    return super.hitTestChildren(result, position: position);
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..isSemanticBoundary = true
      ..role = SemanticsRole.table;
  }
}

/// Row offsets for a virtual list of [count] rows: rows that were laid out
/// keep their measured height, the rest use a fixed estimate (the average of
/// the first rows measured). A Fenwick tree over the corrections gives
/// offsets and lookups in O(log n), so deep jumps in huge tables are cheap.
class CsRowExtents {
  /// Creates the extents; [estimate] is used until rows are measured.
  CsRowExtents({this._estimate = 41});

  double _estimate;
  bool _estimateFixed = false;
  int _count = 0;
  final Map<int, double> _measured = {};
  List<double> _tree = [0]; // 1-based Fenwick tree of (height - estimate)

  /// Estimated height of unmeasured rows.
  double get estimate => _estimate;

  /// Number of rows.
  int get count => _count;
  set count(int n) {
    if (n == _count) return;
    _count = n;
    _measured.removeWhere((r, _) => r >= n);
    _rebuild();
  }

  void _rebuild() {
    _tree = List<double>.filled(_count + 1, 0);
    _measured.forEach((r, h) => _add(r, h - _estimate));
  }

  void _add(int r, double delta) {
    for (var i = r + 1; i <= _count; i += i & -i) {
      _tree[i] += delta;
    }
  }

  double _prefix(int n) {
    var sum = 0.0;
    for (var i = n; i > 0; i -= i & -i) {
      sum += _tree[i];
    }
    return sum;
  }

  /// Height of row [r].
  double extentOf(int r) => _measured[r] ?? _estimate;

  /// Offset of the top of row [r] (r may equal [count]).
  double offsetOf(int r) => r * _estimate + _prefix(r);

  /// Total height.
  double get total => offsetOf(_count);

  /// The first row whose bottom is below [offset] ([count] when none).
  int indexAt(double offset) {
    var lo = 0, hi = _count;
    while (lo < hi) {
      final mid = (lo + hi) >> 1;
      if (offsetOf(mid + 1) <= offset) {
        lo = mid + 1;
      } else {
        hi = mid;
      }
    }
    return lo;
  }

  /// Records measured heights. The first batch fixes the estimate.
  void record(Map<int, double> heights) {
    if (heights.isEmpty) return;
    if (!_estimateFixed) {
      _estimateFixed = true;
      _measured.addAll(heights);
      _estimate = heights.values.reduce((a, b) => a + b) / heights.length;
      _rebuild();
      return;
    }
    heights.forEach((r, h) {
      final old = _measured[r];
      if (old == h) return;
      _measured[r] = h;
      _add(r, h - (old ?? _estimate));
    });
  }
}
