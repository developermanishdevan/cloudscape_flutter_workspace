import 'package:cloudscape_flutter/src/internal/focus_ring.dart';
import 'package:cloudscape_flutter/src/internal/focus_visible.dart';
import 'package:cloudscape_flutter/src/internal/single_tab_stop.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Interaction state passed to [CsPressable.builder].
@immutable
class CsPressableState {
  /// Creates a state snapshot.
  const CsPressableState({
    required this.hovered,
    required this.pressed,
    required this.focused,
    required this.focusVisible,
    required this.disabled,
  });

  /// Pointer is over the element.
  final bool hovered;

  /// Pointer or Space key is held down on the element.
  final bool pressed;

  /// The element has focus.
  final bool focused;

  /// The element has focus and the user is navigating by keyboard (show
  /// the focus ring).
  final bool focusVisible;

  /// The element is disabled.
  final bool disabled;
}

/// Accessibility role of a [CsPressable].
enum CsPressableRole {
  /// A button: Enter activates on key down, Space on key up.
  button,

  /// A link: Enter activates; Space is not handled.
  link,

  /// No role (the child supplies semantics).
  none,
}

/// The shared interactive primitive: hover / pressed / focus / disabled
/// states, Enter/Space activation, pointer activation, single-tab-stop
/// registration and an optional [CsFocusRing].
class CsPressable extends StatefulWidget {
  /// Creates a pressable.
  const CsPressable({
    super.key,
    required this.builder,
    this.onPressed,
    this.disabled = false,
    this.role = CsPressableRole.button,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.tabIndex,
    this.itemKey,
    this.focusRing = true,
    this.focusRingGutter = 4,
    this.focusRingRadius,
    this.mouseCursor,
    this.onFocusChange,
    this.onHoverChange,
  });

  /// Builds the visuals for the current state.
  final Widget Function(BuildContext context, CsPressableState state) builder;

  /// Activation callback. Null (or [disabled]) disables activation.
  final VoidCallback? onPressed;

  /// Disabled: not activatable; not focusable.
  final bool disabled;

  /// Keyboard/semantics role.
  final CsPressableRole role;

  /// Accessible label (when the child has no text).
  final String? semanticLabel;

  /// External focus node.
  final FocusNode? focusNode;

  /// Request focus on mount.
  final bool autofocus;

  /// Upstream `tabIndex`: negative removes it from Tab order.
  final int? tabIndex;

  /// Stable identity for single-tab-stop navigation.
  final Object? itemKey;

  /// Draw [CsFocusRing] when focus-visible.
  final bool focusRing;

  /// Focus ring gutter.
  final double focusRingGutter;

  /// Focus ring radius (defaults to the token).
  final double? focusRingRadius;

  /// Cursor override (default: click when enabled).
  final MouseCursor? mouseCursor;

  /// Focus changes.
  final ValueChanged<bool>? onFocusChange;

  /// Hover changes.
  final ValueChanged<bool>? onHoverChange;

  @override
  State<CsPressable> createState() => _CsPressableState();
}

class _CsPressableState extends State<CsPressable> {
  FocusNode? _ownNode;
  FocusNode get _node =>
      widget.focusNode ?? (_ownNode ??= FocusNode(debugLabel: 'CsPressable'));
  bool _hovered = false;
  bool _pointerPressed = false;
  bool _spacePressed = false;
  bool _focused = false;

  bool get _disabled => widget.disabled || widget.onPressed == null;

  @override
  void initState() {
    super.initState();
    CsFocusVisible.attach();
    CsFocusVisible.isKeyboard.addListener(_rebuild);
  }

  @override
  void dispose() {
    CsFocusVisible.isKeyboard.removeListener(_rebuild);
    CsFocusVisible.detach();
    _ownNode?.dispose();
    super.dispose();
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  void _activate() {
    if (!_disabled) widget.onPressed!.call();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (_disabled || widget.role == CsPressableRole.none) {
      return KeyEventResult.ignored;
    }
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.numpadEnter) {
      if (event is KeyDownEvent) _activate();
      return KeyEventResult.handled;
    }
    if (widget.role == CsPressableRole.button &&
        key == LogicalKeyboardKey.space) {
      if (event is KeyDownEvent) {
        setState(() => _spacePressed = true);
      } else if (event is KeyUpEvent && _spacePressed) {
        setState(() => _spacePressed = false);
        _activate();
      }
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.escape && _spacePressed) {
      setState(() => _spacePressed = false); // native buttons cancel on Esc
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final state = CsPressableState(
      hovered: _hovered && !_disabled,
      pressed: (_pointerPressed || _spacePressed) && !_disabled,
      focused: _focused,
      focusVisible: _focused && CsFocusVisible.isKeyboard.value,
      disabled: _disabled,
    );
    Widget child = widget.builder(context, state);
    if (widget.focusRing) {
      child = CsFocusRing(
        focused: _focused,
        gutter: widget.focusRingGutter,
        borderRadius: widget.focusRingRadius,
        child: child,
      );
    }
    child = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _disabled
          ? null
          : (_) => setState(() => _pointerPressed = true),
      onTapUp: _disabled
          ? null
          : (_) => setState(() => _pointerPressed = false),
      onTapCancel: _disabled
          ? null
          : () => setState(() => _pointerPressed = false),
      onTap: _disabled ? null : _activate,
      excludeFromSemantics: true,
      child: child,
    );
    child = MouseRegion(
      cursor:
          widget.mouseCursor ??
          (_disabled ? SystemMouseCursors.basic : SystemMouseCursors.click),
      onEnter: (_) {
        setState(() => _hovered = true);
        widget.onHoverChange?.call(true);
      },
      onExit: (_) {
        setState(() {
          _hovered = false;
          _pointerPressed = false;
        });
        widget.onHoverChange?.call(false);
      },
      child: child,
    );
    child = Focus(
      focusNode: _node,
      autofocus: widget.autofocus,
      canRequestFocus: !_disabled,
      onKeyEvent: _onKey,
      onFocusChange: (focused) {
        setState(() {
          _focused = focused;
          if (!focused) _spacePressed = false;
        });
        widget.onFocusChange?.call(focused);
      },
      child: child,
    );
    child = CsSingleTabStop(
      focusNode: _node,
      tabIndex: widget.tabIndex,
      itemKey: widget.itemKey,
      isDisabled: () => _disabled,
      child: child,
    );
    if (widget.role == CsPressableRole.none) return child;
    // One node carries role, label, state, tap and focus actions.
    return MergeSemantics(
      child: Semantics(
        button: widget.role == CsPressableRole.button,
        link: widget.role == CsPressableRole.link,
        enabled: !_disabled,
        focusable: !_disabled,
        focused: _focused,
        label: widget.semanticLabel,
        onTap: _disabled ? null : _activate,
        child: child,
      ),
    );
  }
}
