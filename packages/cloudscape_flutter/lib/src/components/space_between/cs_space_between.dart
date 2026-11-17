import 'package:cloudscape_flutter/src/internal/flex.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:cloudscape_flutter/src/theme/spacing.dart';
import 'package:flutter/widgets.dart';

/// Upstream `SpaceBetweenProps.Direction`.
enum CsSpaceBetweenDirection {
  /// A column (default).
  vertical,

  /// A wrapping row.
  horizontal,
}

/// Upstream `SpaceBetweenProps.Size`.
enum CsSpaceBetweenSize {
  /// xxxs.
  xxxs,

  /// xxs.
  xxs,

  /// xs.
  xs,

  /// s.
  s,

  /// m.
  m,

  /// l.
  l,

  /// xl.
  xl,

  /// xxl.
  xxl,
}

/// Upstream `SpaceBetweenProps.AlignItems`.
enum CsSpaceBetweenAlign {
  /// Center.
  center,

  /// Start.
  start,

  /// End.
  end,
}

/// Lays out children with consistent gaps (upstream `SpaceBetween`).
class CsSpaceBetween extends StatelessWidget {
  /// Creates the layout. Null children are skipped.
  const CsSpaceBetween({
    super.key,
    this.direction = CsSpaceBetweenDirection.vertical,
    required this.size,
    this.alignItems,
    this.children = const [],
  });

  /// Column or wrapping row.
  final CsSpaceBetweenDirection direction;

  /// Gap size.
  final CsSpaceBetweenSize size;

  /// Cross-axis alignment (default: stretch).
  final CsSpaceBetweenAlign? alignItems;

  /// Items.
  final List<Widget?> children;

  /// The gap upstream uses: rows use base `space-*`; columns use base
  /// tokens up to xs and density-scaled tokens from s.
  static double gapOf(
    BuildContext context,
    CsSpaceBetweenDirection direction,
    CsSpaceBetweenSize size,
  ) {
    final t = CsTheme.tokensOf(context);
    final spacing = CsSpacing.values[size.index + 1]; // skip `none`
    final scaled =
        direction == CsSpaceBetweenDirection.vertical &&
        size.index >= CsSpaceBetweenSize.s.index;
    return scaled ? spacing.scaled(t) : spacing.of(t);
  }

  @override
  Widget build(BuildContext context) {
    final gap = gapOf(context, direction, size);
    final align = switch (alignItems) {
      CsSpaceBetweenAlign.center => CsFlexAlign.center,
      CsSpaceBetweenAlign.start => CsFlexAlign.start,
      CsSpaceBetweenAlign.end => CsFlexAlign.end,
      null => CsFlexAlign.stretch,
    };
    final items = [for (final c in children) ?c];
    return direction == CsSpaceBetweenDirection.vertical
        ? CsFlex(
            direction: Axis.vertical,
            mainGap: gap,
            alignItems: align,
            children: items,
          )
        : CsFlex(
            direction: Axis.horizontal,
            wrap: true,
            mainGap: gap,
            crossGap: gap,
            alignItems: align,
            children: items,
          );
  }
}
