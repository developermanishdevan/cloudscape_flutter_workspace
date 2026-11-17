// Port of upstream `dropdown/dropdown-fit-handler.js` (getAvailableSpace,
// getDropdownPosition, getInteriorDropdownPosition, hasEnoughSpaceForFlexibleWidth).
// All rects are logical: `left` is inline start (mirrored in RTL by callers).
import 'dart:math' as math;
import 'dart:ui';

/// Space reserve around the trigger (upstream constants).
const double csDropdownReserveDefault = 50;

/// Vertical reserve on mobile (50 - 31).
const double csDropdownReserveMobileVertical = 19;

/// Horizontal reserve on mobile.
const double csDropdownReserveMobileHorizontal = 20;

/// Upstream mobile breakpoint (`xs`, px).
const double csMobileBreakpoint = 688;

/// A width constraint: a pixel value or the trigger's width.
sealed class CsDropdownWidth {
  /// A fixed pixel width.
  const factory CsDropdownWidth.px(double value) = _PxWidth;

  const CsDropdownWidth();

  /// The trigger's width.
  static const CsDropdownWidth trigger = _TriggerWidth();

  double _resolve(double triggerWidth);
}

class _TriggerWidth extends CsDropdownWidth {
  const _TriggerWidth();

  @override
  double _resolve(double triggerWidth) => triggerWidth;

  @override
  bool operator ==(Object other) => other is _TriggerWidth;

  @override
  int get hashCode => 1;
}

class _PxWidth extends CsDropdownWidth {
  const _PxWidth(this.value);

  final double value;

  @override
  double _resolve(double triggerWidth) => value;

  @override
  bool operator ==(Object other) => other is _PxWidth && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

/// Resolves an optional constraint (upstream `resolveWidthConstraint`).
double csResolveDropdownWidth(
  CsDropdownWidth? c,
  double triggerWidth,
  double fallback,
) => c == null ? fallback : c._resolve(triggerWidth);

/// Available space around the trigger in each logical direction.
typedef CsAvailableSpace = ({
  double blockStart,
  double blockEnd,
  double inlineStart,
  double inlineEnd,
});

/// Upstream `getAvailableSpace`.
CsAvailableSpace csDropdownAvailableSpace({
  required Rect trigger,
  required List<Rect> overflowParents,
  bool stretchWidth = false,
  bool stretchHeight = false,
  bool isMobile = false,
}) {
  final reserveV = stretchHeight
      ? 0.0
      : (isMobile ? csDropdownReserveMobileVertical : csDropdownReserveDefault);
  final reserveH = stretchWidth
      ? 0.0
      : (isMobile
            ? csDropdownReserveMobileHorizontal
            : csDropdownReserveDefault);
  var space = (
    blockStart: double.maxFinite,
    blockEnd: double.maxFinite,
    inlineStart: double.maxFinite,
    inlineEnd: double.maxFinite,
  );
  for (final p in overflowParents) {
    final offsetTop = trigger.bottom - p.top;
    space = (
      blockStart: math.min(
        space.blockStart,
        offsetTop - trigger.height - reserveV,
      ),
      blockEnd: math.min(space.blockEnd, p.height - offsetTop - reserveV),
      inlineStart: math.min(
        space.inlineStart,
        trigger.right - p.left - reserveH,
      ),
      inlineEnd: math.min(
        space.inlineEnd,
        p.left + p.width - trigger.left - reserveH,
      ),
    );
  }
  return space;
}

/// Upstream `getInteriorAvailableSpace`.
CsAvailableSpace csInteriorAvailableSpace({
  required Rect trigger,
  required List<Rect> overflowParents,
  bool isMobile = false,
}) {
  final reserveV = isMobile
      ? csDropdownReserveMobileVertical
      : csDropdownReserveDefault;
  final reserveH = isMobile
      ? csDropdownReserveMobileHorizontal
      : csDropdownReserveDefault;
  var space = (
    blockStart: double.maxFinite,
    blockEnd: double.maxFinite,
    inlineStart: double.maxFinite,
    inlineEnd: double.maxFinite,
  );
  for (final p in overflowParents) {
    space = (
      blockStart: math.min(space.blockStart, trigger.bottom - p.top - reserveV),
      blockEnd: math.min(
        space.blockEnd,
        p.height - trigger.top + p.top - reserveV,
      ),
      inlineStart: math.min(
        space.inlineStart,
        trigger.left - p.left - reserveH,
      ),
      inlineEnd: math.min(
        space.inlineEnd,
        p.left + p.width - trigger.right - reserveH,
      ),
    );
  }
  return space;
}

/// The computed dropdown placement (upstream `DropdownPosition`).
class CsDropdownPosition {
  /// Creates a position.
  const CsDropdownPosition({
    required this.dropBlockStart,
    required this.dropInlineStart,
    required this.blockSize,
    required this.inlineSize,
    this.insetInlineStart,
  });

  /// Opens upwards (above the trigger).
  final bool dropBlockStart;

  /// Aligned to the trigger's inline end (opens towards inline start).
  final bool dropInlineStart;

  /// Max height of the content area.
  final double blockSize;

  /// Width.
  final double inlineSize;

  /// Logical x offset from the trigger's inline start (centered alignment
  /// or interior fly-outs); null when aligned to an edge.
  final double? insetInlineStart;

