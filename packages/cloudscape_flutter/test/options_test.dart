import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

const _options = <CsOptionItem>[
  CsOptionDefinition(value: 'a', label: 'Apple', description: 'Red fruit'),
  CsOptionGroup(
    label: 'Citrus',
    options: [
      CsOptionDefinition(value: 'o', label: 'Orange', tags: ['juicy']),
      CsOptionDefinition(value: 'l', label: 'Lemon', disabled: true),
    ],
  ),
  CsOptionGroup(
    label: 'All disabled',
    options: [CsOptionDefinition(value: 'x', label: 'X', disabled: true)],
  ),
  CsOptionDefinition(
    value: 'k',
    label: 'Kiwi',
    labelTag: 'green',
    filteringTags: ['zesty'],
  ),
];

List<String?> _labels(List<CsDropdownOption> rows) => [
  for (final r in rows) r.option.displayLabel,
];

void main() {
  group('flatten', () {
    test('groups become a parent row followed by child rows', () {
      final flat = csFlattenOptions(_options);
      expect(_labels(flat.flatOptions), [
        'Apple',
        'Citrus',
        'Orange',
        'Lemon',
        'All disabled',
        'X',
        'Kiwi',
      ]);
      expect(
        [for (final r in flat.flatOptions) r.type],
        [
          null,
          CsDropdownOptionType.parent,
          CsDropdownOptionType.child,
          CsDropdownOptionType.child,
          CsDropdownOptionType.parent,
          CsDropdownOptionType.child,
          null,
        ],
      );
      expect(flat.parentMap[flat.flatOptions[2]], same(flat.flatOptions[1]));
      expect(flat.parentMap[flat.flatOptions[0]], isNull);
    });

    test('a group is disabled when it or all of its options are', () {
      final rows = csFlattenOptions(_options).flatOptions;
      expect(rows[1].disabled, isFalse);
      expect(rows[3].disabled, isTrue);
      expect(rows[4].disabled, isTrue);
      final disabledGroup = csFlattenOptions(const [
        CsOptionGroup(
          label: 'G',
          disabled: true,
          options: [CsOptionDefinition(value: '1')],
        ),
      ]).flatOptions;
      expect([for (final r in disabledGroup) r.disabled], [true, true]);
    });

    test('interactive: enabled and not a header', () {
      final rows = csFlattenOptions(_options).flatOptions;
      expect(
        [for (final r in rows) csIsInteractive(r)],
        [true, false, true, false, false, false, true],
      );
      expect(csIsGroupInteractive(rows[1]), isTrue);
      expect(csIsInteractive(null), isFalse);
    });

    test('unflatten regroups rows and keeps flat indexes', () {
      final nested = csUnflattenOptions(csFlattenOptions(_options).flatOptions);
      expect(nested.length, 4);
      expect(nested[1].type, CsDropdownOptionType.parent);
      expect([for (final c in nested[1].children!) c.index], [2, 3]);
      expect(nested[3].index, 6);
    });
  });

  group('filter', () {
    List<String?> filter(String text, {bool strict = false}) => _labels(
      csFilterOptions(
        csFlattenOptions(_options).flatOptions,
        text,
        strict: strict,
      ),
    );

    test('empty text keeps everything', () {
      expect(filter('').length, 7);
    });

    test(
      'matches label, value, description, label tag, tags, filtering tags',
      () {
        expect(filter('APP'), ['Apple']);
        expect(filter('red'), ['Apple']);
        expect(filter('green'), ['Kiwi']);
        expect(filter('zest'), ['Kiwi']);
        expect(filter('juic'), ['Citrus', 'Orange']);
      },
    );

    test('a matching child brings its group header once', () {
      expect(filter('on'), ['Citrus', 'Lemon']);
      expect(filter('e'), [
        'Apple',
        'Citrus',
        'Orange',
        'Lemon',
        'All disabled',
        'X', // matches through its group header
        'Kiwi', // "green" / "zesty"
      ]);
    });

    test('a matching group header keeps all of its children', () {
      expect(filter('citrus'), ['Citrus', 'Orange', 'Lemon']);
    });

    test('strict matching is prefix-only and ignores filtering tags', () {
      expect(csMatchesString('Orange', 'ra', strict: true), isFalse);
      expect(csMatchesString('Orange', 'or', strict: true), isTrue);
      expect(filter('zest', strict: true), isEmpty);
      expect(filter('le', strict: true), ['Citrus', 'Lemon']);
    });

    test('csMatchesString ignores null and empty values', () {
      expect(csMatchesString(null, 'a'), isFalse);
      expect(csMatchesString('', ''), isFalse);
    });
  });

  group('prepare', () {
    test('auto filters, manual and none keep all rows', () {
      final auto = csPrepareOptions(
        _options,
        CsOptionsFilteringType.auto,
        'kiwi',
      );
      expect(_labels(auto.filteredOptions), ['Kiwi']);
      expect(auto.totalCount, 7);
      expect(auto.matchesCount, 1);
      for (final type in [
        CsOptionsFilteringType.manual,
        CsOptionsFilteringType.none,
      ]) {
        expect(csPrepareOptions(_options, type, 'kiwi').matchesCount, 7);
      }
    });

    test('test indexes number options through groups', () {
      final rows = csPrepareOptions(
        _options,
        CsOptionsFilteringType.none,
        '',
      ).filteredOptions;
      final idx = [for (final r in rows) csTestOptionIndexes(r)];
      expect(idx[0], (throughIndex: 1, groupIndex: null, inGroupIndex: null));
      expect(idx[1], (throughIndex: null, groupIndex: 1, inGroupIndex: null));
      expect(idx[2], (throughIndex: 2, groupIndex: 1, inGroupIndex: 1));
      expect(idx[3], (throughIndex: 3, groupIndex: 1, inGroupIndex: 2));
      expect(idx[5], (throughIndex: 4, groupIndex: 2, inGroupIndex: 1));
      expect(idx[6], (throughIndex: 5, groupIndex: null, inGroupIndex: null));
    });
  });

  group('highlight', () {
    late List<CsDropdownOption> rows;
    late CsHighlightController c;
    setUp(() {
      rows = csFlattenOptions(_options).flatOptions;
      c = CsHighlightController(
        options: rows,
        isHighlightable: csIsInteractive,
      );
    });
    tearDown(() => c.dispose());

    test('keyboard moves skip headers and disabled rows and do not wrap', () {
      expect(c.highlightedIndex, -1);
      c.moveHighlightWithKeyboard(1);
      expect(c.highlightedIndex, 0);
      c.moveHighlightWithKeyboard(1);
      expect(c.highlightedIndex, 2);
      c.moveHighlightWithKeyboard(1);
      expect(c.highlightedIndex, 6);
      c.moveHighlightWithKeyboard(1);
      expect(c.highlightedIndex, 6);
      c.moveHighlightWithKeyboard(-1);
      expect(c.highlightedIndex, 2);
      expect(c.highlightType.type, CsHighlightType.keyboard);
      expect(c.highlightType.moveFocus, isTrue);
    });

    test('up from nothing goes to the last row; home and end', () {
      c.moveHighlightWithKeyboard(-1);
      expect(c.highlightedIndex, 6);
      c.goHomeWithKeyboard();
      expect(c.highlightedIndex, 0);
      c.goEndWithKeyboard();
      expect(c.highlightedIndex, 6);
      c.resetHighlightWithKeyboard();
      expect(c.highlightedIndex, -1);
      expect(c.highlightedOption, isNull);
    });

    test('mouse highlight does not move focus unless asked', () {
      c.setHighlightedIndexWithMouse(2);
      expect(c.highlightedIndex, 2);
      expect(c.highlightType.type, CsHighlightType.mouse);
      expect(c.highlightType.moveFocus, isFalse);
      expect(c.highlightedOption, same(rows[2]));
      c.highlightFirstOptionWithMouse();
      expect(c.highlightedIndex, 0);
    });

    test('highlightedOption is null on a non-highlightable index', () {
      c.setHighlightedIndexWithMouse(1);
      expect(c.highlightedOption, isNull);
      c.highlightOptionWithKeyboard(rows[6]);
      expect(c.highlightedIndex, 6);
    });

    test('notifies only on change', () {
      var n = 0;
      c.addListener(() => n++);
      c.setHighlightedIndexWithMouse(0);
      c.setHighlightedIndexWithMouse(0);
      expect(n, 1);
      c.highlightOptionWithKeyboard(rows[0]); // same index, new type
      expect(n, 2);
    });
  });

  group('keyboard handlers', () {
    KeyEvent down(LogicalKeyboardKey key) => KeyDownEvent(
      physicalKey: PhysicalKeyboardKey.keyA,
      logicalKey: key,
      timeStamp: Duration.zero,
    );

    test('menu keys', () {
      final log = <String>[];
      final node = FocusNode();
      addTearDown(node.dispose);
      final h = csMenuKeyHandler(
        goUp: () => log.add('up'),
        goDown: () => log.add('down'),
        selectOption: () => log.add('select'),
        goHome: () => log.add('home'),
        goEnd: () => log.add('end'),
        onEscape: () => log.add('escape'),
      );
      expect(h(node, down(LogicalKeyboardKey.arrowUp)), KeyEventResult.handled);
      h(node, down(LogicalKeyboardKey.arrowDown));
      expect(h(node, down(LogicalKeyboardKey.home)), KeyEventResult.ignored);
      h(node, down(LogicalKeyboardKey.end));
      h(node, down(LogicalKeyboardKey.enter));
      h(node, down(LogicalKeyboardKey.escape));
      expect(h(node, down(LogicalKeyboardKey.space)), KeyEventResult.ignored);
      expect(log, ['up', 'down', 'home', 'end', 'select', 'escape']);
      final space = csMenuKeyHandler(
        goUp: () {},
        goDown: () {},
        selectOption: () => log.add('space'),
        goHome: () {},
        goEnd: () {},
        preventNativeSpace: true,
      );
      expect(
        space(node, down(LogicalKeyboardKey.space)),
        KeyEventResult.handled,
      );
      expect(log.last, 'space');
    });

    test('trigger keys open; arrows also go home', () {
      final log = <String>[];
      final node = FocusNode();
      addTearDown(node.dispose);
      final h = csTriggerKeyHandler(
        openDropdown: () => log.add('open'),
        goHome: () => log.add('home'),
      );
      h(node, down(LogicalKeyboardKey.arrowDown));
      h(node, down(LogicalKeyboardKey.space));
      expect(h(node, down(LogicalKeyboardKey.keyQ)), KeyEventResult.ignored);
      expect(log, ['home', 'open', 'open']);
    });
  });

  test('open state', () {
    final log = <String>[];
    final s = CsOpenStateController(
      onOpen: () => log.add('open'),
      onClose: () => log.add('close'),
    );
    addTearDown(s.dispose);
    s
      ..openDropdown(isKeyboard: true)
      ..openDropdown();
    expect(s.isOpen, isTrue);
    expect(s.openedWithKeyboard, isTrue);
    s
      ..toggleDropdown()
      ..closeDropdown()
      ..toggleDropdown();
    expect(s.openedWithKeyboard, isFalse);
    expect(log, ['open', 'close', 'open']);
  });

  test('splitOnFiltering alternates segments case-insensitively', () {
    expect(csSplitOnFiltering('Banana', 'AN'), [
      ('B', false),
      ('an', true),
      ('', false),
      ('an', true),
      ('a', false),
    ]);
    expect(csSplitOnFiltering('a.b', '.'), [
      ('a', false),
      ('.', true),
      ('b', false),
    ]);
    expect(csSplitOnFiltering('x', ''), [('x', false)]);
  });

  group('widgets', () {
    Future<void> pump(WidgetTester tester, Widget child) async {
      tester.view.physicalSize = const Size(600, 600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        CsApp(
          theme: const CsThemeData(motion: CsMotionMode.disabled),
          home: Align(alignment: Alignment.topLeft, child: child),
        ),
      );
      await tester.pump();
    }

    testWidgets('CsOption: label parts and only matching filtering tags', (
      tester,
    ) async {
      await pump(
        tester,
        const SizedBox(
          width: 300,
          child: Column(
            children: [
              CsOption(option: _kiwi, highlightText: 'zes'),
              CsOption(option: _kiwi),
            ],
          ),
        ),
      );
      expect(find.text('Kiwi', findRichText: true), findsNWidgets(2));
      expect(find.textContaining('green', findRichText: true), findsWidgets);
      expect(find.textContaining('lime', findRichText: true), findsNothing);
      expect(find.textContaining('zesty', findRichText: true), findsOneWidget);
      expect(find.text('Sweet'), findsNWidgets(2));
    });

    testWidgets('CsHighlightMatch styles matches bold', (tester) async {
      await pump(tester, const CsHighlightMatch('Banana', highlightText: 'an'));
      final rich = tester.widget<Text>(find.byType(Text)).textSpan! as TextSpan;
      final bold = [
        for (final c in rich.children!.cast<TextSpan>())
          if (c.style?.fontWeight != null) c.text,
      ];
      expect(bold, ['an', 'an']);
    });

    testWidgets('CsOption: prefix and custom content', (tester) async {
      await pump(
        tester,
        const SizedBox(
          width: 300,
          child: Column(
            children: [
              CsOption(
                option: CsOptionDefinition(label: 'Label', labelPrefix: 'Pre'),
              ),
              CsOption(
                option: CsOptionDefinition(label: 'Hidden'),
                customContent: Text('Custom'),
              ),
            ],
          ),
        ),
      );
      expect(find.textContaining('Pre ', findRichText: true), findsOneWidget);
      expect(find.text('Custom'), findsOneWidget);
      expect(find.text('Hidden'), findsNothing);
    });

    Widget list({
      required int count,
      bool virtual = false,
      int highlighted = -1,
      CsHighlight highlight = const CsHighlight(CsHighlightType.keyboard),
      VoidCallback? onLoadMore,
      bool sticky = false,
      ValueChanged<int>? onMouseUp,
      GlobalKey<CsOptionsListState>? key,
    }) => SizedBox(
      width: 200,
      height: 200,
      child: CsOptionsList(
        key: key,
        itemCount: count,
        virtualScroll: virtual,
        highlightedIndex: highlighted,
        highlight: highlight,
        onLoadMore: onLoadMore,
        firstItemSticky: sticky,
        onMouseUp: onMouseUp,
        itemBuilder: (context, i) =>
            SizedBox(height: 40, child: Text('Row $i')),
      ),
    );

    double top(WidgetTester tester, String text) =>
        tester.getTopLeft(find.text(text)).dy;

    testWidgets('scrolls the highlighted row into view (nearest)', (
      tester,
    ) async {
      await pump(tester, list(count: 20));
      await pump(tester, list(count: 20, highlighted: 10));
      await tester.pump();
      // Row 10 bottom (440) aligned to the viewport bottom (200).
      expect(top(tester, 'Row 10'), 160);
      await pump(tester, list(count: 20, highlighted: 9));
      await tester.pump();
      expect(top(tester, 'Row 10'), 160); // already visible: no move
      await pump(tester, list(count: 20, highlighted: 2));
      await tester.pump();
      expect(top(tester, 'Row 2'), 0);
    });

    testWidgets('a mouse highlight does not scroll', (tester) async {
      await pump(tester, list(count: 20));
      await pump(
        tester,
        list(
          count: 20,
          highlighted: 10,
          highlight: const CsHighlight(CsHighlightType.mouse),
        ),
      );
      await tester.pump();
      expect(find.text('Row 10'), findsOneWidget); // built (not virtual)
      expect(top(tester, 'Row 0'), 0);
    });

    testWidgets('virtual: builds only visible rows; scrolls to unbuilt rows', (
      tester,
    ) async {
      await pump(tester, list(count: 1000, virtual: true));
      // The width sample builds up to 50 rows offstage; the painted list
      // only builds the visible rows plus the cache extent.
      expect(find.text('Row 900'), findsNothing);
      final built = find
          .descendant(
            of: find.byType(CustomScrollView),
            matching: find.textContaining('Row '),
          )
          .evaluate()
          .length;
      expect(built, lessThan(20));
      await pump(tester, list(count: 1000, virtual: true, highlighted: 900));
      await tester.pump();
      await tester.pump();
      final r = tester.getRect(find.text('Row 900'));
      expect(r.top >= 0 && r.bottom <= 200, isTrue, reason: '$r');
    });

    testWidgets('virtual: sticky first row stays pinned', (tester) async {
      await pump(tester, list(count: 100, virtual: true, sticky: true));
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
      await tester.pump();
      expect(top(tester, 'Row 0'), 0);
    });

    testWidgets('virtual: intrinsic width comes from the first rows', (
      tester,
    ) async {
      await pump(
        tester,
        IntrinsicWidth(
          child: SizedBox(
            height: 200,
            child: CsOptionsList(
              itemCount: 1000,
              virtualScroll: true,
              itemBuilder: (context, i) => SizedBox(
                width: i == 3 ? 260 : 100,
                height: 40,
                child: Text('Row $i'),
              ),
            ),
          ),
        ),
      );
      expect(tester.getSize(find.byType(CsOptionsList)).width, 260);
    });

    testWidgets('load more fires near the end', (tester) async {
      var loads = 0;
      await pump(tester, list(count: 20, onLoadMore: () => loads++));
      expect(loads, 0);
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -560),
      );
      await tester.pump();
      expect(loads, greaterThan(0));
    });

    testWidgets('pointer up reports the row index', (tester) async {
      int? up;
      await pump(tester, list(count: 5, onMouseUp: (i) => up = i));
      await tester.tap(find.text('Row 3'));
      expect(up, 3);
    });

    testWidgets('closed list builds no rows', (tester) async {
      await pump(
        tester,
        CsOptionsList(
          itemCount: 3,
          open: false,
          itemBuilder: (context, i) => Text('Row $i'),
        ),
      );
      expect(find.textContaining('Row'), findsNothing);
    });

    testWidgets('group header and child rows', (tester) async {
      await pump(
        tester,
        const SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CsSelectableItem(isParent: true, child: Text('Group')),
              CsSelectableItem(isChild: true, child: Text('Child')),
              CsSelectableItem(child: Text('Top')),
            ],
          ),
        ),
      );
      final t = tester.element(find.text('Group')).csTokens;
      final group = DefaultTextStyle.of(tester.element(find.text('Group')));
      expect(group.style.fontWeight, FontWeight.w700);
      expect(
        tester.getTopLeft(find.text('Child')).dx -
            tester.getTopLeft(find.text('Top')).dx,
        t.spaceXxl - t.spaceFieldHorizontal,
      );
    });
  });
}

const _kiwi = CsOptionDefinition(
  value: 'k',
  label: 'Kiwi',
  labelTag: 'green',
  tags: ['Sweet'],
  filteringTags: ['zesty', 'lime'],
);
