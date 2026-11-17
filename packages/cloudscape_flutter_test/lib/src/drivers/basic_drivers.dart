// Drivers for layout, display and utility components.
import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cloudscape_flutter_test/src/driver.dart';
import 'package:cloudscape_flutter_test/src/finders.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// The focus node of the first [Focus] inside [finder].
///
/// Looks it up from inside the Focus' own scope without registering a
/// dependency (tests are not building).
FocusNode csFocusNodeIn(WidgetTester tester, Finder finder) {
  final focus = find.descendant(of: finder, matching: find.byType(Focus)).first;
  return csFocusNodeOf(tester.element(focus));
}

/// The focus node of the [Focus] widget [focusElement].
FocusNode csFocusNodeOf(Element focusElement) {
  Element? scope;
  focusElement.visitChildren((e) => scope ??= e);
  Element? inside;
  scope!.visitChildren((e) => inside ??= e);
  return Focus.of(inside ?? scope!, createDependency: false);
}

/// Drives a [CsBox].
class CsBoxDriver extends CsDriver<CsBox> {
  /// Drives the first box matched by [finder] (default: the first box).
  CsBoxDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csBox());

  /// The variant.
  CsBoxVariant get variant => widget.variant;

  /// The resolved text style of the content.
  TextStyle get textStyle {
    final texts = descendant(find.byType(RichText));
    return tester.widget<RichText>(texts.first).text.style ?? const TextStyle();
  }
}

/// Drives a [CsSpaceBetween].
class CsSpaceBetweenDriver extends CsDriver<CsSpaceBetween> {
  /// Drives the first space-between matched by [finder].
  CsSpaceBetweenDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csSpaceBetween());

  /// The non-null children, in order (upstream `findItems()`).
  List<Widget> get items => [...widget.children.whereType<Widget>()];

  /// Global bounds of each item.
  List<Rect> get itemRects => [
    for (final w in items) tester.getRect(find.byWidget(w).first),
  ];
}

/// Drives a [CsIcon].
class CsIconDriver extends CsDriver<CsIcon> {
  /// Drives the first icon matched by [finder].
  CsIconDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csIcon());

  /// Built-in name.
  CsIconName? get name => widget.name;

  /// Custom (provider) name.
  String? get customName => widget.customName;

  /// Size prop.
  CsIconSize get size => widget.size;

  /// Variant prop.
  CsIconVariant get variant => widget.variant;

  /// Rendered size.
  Size get renderedSize => tester.getSize(finder);

  /// Accessible label, if any.
  String? get semanticsLabel {
    final data = tester.getSemantics(finder);
    return data.label.isEmpty ? null : data.label;
  }
}

/// Drives a [CsIconProvider].
class CsIconProviderDriver extends CsDriver<CsIconProvider> {
  /// Drives the first provider matched by [finder].
  CsIconProviderDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csIconProvider());

  /// Icons registered or overridden by this provider.
  Iterable<String> get iconNames => widget.icons?.keys ?? const [];

  /// Icons inside this provider.
  List<CsIconDriver> get icons => [
    for (var i = 0; i < descendant(find.byType(CsIcon)).evaluate().length; i++)
      CsIconDriver(tester, descendant(find.byType(CsIcon)).at(i)),
  ];
}

/// Drives a [CsLiveRegion].
class CsLiveRegionDriver extends CsDriver<CsLiveRegion> {
  /// Drives the first live region matched by [finder].
  CsLiveRegionDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csLiveRegion());

  /// Assertive (`aria-live="assertive"`).
  bool get isAssertive => widget.assertive;

  /// Visually hidden.
  bool get isHidden => widget.hidden;
}

/// Drives a [CsNavigableGroup].
class CsNavigableGroupDriver extends CsDriver<CsNavigableGroup> {
  /// Drives the first group matched by [finder].
  CsNavigableGroupDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csNavigableGroup());

  /// The focused item's text inside the group, or null.
  String? get focusedText {
    final focused = FocusManager.instance.primaryFocus?.context;
    if (focused == null) return null;
    var inside = false;
    focused.visitAncestorElements((a) {
      if (a == element) inside = true;
      return !inside;
    });
    if (!inside) return null;
    return csExtractTextContent(focused as Element);
  }

  /// Focuses the group's tab stop (Tab into it).
  Future<void> focus() async {
    final pressables = descendant(find.byType(CsPressable));
    csFocusNodeIn(tester, pressables.first).requestFocus();
    await tester.pump();
  }

  /// Presses an arrow (or Home / End) key.
  Future<void> press(LogicalKeyboardKey key) async {
    await tester.sendKeyEvent(key);
    await tester.pump();
  }
}

/// Drives a [CsPressable].
class CsPressableDriver extends CsDriver<CsPressable> {
  /// Drives the first pressable matched by [finder].
  CsPressableDriver(WidgetTester tester, [Finder? finder])
    : super(tester, finder ?? find.csPressable());

  /// Disabled.
  bool get isDisabled => widget.disabled;

  /// Has focus.
  bool get isFocused => csFocusNodeIn(tester, finder).hasFocus;

  /// Clicks it (upstream `click()`).
  Future<void> click() async {
    await tester.tap(finder, warnIfMissed: false);
    await tester.pump();
  }

  /// Moves a mouse over it; returns the gesture (remove it when done).
  Future<TestGesture> hover() async {
    final g = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await g.addPointer(location: tester.getCenter(finder));
    await tester.pump();
    return g;
  }

  /// Focuses it.
  Future<void> focus() async {
    csFocusNodeIn(tester, finder).requestFocus();
    await tester.pump();
  }

  /// Focuses it and presses [key] (Enter or Space activate).
  Future<void> pressKey(LogicalKeyboardKey key) async {
    await focus();
    await tester.sendKeyEvent(key);
    await tester.pump();
  }
}
