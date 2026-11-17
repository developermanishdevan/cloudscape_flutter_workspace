import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cloudscape_flutter_test/cloudscape_flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(WidgetTester tester, Widget child) async {
  tester.view.physicalSize = const Size(900, 700);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    CsApp(
      theme: const CsThemeData(motion: CsMotionMode.disabled),
      home: Align(
        alignment: Alignment.topLeft,
        child: Padding(padding: const EdgeInsets.all(20), child: child),
      ),
    ),
  );
  await tester.pump();
}

Widget _button(String label, List<String> log, {bool disabled = false}) =>
    CsPressable(
      disabled: disabled,
      onPressed: () => log.add(label),
      builder: (context, s) =>
          Padding(padding: const EdgeInsets.all(4), child: Text(label)),
    );

void main() {
  testWidgets('box, space between, icon, icon provider', (tester) async {
    await _pump(
      tester,
      CsIconProvider(
        icons: const {'brand': SizedBox(width: 16, height: 16)},
        child: CsSpaceBetween(
          size: CsSpaceBetweenSize.s,
          children: [
            CsBox.text('Title', variant: CsBoxVariant.h2),
            const CsIcon(name: CsIconName.search, size: CsIconSize.big),
            const CsIcon(customName: 'brand', ariaLabel: 'Brand'),
          ],
        ),
      ),
    );
    final box = CsBoxDriver(tester, find.csBox(text: 'Title'));
    expect(box.variant, CsBoxVariant.h2);
    expect(box.text, 'Title');
    expect(
      CsBoxDriver(tester, find.csBox(variant: CsBoxVariant.h2)).exists,
      isTrue,
    );

    final sb = CsSpaceBetweenDriver(tester);
    expect(sb.items.length, 3);
    expect(sb.itemRects[1].top, greaterThan(sb.itemRects[0].bottom));

    final icon = CsIconDriver(tester, find.csIcon(name: CsIconName.search));
    expect(icon.size, CsIconSize.big);
    expect(icon.renderedSize.width, greaterThan(16));
    final brand = CsIconDriver(tester, find.csIcon(customName: 'brand'));
    expect(brand.customName, 'brand');

    // CsApp installs the root provider; drive the inner one.
    final provider = CsIconProviderDriver(tester, find.csIconProvider().last);
    expect(provider.iconNames, ['brand']);
    expect(provider.icons.length, 2);
  });

  testWidgets('live region', (tester) async {
    await _pump(
      tester,
      const CsLiveRegion(
        assertive: true,
        hidden: true,
        child: Text('3 items loaded'),
      ),
    );
    final live = CsLiveRegionDriver(tester, find.csLiveRegion(text: 'items'));
    expect(live.isAssertive, isTrue);
    expect(live.isHidden, isTrue);
    expect(live.text, '3 items loaded');
  });

  testWidgets('pressable: click, keys, focus, disabled', (tester) async {
    final log = <String>[];
    await _pump(
      tester,
      Row(
        children: [_button('Save', log), _button('Off', log, disabled: true)],
      ),
    );
    final save = CsPressableDriver(tester, find.csPressable(label: 'Save'));
    await save.click();
    await save.pressKey(LogicalKeyboardKey.enter);
    expect(save.isFocused, isTrue);
    expect(log, ['Save', 'Save']);
    final off = CsPressableDriver(tester, find.csPressable(label: 'Off'));
    expect(off.isDisabled, isTrue);
    await off.click();
    expect(log, ['Save', 'Save']);
    final hover = await save.hover();
    await hover.removePointer();
  });

  testWidgets('navigable group: focus and arrow keys', (tester) async {
    final log = <String>[];
    await _pump(
      tester,
      CsNavigableGroup(
        child: Row(
          children: [_button('A', log), _button('B', log), _button('C', log)],
        ),
      ),
    );
    final group = CsNavigableGroupDriver(tester);
    await group.focus();
    expect(group.focusedText, 'A');
    await group.press(LogicalKeyboardKey.arrowRight);
    expect(group.focusedText, 'B');
    await group.press(LogicalKeyboardKey.end);
    expect(group.focusedText, 'C');
  });

  testWidgets('dropdown: slots, open state, outside click, escape', (
    tester,
  ) async {
    var open = true;
    final log = <String>[];
    late StateSetter set;
    await _pump(
      tester,
      StatefulBuilder(
        builder: (context, s) {
          set = s;
          return CsDropdown(
            open: open,
            onOutsideClick: () {
              log.add('outside');
              set(() => open = false);
            },
            onEscape: () => log.add('escape'),
            trigger: const SizedBox(
              width: 120,
              height: 32,
              child: Text('Trigger'),
            ),
            header: const Text('Header'),
            content: const SizedBox(
              width: 200,
              height: 60,
              child: Text('Content'),
            ),
            footer: const Text('Footer'),
          );
        },
      ),
    );
    await tester.pumpAndSettle();
    final dd = CsDropdownDriver(tester);
    expect(dd.isOpen, isTrue);
    expect(
      tester
          .widget<Text>(
            find.descendant(of: dd.trigger, matching: find.byType(Text)),
          )
          .data,
      'Trigger',
    );
    expect(dd.header, findsOneWidget);
    expect(dd.content, findsOneWidget);
    expect(dd.footer, findsOneWidget);
    expect(
      dd.panelRect.top,
      greaterThanOrEqualTo(tester.getRect(dd.trigger).bottom),
    );
    await dd.pressEscape();
    await dd.clickOutside(const Offset(800, 600));
    expect(log, ['escape', 'outside']);
    expect(CsDropdownDriver(tester).isOpen, isFalse);
    expect(CsDropdownDriver(tester).content, findsNothing);
  });

  testWidgets('options list: indexes, groups, highlight, selection, matches', (
    tester,
  ) async {
    const options = <CsOptionItem>[
      CsOptionDefinition(value: 'a', label: 'Apple', description: 'Red'),
      CsOptionGroup(
        label: 'Citrus',
        options: [
          CsOptionDefinition(value: 'o', label: 'Orange', tags: ['juicy']),
          CsOptionDefinition(
            value: 'l',
            label: 'Lemon',
            filteringTags: ['sour'],
          ),
        ],
      ),
    ];
    final rows = csPrepareOptions(
      options,
      CsOptionsFilteringType.none,
      '',
    ).filteredOptions;
    await _pump(
      tester,
      SizedBox(
        width: 300,
        height: 300,
        child: CsOptionsList(
          itemCount: rows.length,
          highlightedIndex: 2,
          itemBuilder: (context, i) => CsSelectableItem(
            isParent: rows[i].type == CsDropdownOptionType.parent,
            highlighted: i == 2,
            selected: i == 3,
            child: CsOption(
              option: rows[i].option,
              isGroupOption: rows[i].type == CsDropdownOptionType.parent,
              highlightText: 'o',
            ),
          ),
        ),
      ),
    );
    final list = CsOptionsListDriver(tester);
    expect(list.options.map((o) => o.label), ['Apple', 'Orange', 'Lemon']);
    expect(list.groups.single.label, 'Citrus');
    expect(list.option(1).description, 'Red');
    expect(list.optionInGroup(1, 2).label, 'Lemon');
    expect(list.optionByLabel('Orange').tags, ['juicy']);
    expect(list.highlightedOption?.label, 'Orange');
    expect(list.selectedOptions.single.label, 'Lemon');
    expect(list.optionByLabel('Lemon').visibleFilteringTags, [
      'sour',
    ]); // 'o' matches
    expect(list.optionByLabel('Orange').highlightedMatches, isNotEmpty);
    final item = CsSelectableItemDriver(
      tester,
      find.csSelectableItem(text: 'Citrus'),
    );
    expect(item.isGroupHeader, isTrue);
  });

  group('editable field', () {
    testWidgets('value, focus, keys, end icon, states', (tester) async {
      var cleared = 0;
      String? submitted;
      await _pump(
        tester,
        SizedBox(
          width: 300,
          child: Column(
            children: [
              CsEditableField(
                ariaLabel: 'Name',
                placeholder: 'Your name',
                onSubmitted: (v) => submitted = v,
                endIcon: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => cleared++,
                  child: const SizedBox(width: 20, height: 20),
                ),
              ),
              const CsEditableField(
                ariaLabel: 'Locked',
                disabled: true,
                invalid: true,
              ),
            ],
          ),
        ),
      );
      final name = CsEditableFieldDriver(
        tester,
        find.csEditableField(label: 'Name'),
      );
      expect(name.placeholder, 'Your name');
      await name.setValue('Ann');
      expect(name.value, 'Ann');
      expect(
        CsEditableFieldDriver(
          tester,
          find.csEditableField(value: 'Ann'),
        ).exists,
        isTrue,
      );
      await name.focus();
      expect(name.isFocused, isTrue);
      await name.submit();
      expect(submitted, 'Ann');
      await name.clickEndIcon();
      expect(cleared, 1);
      await name.blur();
      expect(name.isFocused, isFalse);

      final locked = CsEditableFieldDriver(
        tester,
        find.csEditableField(label: 'Locked'),
      );
      expect(locked.isDisabled, isTrue);
      expect(locked.isInvalid, isTrue);
      expect(locked.isWarning, isFalse);
    });

    testWidgets('context menu', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
      addTearDown(() => debugDefaultTargetPlatformOverride = null);
      await _pump(
        tester,
        const SizedBox(
          width: 300,
          child: CsEditableField(value: 'hello world'),
        ),
      );
      final field = CsEditableFieldDriver(tester);
      await field.openContextMenu();
      expect(field.contextMenuItems, contains('Select all'));
      await field.clickContextMenuItem('Select all');
      expect(
        field.selection,
        const TextSelection(baseOffset: 0, extentOffset: 11),
      );
      debugDefaultTargetPlatformOverride = null;
    });
  });

  testWidgets('table root: headers, lazy cells, scrolling, resizing', (
    tester,
  ) async {
    final widths = <List<double>>[];
    await _pump(
      tester,
      SizedBox(
        width: 600,
        height: 300,
        child: CsTableRoot(
          ariaLabel: 'Items',
          resizableColumns: true,
          onColumnWidthsChange: widths.add,
          columns: [
            for (var i = 0; i < 4; i++)
              CsTableColumn(id: 'c$i', header: Text('Col $i'), width: 150),
          ],
          rowCount: 5000,
          cellBuilder: (context, r, c) => Text('r$r c$c'),
        ),
      ),
    );
    final table = CsTableRootDriver(tester, find.csTableRoot(label: 'Items'));
    expect(table.rowCount, 5000);
    expect(table.columnHeaderTexts, ['Col 0', 'Col 1', 'Col 2', 'Col 3']);
    expect(table.builtRows.first, 0);
    expect(await table.bodyCellText(3, 2), 'r3 c2');
    expect(await table.bodyCellText(4321, 1), 'r4321 c1');
    expect(table.builtRows, contains(4321));
    final cell = await table.bodyCell(4321, 0);
    expect(tester.getRect(cell).top, greaterThanOrEqualTo(table.rect.top));
    expect(tester.getRect(cell).bottom, lessThanOrEqualTo(table.rect.bottom));
    await table.resizeColumn(1, 40);
    expect(table.columnWidths[1], 190);
    await table.resizeColumnWithKeyboard(2, -2);
    expect(table.columnWidths[2], 130);
    expect(widths.length, 3);
  });
}
