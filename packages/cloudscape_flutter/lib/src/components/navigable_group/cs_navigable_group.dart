import 'package:cloudscape_flutter/src/internal/single_tab_stop.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Arrow-key directions (upstream `NavigableGroupProps.navigationDirection`).
enum CsNavigationDirection {
  /// Left/Right (mirrored in RTL).
  horizontal,

  /// Up/Down.
  vertical,

  /// All arrows.
  both,
}

/// Groups interactive children into a single Tab stop navigated with arrow
/// keys, Home and End (upstream `NavigableGroup`). Children built on
/// `CsPressable` register automatically.
class CsNavigableGroup extends StatefulWidget {
  /// Creates a navigable group.
  const CsNavigableGroup({
    super.key,
    required this.child,
    this.getItemKey,
    this.navigationDirection = CsNavigationDirection.horizontal,
  });

  /// The items.
  final Widget child;

  /// Stable identity of an item, used to keep the tab stop on the same item
  /// across rebuilds. Defaults to the item's own key (`itemKey` or node).
  final String Function(CsSingleTabStopFocusable item)? getItemKey;

  /// Which arrow keys move between items.
  final CsNavigationDirection navigationDirection;

  @override
  State<CsNavigableGroup> createState() => CsNavigableGroupState();
}

/// State of [CsNavigableGroup]; call [focus] (upstream ref API).
class CsNavigableGroupState extends State<CsNavigableGroup> {
  final GlobalKey<CsSingleTabStopNavigationProviderState> _api = GlobalKey();
  Object? _focusedKey;

  Object _keyOf(CsSingleTabStopFocusable f) =>
      widget.getItemKey?.call(f) ?? f.itemKey;

  /// Registered, enabled items in tree order (upstream `getFocusablesFrom`).
  List<CsSingleTabStopFocusable> _focusables() {
    final api = _api.currentState;
    if (api == null) return const [];
    final registered = {
      for (final f in api.focusables) f.context as Element: f,
    };
    final ordered = <CsSingleTabStopFocusable>[];
    void visit(Element e) {
      final f = registered[e];
      if (f != null && !f.isDisabled()) ordered.add(f);
      e.visitChildren(visit);
    }

    (context as Element).visitChildren(visit);
    return ordered;
  }

  CsSingleTabStopFocusable? _nextFocusTarget() {
    final items = _focusables();
    for (final f in items) {
      if (_keyOf(f) == _focusedKey) return f;
    }
    return items.isEmpty ? null : items.first;
  }

  /// Focuses the current tab stop.
  void focus() => _nextFocusTarget()?.node.requestFocus();

  void _onPrimaryFocusChange() {
    final api = _api.currentState;
    final primary = FocusManager.instance.primaryFocus;
    if (api == null || primary == null) return;
    for (final f in api.focusables) {
      if (f.node == primary) _focusedKey = _keyOf(f);
    }
    api.updateFocusTarget();
  }

  @override
  void initState() {
    super.initState();
    FocusManager.instance.addListener(_onPrimaryFocusChange);
  }

  @override
  void dispose() {
    FocusManager.instance.removeListener(_onPrimaryFocusChange);
    super.dispose();
  }

  void _onUnregisterActive(CsSingleTabStopFocusable removed) {
    final target = _api.currentState?.getFocusTarget();
    if (target != null && _keyOf(target) != _keyOf(removed)) {
      target.node.requestFocus();
    }
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final keyboard = HardwareKeyboard.instance;
    if (keyboard.isControlPressed ||
        keyboard.isAltPressed ||
        keyboard.isShiftPressed ||
        keyboard.isMetaPressed) {
      return KeyEventResult.ignored;
    }
    final key = event.logicalKey;
    final horizontal = {
      LogicalKeyboardKey.arrowLeft,
      LogicalKeyboardKey.arrowRight,
    };
    final vertical = {LogicalKeyboardKey.arrowUp, LogicalKeyboardKey.arrowDown};
    final special = {
      ...switch (widget.navigationDirection) {
        CsNavigationDirection.horizontal => horizontal,
        CsNavigationDirection.vertical => vertical,
        CsNavigationDirection.both => {...horizontal, ...vertical},
      },
      LogicalKeyboardKey.home,
      LogicalKeyboardKey.end,
      LogicalKeyboardKey.pageUp,
      LogicalKeyboardKey.pageDown,
    };
    if (!special.contains(key)) return KeyEventResult.ignored;
    final api = _api.currentState;
    final target = api?.getFocusTarget();
    if (api == null || target == null) return KeyEventResult.ignored;
    final primary = FocusManager.instance.primaryFocus;
    if (primary != null && !api.isRegistered(primary)) {
      return KeyEventResult.ignored;
    }

    final items = _focusables();
    if (items.isEmpty) return KeyEventResult.handled;
    final active = items.indexOf(target);
    CsSingleTabStopFocusable step(int delta) {
      var i = active + delta;
      if (i < 0) i = items.length - 1;
      if (i > items.length - 1) i = 0;
      return items[i];
    }

    final rtl = Directionality.maybeOf(context) == TextDirection.rtl;
    CsSingleTabStopFocusable? next;
    if (key == LogicalKeyboardKey.home) {
      next = items.first;
    } else if (key == LogicalKeyboardKey.end) {
      next = items.last;
    } else if (key == LogicalKeyboardKey.arrowLeft) {
      next = step(rtl ? 1 : -1);
    } else if (key == LogicalKeyboardKey.arrowRight) {
      next = step(rtl ? -1 : 1);
    } else if (key == LogicalKeyboardKey.arrowUp) {
      next = step(-1);
    } else if (key == LogicalKeyboardKey.arrowDown) {
      next = step(1);
    }
    // PageUp/PageDown are consumed without moving, like upstream.
    next?.node.requestFocus();
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _api.currentState?.updateFocusTarget();
    });
    return Focus(
      canRequestFocus: false,
      skipTraversal: true,
      onKeyEvent: _onKey,
      child: CsSingleTabStopNavigationProvider(
        key: _api,
        navigationActive: true,
        getNextFocusTarget: _nextFocusTarget,
        onUnregisterActive: _onUnregisterActive,
        child: widget.child,
      ),
    );
  }
}
