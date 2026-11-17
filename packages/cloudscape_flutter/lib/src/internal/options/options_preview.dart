import 'package:cloudscape_flutter/src/icon/cs_icon.dart';
import 'package:cloudscape_flutter/src/icon/generated/icons.g.dart';
import 'package:cloudscape_flutter/src/internal/editable_field/cs_editable_field.dart';
import 'package:cloudscape_flutter/src/internal/options/cs_option.dart';
import 'package:cloudscape_flutter/src/internal/options/cs_options_list.dart';
import 'package:cloudscape_flutter/src/internal/options/highlight.dart';
import 'package:cloudscape_flutter/src/internal/options/option_definition.dart';
import 'package:cloudscape_flutter/src/internal/options/option_utils.dart';
import 'package:cloudscape_flutter/src/internal/selectable_item.dart';
import 'package:cloudscape_flutter/src/preview/cs_preview.dart';
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:flutter/widgets.dart';

const List<CsOptionItem> _groupedOptions = [
  CsOptionDefinition(
    value: 'ec2',
    label: 'Amazon EC2',
    description: 'Virtual servers in the cloud',
    iconName: CsIconName.settings,
    labelTag: 'Compute',
  ),
  CsOptionGroup(
    label: 'Storage',
    options: [
      CsOptionDefinition(
        value: 's3',
        label: 'Amazon S3',
        tags: ['Object', 'Durable'],
      ),
      CsOptionDefinition(value: 'ebs', label: 'Amazon EBS', labelTag: 'Block'),
      CsOptionDefinition(
        value: 'efs',
        label: 'Amazon EFS',
        disabled: true,
        description: 'Disabled option',
      ),
    ],
  ),
  CsOptionGroup(
    label: 'Databases',
    options: [
      CsOptionDefinition(
        value: 'rds',
        label: 'Amazon RDS',
        filteringTags: ['postgres', 'mysql'],
      ),
      CsOptionDefinition(value: 'ddb', label: 'Amazon DynamoDB'),
    ],
  ),
  CsOptionGroup(
    label: 'Disabled group',
    disabled: true,
    options: [CsOptionDefinition(value: 'x', label: 'Unavailable')],
  ),
  CsOptionDefinition(
    value: 'lambda',
    label: 'AWS Lambda',
    labelPrefix: 'New',
    iconName: CsIconName.statusPositive,
  ),
];

/// An option list wired like upstream's select: ↑/↓/Home/End and pointer
/// hover move the highlight over interactive rows; Enter or a click selects.
class _OptionsDemo extends StatefulWidget {
  const _OptionsDemo({
    required this.options,
    this.filtering = false,
    this.initialFilter = '',
    this.virtualScroll = false,
  });

  final List<CsOptionItem> options;
  final bool filtering;
  final String initialFilter;
  final bool virtualScroll;

  @override
  State<_OptionsDemo> createState() => _OptionsDemoState();
}

class _OptionsDemoState extends State<_OptionsDemo> {
  late final TextEditingController _text = TextEditingController(
    text: widget.initialFilter,
  );
  final FocusNode _listFocus = FocusNode(debugLabel: 'preview options');
  final FocusNode _textFocus = FocusNode(debugLabel: 'preview filter');
  late CsPreparedOptions _prepared;
  late final CsHighlightController _highlight;
  CsOptionItem? _selected;

  @override
  void initState() {
    super.initState();
    _prepare();
    _highlight = CsHighlightController(
      options: _prepared.filteredOptions,
      isHighlightable: csIsInteractive,
    )..addListener(() => setState(() {}));
    _text.addListener(() {
      setState(_prepare);
      _highlight
        ..options = _prepared.filteredOptions
        ..resetHighlightWithKeyboard();
    });
  }

  void _prepare() => _prepared = csPrepareOptions(
    widget.options,
    widget.filtering
        ? CsOptionsFilteringType.auto
        : CsOptionsFilteringType.none,
    _text.text,
  );

  @override
  void dispose() {
    _highlight.dispose();
    _text.dispose();
    _listFocus.dispose();
    _textFocus.dispose();
    super.dispose();
  }

