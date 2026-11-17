// Parses ICU MessageFormat strings into CsMessageNode lists, following the
// formatjs grammar (arguments, number/date/time, select, plural,
// selectordinal with offset and =N, #, <tags>, apostrophe quoting).
import 'package:cloudscape_flutter/src/i18n/message_ast.dart';

/// Thrown for malformed ICU messages.
class CsIcuSyntaxError extends FormatException {
  /// Creates the error.
  const CsIcuSyntaxError(super.message, [super.source, super.offset]);
}

/// Parses an ICU message string.
List<CsMessageNode> parseIcuMessage(String message) {
  final p = _IcuParser(message);
  final nodes = p.parseMessage(inPlural: false, endTag: null);
  if (!p.atEnd) p.fail('Unexpected "${message[p.i]}"');
  return nodes;
}

final _identifier = RegExp(r'[^\s{}#<>,:=/\\]+');

class _IcuParser {
  _IcuParser(this.src);

  final String src;
  int i = 0;

  bool get atEnd => i >= src.length;

  Never fail(String message) => throw CsIcuSyntaxError(message, src, i);

  void skipSpace() {
    while (!atEnd && RegExp(r'\s').hasMatch(src[i])) {
      i++;
    }
  }

  String identifier() {
    skipSpace();
    final m = _identifier.matchAsPrefix(src, i);
    if (m == null) fail('Expected an identifier');
    i = m.end;
    return m[0]!;
  }

  void expect(String c) {
    skipSpace();
    if (atEnd || src[i] != c) fail('Expected "$c"');
    i++;
  }

  List<CsMessageNode> parseMessage({
    required bool inPlural,
    required String? endTag,
  }) {
    final nodes = <CsMessageNode>[];
    final text = StringBuffer();
    void flush() {
      if (text.isNotEmpty) {
        nodes.add(CsLiteralNode(text.toString()));
        text.clear();
      }
    }

    while (!atEnd) {
      final c = src[i];
      if (c == "'") {
        // '' → '; '<special>...' quotes until the next lone '.
        if (i + 1 < src.length && src[i + 1] == "'") {
          text.write("'");
          i += 2;
        } else if (i + 1 < src.length && '{}#<>|'.contains(src[i + 1])) {
          i++;
          while (true) {
            if (atEnd) fail('Unterminated quote');
            if (src[i] == "'") {
              if (i + 1 < src.length && src[i + 1] == "'") {
                text.write("'");
                i += 2;
                continue;
              }
              i++;
              break;
            }
            text.write(src[i++]);
          }
        } else {
          text.write("'");
          i++;
        }
      } else if (c == '{') {
        flush();
        nodes.add(argument());
      } else if (c == '}') {
        break;
      } else if (c == '#' && inPlural) {
        flush();
        nodes.add(const CsPoundNode());
        i++;
      } else if (c == '<' && i + 1 < src.length && src[i + 1] == '/') {
        if (endTag == null) fail('Unexpected closing tag');
        break;
      } else if (c == '<' &&
          i + 1 < src.length &&
          RegExp('[A-Za-z]').hasMatch(src[i + 1])) {
        flush();
        nodes.add(tag(inPlural));
      } else {
        text.write(c);
        i++;
      }
    }
    flush();
    return nodes;
  }

  CsMessageNode tag(bool inPlural) {
    i++; // <
    final m = RegExp(r'[A-Za-z][A-Za-z0-9_-]*').matchAsPrefix(src, i)!;
    final name = m[0]!;
    i = m.end;
    if (src.startsWith('/>', i)) {
      i += 2;
      return CsLiteralNode('<$name/>');
    }
    if (atEnd || src[i] != '>') fail('Expected ">" in tag <$name>');
    i++;
    final children = parseMessage(inPlural: inPlural, endTag: name);
    final close = '</$name>';
    if (!src.startsWith(close, i)) fail('Expected $close');
    i += close.length;
    return CsTagNode(name, children);
  }

  CsMessageNode argument() {
    i++; // {
    final name = identifier();
    skipSpace();
    if (!atEnd && src[i] == '}') {
      i++;
      return CsArgumentNode(name);
    }
    expect(',');
    final type = identifier();
    skipSpace();
    switch (type) {
      case 'number' || 'date' || 'time':
        String? style;
        if (!atEnd && src[i] == ',') {
          i++;
          final start = i;
          var depth = 0;
          while (!atEnd && !(src[i] == '}' && depth == 0)) {
            if (src[i] == '{') depth++;
            if (src[i] == '}') depth--;
            i++;
          }
          style = src.substring(start, i).trim();
        }
        expect('}');
        return CsFormattedNode(
          CsFormattedKind.values.byName(type),
          name,
          style,
        );
      case 'select':
        expect(',');
        final options = this.options(inPlural: false, allowOffset: false);
        return CsSelectNode(name, options.$1);
      case 'plural' || 'selectordinal':
        expect(',');
        final (opts, offset) = options(inPlural: true, allowOffset: true);
        return CsPluralNode(
          name,
          opts,
          offset: offset,
          ordinal: type == 'selectordinal',
        );
      default:
        fail('Unknown argument type "$type"');
    }
  }

  (Map<String, List<CsMessageNode>>, num) options({
    required bool inPlural,
    required bool allowOffset,
  }) {
    final out = <String, List<CsMessageNode>>{};
    num offset = 0;
    while (true) {
      skipSpace();
      if (atEnd) fail('Unterminated options');
      if (src[i] == '}') {
        i++;
        break;
      }
      if (allowOffset && out.isEmpty && src.startsWith('offset:', i)) {
        i += 'offset:'.length;
        skipSpace();
        final m = RegExp(r'-?\d+(\.\d+)?').matchAsPrefix(src, i);
        if (m == null) fail('Bad offset');
        offset = num.parse(m[0]!);
        i = m.end;
        continue;
      }
      String key;
      if (src[i] == '=') {
        i++;
        final m = RegExp(r'-?\d+(\.\d+)?').matchAsPrefix(src, i);
        if (m == null) fail('Bad exact key');
        key = '=${m[0]}';
        i = m.end;
      } else {
        key = identifier();
      }
      if (out.containsKey(key)) fail('Duplicate option "$key"');
      expect('{');
      out[key] = parseMessage(inPlural: inPlural, endTag: null);
      if (atEnd || src[i] != '}') fail('Expected "}"');
      i++;
    }
    if (!out.containsKey('other')) fail('Missing "other" option');
    return (out, offset);
  }
}
