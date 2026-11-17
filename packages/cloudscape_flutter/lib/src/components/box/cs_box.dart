import 'package:cloudscape_flutter/src/internal/flex.dart';
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:cloudscape_flutter/src/theme/spacing.dart';
import 'package:cloudscape_flutter/src/theme/typography.dart';
import 'package:cloudscape_tokens/cloudscape_tokens.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Upstream `BoxProps.Variant`.
enum CsBoxVariant {
  /// `div` (default).
  div,

  /// `span`.
  span,

  /// Heading 1.
  h1,

  /// Heading 2.
  h2,

  /// Heading 3.
  h3,

  /// Heading 4.
  h4,

  /// Heading 5.
  h5,

  /// Paragraph.
  p,

  /// Strong text.
  strong,

  /// Small text.
  small,

  /// Code.
  code,

  /// Preformatted text.
  pre,

  /// Sample output.
  samp,

  /// `awsui-key-label`.
  awsuiKeyLabel,

  /// `awsui-gen-ai-label`.
  awsuiGenAiLabel,

  /// `awsui-value-large`.
  awsuiValueLarge,

  /// `awsui-inline-code`.
  awsuiInlineCode,
}

/// Upstream `BoxProps.Display`.
enum CsBoxDisplay {
  /// Fills the available width.
  block,

  /// Sized to content.
  inline,

  /// Sized to content.
  inlineBlock,

  /// Not rendered.
  none,
}

/// Upstream `BoxProps.TextAlign` (logical: left = start, right = end).
enum CsBoxTextAlign {
  /// Start.
  left,

  /// Center.
  center,

  /// End.
  right,
}

/// Upstream `BoxProps.Float` (logical: inline start / end).
enum CsBoxFloat {
  /// Inline start.
  left,

  /// Inline end.
  right,
}

/// Upstream `BoxProps.FontSize`.
enum CsBoxFontSize {
  /// body-s.
  bodyS,

  /// body-m.
  bodyM,

  /// heading-xs.
  headingXs,

  /// heading-s.
  headingS,

  /// heading-m.
  headingM,

  /// heading-l.
  headingL,

  /// heading-xl.
  headingXl,

  /// display-l.
  displayL,

  /// display-xl.
  displayXl,
}

/// Upstream `BoxProps.FontWeight`.
enum CsBoxFontWeight {
  /// `font-weight-lighter`.
  light,

  /// `font-weight-normal`.
  normal,

  /// `font-weight-bold`.
  bold,

  /// `font-weight-heavy`.
  heavy,
}

/// Upstream `BoxProps.Color`.
enum CsBoxColor {
  /// The parent's color.
  inherit,

  /// `color-text-label`.
  textLabel,

  /// `color-text-body-secondary`.
  textBodySecondary,

  /// `color-text-status-error`.
  textStatusError,

  /// `color-text-status-success`.
  textStatusSuccess,

  /// `color-text-status-info`.
  textStatusInfo,

  /// `color-text-status-inactive`.
  textStatusInactive,

  /// `color-text-status-warning`.
  textStatusWarning,

  /// Internal upstream `inverted` (`color-text-notification-default`).
  inverted,
}

/// Upstream `BoxProps.Spacing`: per-side sizes. When a side is set by both
/// a specific side and `horizontal`/`vertical`, the larger size wins (the
/// later CSS rule).
@immutable
class CsBoxSpacing {
  /// Creates per-side spacing.
  const CsBoxSpacing({
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.horizontal,
    this.vertical,
  }) : all = null;

  /// The same size on every side (upstream string shorthand).
  const CsBoxSpacing.all(CsSpacing this.all)
    : top = null,
      right = null,
      bottom = null,
      left = null,
      horizontal = null,
      vertical = null;

  /// Shorthand for every side.
  final CsSpacing? all;

  /// Top.
  final CsSpacing? top;

  /// Right (inline end).
  final CsSpacing? right;

  /// Bottom.
  final CsSpacing? bottom;

  /// Left (inline start).
  final CsSpacing? left;

  /// Left and right.
  final CsSpacing? horizontal;

  /// Top and bottom.
  final CsSpacing? vertical;

  static CsSpacing? _later(CsSpacing? a, CsSpacing? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.index >= b.index ? a : b;
  }

