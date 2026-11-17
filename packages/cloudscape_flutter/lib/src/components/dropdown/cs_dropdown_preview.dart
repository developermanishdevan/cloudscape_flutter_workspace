import 'package:cloudscape_flutter/src/components/box/cs_box.dart';
import 'package:cloudscape_flutter/src/components/dropdown/cs_dropdown.dart';
import 'package:cloudscape_flutter/src/components/dropdown/dropdown_geometry.dart';
import 'package:cloudscape_flutter/src/components/space_between/cs_space_between.dart';
import 'package:cloudscape_flutter/src/internal/selectable_item.dart';
import 'package:cloudscape_flutter/src/preview/cs_preview.dart';
import 'package:cloudscape_flutter/src/theme/spacing.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Widget _list(int n, [VoidCallback? onSelect]) =>
    _Menu(count: n, onSelect: onSelect);

/// A preview menu: pointer hover and ↑/↓ move the highlight, Enter or a
/// click selects (like upstream option lists).
class _Menu extends StatefulWidget {
  const _Menu({required this.count, this.onSelect});

  final int count;
  final VoidCallback? onSelect;

  @override
  State<_Menu> createState() => _MenuState();
}

class _MenuState extends State<_Menu> {
  int? _highlighted;
  CsHighlightType _type = CsHighlightType.mouse;
  int _selected = 1;
  final FocusNode _focus = FocusNode(debugLabel: 'preview menu');

  bool _disabled(int i) => i == 2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focus.requestFocus();
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  void _select(int i) {
    if (_disabled(i)) return;
    setState(() => _selected = i);
    widget.onSelect?.call();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent e) {
    if (e is! KeyDownEvent && e is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final n = widget.count;
    if (e.logicalKey == LogicalKeyboardKey.arrowDown ||
        e.logicalKey == LogicalKeyboardKey.arrowUp) {
      final step = e.logicalKey == LogicalKeyboardKey.arrowDown ? 1 : -1;
      setState(() {
        _type = CsHighlightType.keyboard;
        _highlighted = ((_highlighted ?? (step > 0 ? -1 : 0)) + step) % n;
      });
      return KeyEventResult.handled;
    }
    if (e.logicalKey == LogicalKeyboardKey.enter && _highlighted != null) {
      _select(_highlighted!);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) => Focus(
    focusNode: _focus,
    onKeyEvent: _onKey,
    child: MouseRegion(
      onExit: (_) => setState(() => _highlighted = null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < widget.count; i++)
            CsSelectableItem(
              selected: i == _selected,
              highlighted: i == _highlighted,
              highlightType: _type,
              disabled: _disabled(i),
              onHover: () {
                if (_highlighted != i || _type != CsHighlightType.mouse) {
                  setState(() {
                    _highlighted = i;
                    _type = CsHighlightType.mouse;
                  });
                }
              },
              onTap: () => _select(i),
              child: Text(
                _disabled(i) ? 'Option ${i + 1} (disabled)' : 'Option ${i + 1}',
              ),
            ),
        ],
      ),
    ),
  );
}

class _Toggle extends StatefulWidget {
  const _Toggle({required this.builder, this.initiallyOpen = false});

  final Widget Function(bool open, VoidCallback toggle, VoidCallback close)
  builder;
  final bool initiallyOpen;

  @override
  State<_Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<_Toggle> {
  late bool _open = widget.initiallyOpen;

  @override
  Widget build(BuildContext context) => widget.builder(
    _open,
    () => setState(() => _open = !_open),
    () => setState(() => _open = false),
  );
}

/// Dropdown: click the trigger; outside click or Escape closes.
@CsPreview(group: 'Dropdown', name: 'Interactive', size: Size(420, 320))
Widget csDropdownInteractivePreview() => _Toggle(
  builder: (open, toggle, close) => CsDropdown(
    open: open,
    onOutsideClick: close,
    onEscape: close,
    trigger: CsPreviewButton(
      open ? 'Close' : 'Open dropdown',
      onPressed: toggle,
    ),
    content: _list(5, close),
  ),
);

/// Dropdown: header, content and footer.
@CsPreview(group: 'Dropdown', name: 'Header and footer', size: Size(420, 320))
Widget csDropdownSlotsPreview() => _Toggle(
  initiallyOpen: true,
  builder: (open, toggle, close) => CsDropdown(
    open: open,
    onOutsideClick: close,
    trigger: CsPreviewButton('Toggle', onPressed: toggle),
    header: CsBox.text(
      'Header',
      variant: CsBoxVariant.h4,
      padding: const CsBoxSpacing(horizontal: CsSpacing.s),
    ),
    content: _list(4),
    footer: CsBox.text(
      'Footer',
      variant: CsBoxVariant.small,
      padding: const CsBoxSpacing.all(CsSpacing.s),
    ),
  ),
);

/// Dropdown: width rules.
@CsPreview(group: 'Dropdown', name: 'Widths', size: Size(640, 320))
Widget csDropdownWidthsPreview() => CsSpaceBetween(
  direction: CsSpaceBetweenDirection.horizontal,
  size: CsSpaceBetweenSize.xl,
  children: [
    for (final (label, min, max)
        in <(String, CsDropdownWidth?, CsDropdownWidth?)>[
          ('content', null, null),
          ('min: trigger', CsDropdownWidth.trigger, null),
          ('match trigger', CsDropdownWidth.trigger, CsDropdownWidth.trigger),
          ('max: 120px', null, const CsDropdownWidth.px(120)),
        ])
      _Toggle(
        initiallyOpen: true,
        builder: (open, toggle, close) => CsDropdown(
          open: open,
          minWidth: min,
          maxWidth: max,
          trigger: SizedBox(
            width: 140,
            child: CsPreviewButton(label, onPressed: toggle),
          ),
          content: CsBox.text(
            'A line of dropdown content that is fairly long',
            padding: const CsBoxSpacing.all(CsSpacing.xs),
          ),
        ),
      ),
  ],
);

/// Dropdown: centered alignment.
@CsPreview(group: 'Dropdown', name: 'Centered', size: Size(420, 260))
Widget csDropdownCenteredPreview() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 120),
  child: _Toggle(
    initiallyOpen: true,
    builder: (open, toggle, close) => CsDropdown(
      open: open,
      preferredAlignment: CsDropdownAlignment.center,
      trigger: CsPreviewButton('Center', onPressed: toggle),
      content: _list(3),
    ),
  ),
);
