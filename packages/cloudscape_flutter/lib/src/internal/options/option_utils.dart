// Port of upstream `internal/components/option/utils/*` and
// `options-list/utils/test-indexes.js`.
import 'package:cloudscape_flutter/src/internal/options/option_definition.dart';

/// Upstream `OptionsFilteringType`.
enum CsOptionsFilteringType {
  /// No filtering.
  none,

  /// Filter by the built-in matcher.
  auto,

  /// The consumer filters (options are used as given).
  manual,
}

/// Upstream `isInteractive`: enabled and not a group header.
bool csIsInteractive(CsDropdownOption? o) =>
    o != null && !o.disabled && o.type != CsDropdownOptionType.parent;

/// Upstream `isGroupInteractive`: enabled (headers included).
bool csIsGroupInteractive(CsDropdownOption? o) => o != null && !o.disabled;

/// The result of [csFlattenOptions].
typedef CsFlatOptions = ({
  List<CsDropdownOption> flatOptions,
  Map<CsDropdownOption, CsDropdownOption> parentMap,
});

/// Upstream `flattenOptions`: groups become a parent row followed by child
/// rows; a group is disabled if it or all its options are.
CsFlatOptions csFlattenOptions(List<CsOptionItem> options) {
  final parentMap = Map<CsDropdownOption, CsDropdownOption>.identity();
  final flat = <CsDropdownOption>[];
  for (final option in options) {
    if (option is CsOptionGroup) {
      final allDisabled = option.options.every((o) => o.disabled);
      final parent = CsDropdownOption(
        type: CsDropdownOptionType.parent,
        option: option,
        disabled: option.disabled || allDisabled,
      );
      flat.add(parent);
      for (final child in option.options) {
        final row = CsDropdownOption(
          type: CsDropdownOptionType.child,
          option: child,
          disabled: option.disabled || child.disabled,
        );
        flat.add(row);
        parentMap[row] = parent;
      }
    } else {
      flat.add(CsDropdownOption(option: option, disabled: option.disabled));
    }
  }
  return (flatOptions: flat, parentMap: parentMap);
}

/// Upstream `matchesString`: case-insensitive substring, or prefix when
/// [strict]. [searchText] must already be lowercase.
bool csMatchesString(String? value, String searchText, {bool strict = false}) {
  if (value == null || value.isEmpty) return false;
  final index = value.toLowerCase().indexOf(searchText);
  return strict ? index == 0 : index > -1;
}

bool _matchesSingle(CsDropdownOption row, String text, bool strict) {
  final o = row.option;
  final fields = [o.value, o.label, o.description, o.labelTag];
  if (fields.any((f) => csMatchesString(f, text, strict: strict))) return true;
  final tagFields = strict ? [o.tags] : [o.tags, o.filteringTags];
  return tagFields.any(
    (tags) =>
        tags?.any((t) => csMatchesString(t, text, strict: strict)) ?? false,
  );
}

/// Upstream `filterOptions`: keeps matching rows; a group header is kept
/// when it matches (then all its children are kept) or before its first
/// matching child.
List<CsDropdownOption> csFilterOptions(
  List<CsDropdownOption> options,
  String searchText, {
  bool strict = false,
}) {
  if (searchText.isEmpty) return options;
  final text = searchText.toLowerCase();
  CsDropdownOption? currentGroup;
  var parentMatched = false;
  final out = <CsDropdownOption>[];
  for (final row in options) {
    if (row.type == CsDropdownOptionType.parent) {
      parentMatched = false;
      currentGroup = row;
      if (_matchesSingle(row, text, strict)) {
        parentMatched = true;
        out.add(row);
      }
      continue;
    }
    if (row.type != CsDropdownOptionType.child) {
      currentGroup = null;
      parentMatched = false;
    }
    if (parentMatched) {
      out.add(row);
    } else if (_matchesSingle(row, text, strict)) {
      if (currentGroup != null) {
        out.add(currentGroup);
        currentGroup = null;
      }
      out.add(row);
    }
  }
  return out;
}

