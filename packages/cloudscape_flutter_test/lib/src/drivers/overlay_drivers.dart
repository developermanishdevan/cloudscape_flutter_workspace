// Drivers for the dropdown and option lists.
import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cloudscape_flutter_test/src/driver.dart';
import 'package:cloudscape_flutter_test/src/finders.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Drives a [CsDropdown] (upstream internal `DropdownWrapper`).
class CsDropdownDriver extends CsDriver<CsDropdown> {
  /// Drives the first dropdown matched by [finder].
  CsDropdownDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csDropdown());

  /// The `open` prop.
  bool get isOpen => widget.open;

  /// The trigger.
  Finder get trigger => descendant(find.byWidget(widget.trigger));

  /// The open panel's content (upstream `findContent()`), or nothing when
  /// closed.
  Finder get content => _slot(widget.content);

  /// The open panel's header.
  Finder get header => _slot(widget.header);

  /// The open panel's footer.
  Finder get footer => _slot(widget.footer);

  Finder _slot(Widget? w) => w == null || !isOpen
      ? find.byWidgetPredicate((_) => false)
      : descendant(find.byWidget(w));

  /// Global bounds of the open panel's content.
  Rect get panelRect => tester.getRect(content);

  /// Clicks the trigger.
  Future<void> clickTrigger() async {
    await tester.tap(trigger, warnIfMissed: false);
    await tester.pumpAndSettle();
  }

  /// Clicks outside the trigger and panel (fires `onOutsideClick`).
  Future<void> clickOutside([Offset at = const Offset(1, 1)]) async {
    await tester.tapAt(at, kind: PointerDeviceKind.mouse);
    await tester.pumpAndSettle();
  }

  /// Presses Escape (fires `onEscape`).
  Future<void> pressEscape() async {
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
  }
}

/// Drives a [CsSelectableItem] row.
class CsSelectableItemDriver extends CsDriver<CsSelectableItem> {
  /// Drives the first row matched by [finder].
  CsSelectableItemDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csSelectableItem());

  /// Selected.
  bool get isSelected => widget.selected;

  /// Highlighted.
  bool get isHighlighted => widget.highlighted;

  /// Disabled.
  bool get isDisabled => widget.disabled;

  /// A group header row.
  bool get isGroupHeader => widget.isParent;
}

/// Drives one [CsOption] (upstream internal `OptionWrapper`).
class CsOptionDriver extends CsDriver<CsOption> {
  /// Drives the first option matched by [finder].
  CsOptionDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csOption());

  CsOptionItem get _o => widget.option;

  /// The option value.
  String? get value => _o.value;

  /// The label (upstream `findLabel()`).
  String? get label => _o.displayLabel;

  /// The description.
  String? get description => _o.description;

  /// The label tag.
  String? get labelTag => _o.labelTag;

  /// The tags.
  List<String> get tags => _o.tags ?? const [];

  /// Filtering tags shown because they match the filter.
  List<String> get visibleFilteringTags => [
    for (final t in _o.filteringTags ?? const <String>[])
      if (find
          .descendant(of: finder, matching: find.text(t, findRichText: true))
          .evaluate()
          .isNotEmpty)
        t,
  ];

  /// Disabled.
  bool get isDisabled => _o.disabled;

  /// A group header.
  bool get isGroup => widget.isGroupOption;

  CsSelectableItemDriver? get _row {
    final f = find.ancestor(
      of: finder,
      matching: find.byType(CsSelectableItem),
    );
    return f.evaluate().isEmpty ? null : CsSelectableItemDriver(tester, f);
  }

  /// Highlighted (from the row).
  bool get isHighlighted => _row?.isHighlighted ?? widget.highlightedOption;

  /// Selected (from the row).
  bool get isSelected => _row?.isSelected ?? widget.selectedOption;

  /// The parts of the label shown as filter matches.
  List<String> get highlightedMatches {
    final out = <String>[];
    for (final e in descendant(find.byType(RichText)).evaluate()) {
      (e.widget as RichText).text.visitChildren((span) {
        if (span is TextSpan &&
            span.text != null &&
            span.style?.backgroundColor != null) {
          out.add(span.text!);
        }
        return true;
      });
    }
    return out;
  }

  /// Clicks the option.
  Future<void> click() async {
    await tester.tap(finder, warnIfMissed: false);
    await tester.pump();
  }

  /// Hovers the option; returns the gesture.
  Future<TestGesture> hover() async {
    final g = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await g.addPointer(location: tester.getCenter(finder));
    await g.moveTo(tester.getCenter(finder));
    await tester.pump();
    return g;
  }
}

/// Drives a [CsOptionsList] (upstream internal `OptionsListWrapper`).
///
/// Indexes are 1-based like upstream test-utils: [option] counts options
/// across groups (group headers excluded), [optionInGroup] counts within a
/// group.
class CsOptionsListDriver extends CsDriver<CsOptionsList> {
  /// Drives the first list matched by [finder].
  CsOptionsListDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csOptionsList());

  List<Element> get _optionElements =>
      descendant(find.byType(CsOption)).evaluate().toList();

  /// All built rows (options and group headers), in order.
  List<CsOptionDriver> get rows => [
    for (var i = 0; i < _optionElements.length; i++)
      CsOptionDriver(tester, descendant(find.byType(CsOption)).at(i)),
  ];

  /// Options (group headers excluded), in order (upstream `findOptions()`).
  List<CsOptionDriver> get options => [
    for (final r in rows)
      if (!r.isGroup) r,
  ];

  /// Group headers (upstream `findGroups()`).
  List<CsOptionDriver> get groups => [
    for (final r in rows)
      if (r.isGroup) r,
  ];

  /// The [n]th option, 1-based (upstream `findOption(n)`).
  CsOptionDriver option(int n) => options[n - 1];

  /// The [n]th option of the [group]th group, both 1-based (upstream
  /// `findOptionInGroup(g, n)`).
  CsOptionDriver optionInGroup(int group, int n) {
    var g = 0;
    var inGroup = 0;
    for (final r in rows) {
      if (r.isGroup) {
        g++;
        inGroup = 0;
        continue;
      }
      if (g == group) {
        inGroup++;
        if (inGroup == n) return r;
      }
    }
    throw StateError('No option $n in group $group');
  }

  /// The option with [label].
  CsOptionDriver optionByLabel(String label) =>
      options.firstWhere((o) => o.label == label);

  /// The highlighted option (upstream `findHighlightedOption()`), or null.
  CsOptionDriver? get highlightedOption {
    for (final o in options) {
      if (o.isHighlighted) return o;
    }
    return null;
  }

  /// Selected options (upstream `findSelectedOptions()`).
  List<CsOptionDriver> get selectedOptions => [
    for (final o in options)
      if (o.isSelected) o,
  ];

  /// Focuses the list and presses [key].
  Future<void> press(LogicalKeyboardKey key) async {
    if (widget.focusNode != null && !widget.focusNode!.hasFocus) {
      widget.focusNode!.requestFocus();
      await tester.pump();
    }
    await tester.sendKeyEvent(key);
    await tester.pump();
  }
}