  /// Resolved sides; vertical sides use density-scaled tokens, horizontal
  /// sides the base tokens (like upstream).
  ({double? top, double? end, double? bottom, double? start}) resolve(
    CsTokens t,
  ) {
    final a = all;
    if (a != null) {
      return (
        top: a.scaled(t),
        end: a.of(t),
        bottom: a.scaled(t),
        start: a.of(t),
      );
    }
    return (
      top: _later(top, vertical)?.scaled(t),
      end: _later(right, horizontal)?.of(t),
      bottom: _later(bottom, vertical)?.scaled(t),
      start: _later(left, horizontal)?.of(t),
    );
  }
}

/// Upstream `BoxProps.VisualAccent.Color`.
enum CsVisualAccentColor {
  /// Red.
  red,

  /// Yellow.
  yellow,

  /// Indigo.
  indigo,

  /// Green.
  green,

  /// Orange.
  orange,

  /// Purple.
  purple,

  /// Grey.
  grey,

  /// Teal.
  teal,
}

/// Upstream `BoxProps.VisualAccent.BorderRadius` (spacing sizes or full).
enum CsVisualAccentRadius {
  /// space-xxxs.
  xxxs,

  /// space-xxs.
  xxs,

  /// space-xs.
  xs,

  /// space-s.
  s,

  /// space-m.
  m,

  /// space-l.
  l,

  /// space-xl.
  xl,

  /// space-xxl.
  xxl,

  /// space-xxxl.
  xxxl,

  /// 50% (an ellipse / circle).
  full,
}

/// Upstream `BoxProps.VisualAccent`.
@immutable
class CsVisualAccent {
  /// Creates a visual accent.
  const CsVisualAccent({
    required this.color,
    this.equalAspectRatio = false,
    this.borderRadius,
  });

  /// Accent color.
  final CsVisualAccentColor color;

  /// `aspectRatio: 'equal'` (square, `space-xs` padding).
  final bool equalAspectRatio;

  /// Corner radius.
  final CsVisualAccentRadius? borderRadius;
}

/// A typography and spacing container (upstream `Box`).
class CsBox extends StatelessWidget {
  /// Creates a box.
  const CsBox({
    super.key,
    this.variant = CsBoxVariant.div,
    this.tagOverride,
    this.display,
    this.margin,
    this.padding,
    this.textAlign,
    this.float,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.visualAccent,
    this.child,
  });

  /// Creates a box with text content.
  CsBox.text(
    String text, {
    Key? key,
    CsBoxVariant variant = CsBoxVariant.div,
    String? tagOverride,
    CsBoxDisplay? display,
    CsBoxSpacing? margin,
    CsBoxSpacing? padding,
    CsBoxTextAlign? textAlign,
    CsBoxFloat? float,
    CsBoxFontSize? fontSize,
    CsBoxFontWeight? fontWeight,
    CsBoxColor? color,
    CsVisualAccent? visualAccent,
  }) : this(
         key: key,
         variant: variant,
         tagOverride: tagOverride,
         display: display,
         margin: margin,
         padding: padding,
         textAlign: textAlign,
         float: float,
         fontSize: fontSize,
         fontWeight: fontWeight,
         color: color,
         visualAccent: visualAccent,
         child: Text(text),
       );

  /// Visual and semantic variant.
  final CsBoxVariant variant;

  /// Semantic tag override, e.g. `h2` (affects heading semantics only).
  final String? tagOverride;

  /// Display mode; defaults per variant.
  final CsBoxDisplay? display;

  /// Outer spacing.
  final CsBoxSpacing? margin;

  /// Inner spacing.
  final CsBoxSpacing? padding;

  /// Text alignment.
  final CsBoxTextAlign? textAlign;

  /// Inline-start / inline-end placement.
  final CsBoxFloat? float;

  /// Font size (overrides the variant).
  final CsBoxFontSize? fontSize;

  /// Font weight (overrides the variant).
  final CsBoxFontWeight? fontWeight;

  /// Text color (overrides the variant).
  final CsBoxColor? color;

  /// Background accent.
  final CsVisualAccent? visualAccent;

  /// Content.
  final Widget? child;

  /// Upstream `getTag`.
  String get _tag =>
      tagOverride ??
      switch (variant) {
        CsBoxVariant.awsuiValueLarge => 'span',
        CsBoxVariant.awsuiKeyLabel || CsBoxVariant.awsuiGenAiLabel => 'div',
        CsBoxVariant.awsuiInlineCode => 'code',
        _ => variant.name,
      };