/// Positions used by test utilities (upstream `generateTestIndexes`).
typedef CsOptionTestIndexes = ({
  int? throughIndex,
  int? groupIndex,
  int? inGroupIndex,
});

final Expando<CsOptionTestIndexes> _testIndexes = Expando(
  'csOptionTestIndexes',
);

/// The test indexes assigned to [row] by the last [csPrepareOptions].
CsOptionTestIndexes? csTestOptionIndexes(CsDropdownOption row) =>
    _testIndexes[row];

/// Upstream `generateTestIndexes`.
void csGenerateTestIndexes(
  List<CsDropdownOption> rows,
  CsDropdownOption? Function(CsDropdownOption) parentOf,
) {
  var through = 1;
  var groupIndex = 0;
  var inGroup = 1;
  CsDropdownOption? currentGroup;
  for (final row in rows) {
    final isGroup = row.type == CsDropdownOptionType.parent;
    final group = isGroup ? row : parentOf(row);
    if (group != null && !identical(group, currentGroup)) {
      currentGroup = group;
      groupIndex++;
      inGroup = 1;
    }
    if (isGroup) {
      _testIndexes[row] = (
        throughIndex: null,
        groupIndex: groupIndex,
        inGroupIndex: null,
      );
    } else if (group != null && row.type == CsDropdownOptionType.child) {
      _testIndexes[row] = (
        throughIndex: through++,
        groupIndex: groupIndex,
        inGroupIndex: inGroup++,
      );
    } else if (row.type == CsDropdownOptionType.child || row.type == null) {
      _testIndexes[row] = (
        throughIndex: through++,
        groupIndex: null,
        inGroupIndex: null,
      );
    }
  }
}

/// The result of [csPrepareOptions].
typedef CsPreparedOptions = ({
  List<CsDropdownOption> flatOptions,
  List<CsDropdownOption> filteredOptions,
  Map<CsDropdownOption, CsDropdownOption> parentMap,
  int totalCount,
  int matchesCount,
});

/// Upstream `prepareOptions`.
CsPreparedOptions csPrepareOptions(
  List<CsOptionItem> options,
  CsOptionsFilteringType filteringType,
  String filteringText,
) {
  final flat = csFlattenOptions(options);
  final filtered = filteringType != CsOptionsFilteringType.auto
      ? flat.flatOptions
      : csFilterOptions(flat.flatOptions, filteringText);
  csGenerateTestIndexes(filtered, (r) => flat.parentMap[r]);
  return (
    flatOptions: flat.flatOptions,
    filteredOptions: filtered,
    parentMap: flat.parentMap,
    totalCount: flat.flatOptions.length,
    matchesCount: filtered.length,
  );
}

/// A row of [csUnflattenOptions].
class CsNestedOption {
  /// Creates a nested row.
  CsNestedOption({
    required this.type,
    required this.option,
    required this.index,
    this.children,
  });

  /// Parent (group) or child.
  final CsDropdownOptionType type;

  /// The flat row.
  final CsDropdownOption option;

  /// Index in the flat list.
  final int index;

  /// Children of a parent.
  final List<CsNestedOption>? children;
}

/// Upstream `unflattenOptions`: regroups a flat list, keeping indexes.
List<CsNestedOption> csUnflattenOptions(List<CsDropdownOption> options) {
  final nested = <CsNestedOption>[];
  List<CsNestedOption>? currentChildren;
  for (var i = 0; i < options.length; i++) {
    final o = options[i];
    if (o.type == CsDropdownOptionType.parent) {
      currentChildren = [];
      nested.add(
        CsNestedOption(
          type: CsDropdownOptionType.parent,
          option: o,
          index: i,
          children: currentChildren,
        ),
      );
    } else if (o.type == CsDropdownOptionType.child) {
      (currentChildren ?? nested).add(
        CsNestedOption(type: CsDropdownOptionType.child, option: o, index: i),
      );
    } else {
      currentChildren = null;
      nested.add(
        CsNestedOption(type: CsDropdownOptionType.child, option: o, index: i),
      );
    }
  }
  return nested;
}