  void _select(int index) {
    final row = _prepared.filteredOptions[index];
    if (!csIsInteractive(row)) return;
    setState(() => _selected = row.option);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) => csMenuKeyHandler(
    goUp: () => _highlight.moveHighlightWithKeyboard(-1),
    goDown: () => _highlight.moveHighlightWithKeyboard(1),
    goHome: _highlight.goHomeWithKeyboard,
    goEnd: _highlight.goEndWithKeyboard,
    selectOption: () {
      final i = _highlight.highlightedIndex;
      if (i >= 0) _select(i);
    },
  )(node, event);

  Widget _row(BuildContext context, int i) {
    final rows = _prepared.filteredOptions;
    final row = rows[i];
    final isParent = row.type == CsDropdownOptionType.parent;
    final isLastInGroup =
        row.type == CsDropdownOptionType.child &&
        (i == rows.length - 1 ||
            rows[i + 1].type != CsDropdownOptionType.child);
    final highlighted = i == _highlight.highlightedIndex && !isParent;
    final selected = identical(row.option, _selected);
    return CsSelectableItem(
      isParent: isParent,
      isChild: row.type == CsDropdownOptionType.child,
      padBottom: isLastInGroup,
      highlighted: highlighted,
      highlightType: _highlight.highlightType.type,
      selected: selected,
      disabled: row.disabled,
      child: CsOption(
        option: row.option,
        isGroupOption: isParent,
        highlightText: widget.filtering ? _text.text : null,
        highlightedOption: highlighted,
        selectedOption: selected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    final rows = _prepared.filteredOptions;
    final list = Container(
      height: 300,
      decoration: BoxDecoration(
        color: t.colorBackgroundDropdownItemDefault.toColor(),
        border: Border.all(
          color: t.colorBorderDropdownContainer.toColor(),
          width: t.borderWidthDropdown,
        ),
        borderRadius: BorderRadius.circular(t.borderRadiusDropdown),
      ),
      child: CsOptionsList(
        itemCount: rows.length,
        itemBuilder: _row,
        virtualScroll: widget.virtualScroll,
        highlightedIndex: _highlight.highlightedIndex,
        highlight: _highlight.highlightType,
        focusNode: _listFocus,
        embedded: true,
        onKeyEvent: _onKey,
        onMouseMove: (i) {
          if (csIsInteractive(rows[i])) {
            _highlight.setHighlightedIndexWithMouse(i);
          }
        },
        onMouseUp: (i) {
          _select(i);
          _listFocus.requestFocus();
        },
      ),
    );
    final status = DefaultTextStyle.merge(
      style: TextStyle(
        color: t.colorTextBodySecondary.toColor(),
        fontSize: t.fontSizeBodyS,
      ),
      child: Text(
        'Selected: ${_selected?.displayLabel ?? '-'} · '
        '${_prepared.matchesCount}/${_prepared.totalCount} rows',
      ),
    );
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.filtering) ...[
            CsEditableField(
              controller: _text,
              focusNode: _textFocus,
              placeholder: 'Filter options',
              ariaLabel: 'Filter options',
              onKeyEvent: _onKey,
              startIcon: const CsIcon(name: CsIconName.search),
            ),
            SizedBox(height: t.spaceXs),
          ],
          list,
          SizedBox(height: t.spaceXs),
          status,
        ],
      ),
    );
  }
}

/// Option list: groups, descriptions, tags, icons, disabled rows.
@CsPreview(
  group: 'Option list',
  name: 'Options and groups',
  size: Size(360, 420),
)
Widget csOptionListGroupsPreview() =>
    const _OptionsDemo(options: _groupedOptions);

/// Option list: auto filtering with match highlighting (try "am", "post").
@CsPreview(group: 'Option list', name: 'Filtering', size: Size(360, 460))
Widget csOptionListFilteringPreview() => const _OptionsDemo(
  options: _groupedOptions,
  filtering: true,
  initialFilter: 'am',
);

/// Option list: 1,000 options, only visible rows are built.
@CsPreview(
  group: 'Option list',
  name: 'Virtual scroll (1,000 options)',
  size: Size(360, 420),
)
Widget csOptionListVirtualPreview() => _OptionsDemo(
  options: [
    for (var i = 1; i <= 1000; i++)
      CsOptionDefinition(
        value: '$i',
        label: 'Option $i',
        description: i % 5 == 0 ? 'Every fifth option has a description' : null,
        disabled: i % 7 == 0,
      ),
  ],
  virtualScroll: true,
);
