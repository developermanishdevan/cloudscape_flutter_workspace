// ICU message ASTs, mirroring formatjs `MessageFormatElement` (the format
// upstream ships its pre-compiled messages in). Pure Dart.

/// One element of a compiled ICU message.
sealed class CsMessageNode {
  const CsMessageNode();
}

/// Literal text (formatjs type 0).
final class CsLiteralNode extends CsMessageNode {
  /// Creates a literal.
  const CsLiteralNode(this.value);

  /// The text.
  final String value;

  @override
  bool operator ==(Object other) =>
      other is CsLiteralNode && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Literal($value)';
}

/// `{name}` (formatjs type 1).
final class CsArgumentNode extends CsMessageNode {
  /// Creates an argument.
  const CsArgumentNode(this.name);

  /// Argument name.
  final String name;

  @override
  bool operator ==(Object other) =>
      other is CsArgumentNode && other.name == name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'Arg($name)';
}

/// The kind of a formatted argument.
enum CsFormattedKind {
  /// `{name, number, style}` (formatjs type 2).
  number,

  /// `{name, date, style}` (formatjs type 3).
  date,

  /// `{name, time, style}` (formatjs type 4).
  time,
}

/// `{name, number|date|time[, style]}`.
final class CsFormattedNode extends CsMessageNode {
  /// Creates a formatted argument.
  const CsFormattedNode(this.kind, this.name, [this.style]);

  /// number, date or time.
  final CsFormattedKind kind;

  /// Argument name.
  final String name;

  /// Style or skeleton text, if any.
  final String? style;

  @override
  bool operator ==(Object other) =>
      other is CsFormattedNode &&
      other.kind == kind &&
      other.name == name &&
      other.style == style;

  @override
  int get hashCode => Object.hash(kind, name, style);

  @override
  String toString() => 'Formatted($kind, $name, $style)';
}

bool _optionsEqual(
  Map<String, List<CsMessageNode>> a,
  Map<String, List<CsMessageNode>> b,
) {
  if (a.length != b.length) return false;
  for (final e in a.entries) {
    final other = b[e.key];
    if (other == null || !csMessageEquals(e.value, other)) return false;
  }
  return true;
}

/// Deep equality of two messages.
bool csMessageEquals(List<CsMessageNode> a, List<CsMessageNode> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

/// `{name, select, key {...} other {...}}` (formatjs type 5).
final class CsSelectNode extends CsMessageNode {
  /// Creates a select.
  const CsSelectNode(this.name, this.options);

  /// Argument name.
  final String name;

  /// Option key → message.
  final Map<String, List<CsMessageNode>> options;

  @override
  bool operator ==(Object other) =>
      other is CsSelectNode &&
      other.name == name &&
      _optionsEqual(options, other.options);

  @override
  int get hashCode => Object.hash(name, options.length);

  @override
  String toString() => 'Select($name, $options)';
}

/// `{name, plural|selectordinal, [offset:n] =0 {...} one {...} other {...}}`
/// (formatjs type 6).
final class CsPluralNode extends CsMessageNode {
  /// Creates a plural.
  const CsPluralNode(
    this.name,
    this.options, {
    this.offset = 0,
    this.ordinal = false,
  });

  /// Argument name.
  final String name;

  /// Category (`zero`, `one`, ...) or exact (`=0`) key → message.
  final Map<String, List<CsMessageNode>> options;

  /// Plural offset.
  final num offset;

  /// True for `selectordinal`.
  final bool ordinal;

  @override
  bool operator ==(Object other) =>
      other is CsPluralNode &&
      other.name == name &&
      other.offset == offset &&
      other.ordinal == ordinal &&
      _optionsEqual(options, other.options);

  @override
  int get hashCode => Object.hash(name, offset, ordinal, options.length);

  @override
  String toString() =>
      'Plural($name, $options, offset: $offset, ordinal: $ordinal)';
}

/// `#` inside a plural (formatjs type 7).
final class CsPoundNode extends CsMessageNode {
  /// Creates a pound.
  const CsPoundNode();

  @override
  bool operator ==(Object other) => other is CsPoundNode;

  @override
  int get hashCode => 7;

  @override
  String toString() => 'Pound';
}

/// `<name>children</name>` rich-text tag (formatjs type 8).
final class CsTagNode extends CsMessageNode {
  /// Creates a tag.
  const CsTagNode(this.name, this.children);

  /// Tag (and argument) name.
  final String name;

  /// Tag content.
  final List<CsMessageNode> children;

  @override
  bool operator ==(Object other) =>
      other is CsTagNode &&
      other.name == name &&
      csMessageEquals(children, other.children);

  @override
  int get hashCode => Object.hash(name, children.length);

  @override
  String toString() => 'Tag($name, $children)';
}

/// Upstream `I18nProviderProps.Messages`:
/// namespace → locale → component → key → message, where a message is an
/// ICU string or a compiled `List<CsMessageNode>`.
typedef CsI18nMessages =
    Map<String, Map<String, Map<String, Map<String, Object>>>>;
