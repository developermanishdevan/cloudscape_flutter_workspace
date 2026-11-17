// The generated API reference of a catalog page: classes, their
// constructors, properties and methods with parameter tables, and enums.
import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:cs_catalog/src/catalog_model.dart';
import 'package:cs_catalog/src/widgets.dart';
import 'package:flutter/widgets.dart';

/// API reference for [entry].
class CatalogApiSection extends StatelessWidget {
  /// Creates the section.
  const CatalogApiSection({super.key, required this.entry});

  /// Page.
  final CatalogEntry entry;

  @override
  Widget build(BuildContext context) => CsSpaceBetween(
    size: CsSpaceBetweenSize.l,
    children: [
      for (final c in entry.classes) _ClassPanel(c),
      if (entry.enums.isNotEmpty)
        CatalogPanel(
          child: CsSpaceBetween(
            size: CsSpaceBetweenSize.m,
            children: [
              Text('Enums', style: context.heading((t) => t.headingM)),
              for (final e in entry.enums) _EnumBlock(e),
            ],
          ),
        ),
    ],
  );
}

class _ClassPanel extends StatelessWidget {
  const _ClassPanel(this.c);

  final CatalogClass c;

  @override
  Widget build(BuildContext context) {
    final ctors = c.members.where((m) => m.isConstructor);
    final props = c.members.where((m) => m.kind == 'property');
    final rest = c.members.where(
      (m) => !m.isConstructor && m.kind != 'property',
    );
    return CatalogPanel(
      child: CsSpaceBetween(
        size: CsSpaceBetweenSize.m,
        children: [
          Wrap(
            spacing: context.csTokens.spaceXs,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(
                c.name,
                style: context.heading((t) => t.monospace(t.headingM)),
              ),
              if (c.superclass != null)
                Text('extends ${c.superclass}', style: context.small),
            ],
          ),
          if (c.doc.isNotEmpty) _Doc(c.doc),
          for (final m in ctors) _MemberBlock(m),
          if (props.isNotEmpty)
            _Table(
              title: 'Properties',
              header: const ['Name', 'Type', 'Description'],
              rows: [
                for (final p in props)
                  [p.name, p.signature.split(' ').first, p.doc],
              ],
              codeColumns: const {0, 1},
            ),
          for (final m in rest) _MemberBlock(m),
        ],
      ),
    );
  }
}

class _MemberBlock extends StatelessWidget {
  const _MemberBlock(this.m);

  final CatalogMember m;

  @override
  Widget build(BuildContext context) => CsSpaceBetween(
    size: CsSpaceBetweenSize.xs,
    children: [
      Text(m.kind, style: context.small),
      _Code(m.signature),
      if (m.doc.isNotEmpty) _Doc(m.doc),
      if (m.params.isNotEmpty)
        _Table(
          header: const ['Parameter', 'Type', 'Default', 'Description'],
          rows: [
            for (final p in m.params)
              [
                p.isRequired ? '${p.name} *' : p.name,
                p.type,
                p.defaultValue ?? (p.isRequired ? 'required' : '–'),
                p.doc,
              ],
          ],
          codeColumns: const {0, 1, 2},
        ),
    ],
  );
}

class _EnumBlock extends StatelessWidget {
  const _EnumBlock(this.e);

  final CatalogEnum e;

  @override
  Widget build(BuildContext context) => CsSpaceBetween(
    size: CsSpaceBetweenSize.xs,
    children: [
      Text(e.name, style: context.code.copyWith(fontWeight: FontWeight.w700)),
      if (e.doc.isNotEmpty) _Doc(e.doc),
      _Table(
        header: const ['Value', 'Description'],
        rows: [
          for (final (name, doc) in e.values) [name, doc],
        ],
        codeColumns: const {0},
      ),
    ],
  );
}

class _Doc extends StatelessWidget {
  const _Doc(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(text, style: context.body);
}

class _Code extends StatelessWidget {
  const _Code(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final t = context.csTokens;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: t.colorBackgroundInlineCode.toColor(),
        borderRadius: BorderRadius.circular(t.borderRadiusContainer / 4),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: t.spaceXs,
          vertical: t.spaceXxs,
        ),
        child: Text(text, style: context.code),
      ),
    );
  }
}

/// A simple bordered table (stand-in for phase 5's Table).
class _Table extends StatelessWidget {
  const _Table({
    required this.header,
    required this.rows,
    this.title,
    this.codeColumns = const {},
  });

  final String? title;
  final List<String> header;
  final List<List<String>> rows;
  final Set<int> codeColumns;

  @override
  Widget build(BuildContext context) {
    final t = context.csTokens;
    final divider = BorderSide(color: t.colorBorderDividerDefault.toColor());
    Widget cell(String text, TextStyle style) => Padding(
      padding: EdgeInsets.symmetric(
        horizontal: t.spaceXs,
        vertical: t.spaceXxs,
      ),
      child: Text(text, style: style),
    );
    final headerStyle = context.body.copyWith(
      fontWeight: FontWeight.w700,
      color: t.colorTextColumnHeader.toColor(),
    );
    final table = Table(
      border: TableBorder(horizontalInside: divider, bottom: divider),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        for (var i = 0; i < header.length; i++)
          i: FlexColumnWidth(i == header.length - 1 ? 2 : 1),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(border: Border(bottom: divider)),
          children: [for (final h in header) cell(h, headerStyle)],
        ),
        for (final r in rows)
          TableRow(
            children: [
              for (var i = 0; i < r.length; i++)
                cell(
                  r[i],
                  codeColumns.contains(i) ? context.code : context.body,
                ),
            ],
          ),
      ],
    );
    return title == null
        ? table
        : CsSpaceBetween(
            size: CsSpaceBetweenSize.xs,
            children: [
              Text(title!, style: context.small),
              table,
            ],
          );
  }
}
