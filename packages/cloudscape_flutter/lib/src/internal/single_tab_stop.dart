// Port of component-toolkit `single-tab-stop`: inside an active provider,
// only one registered focusable is reachable with Tab; the others are
// skipped (tabIndex -1) but stay focusable programmatically.
import 'package:flutter/widgets.dart';

/// A focusable registered with a [CsSingleTabStopNavigationProvider].
class CsSingleTabStopFocusable {
  CsSingleTabStopFocusable._(
    this.node,
    this.context,
    this._onChange,
    this.isDisabled,
    this.itemKey,
  );

  /// The focusable's node.
  final FocusNode node;

  /// The registering widget's context (tree order).
  final BuildContext context;

  final ValueChanged<bool> _onChange;

  /// Whether the element is currently disabled.
  final bool Function() isDisabled;

  /// Stable identity across rebuilds (upstream `getItemKey`).
  final Object itemKey;
}

/// The registry contract shared by nested providers.
abstract class _Registry {
  bool get navigationActive;
  VoidCallback register(CsSingleTabStopFocusable focusable);
  void resetFocusTarget();
}

class _InactiveRegistry implements _Registry {
  const _InactiveRegistry();

  @override
  bool get navigationActive => false;

  @override
  VoidCallback register(CsSingleTabStopFocusable focusable) => () {};

  @override
  void resetFocusTarget() {}
}

class _Scope extends InheritedWidget {
  _Scope({required this.registry, required super.child})
    : active = registry.navigationActive;

  final _Registry registry;
  final bool active;

  @override
  bool updateShouldNotify(_Scope old) =>
      !identical(old.registry, registry) || old.active != active;
}

/// Registers [focusNode] with the nearest active single-tab-stop provider
/// and keeps `focusNode.skipTraversal` in sync (upstream
/// `useSingleTabStopNavigation`). [tabIndex] < 0 opts out.
class CsSingleTabStop extends StatefulWidget {
  /// Creates the registration.
  const CsSingleTabStop({
    super.key,
    required this.focusNode,
    required this.child,
    this.tabIndex,
    this.isDisabled,
    this.itemKey,
  });

  /// The node to register.
  final FocusNode focusNode;

  /// The subtree.
  final Widget child;

  /// Upstream `tabIndex`: negative removes the element from navigation.
  final int? tabIndex;

  /// Whether the element is disabled (skipped by arrow navigation).
  final bool Function()? isDisabled;

  /// Stable item identity. Defaults to [focusNode].
  final Object? itemKey;

  /// Whether single-tab-stop navigation is active above [context].
  static bool navigationActiveOf(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<_Scope>()
          ?.registry
          .navigationActive ??
      false;

  @override
  State<CsSingleTabStop> createState() => _CsSingleTabStopState();
}

class _CsSingleTabStopState extends State<CsSingleTabStop> {
  VoidCallback? _unregister;
  _Registry? _registry;
  bool _focusTarget = false;
  bool? _active;

  bool get _navigationDisabled => (widget.tabIndex ?? 0) < 0;

  void _sync() {
    final active =
        (_registry?.navigationActive ?? false) && !_navigationDisabled;
    widget.focusNode.skipTraversal = active
        ? !_focusTarget
        : (widget.tabIndex ?? 0) < 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final registry =
        context.dependOnInheritedWidgetOfExactType<_Scope>()?.registry ??
        const _InactiveRegistry();
    if (!identical(registry, _registry) ||
        registry.navigationActive != _active) {
      _unregister?.call();
      _registry = registry;
      _active = registry.navigationActive;
      _register();
    }
  }

  void _register() {
    _unregister = null;
    if (_registry!.navigationActive && !_navigationDisabled) {
      _unregister = _registry!.register(
        CsSingleTabStopFocusable._(
          widget.focusNode,
          context,
          (isTarget) {
            _focusTarget = isTarget;
            _sync();
          },
          widget.isDisabled ?? () => false,
          widget.itemKey ?? widget.focusNode,
        ),
      );
    }
    _sync();
  }

  @override
  void didUpdateWidget(CsSingleTabStop old) {
    super.didUpdateWidget(old);
    if (old.focusNode != widget.focusNode ||
        old.tabIndex != widget.tabIndex ||
        old.itemKey != widget.itemKey) {
      _unregister?.call();
      _register();
    } else {
      _sync();
    }
  }

