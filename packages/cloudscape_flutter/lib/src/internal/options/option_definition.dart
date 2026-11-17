// Port of upstream `types/option.d.ts` and the internal `DropdownOption`.
import 'package:cloudscape_flutter/src/icon/generated/icons.g.dart';
import 'package:flutter/widgets.dart';

/// Fields shared by options and option groups (upstream `BaseOption`).
@immutable
sealed class CsOptionItem {
  const CsOptionItem({
    this.value,
    this.label,
    this.labelContent,
    this.lang,
    this.description,
    this.disabled = false,
    this.disabledReason,
    this.labelTag,
    this.tags,
    this.filteringTags,
    this.iconAlt,
    this.iconAriaLabel,
    this.iconName,
    this.iconUrl,
    this.iconSvg,
  });

  /// Value (also the fallback label).
  final String? value;

  /// Label text.
  final String? label;

  /// Custom label content (replaces [label] in the list).
  final Widget? labelContent;

  /// Language of the label.
  final String? lang;

  /// Secondary text.
  final String? description;

  /// Not selectable.
  final bool disabled;

  /// Why it is disabled (shown in a tooltip by components).
  final String? disabledReason;

  /// Text at the end of the label row.
  final String? labelTag;

  /// Tags under the label.
  final List<String>? tags;

  /// Tags shown only when they match the filter.
  final List<String>? filteringTags;

  /// Alternative text for [iconUrl].
  final String? iconAlt;

  /// Accessible icon label.
  final String? iconAriaLabel;

  /// Built-in icon.
  final CsIconName? iconName;

  /// Icon image URL.
  final String? iconUrl;

  /// Custom icon.
  final Widget? iconSvg;

  /// Upstream `option.label ?? option.value`.
  String? get displayLabel => label ?? value;
}

/// One selectable option (upstream `OptionDefinition`).
final class CsOptionDefinition extends CsOptionItem {
  /// Creates an option.
  const CsOptionDefinition({
    super.value,
    super.label,
    super.labelContent,
    super.lang,
    super.description,
    super.disabled,
    super.disabledReason,
    super.labelTag,
    super.tags,
    super.filteringTags,
    super.iconAlt,
    super.iconAriaLabel,
    super.iconName,
    super.iconUrl,
    super.iconSvg,
    this.labelPrefix,
    this.customIcon,
  });

  /// Internal: bold prefix before the label (upstream `__labelPrefix`).
  final String? labelPrefix;

  /// Internal: replaces the icon (upstream `__customIcon`).
  final Widget? customIcon;
}

/// A titled group of options (upstream `OptionGroup`).
final class CsOptionGroup extends CsOptionItem {
  /// Creates a group.
  const CsOptionGroup({
    required this.options,
    super.value,
    super.label,
    super.labelContent,
    super.lang,
    super.description,
    super.disabled,
    super.disabledReason,
    super.labelTag,
    super.tags,
    super.filteringTags,
    super.iconAlt,
    super.iconAriaLabel,
    super.iconName,
    super.iconUrl,
    super.iconSvg,
  });

  /// The group's options.
  final List<CsOptionDefinition> options;
}

/// Row kinds in a flattened list (upstream `DropdownOption.type`).
enum CsDropdownOptionType {
  /// A group header.
  parent,

  /// An option inside a group, or a top-level option.
  child,

  /// "Select all" row (multiselect).
  selectAll,

  /// `Use: <text>` row (autosuggest).
  useEntered,
}

/// One row of a flattened option list (upstream `DropdownOption`). Identity
/// matters: highlight and parent maps key on the instance.
class CsDropdownOption {
  /// Creates a row.
  CsDropdownOption({
    required this.option,
    this.type,
    this.disabled = false,
    this.disabledReason,
    this.afterHeader = false,
  });

  /// Kind; null for top-level options (upstream leaves it undefined).
  final CsDropdownOptionType? type;

  /// The option or group.
  final CsOptionItem option;

  /// Disabled (the option, its group, or all of a group's options).
  final bool disabled;

  /// Why it is disabled.
  final String? disabledReason;

  /// Rendered right after a sticky header.
  final bool afterHeader;

  @override
  String toString() =>
      'CsDropdownOption(${type?.name ?? 'top'}, ${option.displayLabel}${disabled ? ', disabled' : ''})';
}
