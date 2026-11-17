// The one text-input base (plan risk "Text input fidelity"): upstream
// `input/internal.js` + `input/styles.scss` (and the textarea variant) on
// top of EditableText, with Material-free selection gestures, handles,
// context menu and magnifier. Input, Textarea, Autosuggest, Select filter,
// Date input, Property filter, ... all build on this.
import 'package:cloudscape_flutter/src/internal/editable_field/text_selection.dart';
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:cloudscape_flutter/src/theme/typography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// A Cloudscape text field: upstream's `input-field` box (border, focus
/// ring, disabled / read-only / invalid / warning states, start and end
/// icons, prefix and suffix) around an [EditableText].
///
/// Single line by default; set [maxLines] to more than 1 (or null) for the
/// textarea variant. Controlled with [value] + [onChange], or uncontrolled
/// with an optional [controller].
class CsEditableField extends StatefulWidget {
  /// Creates the field.
  const CsEditableField({
    super.key,
    this.value,
    this.controller,
    this.focusNode,
    this.onChange,
    this.onSubmitted,
    this.onEditingComplete,
    this.onFocus,
    this.onBlur,
    this.onKeyEvent,
    this.onTap,
    this.placeholder,
    this.ariaLabel,
    this.disabled = false,
    this.readOnly = false,
    this.invalid = false,
    this.warning = false,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = false,
    this.enableSuggestions = true,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofillHints,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.startIcon,
    this.onStartIconTap,
    this.endIcon,
    this.prefix,
    this.suffix,
    this.inlineContent,
    this.noBorderRadius = false,
    this.enableInteractiveSelection = true,
    this.contextMenuBuilder = csDefaultTextContextMenu,
    this.selectionControls,
    this.magnifierConfiguration,
  });

  /// Controlled text. When non-null, the field shows this value and
  /// reports edits through [onChange] (React controlled input).
  final String? value;

  /// Text controller for uncontrolled use. Ignored when [value] is set.
  final TextEditingController? controller;

  /// Focus node.
  final FocusNode? focusNode;

  /// Text changed (upstream `onChange`).
  final ValueChanged<String>? onChange;

  /// The user submitted (Enter in a single-line field).
  final ValueChanged<String>? onSubmitted;

  /// Editing complete.
  final VoidCallback? onEditingComplete;

  /// Gained focus.
  final VoidCallback? onFocus;

  /// Lost focus.
  final VoidCallback? onBlur;

  /// Raw keys while focused (upstream `onKeyDown`); return handled to stop
  /// the field from processing the key.
  final KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent;

  /// Tapped.
  final VoidCallback? onTap;

  /// Placeholder text.
  final String? placeholder;

  /// Accessible label.
  final String? ariaLabel;

  /// Disabled: not focusable, not selectable.
  final bool disabled;

  /// Read-only: focusable and selectable, not editable.
  final bool readOnly;

  /// Error state.
  final bool invalid;

  /// Warning state (ignored when [invalid]).
  final bool warning;

  /// Focus on first build.
  final bool autofocus;

  /// Password-style obscuring.
  final bool obscureText;

  /// Autocorrect (upstream `disableBrowserAutocorrect` inverted).
  final bool autocorrect;

  /// Keyboard suggestions.
  final bool enableSuggestions;

  /// Keyboard type; multiline for multi-line fields.
  final TextInputType? keyboardType;

  /// IME action button.
  final TextInputAction? textInputAction;

  /// Input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Autofill hints (upstream `autoComplete`).
  final Iterable<String>? autofillHints;

  /// Overrides the ambient direction (upstream forces LTR for e-mail).
  final TextDirection? textDirection;

  /// Text alignment.
  final TextAlign textAlign;

  /// Max visible lines; 1 for an input, more or null for a textarea.
  final int? maxLines;

  /// Min visible lines (textarea `rows`).
  final int? minLines;

  /// Max characters.
  final int? maxLength;

  /// Icon at the start (upstream `__startIcon`, e.g. search).
  final Widget? startIcon;