  CsBoxDisplay get _defaultDisplay => switch (_tag) {
    'span' ||
    'strong' ||
    'code' ||
    'samp' ||
    'b' ||
    'a' ||
    'em' ||
    'i' => CsBoxDisplay.inline,
    _ =>
      variant == CsBoxVariant.small
          ? CsBoxDisplay.inlineBlock
          : CsBoxDisplay.block,
  };

  static (double, double, CsLength?) _size(CsBoxFontSize s, CsTokens t) =>
      switch (s) {
        CsBoxFontSize.bodyS => (
          t.fontSizeBodyS,
          t.lineHeightBodyS,
          t.letterSpacingBodyS,
        ),
        CsBoxFontSize.bodyM => (t.fontSizeBodyM, t.lineHeightBodyM, null),
        CsBoxFontSize.headingXs => (
          t.fontSizeHeadingXs,
          t.lineHeightHeadingXs,
          t.letterSpacingHeadingXs,
        ),
        CsBoxFontSize.headingS => (
          t.fontSizeHeadingS,
          t.lineHeightHeadingS,
          t.letterSpacingHeadingS,
        ),
        CsBoxFontSize.headingM => (
          t.fontSizeHeadingM,
          t.lineHeightHeadingM,
          t.letterSpacingHeadingM,
        ),
        CsBoxFontSize.headingL => (
          t.fontSizeHeadingL,
          t.lineHeightHeadingL,
          t.letterSpacingHeadingL,
        ),
        CsBoxFontSize.headingXl => (
          t.fontSizeHeadingXl,
          t.lineHeightHeadingXl,
          t.letterSpacingHeadingXl,
        ),
        CsBoxFontSize.displayL => (
          t.fontSizeDisplayL,
          t.lineHeightDisplayL,
          t.letterSpacingDisplayL,
        ),
        CsBoxFontSize.displayXl => (
          t.fontSizeDisplayXl,
          t.lineHeightDisplayXl,
          t.letterSpacingDisplayXl,
        ),
      };

  CsBoxFontSize get _defaultSize => switch (variant) {
    CsBoxVariant.small ||
    CsBoxVariant.code ||
    CsBoxVariant.awsuiGenAiLabel ||
    CsBoxVariant.awsuiInlineCode => CsBoxFontSize.bodyS,
    CsBoxVariant.h5 => CsBoxFontSize.headingXs,
    CsBoxVariant.h4 => CsBoxFontSize.headingS,
    CsBoxVariant.h3 => CsBoxFontSize.headingM,
    CsBoxVariant.h2 => CsBoxFontSize.headingL,
    CsBoxVariant.h1 => CsBoxFontSize.headingXl,
    CsBoxVariant.awsuiValueLarge => CsBoxFontSize.displayL,
    _ => CsBoxFontSize.bodyM,
  };

  CsFontWeight _weight(CsTokens t) => switch (fontWeight) {
    CsBoxFontWeight.light => t.fontWeightLighter,
    CsBoxFontWeight.normal => t.fontWeightNormal,
    CsBoxFontWeight.bold => t.fontWeightBold,
    CsBoxFontWeight.heavy => t.fontWeightHeavy,
    null => switch (variant) {
      CsBoxVariant.strong => t.fontWeightBold,
      CsBoxVariant.h5 => t.fontWeightHeadingXs,
      CsBoxVariant.h4 => t.fontWeightHeadingS,
      CsBoxVariant.h3 => t.fontWeightHeadingM,
      CsBoxVariant.h2 => t.fontWeightHeadingL,
      CsBoxVariant.h1 => t.fontWeightHeadingXl,
      CsBoxVariant.awsuiKeyLabel => t.fontDisplayLabelWeight,
      CsBoxVariant.awsuiValueLarge => t.fontWeightDisplayL,
      _ => t.fontWeightNormal,
    },
  };

