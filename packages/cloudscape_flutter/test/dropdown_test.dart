import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

const _screen = Rect.fromLTWH(0, 0, 1000, 800);

void main() {
  group('geometry (upstream fit handler)', () {
    test('room below and to the end: drops down, start-aligned, ideal width, cropped rows', () {
      final p = csDropdownPosition(
        trigger: const Rect.fromLTWH(100, 100, 200, 32),
        overflowParents: [_screen],
        requiredWidth: 260,
        dropdownHeight: 300,
      );
      expect(p.dropBlockStart, isFalse);
      expect(p.dropInlineStart, isFalse);
      expect(p.inlineSize, 260);
      // blockEnd = 800 - 132 - 50 = 618 → floor(618/31)*31 + 16
      expect(p.blockSize, (618 / 31).floor() * 31 + 16);
    });

    test('flips up when there is less room below than above', () {
      final p = csDropdownPosition(
        trigger: const Rect.fromLTWH(100, 700, 200, 32),
        overflowParents: [_screen],
        requiredWidth: 200,
        dropdownHeight: 300,
      );
      expect(p.dropBlockStart, isTrue);
      expect(p.blockSize, ((700 - 50) / 31).floor() * 31 + 16);
    });

    test('aligns to the trigger end near the inline end; biggest side when neither fits', () {
      final end = csDropdownPosition(
        trigger: const Rect.fromLTWH(800, 100, 150, 32),
        overflowParents: [_screen],
        requiredWidth: 300,
        dropdownHeight: 100,
      );
      expect(end.dropInlineStart, isTrue);
      final neither = csDropdownPosition(
        trigger: const Rect.fromLTWH(400, 100, 100, 32),
        overflowParents: [_screen],
        requiredWidth: 900,
        dropdownHeight: 100,
        minWidth: const CsDropdownWidth.px(700),
      );
      // inlineStart = 500-50 = 450, inlineEnd = 1000-400-50 = 550 → max(550, 700)
      expect(neither.dropInlineStart, isFalse);
      expect(neither.inlineSize, 700);
    });

    test('width constraints: min/max px and trigger', () {
      final p = csDropdownPosition(
        trigger: const Rect.fromLTWH(100, 100, 200, 32),
        overflowParents: [_screen],
        requiredWidth: 120,
        dropdownHeight: 100,
        minWidth: CsDropdownWidth.trigger,
      );
      expect(p.inlineSize, 200);
      final capped = csDropdownPosition(
        trigger: const Rect.fromLTWH(100, 100, 200, 32),
        overflowParents: [_screen],
        requiredWidth: 500,
        dropdownHeight: 100,
        maxWidth: const CsDropdownWidth.px(320),
      );
      expect(capped.inlineSize, 320);
    });

    test('preferCenter centers when both sides have room; maxHeight caps', () {
      final p = csDropdownPosition(
        trigger: const Rect.fromLTWH(400, 100, 100, 32),
        overflowParents: [_screen],
        requiredWidth: 300,
        dropdownHeight: 100,
        preferCenter: true,
        maxHeight: 120,
      );
      expect(p.insetInlineStart, -100);
      expect(p.blockSize, 120);
    });

    test(
      'stretchHeight uses all space without row cropping; mobile reserves',
      () {
        final s = csDropdownPosition(
          trigger: const Rect.fromLTWH(0, 100, 100, 32),
          overflowParents: [_screen],
          requiredWidth: 100,
          dropdownHeight: 10,
          stretchHeight: true,
        );
        expect(s.blockSize, 800 - 132);
        final m = csDropdownAvailableSpace(
          trigger: const Rect.fromLTWH(0, 100, 100, 32),
          overflowParents: [_screen],
          isMobile: true,
        );
        expect(m.blockEnd, 800 - 132 - csDropdownReserveMobileVertical);
        expect(m.inlineEnd, 1000 - 0 - csDropdownReserveMobileHorizontal);
      },
    );

    test('the tightest overflow parent wins', () {
      final s = csDropdownAvailableSpace(
        trigger: const Rect.fromLTWH(100, 100, 100, 32),
        overflowParents: [const Rect.fromLTWH(50, 50, 300, 200), _screen],
      );
      expect(s.blockEnd, 200 - (132 - 50) - 50);
      expect(s.inlineEnd, 50 + 300 - 100 - 50);
    });

    test('interior fly-out sits beside the trigger', () {
      final p = csInteriorDropdownPosition(
        trigger: const Rect.fromLTWH(100, 100, 150, 30),
        overflowParents: [_screen],
        dropdownWidth: 200,
        dropdownHeight: 100,
      );
      expect(p.dropInlineStart, isFalse);
      expect(p.insetInlineStart, 150);
      final flipped = csInteriorDropdownPosition(
        trigger: const Rect.fromLTWH(700, 100, 150, 30),
        overflowParents: [_screen],
        dropdownWidth: 200,
        dropdownHeight: 100,
      );
      expect(flipped.dropInlineStart, isTrue);
      expect(flipped.insetInlineStart, -200);
    });

    test('flexible width check', () {
      expect(
        csHasEnoughSpaceForFlexibleWidth(
          trigger: const Rect.fromLTWH(400, 100, 100, 32),
          overflowParents: [_screen],
          requiredWidth: 900,
        ),
        isFalse,
      );
      expect(
        csHasEnoughSpaceForFlexibleWidth(
          trigger: const Rect.fromLTWH(400, 100, 100, 32),
          overflowParents: [_screen],
          requiredWidth: 300,
        ),
        isTrue,
      );
    });
  });

  group('CsDropdown', () {
    Future<void> pump(
      WidgetTester tester,
      Widget dropdown, {
      Alignment at = Alignment.topLeft,
    }) async {
      tester.view.physicalSize = const Size(1000, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        CsApp(
          theme: const CsThemeData(motion: CsMotionMode.disabled),
          home: Align(
            alignment: at,
            child: Padding(padding: const EdgeInsets.all(60), child: dropdown),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    Widget trigger([String text = 'Trigger']) =>
        SizedBox(width: 120, height: 32, child: Text(text));

    testWidgets(
      'closed shows nothing; open shows the panel below, start-aligned',
      (tester) async {
        await pump(
          tester,
          CsDropdown(
            trigger: trigger(),
            content: const SizedBox(
              width: 200,
              height: 50,
              child: Text('Panel'),
            ),
          ),
        );
        expect(find.text('Panel'), findsNothing);
        await pump(
          tester,
          CsDropdown(
            open: true,
            trigger: trigger(),
            content: const SizedBox(
              width: 200,
              height: 50,
              child: Text('Panel'),
            ),
          ),
        );
        final t = tester.getRect(find.text('Trigger'));
        final panel = tester.getRect(find.text('Panel'));
        expect(panel.top, t.bottom);
        expect(panel.left, t.left);
        expect(panel.width, 200);
      },
    );

    testWidgets(
      'minWidth trigger widens; min+max trigger matches the trigger',
      (tester) async {
        await pump(
          tester,
          const CsDropdown(
            open: true,
            minWidth: CsDropdownWidth.trigger,
            trigger: SizedBox(width: 300, height: 32, child: Text('T')),
            content: SizedBox(width: 80, height: 20, child: Text('Small')),
          ),
        );
        expect(
          tester
              .getSize(
                find
                    .ancestor(
                      of: find.text('Small'),
                      matching: find.byType(DecoratedBox),
                    )
                    .first,
              )
              .width,
          300,
        );
        await pump(
          tester,
          const CsDropdown(
            open: true,
            minWidth: CsDropdownWidth.trigger,
            maxWidth: CsDropdownWidth.trigger,
            trigger: SizedBox(width: 150, height: 32, child: Text('T')),
            content: Text('A much longer line of content than the trigger'),
          ),
        );
        expect(
          tester
              .getSize(
                find
                    .ancestor(
                      of: find.text(
                        'A much longer line of content than the trigger',
                      ),
                      matching: find.byType(DecoratedBox),
                    )
                    .first,
              )
              .width,
          150,
        );
      },
    );

    testWidgets('opens above near the bottom of the screen', (tester) async {
      await pump(
        tester,
        CsDropdown(
          open: true,
          trigger: trigger(),
          content: const SizedBox(
            width: 200,
            height: 300,
            child: Text('Panel'),
          ),
        ),
        at: Alignment.bottomLeft,
      );
      expect(
        tester.getRect(find.text('Panel')).bottom,
        tester.getRect(find.text('Trigger')).top,
      );
      expect(
        CsDropdownContext.placementOf(tester.element(find.text('Panel'))),
        CsDropdownPlacement.topRight,
      );
    });

    testWidgets('outside click and Escape', (tester) async {
      var outside = 0, escape = 0;
      await pump(
        tester,
        CsDropdown(
          open: true,
          trigger: trigger(),
          content: const SizedBox(width: 200, height: 50, child: Text('Panel')),
          onOutsideClick: () => outside++,
          onEscape: () => escape++,
        ),
      );
      await tester.tap(find.text('Panel'));
      await tester.tap(find.text('Trigger'));
      expect(outside, 0);
      await tester.tapAt(const Offset(900, 700));
      expect(outside, 1);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      expect(escape, 1);
    });

    testWidgets('focus enter/leave and Tab looping in viewport mode', (
      tester,
    ) async {
      final events = <String>[];
      final triggerNode = FocusNode();
      final a = FocusNode(), b = FocusNode();
      addTearDown(() {
        for (final n in [triggerNode, a, b]) {
          n.dispose();
        }
      });
      await pump(
        tester,
        CsDropdown(
          open: true,
          expandToViewport: true,
          onFocusEnter: () => events.add('enter'),
          onFocusLeave: () => events.add('leave'),
          trigger: Focus(focusNode: triggerNode, child: trigger()),
          content: Column(
            children: [
              Focus(focusNode: a, child: const Text('A')),
              Focus(focusNode: b, child: const Text('B')),
            ],
          ),
        ),
      );
      triggerNode.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      expect(a.hasPrimaryFocus, isTrue);
      expect(events, ['enter']);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      expect(b.hasPrimaryFocus, isTrue);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab); // loops back
      await tester.pump();
      expect(triggerNode.hasPrimaryFocus, isTrue);
      expect(events, ['enter', 'leave']);
    });

    testWidgets('panel fades in with motion and draws the outline', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1000, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        CsApp(
          theme: const CsThemeData(motion: CsMotionMode.normal),
          home: Align(
            alignment: Alignment.topLeft,
            child: CsDropdown(
              open: true,
              trigger: trigger(),
              content: const SizedBox(width: 100, height: 20, child: Text('P')),
            ),
          ),
        ),
      );
      await tester.pump();
      final opacity = tester.widget<Opacity>(
        find.ancestor(of: find.text('P'), matching: find.byType(Opacity)).first,
      );
      expect(opacity.opacity, lessThan(1));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<Opacity>(
              find
                  .ancestor(of: find.text('P'), matching: find.byType(Opacity))
                  .first,
            )
            .opacity,
        1,
      );
    });
  });

  group('previewer-like hosting', () {
    testWidgets('nested, offset and zoomed app: panel sits under the trigger', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.only(left: 200, top: 150),
            child: Align(
              alignment: Alignment.topLeft,
              child: Transform.scale(
                scale: 1.5,
                alignment: Alignment.topLeft,
                child: const SizedBox(
                  width: 500,
                  height: 400,
                  child: CsApp(
                    theme: CsThemeData(motion: CsMotionMode.disabled),
                    home: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CsDropdown(
                          open: true,
                          minWidth: CsDropdownWidth.trigger,
                          maxWidth: CsDropdownWidth.trigger,
                          trigger: SizedBox(
                            width: 160,
                            height: 32,
                            child: Text('T'),
                          ),
                          content: SizedBox(height: 60, child: Text('Panel')),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final trigger = tester.getRect(find.text('T'));
      final panel = tester.getRect(
        find
            .ancestor(
              of: find.text('Panel'),
              matching: find.byType(DecoratedBox),
            )
            .first,
      );
      expect(panel.left, closeTo(trigger.left, 0.01));
      expect(panel.top, closeTo(trigger.bottom, 0.01));
      expect(panel.width, closeTo(trigger.width, 0.01)); // both scaled by 1.5
    });
  });

  group('CsSelectableItem', () {
    testWidgets('hover reports highlight; states paint upstream colors', (
      tester,
    ) async {
      var hovered = 0;
      final t = CsTokens.resolve();
      await tester.pumpWidget(
        CsApp(
          theme: const CsThemeData(colorMode: CsColorMode.light),
          home: Column(
            children: [
              CsSelectableItem(
                onHover: () => hovered++,
                child: const Text('A'),
              ),
              const CsSelectableItem(highlighted: true, child: Text('B')),
              const CsSelectableItem(
                highlighted: true,
                highlightType: CsHighlightType.keyboard,
                child: Text('C'),
              ),
              const CsSelectableItem(
                selected: true,
                highlighted: true,
                child: Text('D'),
              ),
              const CsSelectableItem(disabled: true, child: Text('E')),
            ],
          ),
        ),
      );
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await gesture.moveTo(tester.getCenter(find.text('A')));
      await tester.pump();
      expect(hovered, greaterThan(0));
      CsSelectableItemPainter painter(String text) =>
          tester
                  .widget<CustomPaint>(
                    find
                        .ancestor(
                          of: find.text(text),
                          matching: find.byType(CustomPaint),
                        )
                        .first,
                  )
                  .painter!
              as CsSelectableItemPainter;
      expect(
        painter('B').background,
        t.colorBackgroundDropdownItemHover.toColor(),
      );
      expect(
        painter('B').rings.single.$2,
        t.colorBorderDropdownItemHover.toColor(),
      );
      expect(
        painter('C').rings.single.$2,
        t.colorBorderDropdownItemFocused.toColor(),
      );
      expect(painter('D').rings.length, 2);
      expect(
        painter('D').background,
        t.colorBackgroundDropdownItemSelected.toColor(),
      );
      expect(
        DefaultTextStyle.of(tester.element(find.text('E'))).style.color,
        t.colorTextDropdownItemDisabled.toColor(),
      );
    });
  });
}
