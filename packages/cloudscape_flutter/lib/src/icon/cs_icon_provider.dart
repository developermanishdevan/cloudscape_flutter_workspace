import 'package:cloudscape_flutter/src/icon/generated/icons.g.dart';
import 'package:flutter/widgets.dart';

/// Upstream table sorting states, for [CsTableIcons.sortingIndicator].
enum CsSortingState {
  /// Sortable but not sorted.
  sortable,

  /// Sorted ascending.
  ascending,

  /// Sorted descending.
  descending,
}

/// Components whose icons can be customized via [CsComponentIcons].
enum CsIconComponent {
  /// Table.
  table,

  /// Tree view.
  treeView,

  /// Expandable section.
  expandableSection,
}

/// Custom table icons (upstream `IconProviderProps.TableIcons`).
@immutable
class CsTableIcons {
  /// Creates table icons; null builders keep the inherited/built-in icon.
  const CsTableIcons({this.expandToggle, this.sortingIndicator});

  /// Expand toggle icon for expandable rows.
  final Widget Function(bool expanded)? expandToggle;

  /// Sorting indicator in header cells.
  final Widget Function(CsSortingState state)? sortingIndicator;

  CsTableIcons _merge(CsTableIcons? closer) => CsTableIcons(
    expandToggle: closer?.expandToggle ?? expandToggle,
    sortingIndicator: closer?.sortingIndicator ?? sortingIndicator,
  );
}

/// Custom expand-toggle icon (tree view, expandable section).
@immutable
class CsExpandToggleIcons {
  /// Creates the icon set; null keeps the inherited/built-in icon.
  const CsExpandToggleIcons({this.expandToggle});

  /// Expand toggle icon.
  final Widget Function(bool expanded)? expandToggle;

  CsExpandToggleIcons _merge(CsExpandToggleIcons? closer) =>
      CsExpandToggleIcons(expandToggle: closer?.expandToggle ?? expandToggle);
}

/// Per-component custom icons (upstream `IconProviderProps.ComponentIcons`).
@immutable
class CsComponentIcons {
  /// Creates component icons. Components in [remove] drop inherited custom
  /// icons (upstream `null` per component).
  const CsComponentIcons({
    this.table,
    this.treeView,
    this.expandableSection,
    this.remove = const {},
  });

  /// Table icons.
  final CsTableIcons? table;

  /// Tree view icons.
  final CsExpandToggleIcons? treeView;

  /// Expandable section icons.
  final CsExpandToggleIcons? expandableSection;

  /// Components whose inherited custom icons are removed.
  final Set<CsIconComponent> remove;

  /// No custom component icons.
  static const CsComponentIcons none = CsComponentIcons();

  CsComponentIcons _mergedWith(CsComponentIcons closer) {
    T? pick<T>(
      CsIconComponent c,
      T? inherited,
      T? value,
      T Function(T, T?) merge,
    ) {
      if (closer.remove.contains(c)) return null;
      if (value == null) return inherited;
      return inherited == null ? value : merge(inherited, value);
    }

    return CsComponentIcons(
      table: pick(
        CsIconComponent.table,
        table,
        closer.table,
        (a, b) => a._merge(b),
      ),
      treeView: pick(
        CsIconComponent.treeView,
        treeView,
        closer.treeView,
        (a, b) => a._merge(b),
      ),
      expandableSection: pick(
        CsIconComponent.expandableSection,
        expandableSection,
        closer.expandableSection,
        (a, b) => a._merge(b),
      ),
    );
  }
}

class _CsIconScope extends InheritedTheme {
  const _CsIconScope({
    required this.icons,
    required this.componentIcons,
    required super.child,
  });

  final Map<String, Widget> icons;
  final CsComponentIcons componentIcons;

  // An InheritedTheme so overlays inserted above the app (selection
  // handles, text context menus, magnifiers) keep the Cloudscape context.
  @override
  Widget wrap(BuildContext context, Widget child) =>
      _CsIconScope(icons: icons, componentIcons: componentIcons, child: child);

  @override
  bool updateShouldNotify(_CsIconScope old) =>
      !identical(old.icons, icons) ||
      !identical(old.componentIcons, componentIcons);
}

/// Replaces built-in icons or registers custom ones for a subtree
/// (upstream `IconProvider`). Nested providers merge with their parents.
class CsIconProvider extends StatelessWidget {
  /// Creates an icon provider.
  ///
  /// In [icons], a widget overrides or defines the icon with that name and
  /// `null` resets it (built-in icons to their default, custom icons to the
  /// inherited value). [resetIcons] drops every inherited override (upstream
  /// `icons={null}`); [resetComponentIcons] does the same for component icons.
  const CsIconProvider({
    super.key,
    this.icons,
    this.resetIcons = false,
    this.componentIcons,
    this.resetComponentIcons = false,
    required this.child,
  });

  /// Icon overrides by upstream name (see [CsIconName.id]) or custom name.
  final Map<String, Widget?>? icons;

  /// Drops all inherited icon overrides.
  final bool resetIcons;

  /// Per-component custom icons.
  final CsComponentIcons? componentIcons;

  /// Drops all inherited component icons.
  final bool resetComponentIcons;

  /// The subtree.
  final Widget child;

  static _CsIconScope? _scope(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_CsIconScope>();

  /// The override or custom icon registered for [name], or null to use the
  /// built-in artwork.
  static Widget? iconOf(BuildContext context, String name) =>
      _scope(context)?.icons[name];

  /// The custom component icons in scope.
  static CsComponentIcons componentIconsOf(BuildContext context) =>
      _scope(context)?.componentIcons ?? CsComponentIcons.none;

  @override
  Widget build(BuildContext context) {
    final parent = _scope(context);
    final inherited = parent?.icons ?? const <String, Widget>{};
    Map<String, Widget> provided;
    if (resetIcons) {
      provided = const {};
    } else if (icons != null) {
      provided = {...inherited};
      for (final e in icons!.entries) {
        final value = e.value;
        if (value != null) {
          provided[e.key] = value;
        } else if (CsIconName.byId(e.key) != null) {
          provided.remove(e.key); // back to the built-in artwork
        }
        // A null custom icon keeps the inherited value.
      }
    } else {
      provided = inherited;
    }
    final inheritedComponents = parent?.componentIcons ?? CsComponentIcons.none;
    final components = resetComponentIcons
        ? CsComponentIcons.none
        : componentIcons == null
        ? inheritedComponents
        : inheritedComponents._mergedWith(componentIcons!);
    return _CsIconScope(
      icons: provided,
      componentIcons: components,
      child: child,
    );
  }
}