  @override
  void dispose() {
    _unregister?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Activates single-tab-stop navigation for a subtree (upstream
/// `SingleTabStopNavigationProvider`). The outermost active provider wins.
class CsSingleTabStopNavigationProvider extends StatefulWidget {
  /// Creates a provider.
  const CsSingleTabStopNavigationProvider({
    super.key,
    required this.navigationActive,
    required this.getNextFocusTarget,
    required this.child,
    this.isElementSuppressed,
    this.onRegisterFocusable,
    this.onUnregisterActive,
  });

  /// Whether navigation is active.
  final bool navigationActive;

  /// Picks the single tab stop.
  final CsSingleTabStopFocusable? Function() getNextFocusTarget;

  /// Elements that stay tabbable regardless.
  final bool Function(CsSingleTabStopFocusable)? isElementSuppressed;

  /// Called after registration.
  final void Function(CsSingleTabStopFocusable)? onRegisterFocusable;

  /// Called (after the frame) when the focused element unregisters.
  final void Function(CsSingleTabStopFocusable)? onUnregisterActive;

  /// The subtree.
  final Widget child;

  @override
  State<CsSingleTabStopNavigationProvider> createState() =>
      CsSingleTabStopNavigationProviderState();
}

/// The provider's imperative API (upstream ref): [updateFocusTarget],
/// [getFocusTarget], [isRegistered], [focusables].
class CsSingleTabStopNavigationProviderState
    extends State<CsSingleTabStopNavigationProvider>
    implements _Registry {
  final List<CsSingleTabStopFocusable> _focusables = [];
  final Map<CsSingleTabStopFocusable, bool> _state = {};
  final Map<CsSingleTabStopFocusable, VoidCallback> _parentUnregister = {};
  CsSingleTabStopFocusable? _focusTarget;
  _Registry _parent = const _InactiveRegistry();

  @override
  bool get navigationActive => widget.navigationActive;

  /// Registered focusables.
  List<CsSingleTabStopFocusable> get focusables =>
      List.unmodifiable(_focusables);

  /// The current single tab stop.
  CsSingleTabStopFocusable? getFocusTarget() => _focusTarget;

  /// Whether [node] belongs to a registered focusable.
  bool isRegistered(FocusNode node) => _focusables.any((f) => f.node == node);

  bool _isFocusable(CsSingleTabStopFocusable f) =>
      identical(_focusTarget, f) ||
      (widget.isElementSuppressed?.call(f) ?? false);

  @override
  VoidCallback register(CsSingleTabStopFocusable focusable) {
    _parentUnregister[focusable] = _parent.register(focusable);
    _focusables.add(focusable);
    final now = _isFocusable(focusable);
    if (now != (_state[focusable] ?? false)) {
      _state[focusable] = now;
      focusable._onChange(now);
    }
    widget.onRegisterFocusable?.call(focusable);
    return () {
      _parentUnregister.remove(focusable)?.call();
      _focusables.remove(focusable);
      _state.remove(focusable);
      if (focusable.node.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) widget.onUnregisterActive?.call(focusable);
        });
      }
    };
  }

  /// Picks the next tab stop and notifies changed focusables.
  void updateFocusTarget({bool forceUpdate = false}) {
    _focusTarget = widget.getNextFocusTarget();
    for (final f in List.of(_focusables)) {
      final now = _isFocusable(f);
      if (now != (_state[f] ?? false) || forceUpdate) {
        _state[f] = now;
        f._onChange(now);
      }
    }
  }

  @override
  void resetFocusTarget() => updateFocusTarget(forceUpdate: true);

  bool? _parentWasActive;

  @override
  Widget build(BuildContext context) {
    _parent =
        context.dependOnInheritedWidgetOfExactType<_Scope>()?.registry ??
        const _InactiveRegistry();
    final parentActive = _parent.navigationActive;
    if (_parentWasActive != null && _parentWasActive != parentActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        parentActive ? _parent.resetFocusTarget() : resetFocusTarget();
      });
    }
    _parentWasActive = parentActive;
    return _Scope(registry: parentActive ? _parent : this, child: widget.child);
  }
}

/// Clears single-tab-stop navigation for a subtree (upstream
/// `SingleTabStopNavigationReset`).
class CsSingleTabStopNavigationReset extends StatelessWidget {
  /// Creates the reset.
  const CsSingleTabStopNavigationReset({super.key, required this.child});

  /// The subtree.
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      _Scope(registry: const _InactiveRegistry(), child: child);
}
