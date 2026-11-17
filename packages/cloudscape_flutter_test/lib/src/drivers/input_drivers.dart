// Drivers for text inputs.
import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cloudscape_flutter_test/src/driver.dart';
import 'package:cloudscape_flutter_test/src/finders.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Drives a [CsEditableField] (upstream `InputWrapper` / `TextareaWrapper`).
class CsEditableFieldDriver extends CsDriver<CsEditableField> {
  /// Drives the first field matched by [finder].
  CsEditableFieldDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csEditableField());

  CsEditableFieldState get _state => tester.state<CsEditableFieldState>(finder);

  /// The native text input (upstream `findNativeInput()`).
  Finder get nativeInput => descendant(find.byType(EditableText));

  /// The current value.
  String get value => _state.controller.text;

  /// The current selection.
  TextSelection get selection => _state.controller.selection;

  /// The placeholder.
  String? get placeholder => widget.placeholder;

  /// Disabled.
  bool get isDisabled => widget.disabled;

  /// Read-only.
  bool get isReadOnly => widget.readOnly;

  /// Invalid.
  bool get isInvalid => widget.invalid;

  /// Warning (and not invalid).
  bool get isWarning => widget.warning && !widget.invalid;

  /// Has focus.
  bool get isFocused => _state.hasFocus;

  /// The start icon slot.
  Finder get startIcon => widget.startIcon == null
      ? find.byWidgetPredicate((_) => false)
      : descendant(find.byWidget(widget.startIcon!));

  /// The end icon slot (e.g. the clear button).
  Finder get endIcon => widget.endIcon == null
      ? find.byWidgetPredicate((_) => false)
      : descendant(find.byWidget(widget.endIcon!));

  /// Types [text], replacing the value (upstream `setInputValue()`).
  Future<void> setValue(String text) async {
    await tester.enterText(nativeInput, text);
    await tester.pump();
  }

  /// Focuses the field (upstream `focus()`).
  Future<void> focus() async {
    _state.focusNode.requestFocus();
    await tester.pump();
  }

  /// Removes focus (upstream `blur()`).
  Future<void> blur() async {
    _state.focusNode.unfocus();
    await tester.pump();
  }

  /// Clicks the field.
  Future<void> click() async {
    await tester.tap(finder, warnIfMissed: false);
    await tester.pump();
  }

  /// Clicks the end icon (upstream `findClearButton().click()`).
  Future<void> clickEndIcon() async {
    await tester.tap(endIcon);
    await tester.pump();
  }

  /// Submits (Enter / the IME action).
  Future<void> submit([TextInputAction action = TextInputAction.done]) async {
    await tester.testTextInput.receiveAction(action);
    await tester.pump();
  }

  /// Presses [key] while focused.
  Future<void> pressKey(LogicalKeyboardKey key) async {
    if (!isFocused) await focus();
    await tester.sendKeyEvent(key);
    await tester.pump();
  }

  /// Opens the context menu with a right click.
  Future<void> openContextMenu() async {
    final g = await tester.startGesture(
      tester.getCenter(nativeInput),
      kind: PointerDeviceKind.mouse,
      buttons: kSecondaryMouseButton,
    );
    await g.up();
    await tester.pumpAndSettle();
  }

  /// Labels of the open context menu's items.
  List<String> get contextMenuItems {
    final menu = find.byType(CsTextContextMenu);
    if (menu.evaluate().isEmpty) return const [];
    final m = tester.widget<CsTextContextMenu>(menu);
    final ctx = tester.element(menu);
    return [for (final i in m.buttonItems) csContextMenuLabel(ctx, i)];
  }

  /// Clicks the context menu item labeled [label].
  Future<void> clickContextMenuItem(String label) async {
    await tester.tap(
      find.descendant(
        of: find.byType(CsTextContextMenu),
        matching: find.text(label),
      ),
    );
    await tester.pumpAndSettle();
  }
}
