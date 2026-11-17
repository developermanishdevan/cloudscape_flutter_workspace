// Material-free text selection pieces for CsEditableField: selection
// handles, the context menu (cut/copy/paste/select all) and the magnifier.
//
// Cloudscape relies on the browser for these, so there is no upstream
// design to port; they use Cloudscape tokens (focus blue handles, a
// dropdown-styled menu) and the platform's geometry conventions.
import 'dart:math' as math;

import 'package:cloudscape_flutter/src/internal/selectable_item.dart';
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:cloudscape_flutter/src/theme/typography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Whether [platform] uses iOS-style (lollipop) handles.
bool _cupertinoHandles(TargetPlatform platform) =>
    platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

// Android-style teardrop handle.
const double _kTeardropSize = 22;
// iOS-style lollipop handle.
const double _kLollipopRadius = 6;
const double _kLollipopOverlap = 1.5;

/// Selection handles in the Cloudscape focus color. iOS and macOS get
/// lollipop handles; other platforms get teardrop handles.
class CsTextSelectionControls extends TextSelectionControls
    with TextSelectionHandleControls {
  /// Creates the controls; [platform] defaults to [defaultTargetPlatform].
  CsTextSelectionControls({this._platform});

  final TargetPlatform? _platform;

  TargetPlatform get _target => _platform ?? defaultTargetPlatform;

  @override
  Size getHandleSize(double textLineHeight) => _cupertinoHandles(_target)
      ? Size(
          _kLollipopRadius * 2,
          textLineHeight + _kLollipopRadius * 2 - _kLollipopOverlap,
        )
      : const Size(_kTeardropSize, _kTeardropSize);

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    if (_cupertinoHandles(_target)) {
      final size = getHandleSize(textLineHeight);
      return switch (type) {
        TextSelectionHandleType.left => Offset(size.width / 2, size.height),
        TextSelectionHandleType.right => Offset(
          size.width / 2,
          size.height - 2 * _kLollipopRadius + _kLollipopOverlap,
        ),
        TextSelectionHandleType.collapsed => Offset(
          size.width / 2,
          textLineHeight + (size.height - textLineHeight) / 2,
        ),
      };
    }
    return switch (type) {
      TextSelectionHandleType.left => const Offset(_kTeardropSize, 0),
      TextSelectionHandleType.right => Offset.zero,
      TextSelectionHandleType.collapsed => const Offset(_kTeardropSize / 2, -4),
    };
  }

  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
  ]) {
    final color = CsTheme.tokensOf(context).colorBorderItemFocused.toColor();
    if (_cupertinoHandles(_target)) {
      if (type == TextSelectionHandleType.collapsed) {
        return const SizedBox.shrink(); // iOS shows no caret handle
      }
      final size = getHandleSize(textLineHeight);
      Widget handle = SizedBox.fromSize(
        size: size,
        child: CustomPaint(painter: _LollipopPainter(color)),
      );
      if (type == TextSelectionHandleType.right) {
        handle = Transform.rotate(angle: math.pi, child: handle);
      }
      return _tappable(handle, onTap);
    }
    final handle = SizedBox.square(
      dimension: _kTeardropSize,
      child: CustomPaint(painter: _TeardropPainter(color)),
    );
    return _tappable(switch (type) {
      TextSelectionHandleType.left => Transform.rotate(
        angle: math.pi / 2,
        child: handle,
      ),
      TextSelectionHandleType.right => handle,
      TextSelectionHandleType.collapsed => Transform.rotate(
        angle: math.pi / 4,
        child: handle,
      ),
    }, onTap);
  }

  Widget _tappable(Widget child, VoidCallback? onTap) => onTap == null
      ? child
      : GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.translucent,
          child: child,
        );
}

class _TeardropPainter extends CustomPainter {
  _TeardropPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    final path = Path()
      ..addOval(Rect.fromCircle(center: Offset(r, r), radius: r))
      ..addRect(Rect.fromLTWH(0, 0, r, r));
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_TeardropPainter old) => old.color != color;
}

class _LollipopPainter extends CustomPainter {
  _LollipopPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const half = 1.0;
    final path = Path()
      ..addOval(
        Rect.fromCircle(
          center: const Offset(_kLollipopRadius, _kLollipopRadius),
          radius: _kLollipopRadius,
        ),
      )
      ..addRect(
        Rect.fromPoints(
          const Offset(
            _kLollipopRadius - half,
            2 * _kLollipopRadius - _kLollipopOverlap,
          ),
          Offset(_kLollipopRadius + half, size.height),
        ),
      );
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_LollipopPainter old) => old.color != color;
}