  /// The color, or null to inherit the parent's.
  Color? _color(CsTokens t) {
    final accent = visualAccent;
    if (color != null) {
      return switch (color!) {
        CsBoxColor.inherit => null,
        CsBoxColor.textLabel => t.colorTextLabel.toColor(),
        CsBoxColor.textBodySecondary => t.colorTextBodySecondary.toColor(),
        CsBoxColor.textStatusError => t.colorTextStatusError.toColor(),
        CsBoxColor.textStatusSuccess => t.colorTextStatusSuccess.toColor(),
        CsBoxColor.textStatusInfo => t.colorTextStatusInfo.toColor(),
        CsBoxColor.textStatusInactive => t.colorTextStatusInactive.toColor(),
        CsBoxColor.textStatusWarning => t.colorTextStatusWarning.toColor(),
        CsBoxColor.inverted => t.colorTextNotificationDefault.toColor(),
      };
    }
    if (accent != null) {
      return switch (accent.color) {
        CsVisualAccentColor.red => t.colorTextVisualAccentRed,
        CsVisualAccentColor.yellow => t.colorTextVisualAccentYellow,
        CsVisualAccentColor.indigo => t.colorTextVisualAccentIndigo,
        CsVisualAccentColor.green => t.colorTextVisualAccentGreen,
        CsVisualAccentColor.orange => t.colorTextVisualAccentOrange,
        CsVisualAccentColor.purple => t.colorTextVisualAccentPurple,
        CsVisualAccentColor.grey => t.colorTextVisualAccentGrey,
        CsVisualAccentColor.teal => t.colorTextVisualAccentTeal,
      }.toColor();
    }
    return switch (variant) {
      CsBoxVariant.h1 ||
      CsBoxVariant.h2 ||
      CsBoxVariant.h3 ||
      CsBoxVariant.h4 ||
      CsBoxVariant.h5 => t.colorTextHeadingDefault.toColor(),
      CsBoxVariant.small => t.colorTextSmall.toColor(),
      CsBoxVariant.awsuiKeyLabel => t.colorTextLabel.toColor(),
      CsBoxVariant.awsuiGenAiLabel => t.colorTextLabelGenAi.toColor(),
      CsBoxVariant.awsuiValueLarge => null, // color: inherit
      _ => t.colorTextBodyDefault.toColor(),
    };
  }

  Color _accentBackground(CsTokens t, CsVisualAccentColor c) => switch (c) {
    CsVisualAccentColor.red => t.colorBackgroundVisualAccentRed,
    CsVisualAccentColor.yellow => t.colorBackgroundVisualAccentYellow,
    CsVisualAccentColor.indigo => t.colorBackgroundVisualAccentIndigo,
    CsVisualAccentColor.green => t.colorBackgroundVisualAccentGreen,
    CsVisualAccentColor.orange => t.colorBackgroundVisualAccentOrange,
    CsVisualAccentColor.purple => t.colorBackgroundVisualAccentPurple,
    CsVisualAccentColor.grey => t.colorBackgroundVisualAccentGrey,
    CsVisualAccentColor.teal => t.colorBackgroundVisualAccentTeal,
  }.toColor();

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    final effectiveDisplay = display ?? _defaultDisplay;
    if (effectiveDisplay == CsBoxDisplay.none) return const SizedBox.shrink();

    // Typography: the `.root` reset, then variant defaults, then props.
    final (size, lineHeight, letterSpacing) = _size(
      fontSize ?? _defaultSize,
      t,
    );
    final monospace = const {
      CsBoxVariant.code,
      CsBoxVariant.pre,
      CsBoxVariant.samp,
      CsBoxVariant.awsuiInlineCode,
    }.contains(variant);
    final family = csFontFamily(
      monospace
          ? t.fontFamilyMonospace
          : variant == CsBoxVariant.awsuiValueLarge
          ? t.fontFamilyDisplay
          : t.fontFamilyBase,
    );
    final parent = DefaultTextStyle.of(context);
    final style = parent.style.merge(
      TextStyle(
        fontFamily: family.family,
        fontFamilyFallback: family.fallback,
        fontSize: size,
        height: lineHeight / size,
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: letterSpacing?.resolve(fontSize: size),
        fontWeight: _weight(t).toFontWeight(),
        fontStyle: variant == CsBoxVariant.awsuiGenAiLabel
            ? FontStyle.italic
            : null,
        color: _color(t),
      ),
    );
    final align = switch (textAlign) {
      CsBoxTextAlign.left => TextAlign.start,
      CsBoxTextAlign.center => TextAlign.center,
      CsBoxTextAlign.right => TextAlign.end,
      null => parent.textAlign ?? TextAlign.start,
    };
    Widget content = DefaultTextStyle(
      style: style,
      textAlign: align,
      softWrap: parent.softWrap,
      overflow: parent.overflow,
      maxLines: parent.maxLines,
      child: child ?? const SizedBox.shrink(),
    );

