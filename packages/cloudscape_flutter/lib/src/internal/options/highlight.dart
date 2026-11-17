// Port of upstream `options-list/utils/use-highlight-option.js`,
// `use-keyboard.js` and `use-open-state.js`.
import 'package:cloudscape_flutter/src/internal/options/option_definition.dart';
import 'package:cloudscape_flutter/src/internal/selectable_item.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Upstream `HighlightType`: who moved the highlight and whether focus /
/// scrolling should follow it.
@immutable
class CsHighlight {
  /// Creates a highlight type. [moveFocus] defaults to keyboard.
  const CsHighlight(this.type, {bool? moveFocus})
    : moveFocus = moveFocus ?? type == CsHighlightType.keyboard;

  /// Mouse or keyboard.
  final CsHighlightType type;

  /// Scroll the highlighted row into view.
  final bool moveFocus;
}

/// Upstream `useHighlightedOption`: the highlighted row of a list, moved
/// over [isHighlightable] rows only.
class CsHighlightController extends ChangeNotifier {
  /// Creates the controller.
  CsHighlightController({
    required this._options,
    required this.isHighlightable,
  });

  List<CsDropdownOption> _options;

  /// Which rows can be highlighted (e.g. [csIsInteractive]).
  bool Function(CsDropdownOption) isHighlightable;

  int _index = -1;
  CsHighlight _highlight = const CsHighlight(CsHighlightType.keyboard);

  /// The rows.
  List<CsDropdownOption> get options => _options;
  set options(List<CsDropdownOption> value) {
    if (identical(value, _options)) return;
    _options = value;
    notifyListeners();
  }

  /// Highlighted index (-1: none).
  int get highlightedIndex => _index;

  /// How the highlight was set.
  CsHighlight get highlightType => _highlight;

  /// The highlighted row when highlightable.
  CsDropdownOption? get highlightedOption =>
      _index >= 0 &&
          _index < _options.length &&
          isHighlightable(_options[_index])
      ? _options[_index]
      : null;

  void _set(int index, CsHighlight type) {
    final changedType = _highlight.type != type.type;
    if (_index == index && !changedType) return;
    _index = index;
    // Upstream keeps the old HighlightType object unless the kind changed.
    if (changedType) _highlight = type;
    notifyListeners();
  }

  void _moveFrom(int direction, int start, CsHighlight type) {
    var i = start == -1 && direction == -1 ? _options.length : start;
    do {
      i += direction;
    } while (i >= 0 && i < _options.length && !isHighlightable(_options[i]));
    if (i >= 0 && i < _options.length) _set(i, type);
  }

  /// Highlight [index] from a pointer move.
  void setHighlightedIndexWithMouse(int index, {bool moveFocus = false}) =>
      _set(index, CsHighlight(CsHighlightType.mouse, moveFocus: moveFocus));

  /// Highlight the first highlightable row (pointer, scrolls into view).
  void highlightFirstOptionWithMouse() => _moveFrom(
    1,
    -1,
    const CsHighlight(CsHighlightType.mouse, moveFocus: true),
  );

  /// Move by [direction] (±1) skipping non-highlightable rows.
  void moveHighlightWithKeyboard(int direction) =>
      _moveFrom(direction, _index, const CsHighlight(CsHighlightType.keyboard));

  /// Highlight [option] with the keyboard.
  void highlightOptionWithKeyboard(CsDropdownOption option) => _set(
    _options.indexOf(option),
    const CsHighlight(CsHighlightType.keyboard),
  );

  /// Clear the highlight (keyboard).
  void resetHighlightWithKeyboard() =>
      _set(-1, const CsHighlight(CsHighlightType.keyboard));

  /// Highlight the first row.
  void goHomeWithKeyboard() =>
      _moveFrom(1, -1, const CsHighlight(CsHighlightType.keyboard));

  /// Highlight the last row.
  void goEndWithKeyboard() => _moveFrom(
    -1,
    _options.length,
    const CsHighlight(CsHighlightType.keyboard),
  );
}

/// Upstream `useMenuKeyboard`: keys inside an open list.
KeyEventResult Function(FocusNode, KeyEvent) csMenuKeyHandler({
  required VoidCallback goUp,
  required VoidCallback goDown,
  required VoidCallback selectOption,
  required VoidCallback goHome,
  required VoidCallback goEnd,
  VoidCallback? onEscape,
  bool preventNativeSpace = false,
}) => (node, event) {
  if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
    return KeyEventResult.ignored;
  }
  final key = event.logicalKey;
  if (key == LogicalKeyboardKey.arrowUp) {
    goUp();
    return KeyEventResult.handled;
  }
  if (key == LogicalKeyboardKey.arrowDown) {
    goDown();
    return KeyEventResult.handled;
  }
  if (key == LogicalKeyboardKey.home) {
    goHome();
    return KeyEventResult.ignored; // upstream does not preventDefault
  }
  if (key == LogicalKeyboardKey.end) {
    goEnd();
    return KeyEventResult.ignored;
  }
  if (key == LogicalKeyboardKey.escape) {
    if (onEscape != null) {
      onEscape();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
  if (key == LogicalKeyboardKey.enter ||
      key == LogicalKeyboardKey.numpadEnter) {
    selectOption();
    return KeyEventResult.handled;
  }
  if (key == LogicalKeyboardKey.space && preventNativeSpace) {
    selectOption();
    return KeyEventResult.handled;
  }
  return KeyEventResult.ignored;
};

/// Upstream `useTriggerKeyboard`: keys on a closed trigger.
KeyEventResult Function(FocusNode, KeyEvent) csTriggerKeyHandler({
  required VoidCallback openDropdown,
  required VoidCallback goHome,
}) => (node, event) {
  if (event is! KeyDownEvent) return KeyEventResult.ignored;
  final key = event.logicalKey;
  if (key == LogicalKeyboardKey.arrowUp ||
      key == LogicalKeyboardKey.arrowDown) {
    goHome();
    openDropdown();
    return KeyEventResult.handled;
  }
  if (key == LogicalKeyboardKey.space || key == LogicalKeyboardKey.enter) {
    openDropdown();
    return KeyEventResult.handled;
  }
  return KeyEventResult.ignored;
};

/// Upstream `useOpenState`.
class CsOpenStateController extends ChangeNotifier {
  /// Creates the controller.
  CsOpenStateController({this.onOpen, this.onClose, bool defaultOpen = false})
    : _isOpen = defaultOpen;

  /// Called when opened.
  VoidCallback? onOpen;

  /// Called when closed.
  VoidCallback? onClose;

  bool _isOpen;
  bool _openedWithKeyboard = false;

  /// Open.
  bool get isOpen => _isOpen;

  /// Last opened from the keyboard.
  bool get openedWithKeyboard => _openedWithKeyboard;

  /// Opens (no-op when open).
  void openDropdown({bool isKeyboard = false}) {
    if (_isOpen) return;
    _isOpen = true;
    _openedWithKeyboard = isKeyboard;
    notifyListeners();
    onOpen?.call();
  }

  /// Closes (no-op when closed).
  void closeDropdown() {
    if (!_isOpen) return;
    _isOpen = false;
    notifyListeners();
    onClose?.call();
  }

  /// Toggles (opening counts as pointer).
  void toggleDropdown() => _isOpen ? closeDropdown() : openDropdown();
}