/// The label of a context menu item, localized through
/// [WidgetsLocalizations].
String csContextMenuLabel(BuildContext context, ContextMenuButtonItem item) {
  if (item.label != null) return item.label!;
  final l = WidgetsLocalizations.of(context);
  return switch (item.type) {
    ContextMenuButtonType.cut => l.cutButtonLabel,
    ContextMenuButtonType.copy => l.copyButtonLabel,
    ContextMenuButtonType.paste => l.pasteButtonLabel,
    ContextMenuButtonType.selectAll => l.selectAllButtonLabel,
    ContextMenuButtonType.lookUp => l.lookUpButtonLabel,
    ContextMenuButtonType.searchWeb => l.searchWebButtonLabel,
    ContextMenuButtonType.share => l.shareButtonLabel,
    ContextMenuButtonType.delete => 'Delete',
    ContextMenuButtonType.liveTextInput => 'Scan text',
    ContextMenuButtonType.custom => '',
  };
}

/// The default context menu of a [CsEditableField]: the iOS system menu
/// where available, otherwise a [CsTextContextMenu].
Widget csDefaultTextContextMenu(
  BuildContext context,
  EditableTextState editableTextState,
) {
  if (SystemContextMenu.isSupportedByField(editableTextState)) {
    return SystemContextMenu.editableText(editableTextState: editableTextState);
  }
  return CsTextContextMenu(
    anchors: editableTextState.contextMenuAnchors,
    buttonItems: editableTextState.contextMenuButtonItems,
  );
}

/// A Cloudscape-styled text context menu: a vertical dropdown-like menu at
/// the pointer on desktop, a horizontal bar above the selection on touch
/// platforms.
class CsTextContextMenu extends StatelessWidget {
  /// Creates the menu.
  const CsTextContextMenu({
    super.key,
    required this.anchors,
    required this.buttonItems,
    this.platform,
  });

  /// Where to show the menu.
  final TextSelectionToolbarAnchors anchors;

  /// The actions.
  final List<ContextMenuButtonItem> buttonItems;

  /// Overrides [defaultTargetPlatform] (tests).
  final TargetPlatform? platform;

  /// Whether [platform] uses the horizontal touch toolbar.
  static bool isTouch(TargetPlatform platform) => switch (platform) {
    TargetPlatform.android ||
    TargetPlatform.iOS ||
    TargetPlatform.fuchsia => true,
    TargetPlatform.macOS ||
    TargetPlatform.linux ||
    TargetPlatform.windows => false,
  };

  @override
  Widget build(BuildContext context) {
    if (buttonItems.isEmpty) return const SizedBox.shrink();
    final t = CsTheme.tokensOf(context);
    final touch = isTouch(platform ?? defaultTargetPlatform);
    final items = [
      for (final item in buttonItems)
        _MenuItem(
          label: csContextMenuLabel(context, item),
          onPressed: item.onPressed,
          horizontal: touch,
        ),
    ];
    Widget menu = DecoratedBox(
      decoration: BoxDecoration(
        color: t.colorBackgroundDropdownItemDefault.toColor(),
        borderRadius: BorderRadius.circular(t.borderRadiusDropdown),
        boxShadow: t.shadowDropdown.toBoxShadows(),
        border: Border.all(
          color: t.colorBorderDropdownContainer.toColor(),
          width: t.borderWidthDropdown,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(t.borderRadiusDropdown),
        child: DefaultTextStyle(
          style: CsTypography(t).reset,
          child: touch
              ? CsRowOrColumn(children: items)
              : IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: items,
                  ),
                ),
        ),
      ),
    );
    menu = Semantics(container: true, explicitChildNodes: true, child: menu);
    final padding = MediaQuery.paddingOf(context);
    final screenPadding = EdgeInsets.fromLTRB(
      t.spaceXs + padding.left,
      t.spaceXs + padding.top,
      t.spaceXs + padding.right,
      t.spaceXs + padding.bottom,
    );
    final SingleChildLayoutDelegate delegate = touch
        ? TextSelectionToolbarLayoutDelegate(
            anchorAbove: anchors.primaryAnchor - Offset(0, t.spaceXs),
            anchorBelow:
                (anchors.secondaryAnchor ?? anchors.primaryAnchor) +
                Offset(0, t.spaceXs),
          )
        : DesktopTextSelectionToolbarLayoutDelegate(
            anchor: anchors.primaryAnchor - screenPadding.topLeft,
          );
    return Padding(
      padding: screenPadding,
      child: CustomSingleChildLayout(delegate: delegate, child: menu),
    );
  }
}

