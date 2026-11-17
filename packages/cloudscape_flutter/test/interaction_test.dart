import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {TextDirection direction = TextDirection.ltr}) =>
    CsApp(
      home: Directionality(
        textDirection: direction,
        child: Center(child: child),
      ),
    );

Widget _item(
  String label,
  List<String> log, {
  bool disabled = false,
  CsPressableRole role = CsPressableRole.button,
}) => CsPressable(
  key: ValueKey(label),
  role: role,
  disabled: disabled,
  onPressed: () => log.add(label),
  builder: (context, s) =>
      Padding(padding: const EdgeInsets.all(4), child: Text(label)),
);

FocusNode _nodeOf(WidgetTester tester, String label) =>
    Focus.of(tester.element(find.text(label)));

void main() {
  group('focus visible', () {
    testWidgets('keyboard on (not modifiers), pointer off', (tester) async {
      await tester.pumpWidget(_app(_item('A', [])));
      expect(CsFocusVisible.isKeyboard.value, isFalse);
      await tester.sendKeyEvent(LogicalKeyboardKey.shiftLeft);
      expect(CsFocusVisible.isKeyboard.value, isFalse);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      expect(CsFocusVisible.isKeyboard.value, isTrue);
      await tester.tapAt(Offset.zero);
      expect(CsFocusVisible.isKeyboard.value, isFalse);
    });

    testWidgets('the ring shows only for keyboard focus', (tester) async {
      await tester.pumpWidget(_app(_item('A', [])));
      CustomPaint ring() => tester.widget<CustomPaint>(
        find
            .descendant(
              of: find.byType(CsFocusRing),
              matching: find.byType(CustomPaint),
            )
            .first,
      );
      _nodeOf(tester, 'A').requestFocus();
      await tester.pump();
      expect(
        ring().foregroundPainter,
        isNull,
      ); // focused, but no keyboard use yet
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      _nodeOf(tester, 'A').requestFocus();
      await tester.pump();
      expect(ring().foregroundPainter, isNotNull);
    });
  });

  group('CsPressable', () {
    testWidgets('pointer, Enter (down) and Space (up) activate', (
      tester,
    ) async {
      final log = <String>[];
      await tester.pumpWidget(_app(_item('A', log)));
      await tester.tap(find.text('A'));
      expect(log, ['A']);
      _nodeOf(tester, 'A').requestFocus();
      await tester.pump();
      await tester.sendKeyDownEvent(LogicalKeyboardKey.enter);
      expect(log, ['A', 'A']);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.enter);
      await tester.sendKeyDownEvent(LogicalKeyboardKey.space);
      expect(log, hasLength(2)); // not yet: buttons fire Space on key up
      await tester.sendKeyUpEvent(LogicalKeyboardKey.space);
      expect(log, hasLength(3));
    });

    testWidgets('links ignore Space; disabled items do nothing', (
      tester,
    ) async {
      final log = <String>[];
      await tester.pumpWidget(
        _app(
          Column(
            children: [
              _item('L', log, role: CsPressableRole.link),
              _item('D', log, disabled: true),
            ],
          ),
        ),
      );
      _nodeOf(tester, 'L').requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      expect(log, isEmpty);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      expect(log, ['L']);
      await tester.tap(find.text('D'));
      expect(log, ['L']);
      expect(_nodeOf(tester, 'D').canRequestFocus, isFalse);
    });

    testWidgets('exposes button semantics', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_app(_item('Save', [])));
      expect(
        tester.getSemantics(find.text('Save')),
        matchesSemantics(
          label: 'Save',
          isButton: true,
          isEnabled: true,
          hasEnabledState: true,
          isFocusable: true,
          hasTapAction: true,
          hasFocusAction: true,
        ),
      );
      handle.dispose();
    });
  });

  group('CsNavigableGroup', () {
    Widget group(
      List<String> log, {
      CsNavigationDirection direction = CsNavigationDirection.horizontal,
      bool disableB = false,
    }) => CsNavigableGroup(
      navigationDirection: direction,
      child: Row(
        children: [
          _item('A', log),
          _item('B', log, disabled: disableB),
          _item('C', log),
        ],
      ),
    );

    testWidgets('only one tab stop; arrows, Home/End and wrap-around move it', (
      tester,
    ) async {
      await tester.pumpWidget(_app(group([])));
      await tester.pump();
      expect(
        [
          for (final l in ['A', 'B', 'C']) _nodeOf(tester, l).skipTraversal,
        ],
        [false, true, true],
      );
      _nodeOf(tester, 'A').requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      expect(_nodeOf(tester, 'B').hasPrimaryFocus, isTrue);
      expect(
        [
          for (final l in ['A', 'B', 'C']) _nodeOf(tester, l).skipTraversal,
        ],
        [true, false, true],
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.end);
      await tester.pump();
      expect(_nodeOf(tester, 'C').hasPrimaryFocus, isTrue);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      expect(_nodeOf(tester, 'A').hasPrimaryFocus, isTrue); // wraps
      await tester.sendKeyEvent(LogicalKeyboardKey.home);
      await tester.pump();
      expect(_nodeOf(tester, 'A').hasPrimaryFocus, isTrue);
    });

    testWidgets('RTL mirrors left/right; disabled items are skipped', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(group([], disableB: true), direction: TextDirection.rtl),
      );
      await tester.pump();
      _nodeOf(tester, 'A').requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft); // = next in RTL
      await tester.pump();
      expect(_nodeOf(tester, 'C').hasPrimaryFocus, isTrue);
    });

    testWidgets('off-axis arrows and modifiers are ignored', (tester) async {
      await tester.pumpWidget(_app(group([])));
      await tester.pump();
      _nodeOf(tester, 'A').requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      expect(_nodeOf(tester, 'A').hasPrimaryFocus, isTrue);
      await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
      await tester.pump();
      expect(_nodeOf(tester, 'A').hasPrimaryFocus, isTrue);
    });

    testWidgets('vertical groups use up/down', (tester) async {
      await tester.pumpWidget(
        _app(group([], direction: CsNavigationDirection.vertical)),
      );
      await tester.pump();
      _nodeOf(tester, 'A').requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      expect(_nodeOf(tester, 'B').hasPrimaryFocus, isTrue);
    });

    testWidgets(
      'focus() focuses the tab stop; removing the focused item moves focus',
      (tester) async {
        final key = GlobalKey<CsNavigableGroupState>();
        var showB = true;
        late StateSetter set;
        await tester.pumpWidget(
          _app(
            StatefulBuilder(
              builder: (context, setState) {
                set = setState;
                return CsNavigableGroup(
                  key: key,
                  child: Row(
                    children: [
                      _item('A', []),
                      if (showB) _item('B', []),
                      _item('C', []),
                    ],
                  ),
                );
              },
            ),
          ),
        );
        await tester.pump();
        key.currentState!.focus();
        await tester.pump();
        expect(_nodeOf(tester, 'A').hasPrimaryFocus, isTrue);
        await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
        await tester.pump();
        expect(_nodeOf(tester, 'B').hasPrimaryFocus, isTrue);
        set(() => showB = false);
        await tester.pump();
        await tester.pump();
        expect(
          _nodeOf(tester, 'A').hasPrimaryFocus ||
              _nodeOf(tester, 'C').hasPrimaryFocus,
          isTrue,
        );
      },
    );
  });

  group('CsLiveRegion', () {
    final announced = <(String, Assertiveness)>[];
    setUp(() {
      announced.clear();
      CsLiveRegionController.debugOnAnnounce = (m, a) => announced.add((m, a));
    });
    tearDown(() => CsLiveRegionController.debugOnAnnounce = null);

    Widget region(
      String text, {
      bool hidden = false,
      bool assertive = false,
      bool prevent = false,
      Key? key,
    }) => CsLiveRegion(
      key: key,
      delay: 0,
      hidden: hidden,
      assertive: assertive,
      preventInitialAnnouncement: prevent,
      child: Text(text),
    );

    testWidgets(
      'announces content; deduplicates; reannounce toggles a period',
      (tester) async {
        final key = GlobalKey<CsLiveRegionState>();
        await tester.pumpWidget(_app(region('3 items', key: key)));
        await tester.pump();
        expect(announced.map((a) => a.$1), ['3 items']);
        await tester.pumpWidget(_app(region('3 items', key: key)));
        await tester.pump();
        expect(announced, hasLength(1)); // unchanged → not repeated
        key.currentState!.reannounce();
        expect(announced.last.$1, '3 items.');
        key.currentState!.reannounce();
        expect(announced.last.$1, '3 items');
        await tester.pumpWidget(_app(region('4 items', key: key)));
        await tester.pump();
        expect(announced.last.$1, '4 items');
      },
    );

    testWidgets(
      'hidden content is announced but not shown; assertive politeness',
      (tester) async {
        await tester.pumpWidget(
          _app(region('Saved', hidden: true, assertive: true)),
        );
        await tester.pump();
        expect(announced.single, ('Saved', Assertiveness.assertive));
        expect(find.text('Saved').hitTestable(), findsNothing);
      },
    );

    testWidgets('preventInitialAnnouncement and sources', (tester) async {
      await tester.pumpWidget(_app(region('Initial', prevent: true)));
      await tester.pump();
      expect(announced, isEmpty);
      await tester.pumpWidget(
        _app(
          const CsLiveRegion(
            delay: 0,
            sources: ['Page', null, '2'],
            child: Text('ignored'),
          ),
        ),
      );
      await tester.pump();
      expect(announced.last.$1, 'Page 2');
    });

    testWidgets('throttles with the default 1 second delay', (tester) async {
      await tester.pumpWidget(_app(const CsLiveRegion(child: Text('a'))));
      await tester.pump();
      expect(announced, isEmpty);
      await tester.pump(const Duration(seconds: 1));
      expect(announced.single.$1, 'a');
    });
  });
}
