import 'package:cloudscape_flutter/src/icon/cs_icon.dart';
import 'package:cloudscape_flutter/src/icon/generated/icons.g.dart';
import 'package:cloudscape_flutter/src/internal/editable_field/cs_editable_field.dart';
import 'package:cloudscape_flutter/src/internal/pressable.dart';
import 'package:cloudscape_flutter/src/preview/cs_preview.dart';
import 'package:cloudscape_flutter/src/theme/conversions.dart';
import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:flutter/widgets.dart';

Widget _labeled(String label, Widget field) => Builder(
  builder: (context) {
    final t = CsTheme.tokensOf(context);
    return Padding(
      padding: EdgeInsets.only(bottom: t.spaceS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: t.spaceXxxs),
            child: Text(
              label,
              style: TextStyle(
                color: t.colorTextBodySecondary.toColor(),
                fontSize: t.fontSizeBodyS,
              ),
            ),
          ),
          field,
        ],
      ),
    );
  },
);

/// An inline icon button (upstream `variant="inline-icon"`), used for the
/// clear button of search fields until CsButton lands.
class _InlineIconButton extends StatelessWidget {
  const _InlineIconButton({required this.icon, required this.onPressed});

  final CsIconName icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final t = CsTheme.tokensOf(context);
    return CsPressable(
      onPressed: onPressed,
      semanticLabel: 'Clear',
      builder: (context, s) => Padding(
        padding: EdgeInsets.all(t.spaceXxxs),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color:
                (s.hovered
                        ? t.colorTextInteractiveHover
                        : t.colorTextInteractiveDefault)
                    .toColor(),
          ),
          child: CsIcon(name: icon),
        ),
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField();

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  String _value = 'Cloudscape';

  @override
  Widget build(BuildContext context) => CsEditableField(
    value: _value,
    onChange: (v) => setState(() => _value = v),
    placeholder: 'Search',
    ariaLabel: 'Search',
    startIcon: const CsIcon(name: CsIconName.search),
    endIcon: _value.isEmpty
        ? null
        : _InlineIconButton(
            icon: CsIconName.close,
            onPressed: () => setState(() => _value = ''),
          ),
  );
}

/// Editable field: every visual state of the text-input base.
@CsPreview(group: 'Editable field', name: 'States', size: Size(380, 760))
Widget csEditableFieldStatesPreview() => SizedBox(
  width: 340,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      _labeled(
        'Default',
        CsEditableField(controller: TextEditingController(text: 'Value')),
      ),
      _labeled(
        'Placeholder',
        const CsEditableField(placeholder: 'Enter a value'),
      ),
      _labeled(
        'Focused',
        CsEditableField(
          autofocus: true,
          controller: TextEditingController(text: 'Has focus'),
        ),
      ),
      _labeled(
        'Disabled',
        CsEditableField(
          disabled: true,
          controller: TextEditingController(text: 'Disabled'),
        ),
      ),
      _labeled(
        'Disabled placeholder',
        const CsEditableField(disabled: true, placeholder: 'Placeholder'),
      ),
      _labeled(
        'Read-only',
        CsEditableField(
          readOnly: true,
          controller: TextEditingController(text: 'Read-only'),
        ),
      ),
      _labeled(
        'Invalid',
        CsEditableField(
          invalid: true,
          controller: TextEditingController(text: 'Invalid value'),
        ),
      ),
      _labeled(
        'Warning',
        CsEditableField(
          warning: true,
          controller: TextEditingController(text: 'Warning value'),
        ),
      ),
      _labeled('Search (start icon + clear button)', const _SearchField()),
    ],
  ),
);

/// Editable field: prefix / suffix adornments, with and without status.
@CsPreview(
  group: 'Editable field',
  name: 'Prefix and suffix',
  size: Size(380, 300),
)
Widget csEditableFieldAdornmentsPreview() => SizedBox(
  width: 340,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      _labeled(
        'Prefix and suffix',
        CsEditableField(
          prefix: const Text('https://'),
          suffix: const Text('.com'),
          controller: TextEditingController(text: 'example'),
        ),
      ),
      _labeled(
        'Invalid with suffix',
        CsEditableField(
          invalid: true,
          suffix: const Text('GiB'),
          controller: TextEditingController(text: '12x'),
        ),
      ),
      _labeled(
        'Disabled with prefix',
        CsEditableField(
          disabled: true,
          prefix: const Text(r'$'),
          controller: TextEditingController(text: '42.00'),
        ),
      ),
    ],
  ),
);

/// Editable field: multi-line (textarea) variant.
@CsPreview(group: 'Editable field', name: 'Textarea', size: Size(380, 360))
Widget csEditableFieldTextareaPreview() => SizedBox(
  width: 340,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      _labeled(
        'Three rows',
        CsEditableField(
          maxLines: null,
          minLines: 3,
          placeholder: 'Describe the resource',
          controller: TextEditingController(),
        ),
      ),
      _labeled(
        'Invalid',
        CsEditableField(
          maxLines: null,
          minLines: 3,
          invalid: true,
          controller: TextEditingController(
            text:
                'Line one\nLine two is longer and wraps onto the next line '
                'inside the field',
          ),
        ),
      ),
    ],
  ),
);
