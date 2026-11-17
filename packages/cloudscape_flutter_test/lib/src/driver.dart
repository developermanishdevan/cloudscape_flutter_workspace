// Base driver: the Dart counterpart of upstream test-utils' ElementWrapper.
import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Drives one Cloudscape widget in a widget test (upstream test-utils
/// `*Wrapper`).
///
/// [finder] must match the widget; when it matches several, the first is
/// used, like upstream's `findX()`.
abstract class CsDriver<W extends Widget> {
  /// Creates a driver for the first widget matched by [finder].
  CsDriver(this.tester, Finder finder) : finder = finder.first;

  /// The tester.
  final WidgetTester tester;

  /// The widget's finder (first match).
  final Finder finder;

  /// Whether the widget is in the tree.
  bool get exists => finder.evaluate().isNotEmpty;

  /// The widget.
  W get widget => tester.widget<W>(finder);

  /// The widget's element.
  Element get element => tester.element(finder);

  /// Global bounds of the widget.
  Rect get rect => tester.getRect(finder);

  /// Visible text inside the widget (upstream `getElement().textContent`).
  String get text => csExtractTextContent(element);

  /// Finds [matching] inside the widget.
  Finder descendant(Finder matching) =>
      find.descendant(of: finder, matching: matching);
}

/// Finds widgets of type [W], optionally only those containing [text] (or
/// a widget matched by [containing]).
Finder csFindWidget<W extends Widget>({
  String? text,
  Finder? containing,
  bool Function(W widget)? where,
  bool skipOffstage = true,
}) {
  Finder f = find.byWidgetPredicate(
    (w) => w is W && (where == null || where(w)),
    skipOffstage: skipOffstage,
  );
  final inner =
      containing ??
      (text == null
          ? null
          : find.text(text, findRichText: true, skipOffstage: skipOffstage));
  if (inner != null) {
    f = find.ancestor(of: inner, matching: f);
  }
  return f;
}