  /// Start icon tapped.
  final VoidCallback? onStartIconTap;

  /// Widget at the end, usually an inline icon button (upstream
  /// `__endIcon`, e.g. clear).
  final Widget? endIcon;

  /// Adornment before the text, separated by a divider.
  final Widget? prefix;

  /// Adornment after the text, separated by a divider.
  final Widget? suffix;

  /// Content before the text inside the box (upstream `__inlineContent`).
  final Widget? inlineContent;

  /// Use the dropdown radius (upstream `__noBorderRadius`).
  final bool noBorderRadius;

  /// Allow selecting text.
  final bool enableInteractiveSelection;

  /// Builds the context menu; null disables it.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Handles; defaults to [CsTextSelectionControls].
  final TextSelectionControls? selectionControls;

  /// Magnifier; defaults to [csTextMagnifierConfiguration].
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Whether this field is multi-line (the textarea variant).
  bool get isMultiline => maxLines != 1;

  @override
  State<CsEditableField> createState() => CsEditableFieldState();
}

/// State of [CsEditableField].
class CsEditableFieldState extends State<CsEditableField>
    implements TextSelectionGestureDetectorBuilderDelegate {
  TextEditingController? _ownController;
  FocusNode? _ownFocusNode;
  late _CsSelectionGestureBuilder _gestures;
  bool _showSelectionHandles = false;
  // Kept across builds: EditableText recreates its selection overlay (and
  // drops visible handles) whenever these change identity.
  final CsTextSelectionControls _defaultControls = CsTextSelectionControls();
  final TextMagnifierConfiguration _defaultMagnifier =
      csTextMagnifierConfiguration();
  bool _hasFocus = false;

  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  @override
  bool get forcePressEnabled => defaultTargetPlatform == TargetPlatform.iOS;

  @override
  bool get selectionEnabled =>
      widget.enableInteractiveSelection && !widget.disabled;

  /// The text controller in use.
  TextEditingController get controller =>
      widget.value == null && widget.controller != null
      ? widget.controller!
      : (_ownController ??= TextEditingController(text: widget.value));

  /// The focus node in use.
  FocusNode get focusNode =>
      widget.focusNode ??
      (_ownFocusNode ??= FocusNode(debugLabel: 'CsEditableField'));

  /// The underlying [EditableTextState].
  EditableTextState? get editableText => editableTextKey.currentState;

  /// Whether the field has focus.
  bool get hasFocus => _hasFocus;

  @override
  void initState() {
    super.initState();
    _gestures = _CsSelectionGestureBuilder(this);
    focusNode.addListener(_onFocusChange);
    focusNode.canRequestFocus = !widget.disabled;
    _hasFocus = focusNode.hasFocus;
  }

  @override
  void didUpdateWidget(CsEditableField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldNode = oldWidget.focusNode ?? _ownFocusNode;
    if (oldWidget.focusNode != widget.focusNode) {
      oldNode?.removeListener(_onFocusChange);
      focusNode.addListener(_onFocusChange);
    }
    focusNode.canRequestFocus = !widget.disabled;
    if (widget.disabled && focusNode.hasFocus) focusNode.unfocus();
    final v = widget.value;
    if (v != null && v != controller.text) {
      // Controlled: adopt the new value, keeping the caret in range.
      final sel = controller.selection;
      controller.value = TextEditingValue(
        text: v,
        selection: sel.isValid && sel.end <= v.length
            ? sel
            : TextSelection.collapsed(offset: v.length),
      );
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusChange);
    _ownFocusNode?.dispose();
    _ownController?.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    final has = focusNode.hasFocus;
    if (has == _hasFocus) return;
    setState(() => _hasFocus = has);
    has ? widget.onFocus?.call() : widget.onBlur?.call();
  }

  void _requestKeyboard() => editableText?.requestKeyboard();

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // Same rules as the platform text fields.
    if (!_gestures.shouldShowSelectionToolbar || widget.disabled) return false;
    // Programmatic changes (autofocus, controller updates) and keyboard
    // selection never show handles; only user gestures do.
    if (cause == null || cause == SelectionChangedCause.keyboard) {
      return false;
    }
    if (widget.readOnly && controller.selection.isCollapsed) return false;
    if (cause == SelectionChangedCause.longPress ||
        cause == SelectionChangedCause.stylusHandwriting) {
      return true;
    }
    return controller.text.isNotEmpty;
  }

  void _onSelectionChanged(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    final show = _shouldShowSelectionHandles(cause);
    if (show != _showSelectionHandles) {
      setState(() => _showSelectionHandles = show);
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS || TargetPlatform.macOS:
        if (cause == SelectionChangedCause.longPress ||
            cause == SelectionChangedCause.drag) {
          editableText?.bringIntoView(selection.extent);
        }
      case TargetPlatform.android ||
          TargetPlatform.fuchsia ||
          TargetPlatform.linux ||
          TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) {
          editableText?.bringIntoView(selection.extent);
        }
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.linux ||
          TargetPlatform.windows ||
          TargetPlatform.macOS:
        if (cause == SelectionChangedCause.drag) editableText?.hideToolbar();
      case TargetPlatform.iOS ||
          TargetPlatform.android ||
          TargetPlatform.fuchsia:
        break;
    }
  }

  void _onChanged(String text) {
    widget.onChange?.call(text);
    if (widget.value != null && widget.value != text) {
      // Controlled and the owner did not accept the edit: revert after
      // the frame (React restores the controlled value the same way).
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final v = widget.value;
        if (v != null && controller.text != v) {
          controller.value = TextEditingValue(
            text: v,
            selection: TextSelection.collapsed(offset: v.length),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    final platform = defaultTargetPlatform;
    final disabled = widget.disabled;
    final invalid = widget.invalid;
    final warning = widget.warning && !invalid;
    final hasAdornments = widget.prefix != null || widget.suffix != null;
    final status = invalid || warning;

    // Colors (input + input-field rules).
    final Color textColor;
    if (disabled) {
      textColor = t.colorTextInputDisabled.toColor();
    } else if (invalid && !hasAdornments) {
      textColor = t.colorTextStatusError.toColor();
    } else if (warning && !hasAdornments) {
      textColor = t.colorTextStatusWarning.toColor();
    } else {
      textColor = t.colorTextBodyDefault.toColor();
    }
    final Color fieldColor = disabled
        ? t.colorTextInputDisabled.toColor()
        : invalid
        ? t.colorTextStatusError.toColor()
        : warning
        ? t.colorTextStatusWarning.toColor()
        : t.colorTextFormSecondary.toColor();
    final Color borderColor = invalid
        ? t.colorTextStatusError.toColor()
        : warning
        ? t.colorTextStatusWarning.toColor()
        : disabled || widget.readOnly
        ? t.colorBorderInputDisabled.toColor()
        : _hasFocus
        ? t.colorBorderInputFocused.toColor()
        : t.colorBorderInputDefault.toColor();
    final background = disabled
        ? t.colorBackgroundInputDisabled.toColor()
        : t.colorBackgroundInputDefault.toColor();

    final typo = CsTypography(t);
    final textStyle = typo.bodyM.copyWith(color: textColor);
    final bw = t.borderWidthField;
    final statusExtra = status ? t.borderWidthFieldStatusInlineStart - bw : 0.0;
    final firstStart = t.spaceFieldHorizontal - statusExtra;
    final hasStartIcon = widget.startIcon != null;
    final hasEndIcon = widget.endIcon != null;
    final startsWithText =
        widget.prefix == null && widget.inlineContent == null;
    final textPadding = EdgeInsetsDirectional.only(
      top: t.spaceFieldVertical,
      bottom: t.spaceFieldVertical,
      start: !startsWithText
          ? t.spaceFieldHorizontal
          : hasStartIcon
          ? t.spaceFieldIconOffset - statusExtra
          : firstStart,
      end: hasEndIcon ? t.spaceFieldIconOffset : t.spaceFieldHorizontal,
    );

    final multiline = widget.isMultiline;
    final cupertino =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
    final dpr = MediaQuery.maybeDevicePixelRatioOf(context) ?? 1;

    Widget editable = EditableText(
      key: editableTextKey,
      controller: controller,
      focusNode: focusNode,
      readOnly: widget.readOnly || disabled,
      showCursor: disabled ? false : null,
      autofocus: widget.autofocus && !disabled,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      style: textStyle,
      strutStyle: StrutStyle.fromTextStyle(textStyle, forceStrutHeight: true),
      cursorColor: textColor,
      backgroundCursorColor: t.colorTextInputPlaceholder.toColor(),
      // Browser carets are 1px; touch platforms use the platform width.
      cursorWidth: switch (platform) {
        TargetPlatform.iOS || TargetPlatform.android => 2,
        _ => 1,
      },
      cursorRadius: cupertino ? const Radius.circular(2) : null,
      cursorOffset: platform == TargetPlatform.iOS ? Offset(-2 / dpr, 0) : null,
      cursorOpacityAnimates: platform == TargetPlatform.iOS,
      paintCursorAboveText: cupertino,
      selectionColor: t.colorBorderInputFocused.toColor().withValues(
        alpha: 0.3,
      ),
      selectionControls: widget.enableInteractiveSelection && !disabled
          ? (widget.selectionControls ?? _defaultControls)
          : null,
      showSelectionHandles: _showSelectionHandles,
      onSelectionChanged: _onSelectionChanged,
      enableInteractiveSelection: selectionEnabled,
      contextMenuBuilder: widget.contextMenuBuilder,
      magnifierConfiguration:
          widget.magnifierConfiguration ?? _defaultMagnifier,
      keyboardType:
          widget.keyboardType ??
          (multiline ? TextInputType.multiline : TextInputType.text),
      textInputAction: widget.textInputAction,
      inputFormatters: [
        ...?widget.inputFormatters,
        // Last, like the platform fields: count what the formatters keep.
        if (widget.maxLength != null)
          LengthLimitingTextInputFormatter(widget.maxLength),
      ],
      autofillHints: disabled ? null : widget.autofillHints,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onChanged: _onChanged,
      onSubmitted: widget.onSubmitted,
      onEditingComplete: widget.onEditingComplete,
      rendererIgnoresPointer: true,
      mouseCursor: MouseCursor.defer,
    );

    // Placeholder (italic, placeholder color), painted under the text.
    final placeholder = widget.placeholder;
    editable = Stack(
      children: [
        if (placeholder != null && placeholder.isNotEmpty)
          Positioned.fill(
            child: ListenableBuilder(
              listenable: controller,
              builder: (context, _) => controller.text.isEmpty
                  ? ExcludeSemantics(
                      child: Text(
                        placeholder,
                        textAlign: widget.textAlign,
                        textDirection: widget.textDirection,
                        maxLines: multiline ? null : 1,
                        overflow: multiline ? null : TextOverflow.ellipsis,
                        style: textStyle.copyWith(
                          fontStyle: FontStyle.italic,
                          color:
                              (disabled
                                      ? t.colorTextInputPlaceholderDisabled
                                      : t.colorTextInputPlaceholder)
                                  .toColor(),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        editable,
      ],
    );
    editable = Padding(padding: textPadding, child: editable);
    if (widget.textDirection != null) {
      editable = Directionality(
        textDirection: widget.textDirection!,
        child: editable,
      );
    }

    final divider = SizedBox(
      width: bw,
      child: ColoredBox(color: t.colorBorderDividerDefault.toColor()),
    );
    Widget adornment(Widget child, {required bool first}) => Container(
      constraints: const BoxConstraints(minWidth: 0),
      padding: EdgeInsetsDirectional.only(
        top: t.spaceFieldVertical,
        bottom: t.spaceFieldVertical,
        start: first ? firstStart : t.spaceFieldHorizontal,
        end: t.spaceFieldHorizontal,
      ),
      alignment: Alignment.center,
      child: ExcludeSemantics(
        child: DefaultTextStyle.merge(
          style: typo.bodyM.copyWith(color: fieldColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          child: child,
        ),
      ),
    );

    Widget row = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.prefix != null) ...[
          Flexible(flex: 0, child: adornment(widget.prefix!, first: true)),
          divider,
        ],
        if (widget.inlineContent != null)
          Padding(
            padding: EdgeInsetsDirectional.only(
              start:
                  t.spaceFieldHorizontal +
                  t.sizeIconNormal +
                  t.spaceXxs -
                  bw -
                  (widget.prefix == null ? statusExtra : 0),
            ),
            child: Center(child: widget.inlineContent),
          ),
        Expanded(child: editable),
        if (widget.suffix != null) ...[
          divider,
          Flexible(flex: 0, child: adornment(widget.suffix!, first: false)),
        ],
      ],
    );
    row = IntrinsicHeight(child: row);

    final radius = widget.noBorderRadius
        ? t.borderRadiusDropdown
        : t.borderRadiusInput;
    final side = BorderSide(color: borderColor, width: bw);
    final focusSpread = status
        ? t.borderControlInvalidFocusRingShadowSpread
        : t.borderControlFocusRingShadowSpread;
    Widget field = Container(
      constraints: BoxConstraints(minHeight: t.sizeVerticalInput),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
        border: BorderDirectional(
          top: side,
          bottom: side,
          end: side,
          start: side.copyWith(
            width: status ? t.borderWidthFieldStatusInlineStart : bw,
          ),
        ),
        boxShadow: _hasFocus && !disabled
            ? [
                BoxShadow(
                  color: t.colorBorderItemFocused.toColor(),
                  spreadRadius: focusSpread,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          (radius - bw).clamp(0, double.infinity),
        ),
        child: row,
      ),
    );

    // Icons sit over the box, vertically centered on the first line.
    final iconTop = t.sizeVerticalInput / 2 - t.lineHeightBodyM / 2;
    field = Stack(
      children: [
        field,
        if (hasStartIcon)
          PositionedDirectional(
            start: t.spaceFieldHorizontal,
            top: iconTop,
            child: GestureDetector(
              onTap: widget.onStartIconTap,
              child: DefaultTextStyle.merge(
                style: TextStyle(
                  color:
                      (disabled
                              ? t.colorTextInteractiveDisabled
                              : t.colorTextIconSubtle)
                          .toColor(),
                ),
                child: widget.startIcon!,
              ),
            ),
          ),
        if (hasEndIcon)
          PositionedDirectional(
            end: t.spaceFieldHorizontal - t.spaceXxs,
            top: iconTop - t.spaceXxxs,
            child: widget.endIcon!,
          ),
      ],
    );

    field = _gestures.buildGestureDetector(
      behavior: HitTestBehavior.translucent,
      child: field,
    );
    field = MouseRegion(
      cursor: disabled ? SystemMouseCursors.basic : SystemMouseCursors.text,
      child: IgnorePointer(ignoring: disabled, child: field),
    );
    if (widget.onKeyEvent != null) {
      field = Focus(
        canRequestFocus: false,
        skipTraversal: true,
        onKeyEvent: widget.onKeyEvent,
        child: field,
      );
    }
    return Semantics(
      label: widget.ariaLabel,
      enabled: !disabled,
      readOnly: widget.readOnly,
      onTap: disabled
          ? null
          : () {
              if (!focusNode.hasFocus) focusNode.requestFocus();
              _requestKeyboard();
            },
      child: field,
    );
  }
}

class _CsSelectionGestureBuilder extends TextSelectionGestureDetectorBuilder {
  _CsSelectionGestureBuilder(this._state) : super(delegate: _state);

  final CsEditableFieldState _state;

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    super.onSingleTapUp(details);
    _state._requestKeyboard();
  }

  @override
  void onUserTap() => _state.widget.onTap?.call();
}
