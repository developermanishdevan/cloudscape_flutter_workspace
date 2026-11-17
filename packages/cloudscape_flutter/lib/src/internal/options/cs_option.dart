// Port of upstream `internal/components/option` (index, option-parts,
// highlight-match).
import 'package:cloudscape_flutter/src/icon/cs_icon.dart';
import 'package:cloudscape_flutter/src/internal/options/option_definition.dart';
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:flutter/widgets.dart';

/// Upstream `splitOnFiltering`: alternating non-match / match segments.
/// Matching is case-insensitive; very long patterns are not highlighted.
List<(String, bool)> csSplitOnFiltering(String str, String highlightText) {
  if (highlightText.isEmpty || highlightText.length > 10000) {
    return [(str, false)];
  }
  final re = RegExp(RegExp.escape(highlightText), caseSensitive: false);
  final out = <(String, bool)>[];
  var last = 0;
  for (final m in re.allMatches(str)) {
    out.add((str.substring(last, m.start), false));
    out.add((m[0]!, true));
    last = m.end;
  }
  out.add((str.substring(last), false));
  return out;
}

/// Text with filter matches highlighted (upstream `HighlightMatch`).
class CsHighlightMatch extends StatelessWidget {
  /// Creates the text.
  const CsHighlightMatch(
    this.text, {
    super.key,
    this.highlightText,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  /// The text.
  final String text;

  /// Text to highlight.
  final String? highlightText;

  /// Max lines.
  final int? maxLines;

  /// Overflow.
  final TextOverflow? overflow;

  /// Soft wrap.
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    final h = highlightText;
    if (h == null || h.isEmpty) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
      );
    }
    final t = CsTheme.tokensOf(context);
    final match = TextStyle(
      backgroundColor: t.colorBackgroundDropdownItemFilterMatch.toColor(),
      color: t.colorTextDropdownItemFilterMatch.toColor(),
      fontWeight: t.fontWeightBold.toFontWeight(),
    );
    final parts = text == h ? [(text, true)] : csSplitOnFiltering(text, h);
    return Text.rich(
      TextSpan(
        children: [
          for (final (s, m) in parts)
            if (s.isNotEmpty) TextSpan(text: s, style: m ? match : null),
        ],
      ),
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}

/// One option's content (upstream internal `Option`): icon, label (with
/// prefix and filter highlighting), label tag, description, tags and
/// matching filtering tags.
class CsOption extends StatelessWidget {
  /// Creates the content.
  const CsOption({
    super.key,
    required this.option,
    this.highlightText,
    this.triggerVariant = false,
    this.isGroupOption = false,
    this.highlightedOption = false,
    this.selectedOption = false,
    this.singleLineLabelContent = false,
    this.customContent,
  });

  /// The option or group.
  final CsOptionItem option;

  /// Filter text to highlight.
  final String? highlightText;

  /// Rendered inside a trigger: single line, inherited font.
  final bool triggerVariant;

  /// A group header.
  final bool isGroupOption;

  /// The row is highlighted.
  final bool highlightedOption;

  /// The row is selected.
  final bool selectedOption;

  /// Keep the label row on one line.
  final bool singleLineLabelContent;

  /// Replaces the whole content.
  final Widget? customContent;

  @override
  Widget build(BuildContext context) {
    final custom = customContent;
    if (custom != null) return SizedBox(width: double.infinity, child: custom);
    final t = CsTheme.tokensOf(context);
    final o = option;
    final oneLine = triggerVariant;
    final secondaryColor = o.disabled
        ? null // `color: currentColor` from the disabled row
        : (highlightedOption && !selectedOption
                  ? t.colorTextDropdownItemSecondaryHover
                  : t.colorTextDropdownItemSecondary)
              .toColor();
    final secondaryStyle = TextStyle(
      fontSize: t.fontSizeBodyS,
      height: t.lineHeightBodyS / t.fontSizeBodyS,
      letterSpacing: t.letterSpacingBodyS.resolve(fontSize: t.fontSizeBodyS),
      color: secondaryColor,
    );

    Widget text(String s, {TextStyle? style}) => DefaultTextStyle.merge(
      style: style,
      child: CsHighlightMatch(
        s,
        highlightText: highlightText,
        maxLines: oneLine ? 1 : null,
        overflow: oneLine ? TextOverflow.ellipsis : null,
        softWrap: !oneLine,
      ),
    );

    final labelText = o.displayLabel ?? '';
    final prefix = o is CsOptionDefinition ? o.labelPrefix : null;
    final Widget label =
        o.labelContent ??
        (prefix != null
            ? Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$prefix ',
                      style: TextStyle(
                        fontWeight: t.fontWeightBold.toFontWeight(),
                      ),
                    ),
                    WidgetSpan(
                      child: CsHighlightMatch(
                        labelText,
                        highlightText: highlightText,
                      ),
                    ),
                  ],
                ),
              )
            : text(labelText));
    final tag = o.labelTag;
    Widget labelRow = tag == null || tag.isEmpty
        ? label
        : Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              label,
              Padding(
                padding: EdgeInsetsDirectional.only(start: t.spaceS),
                child: text(tag),
              ),
            ],
          );
    if (singleLineLabelContent) {
      labelRow = Row(
        children: [
          Flexible(child: label),
          if (tag != null && tag.isNotEmpty)
            Flexible(
              flex: 0,
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: t.spaceS),
                child: Text(tag, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ),
        ],
      );
    }

    final filtering = highlightText == null || highlightText!.isEmpty
        ? const <String>[]
        : [
            for (final ft in o.filteringTags ?? const <String>[])
              if (ft.toLowerCase().contains(highlightText!.toLowerCase())) ft,
          ];
    Widget tagsRow(List<String> tags) => DefaultTextStyle.merge(
      style: secondaryStyle,
      child: Wrap(
        children: [
          for (var i = 0; i < tags.length; i++)
            Padding(
              padding: EdgeInsetsDirectional.only(
                end: i < tags.length - 1 ? t.spaceM : 0,
              ),
              child: CsHighlightMatch(tags[i], highlightText: highlightText),
            ),
        ],
      ),
    );

    Widget? icon;
    final customIcon = o is CsOptionDefinition ? o.customIcon : null;
    if (customIcon != null) {
      icon = customIcon;
    } else if (o.iconName != null || o.iconUrl != null || o.iconSvg != null) {
      icon = CsIcon(
        name: o.iconName,
        url: o.iconUrl,
        svg: o.iconSvg,
        alt: o.iconAlt,
        ariaLabel: o.iconAriaLabel,
      );
    }

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        labelRow,
        if (o.description != null && o.description!.isNotEmpty)
          DefaultTextStyle.merge(
            style: secondaryStyle,
            child: text(o.description!),
          ),
        if (o.tags != null && o.tags!.isNotEmpty) tagsRow(o.tags!),
        if (filtering.isNotEmpty) tagsRow(filtering),
      ],
    );

    var style = const TextStyle();
    if (isGroupOption) {
      style = TextStyle(
        fontWeight: t.fontWeightBold.toFontWeight(),
        color: !o.disabled && !highlightedOption
            ? t.colorTextDropdownGroupLabel.toColor()
            : null,
      );
    }
    if (o.disabled) {
      style = style.copyWith(color: t.colorTextDropdownItemDisabled.toColor());
    }

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Padding(
            padding: EdgeInsetsDirectional.only(end: t.spaceXs),
            child: icon,
          ),
        Expanded(child: content),
      ],
    );
    return Semantics(
      label: o.labelContent == null ? null : o.displayLabel,
      child: DefaultTextStyle.merge(style: style, child: row),
    );
  }
}
