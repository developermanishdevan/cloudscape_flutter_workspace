// `find.csX()` finders: the counterpart of upstream `createWrapper().findX()`.
import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cloudscape_flutter_test/src/driver.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Cloudscape finders on `find`.
extension CsFinders on CommonFinders {
  /// [CsBox] widgets (containing [text], when given).
  Finder csBox({String? text, CsBoxVariant? variant}) => csFindWidget<CsBox>(
    text: text,
    where: variant == null ? null : (w) => w.variant == variant,
  );

  /// [CsSpaceBetween] widgets.
  Finder csSpaceBetween({String? text}) =>
      csFindWidget<CsSpaceBetween>(text: text);

  /// [CsIcon] widgets, by built-in [name] or [customName].
  Finder csIcon({CsIconName? name, String? customName}) => csFindWidget<CsIcon>(
    where: (w) =>
        (name == null || w.name == name) &&
        (customName == null || w.customName == customName),
  );

  /// [CsIconProvider] widgets.
  Finder csIconProvider() => csFindWidget<CsIconProvider>();

  /// [CsLiveRegion] widgets (containing [text], when given). Hidden live
  /// regions are offstage, so they are included.
  Finder csLiveRegion({String? text}) => find.byElementPredicate(
    (e) =>
        e.widget is CsLiveRegion &&
        (text == null || csExtractTextContent(e).contains(text)),
    skipOffstage: false,
  );

  /// [CsNavigableGroup] widgets.
  Finder csNavigableGroup({String? text}) =>
      csFindWidget<CsNavigableGroup>(text: text);

  /// [CsPressable] widgets, by [label]: the semantic label or the visible
  /// text.
  Finder csPressable({String? label}) => find.byElementPredicate((e) {
    final w = e.widget;
    if (w is! CsPressable) return false;
    return label == null ||
        w.semanticLabel == label ||
        csExtractTextContent(e) == label;
  });

  /// [CsDropdown] widgets.
  Finder csDropdown() => csFindWidget<CsDropdown>();

  /// [CsSelectableItem] rows (containing [text], when given).
  Finder csSelectableItem({String? text}) =>
      csFindWidget<CsSelectableItem>(text: text);

  /// [CsOptionsList] widgets.
  Finder csOptionsList() => csFindWidget<CsOptionsList>();

  /// [CsOption] contents, by label (group headers included).
  Finder csOption({String? label}) => csFindWidget<CsOption>(
    where: label == null ? null : (w) => w.option.displayLabel == label,
  );

  /// [CsEditableField] widgets, by accessible [label], [placeholder] or
  /// current [value].
  Finder csEditableField({String? label, String? placeholder, String? value}) =>
      find.byElementPredicate((e) {
        final w = e.widget;
        if (w is! CsEditableField) return false;
        if (label != null && w.ariaLabel != label) return false;
        if (placeholder != null && w.placeholder != placeholder) return false;
        if (value != null) {
          final s = (e as StatefulElement).state as CsEditableFieldState;
          if (s.controller.text != value) return false;
        }
        return true;
      });

  /// [CsTableRoot] widgets, by accessible [label].
  Finder csTableRoot({String? label}) => csFindWidget<CsTableRoot>(
    where: label == null ? null : (w) => w.ariaLabel == label,
  );
}
