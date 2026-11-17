import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  double width = 300,
}) async {
  tester.view.physicalSize = const Size(800, 600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    CsApp(
      theme: const CsThemeData(
        motion: CsMotionMode.disabled,
        colorMode: CsColorMode.light,
      ),
      home: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(width: width, child: child),
        ),
      ),
    ),
  );
  await tester.pump();
}

CsTokens _tokens(WidgetTester tester) =>
    tester.element(find.byType(CsEditableField).first).csTokens;

BoxDecoration _decoration(WidgetTester tester) {
  final c = tester.widget<Container>(
    find
        .descendant(
          of: find.byType(CsEditableField).first,
          matching: find.byType(Container),
        )
        .first,
  );
  return c.decoration! as BoxDecoration;
}

EditableText _editable(WidgetTester tester) =>
    tester.widget<EditableText>(find.byType(EditableText).first);

void main() {
  group('editing', () {
    testWidgets('uncontrolled: typing updates the controller and onChange', (
      tester,
    ) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);
      final changes = <String>[];
      await _pump(
        tester,
        CsEditableField(controller: controller, onChange: changes.add),
      );
      await tester.enterText(find.byType(EditableText), 'hello');
      expect(controller.text, 'hello');
      expect(changes, ['hello']);
    });

    testWidgets(
      'controlled: shows value, follows updates, reverts rejected edits',
      (tester) async {
        final changes = <String>[];
        Widget field(String v) =>
            CsEditableField(value: v, onChange: changes.add);
        await _pump(tester, field('abc'));
        expect(find.text('abc'), findsOneWidget);
        await _pump(tester, field('xyz'));
        expect(_editable(tester).controller.text, 'xyz');
        // The owner ignores the edit: the field restores its value.
        await tester.enterText(find.byType(EditableText), 'nope');
        await tester.pump();
        expect(changes, ['nope']);
        expect(_editable(tester).controller.text, 'xyz');
      },
    );

    testWidgets('Enter submits a single-line field', (tester) async {
      String? submitted;
      await _pump(tester, CsEditableField(onSubmitted: (v) => submitted = v));
      await tester.enterText(find.byType(EditableText), 'go');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      expect(submitted, 'go');
    });

    testWidgets('maxLength and formatters limit input', (tester) async {
      await _pump(
        tester,
        CsEditableField(
          maxLength: 3,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      );
      await tester.enterText(find.byType(EditableText), 'a12345');
      expect(_editable(tester).controller.text, '123');
    });

    testWidgets('onKeyEvent sees keys first', (tester) async {
      final keys = <LogicalKeyboardKey>[];
      await _pump(
        tester,
        CsEditableField(
          onKeyEvent: (node, e) {
            if (e is KeyDownEvent) keys.add(e.logicalKey);
            return e.logicalKey == LogicalKeyboardKey.arrowDown
                ? KeyEventResult.handled
                : KeyEventResult.ignored;
          },
        ),
      );
      await tester.tap(find.byType(CsEditableField));
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      expect(keys, [LogicalKeyboardKey.arrowDown, LogicalKeyboardKey.escape]);
    });
  });

  group('states', () {
    testWidgets('default geometry: input height and text inset', (
      tester,
    ) async {
      await _pump(tester, const CsEditableField());
      final t = _tokens(tester);
      expect(
        tester.getSize(find.byType(CsEditableField)).height,
        t.sizeVerticalInput,
      );
      final field = tester.getTopLeft(find.byType(CsEditableField));
      final text = tester.getTopLeft(find.byType(EditableText));
      expect(text.dx - field.dx, t.borderWidthField + t.spaceFieldHorizontal);
      expect(text.dy - field.dy, t.borderWidthField + t.spaceFieldVertical);
      final d = _decoration(tester);
      expect(d.color, t.colorBackgroundInputDefault.toColor());
      expect(d.borderRadius, BorderRadius.circular(t.borderRadiusInput));
      expect(
        (d.border! as BorderDirectional).top.color,
        t.colorBorderInputDefault.toColor(),
      );
      expect(d.boxShadow, isNull);
    });

    testWidgets('focus: focused border, focus ring, onFocus / onBlur', (
      tester,
    ) async {
      final log = <String>[];
      final node = FocusNode();
      addTearDown(node.dispose);
      await _pump(
        tester,
        CsEditableField(
          focusNode: node,
          onFocus: () => log.add('focus'),
          onBlur: () => log.add('blur'),
        ),
      );
      await tester.tap(find.byType(CsEditableField));
      await tester.pump();
      final t = _tokens(tester);
      final d = _decoration(tester);
      expect(node.hasFocus, isTrue);
      expect(
        (d.border! as BorderDirectional).top.color,
        t.colorBorderInputFocused.toColor(),
      );
      expect(
        d.boxShadow!.single.spreadRadius,
        t.borderControlFocusRingShadowSpread,
      );
      expect(d.boxShadow!.single.color, t.colorBorderItemFocused.toColor());
      node.unfocus();
      await tester.pump();
      expect(log, ['focus', 'blur']);
    });

    testWidgets('placeholder: italic, shown only while empty', (tester) async {
      await _pump(tester, const CsEditableField(placeholder: 'Type here'));
      final t = _tokens(tester);
      final p = tester.widget<Text>(find.text('Type here'));
      expect(p.style!.fontStyle, FontStyle.italic);
      expect(p.style!.color, t.colorTextInputPlaceholder.toColor());
      await tester.enterText(find.byType(EditableText), 'x');
      await tester.pump();
      expect(find.text('Type here'), findsNothing);
    });

    testWidgets('disabled: not focusable, disabled colors, no edits', (
      tester,
    ) async {
      final node = FocusNode();
      addTearDown(node.dispose);
      await _pump(
        tester,
        CsEditableField(focusNode: node, disabled: true, placeholder: 'P'),
      );
      await tester.tap(find.byType(CsEditableField), warnIfMissed: false);
      await tester.pump();
      final t = _tokens(tester);
      expect(node.hasFocus, isFalse);
      expect(_editable(tester).readOnly, isTrue);
      expect(
        _decoration(tester).color,
        t.colorBackgroundInputDisabled.toColor(),
      );
      expect(
        tester.widget<Text>(find.text('P')).style!.color,
        t.colorTextInputPlaceholderDisabled.toColor(),
      );
      expect(_editable(tester).style.color, t.colorTextInputDisabled.toColor());
    });

    testWidgets('read-only: focusable, not editable, disabled border', (
      tester,
    ) async {
      await _pump(tester, const CsEditableField(readOnly: true, value: 'RO'));
      await tester.tap(find.byType(CsEditableField));
      await tester.pump();
      final t = _tokens(tester);
      expect(_editable(tester).readOnly, isTrue);
      expect(_editable(tester).focusNode.hasFocus, isTrue);
      expect(
        (_decoration(tester).border! as BorderDirectional).top.color,
        t.colorBorderInputDisabled.toColor(),
      );
    });

    testWidgets(
      'invalid: status border on the start side, error text, inset kept',
      (tester) async {
        await _pump(
          tester,
          const CsEditableField(invalid: true, warning: true),
        );
        final t = _tokens(tester);
        final b = _decoration(tester).border! as BorderDirectional;
        expect(b.start.width, t.borderWidthFieldStatusInlineStart);
        expect(b.end.width, t.borderWidthField);
        expect(b.top.color, t.colorTextStatusError.toColor());
        expect(_editable(tester).style.color, t.colorTextStatusError.toColor());
        // The wider border eats into the padding: text stays where it was.
        final field = tester.getTopLeft(find.byType(CsEditableField));
        final text = tester.getTopLeft(find.byType(EditableText));
        expect(text.dx - field.dx, t.borderWidthField + t.spaceFieldHorizontal);
      },
    );

    testWidgets(
      'warning text color; status with adornments keeps text default',
      (tester) async {
        await _pump(tester, const CsEditableField(warning: true));
        final t = _tokens(tester);
        expect(
          _editable(tester).style.color,
          t.colorTextStatusWarning.toColor(),
        );
        await _pump(
          tester,
          const CsEditableField(invalid: true, suffix: Text('GiB')),
        );
        expect(_editable(tester).style.color, t.colorTextBodyDefault.toColor());
        expect(
          DefaultTextStyle.of(tester.element(find.text('GiB'))).style.color,
          t.colorTextStatusError.toColor(),
        );
      },
    );

    testWidgets('start / end icons offset the text', (tester) async {
      await _pump(
        tester,
        const CsEditableField(
          startIcon: CsIcon(name: CsIconName.search),
          endIcon: SizedBox(width: 20, height: 20),
        ),
      );
      final t = _tokens(tester);
      final field = tester.getRect(find.byType(CsEditableField));
      final text = tester.getRect(find.byType(EditableText));
      expect(
        text.left - field.left,
        t.borderWidthField + t.spaceFieldIconOffset,
      );
      expect(
        field.right - text.right,
        t.borderWidthField + t.spaceFieldIconOffset,
      );
      expect(
        tester.getTopLeft(find.byType(CsIcon)).dx - field.left,
        t.spaceFieldHorizontal,
      );
    });

    testWidgets('prefix and suffix with dividers', (tester) async {
      await _pump(
        tester,
        const CsEditableField(prefix: Text('https://'), suffix: Text('.com')),
      );
      final prefix = tester.getRect(find.text('https://'));
      final suffix = tester.getRect(find.text('.com'));
      final text = tester.getRect(find.byType(EditableText));
      expect(prefix.right, lessThan(text.left));
      expect(suffix.left, greaterThan(text.right));
    });

    testWidgets('textarea: minLines rows tall, multiline keyboard', (
      tester,
    ) async {
      await _pump(tester, const CsEditableField(maxLines: null, minLines: 3));
      final t = _tokens(tester);
      expect(
        tester.getSize(find.byType(CsEditableField)).height,
        3 * t.lineHeightBodyM +
            2 * t.spaceFieldVertical +
            2 * t.borderWidthField,
      );
      expect(_editable(tester).keyboardType, TextInputType.multiline);
    });

    testWidgets('RTL mirrors the insets and status border', (tester) async {
      await _pump(
        tester,
        const Directionality(
          textDirection: TextDirection.rtl,
          child: CsEditableField(startIcon: CsIcon(name: CsIconName.search)),
        ),
      );
      final t = _tokens(tester);
      final field = tester.getRect(find.byType(CsEditableField));
      final text = tester.getRect(find.byType(EditableText));
      expect(
        field.right - text.right,
        t.borderWidthField + t.spaceFieldIconOffset,
      );
    });
  });

  group('selection', () {
    testWidgets('desktop: right click shows the Cloudscape context menu', (
      tester,
    ) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;
      addTearDown(() => debugDefaultTargetPlatformOverride = null);
      final controller = TextEditingController(text: 'hello world');
      addTearDown(controller.dispose);
      await _pump(tester, CsEditableField(controller: controller));
      final center = tester.getCenter(find.byType(EditableText));
      final gesture = await tester.startGesture(
        center,
        kind: PointerDeviceKind.mouse,
        buttons: kSecondaryMouseButton,
      );
      await gesture.up();
      await tester.pumpAndSettle();
      expect(find.byType(CsTextContextMenu), findsOneWidget);
      expect(find.text('Select all'), findsOneWidget);
      await tester.tap(find.text('Select all'));
      await tester.pumpAndSettle();
      expect(
        controller.selection,
        const TextSelection(baseOffset: 0, extentOffset: 11),
      );
      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('android: long press selects a word and shows handles', (
      tester,
    ) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      addTearDown(() => debugDefaultTargetPlatformOverride = null);
      final controller = TextEditingController(text: 'hello world');
      addTearDown(controller.dispose);
      await _pump(tester, CsEditableField(controller: controller));
      final start = tester.getTopLeft(find.byType(EditableText));
      await tester.longPressAt(start + const Offset(10, 8));
      await tester.pumpAndSettle();
      expect(
        controller.selection,
        const TextSelection(baseOffset: 0, extentOffset: 5),
      );
      final state = tester.state<EditableTextState>(find.byType(EditableText));
      expect(state.selectionOverlay?.handlesAreVisible, isTrue);
      expect(find.byType(CsTextContextMenu), findsOneWidget);
      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
      'nested app (widget previewer): handles and menu in the outer root '
      'overlay still see the Cloudscape theme',
      (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        addTearDown(() => debugDefaultTargetPlatformOverride = null);
        tester.view.physicalSize = const Size(800, 600);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        final controller = TextEditingController(text: 'hello world');
        addTearDown(controller.dispose);
        // The previewer hosts each preview's CsApp inside its own app, so
        // the root overlay sits above CsTheme.
        await tester.pumpWidget(
          WidgetsApp(
            color: const Color(0xFF000000),
            builder: (context, _) => Center(
              child: SizedBox(
                width: 400,
                height: 200,
                child: CsApp(
                  home: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CsEditableField(controller: controller),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        final start = tester.getTopLeft(find.byType(EditableText));
        await tester.longPressAt(start + const Offset(10, 8));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        final state = tester.state<EditableTextState>(
          find.byType(EditableText),
        );
        expect(state.selectionOverlay?.handlesAreVisible, isTrue);
        expect(find.byType(CsTextContextMenu), findsOneWidget);
        expect(find.text('Select all'), findsOneWidget);
        debugDefaultTargetPlatformOverride = null;
      },
    );

    testWidgets(
      'touch menu: a row when it fits, a full-width column when not',
      (tester) async {
        Widget bar(double width) => Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: width,
            child: const Align(
              alignment: Alignment.topLeft,
              child: CsRowOrColumn(
                children: [
                  SizedBox(width: 60, height: 30, child: Text('A')),
                  SizedBox(width: 80, height: 30, child: Text('B')),
                ],
              ),
            ),
          ),
        );
        await _pump(tester, bar(200));
        expect(
          tester.getTopLeft(find.text('B')).dy,
          tester.getTopLeft(find.text('A')).dy,
        );
        expect(tester.getSize(find.byType(CsRowOrColumn)), const Size(140, 30));
        await _pump(tester, bar(100));
        expect(tester.takeException(), isNull);
        expect(tester.getSize(find.byType(CsRowOrColumn)), const Size(80, 60));
        expect(
          tester.getTopLeft(find.text('B')).dy -
              tester.getTopLeft(find.text('A')).dy,
          30,
        );
      },
    );

    testWidgets('disabled fields get no selection controls', (tester) async {
      await _pump(tester, const CsEditableField(disabled: true, value: 'x'));
      expect(_editable(tester).selectionControls, isNull);
      expect(_editable(tester).enableInteractiveSelection, isFalse);
    });

    test('handle geometry follows the platform', () {
      final android = CsTextSelectionControls(platform: TargetPlatform.android);
      expect(android.getHandleSize(20), const Size(22, 22));
      expect(
        android.getHandleAnchor(TextSelectionHandleType.left, 20),
        const Offset(22, 0),
      );
      final ios = CsTextSelectionControls(platform: TargetPlatform.iOS);
      expect(ios.getHandleSize(20), const Size(12, 30.5));
      expect(
        ios.getHandleAnchor(TextSelectionHandleType.left, 20),
        const Offset(6, 30.5),
      );
      expect(
        ios.getHandleAnchor(TextSelectionHandleType.right, 20),
        const Offset(6, 20),
      );
    });

    testWidgets('magnifier only on iOS and Android', (tester) async {
      await _pump(tester, const SizedBox());
      final ctx = tester.element(find.byType(SizedBox).last);
      final info = ValueNotifier(MagnifierInfo.empty);
      addTearDown(info.dispose);
      final controller = MagnifierController();
      Widget? build(TargetPlatform p) =>
          csTextMagnifierConfiguration(platform: p)
              .magnifierBuilder(ctx, controller, info);
      expect(build(TargetPlatform.android), isA<CsTextMagnifier>());
      expect(build(TargetPlatform.iOS), isA<CsTextMagnifier>());
      expect(build(TargetPlatform.macOS), isNull);
    });

    testWidgets('context menu labels are localized defaults', (tester) async {
      await _pump(tester, const SizedBox());
      final ctx = tester.element(find.byType(SizedBox).last);
      String label(ContextMenuButtonType type) => csContextMenuLabel(
        ctx,
        ContextMenuButtonItem(type: type, onPressed: () {}),
      );
      expect(label(ContextMenuButtonType.copy), 'Copy');
      expect(label(ContextMenuButtonType.cut), 'Cut');
      expect(label(ContextMenuButtonType.paste), 'Paste');
      expect(
        csContextMenuLabel(
          ctx,
          ContextMenuButtonItem(label: 'Custom', onPressed: () {}),
        ),
        'Custom',
      );
    });
  });

  testWidgets('semantics: text field with label and state', (tester) async {
    final handle = tester.ensureSemantics();
    await _pump(tester, const CsEditableField(ariaLabel: 'Name', value: 'Ann'));
    expect(
      tester.getSemantics(find.byType(EditableText)),
      matchesSemantics(
        label: 'Name',
        value: 'Ann',
        isTextField: true,
        hasEnabledState: true,
        isEnabled: true,
        isFocusable: true,
        hasTapAction: true,
        textDirection: TextDirection.ltr,
      ),
    );
    handle.dispose();
  });
}
