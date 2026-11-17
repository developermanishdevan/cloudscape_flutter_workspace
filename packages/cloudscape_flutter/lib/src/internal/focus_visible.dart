// Port of component-toolkit `focus-visible`: focus rings show only after
// keyboard interaction (upstream sets `data-awsui-focus-visible` on <body>).
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

final Set<LogicalKeyboardKey> _modifiers = {
  LogicalKeyboardKey.shift,
  LogicalKeyboardKey.shiftLeft,
  LogicalKeyboardKey.shiftRight,
  LogicalKeyboardKey.control,
  LogicalKeyboardKey.controlLeft,
  LogicalKeyboardKey.controlRight,
  LogicalKeyboardKey.alt,
  LogicalKeyboardKey.altLeft,
  LogicalKeyboardKey.altRight,
  LogicalKeyboardKey.meta,
  LogicalKeyboardKey.metaLeft,
  LogicalKeyboardKey.metaRight,
};

/// Whether the last interaction was a (non-modifier) key press rather than
/// a pointer press. Listeners are installed while at least one component
/// [attach]es, like upstream's per-document reference counting.
abstract final class CsFocusVisible {
  /// True after a non-modifier keydown, false after any pointer down.
  static final ValueNotifier<bool> isKeyboard = ValueNotifier(false);

  static int _users = 0;

  static bool _onKey(KeyEvent event) {
    if (event is KeyDownEvent && !_modifiers.contains(event.logicalKey)) {
      isKeyboard.value = true;
    }
    return false; // never consume
  }

  static void _onPointer(PointerEvent event) {
    if (event is PointerDownEvent) isKeyboard.value = false;
  }

  /// Starts tracking (reference counted). Call [detach] when done.
  static void attach() {
    if (_users++ == 0) {
      HardwareKeyboard.instance.addHandler(_onKey);
      GestureBinding.instance.pointerRouter.addGlobalRoute(_onPointer);
    }
  }

  /// Stops tracking for one [attach] call.
  static void detach() {
    assert(_users > 0, 'CsFocusVisible.detach without attach');
    if (--_users == 0) {
      HardwareKeyboard.instance.removeHandler(_onKey);
      GestureBinding.instance.pointerRouter.removeGlobalRoute(_onPointer);
      isKeyboard.value = false;
    }
  }
}