  @override
  String toString() =>
      'CsDropdownPosition(up: $dropBlockStart, start: $dropInlineStart, h: $blockSize, w: $inlineSize, x: $insetInlineStart)';
}

/// Widths used by the algorithm (upstream `getWidths`).
({double idealWidth, double minWidth}) csDropdownWidths({
  required double triggerWidth,
  required double requiredWidth,
  CsDropdownWidth? minWidth,
  CsDropdownWidth? maxWidth,
}) {
  final min = csResolveDropdownWidth(minWidth, triggerWidth, 0);
  final max = csResolveDropdownWidth(maxWidth, triggerWidth, double.maxFinite);
  return (
    idealWidth: math.min(math.max(requiredWidth, min), max),
    minWidth: min,
  );
}

/// Upstream `hasEnoughSpaceForFlexibleWidth`.
bool csHasEnoughSpaceForFlexibleWidth({
  required Rect trigger,
  required List<Rect> overflowParents,
  required double requiredWidth,
  CsDropdownWidth? minWidth,
  CsDropdownWidth? maxWidth,
  bool stretchHeight = false,
  bool isMobile = false,
}) {
  final ideal = csDropdownWidths(
    triggerWidth: trigger.width,
    requiredWidth: requiredWidth,
    minWidth: minWidth,
    maxWidth: maxWidth,
  ).idealWidth;
  final space = csDropdownAvailableSpace(
    trigger: trigger,
    overflowParents: overflowParents,
    stretchHeight: stretchHeight,
    isMobile: isMobile,
  );
  return ideal <= space.inlineStart || ideal <= space.inlineEnd;
}

/// Upstream `getDropdownPosition`. [requiredWidth] / [dropdownHeight] are
/// the dropdown's natural size before positioning.
CsDropdownPosition csDropdownPosition({
  required Rect trigger,
  required List<Rect> overflowParents,
  required double requiredWidth,
  required double dropdownHeight,
  CsDropdownWidth? minWidth,
  CsDropdownWidth? maxWidth,
  bool preferCenter = false,
  bool matchTriggerWidth = false,
  bool stretchHeight = false,
  bool isMobile = false,
  double? maxHeight,
}) {
  final space = csDropdownAvailableSpace(
    trigger: trigger,
    overflowParents: overflowParents,
    stretchWidth: matchTriggerWidth,
    stretchHeight: stretchHeight,
    isMobile: isMobile,
  );
  final widths = csDropdownWidths(
    triggerWidth: trigger.width,
    requiredWidth: requiredWidth,
    minWidth: minWidth,
    maxWidth: maxWidth,
  );
  final ideal = widths.idealWidth;
  bool dropInlineStart;
  var inlineSize = ideal;
  if (ideal <= space.inlineEnd) {
    dropInlineStart = false;
  } else if (ideal <= space.inlineStart) {
    dropInlineStart = true;
  } else {
    dropInlineStart = space.inlineStart > space.inlineEnd;
    inlineSize = math.max(
      math.max(space.inlineStart, space.inlineEnd),
      widths.minWidth,
    );
  }
  double? insetInlineStart;
  if (preferCenter) {
    final spillOver = (ideal - trigger.width) / 2;
    final outsideLeft = space.inlineStart - trigger.width;
    final outsideRight = space.inlineEnd - trigger.width;
    if (outsideLeft >= spillOver && outsideRight >= spillOver) {
      insetInlineStart = -spillOver;
    }
  }
  final dropBlockStart =
      space.blockEnd < dropdownHeight && space.blockStart > space.blockEnd;
  final available = dropBlockStart ? space.blockStart : space.blockEnd;
  // Crop to whole 31px rows + 16 so a partially visible item hints at more.
  final cropped = math.max(
    stretchHeight ? available : (available / 31).floor() * 31 + 16.0,
    15.0,
  );
  return CsDropdownPosition(
    dropBlockStart: dropBlockStart,
    dropInlineStart: dropInlineStart,
    blockSize: maxHeight == null ? cropped : math.min(cropped, maxHeight),
    inlineSize: inlineSize,
    insetInlineStart: insetInlineStart,
  );
}

/// Upstream `getInteriorDropdownPosition` (nested fly-outs). The returned
/// [CsDropdownPosition.insetInlineStart] is relative to the trigger's
/// inline start.
CsDropdownPosition csInteriorDropdownPosition({
  required Rect trigger,
  required List<Rect> overflowParents,
  required double dropdownWidth,
  required double dropdownHeight,
  bool isMobile = false,
}) {
  final space = csInteriorAvailableSpace(
    trigger: trigger,
    overflowParents: overflowParents,
    isMobile: isMobile,
  );
  var inlineSize = dropdownWidth;
  bool dropInlineStart;
  if (inlineSize <= space.inlineEnd) {
    dropInlineStart = false;
  } else if (inlineSize <= space.inlineStart) {
    dropInlineStart = true;
  } else {
    dropInlineStart = space.inlineStart > space.inlineEnd;
    inlineSize = math.max(space.inlineStart, space.inlineEnd);
  }
  final dropBlockStart =
      space.blockEnd < dropdownHeight && space.blockStart > space.blockEnd;
  final available = dropBlockStart ? space.blockStart : space.blockEnd;
  return CsDropdownPosition(
    dropBlockStart: dropBlockStart,
    dropInlineStart: dropInlineStart,
    blockSize: (available / 31).floor() * 31 + 16.0,
    inlineSize: inlineSize,
    insetInlineStart: dropInlineStart ? -inlineSize : trigger.width,
  );
}