class _MenuItem extends StatefulWidget {
  const _MenuItem({
    required this.label,
    required this.onPressed,
    required this.horizontal,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool horizontal;

  @override
  State<_MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      excludeSemantics: true,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onPressed,
          child: CsSelectableItem(
            highlighted: _hover && enabled,
            disabled: !enabled,
            child: Text(widget.label, maxLines: 1, softWrap: false),
          ),
        ),
      ),
    );
  }
}

/// A Cloudscape magnifier for touch text selection (iOS and Android).
TextMagnifierConfiguration csTextMagnifierConfiguration({
  TargetPlatform? platform,
}) => TextMagnifierConfiguration(
  magnifierBuilder: (context, controller, info) => switch (platform ??
      defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.android => CsTextMagnifier(info: info),
    _ => null,
  },
);

/// A rounded magnifier shown above the caret line while dragging.
class CsTextMagnifier extends StatelessWidget {
  /// Creates the magnifier.
  const CsTextMagnifier({super.key, required this.info});

  /// Gesture and caret geometry from the text field.
  final ValueNotifier<MagnifierInfo> info;

  /// Magnifier size.
  static const Size size = Size(80, 40);

  /// Gap between the magnifier and the line.
  static const double gap = 12;

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    return ValueListenableBuilder<MagnifierInfo>(
      valueListenable: info,
      builder: (context, i, _) {
        final line = i.currentLineBoundaries;
        final x = clampDouble(
          i.globalGesturePosition.dx,
          line.left,
          math.max(line.left, line.right),
        );
        final screen = MediaQuery.sizeOf(context);
        final left = clampDouble(
          x - size.width / 2,
          0,
          math.max(0, screen.width - size.width),
        );
        final top = math.max(0.0, line.top - size.height - gap);
        final center = Offset(left + size.width / 2, top + size.height / 2);
        return Positioned(
          left: left,
          top: top,
          child: RawMagnifier(
            size: size,
            magnificationScale: 1.25,
            focalPointOffset: Offset(x, line.center.dy) - center,
            decoration: MagnifierDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.height / 2),
                side: BorderSide(
                  color: t.colorBorderDropdownContainer.toColor(),
                ),
              ),
              shadows: t.shadowDropdown.toBoxShadows(),
            ),
          ),
        );
      },
    );
  }
}

/// Lays [children] out in a row when they fit the available width, else
/// in a full-width column (a touch text toolbar on a narrow screen).
class CsRowOrColumn extends MultiChildRenderObjectWidget {
  /// Creates the layout.
  const CsRowOrColumn({super.key, super.children});

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderRowOrColumn();
}

class _RowOrColumnParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderRowOrColumn extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _RowOrColumnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _RowOrColumnParentData> {
  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _RowOrColumnParentData) {
      child.parentData = _RowOrColumnParentData();
    }
  }

  List<RenderBox> get _children {
    final out = <RenderBox>[];
    var c = firstChild;
    while (c != null) {
      out.add(c);
      c = childAfter(c);
    }
    return out;
  }

  /// Whether the children fit side by side within [maxWidth].
  bool _fitsInRow(double maxWidth) =>
      _children.fold(
        0.0,
        (w, c) => w + c.getMaxIntrinsicWidth(double.infinity),
      ) <=
      maxWidth;

  @override
  double computeMaxIntrinsicWidth(double height) =>
      _children.fold(0.0, (w, c) => w + c.getMaxIntrinsicWidth(height));

  @override
  double computeMinIntrinsicWidth(double height) => _children.fold(
    0.0,
    (w, c) => math.max(w, c.getMinIntrinsicWidth(height)),
  );

  @override
  void performLayout() {
    final children = _children;
    if (children.isEmpty) {
      size = constraints.smallest;
      return;
    }
    if (_fitsInRow(constraints.maxWidth)) {
      var height = 0.0;
      for (final c in children) {
        height = math.max(
          height,
          c.getMaxIntrinsicHeight(c.getMaxIntrinsicWidth(double.infinity)),
        );
      }
      var x = 0.0;
      for (final c in children) {
        final w = c.getMaxIntrinsicWidth(double.infinity);
        c.layout(BoxConstraints.tightFor(width: w, height: height));
        (c.parentData! as _RowOrColumnParentData).offset = Offset(x, 0);
        x += w;
      }
      size = constraints.constrain(Size(x, height));
    } else {
      final width = math.min(
        children.fold(
          0.0,
          (w, c) => math.max(w, c.getMaxIntrinsicWidth(double.infinity)),
        ),
        constraints.maxWidth,
      );
      var y = 0.0;
      for (final c in children) {
        c.layout(BoxConstraints.tightFor(width: width), parentUsesSize: true);
        (c.parentData! as _RowOrColumnParentData).offset = Offset(0, y);
        y += c.size.height;
      }
      size = constraints.constrain(Size(width, y));
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) =>
      defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);
}