    // Padding: variant defaults, then per-side props.
    final headingLike = const {
      CsBoxVariant.h1,
      CsBoxVariant.h2,
      CsBoxVariant.h3,
      CsBoxVariant.h4,
      CsBoxVariant.h5,
      CsBoxVariant.p,
    }.contains(variant);
    final accent = visualAccent;
    var pTop = 0.0, pBottom = 0.0, pStart = 0.0, pEnd = 0.0;
    if (headingLike) pTop = pBottom = t.spaceXxs;
    if (variant == CsBoxVariant.awsuiInlineCode) {
      pTop = pBottom = t.spaceStaticXxxs;
      pStart = pEnd = t.spaceStaticXxs;
    }
    if (accent != null) {
      pTop = pBottom = accent.equalAspectRatio ? t.spaceXs : t.spaceXxs;
      pStart = pEnd = t.spaceXs;
    }
    final p = padding?.resolve(t);
    if (p != null) {
      pTop = p.top ?? pTop;
      pBottom = p.bottom ?? pBottom;
      pStart = p.start ?? pStart;
      pEnd = p.end ?? pEnd;
    }
    content = Padding(
      padding: EdgeInsetsDirectional.fromSTEB(pStart, pTop, pEnd, pBottom),
      child: content,
    );

    if (accent != null) {
      content = Center(widthFactor: 1, heightFactor: 1, child: content);
      // CSS `aspect-ratio: 1/1; inline-size: fit-content`: a square sized to
      // the content, not to the available width.
      if (accent.equalAspectRatio) content = _FitContentSquare(child: content);
      final bg = _accentBackground(t, accent.color);
      final r = accent.borderRadius;
      content = r == CsVisualAccentRadius.full
          ? ClipOval(
              child: ColoredBox(color: bg, child: content),
            )
          : DecoratedBox(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: r == null
                    ? null
                    : BorderRadius.circular(
                        CsSpacing.values[r.index + 1].of(t),
                      ),
              ),
              child: content,
            );
    } else if (variant == CsBoxVariant.awsuiInlineCode) {
      content = DecoratedBox(
        decoration: BoxDecoration(
          color: t.colorBackgroundInlineCode.toColor(),
          borderRadius: BorderRadius.circular(t.spaceStaticXxs),
        ),
        child: content,
      );
    }

    if (effectiveDisplay == CsBoxDisplay.block && accent == null) {
      content = CsFlex(direction: Axis.vertical, children: [content]);
    } else {
      // Inline content never stretches, even under tight constraints.
      content = Align(
        alignment: AlignmentDirectional.topStart,
        widthFactor: 1,
        heightFactor: 1,
        child: content,
      );
    }

    // Margin: variant default, then per-side props.
    var mBottom = variant == CsBoxVariant.awsuiKeyLabel
        ? t.spaceKeyValueGap
        : 0.0;
    var mTop = 0.0, mStart = 0.0, mEnd = 0.0;
    final m = margin?.resolve(t);
    if (m != null) {
      mTop = m.top ?? mTop;
      mBottom = m.bottom ?? mBottom;
      mStart = m.start ?? mStart;
      mEnd = m.end ?? mEnd;
    }
    if (mTop != 0 || mBottom != 0 || mStart != 0 || mEnd != 0) {
      content = Padding(
        padding: EdgeInsetsDirectional.fromSTEB(mStart, mTop, mEnd, mBottom),
        child: content,
      );
    }

    if (float != null) {
      content = Align(
        alignment: float == CsBoxFloat.left
            ? AlignmentDirectional.topStart
            : AlignmentDirectional.topEnd,
        widthFactor: null,
        heightFactor: 1,
        child: content,
      );
    }

    final heading = RegExp(r'^h([1-6])$').firstMatch(_tag);
    if (heading != null) {
      content = Semantics(
        header: true,
        headingLevel: int.parse(heading[1]!),
        child: content,
      );
    }
    if (variant == CsBoxVariant.h1) {
      // Upstream gives h1 boxes tabIndex=-1 so flashbars can focus them.
      content = Focus(skipTraversal: true, child: content);
    }
    return content;
  }
}

class _FitContentSquare extends SingleChildRenderObjectWidget {
  const _FitContentSquare({required super.child});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderFitContentSquare();
}

class _RenderFitContentSquare extends RenderShiftedBox {
  _RenderFitContentSquare() : super(null);

  @override
  void performLayout() {
    final c = child;
    if (c == null) {
      size = constraints.smallest;
      return;
    }
    c.layout(constraints.loosen(), parentUsesSize: true);
    final side = c.size.width > c.size.height ? c.size.width : c.size.height;
    size = constraints.constrain(Size.square(side));
    (c.parentData! as BoxParentData).offset = Offset(
      (size.width - c.size.width) / 2,
      (size.height - c.size.height) / 2,
    );
  }
}
