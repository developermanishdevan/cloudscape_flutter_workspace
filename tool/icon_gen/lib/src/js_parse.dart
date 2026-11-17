// A small parser for the compiled React icon module
// (`React.createElement("svg", {...}, ...children)` trees in object
// literals). It accepts only the shapes upstream emits and throws otherwise.

/// One `React.createElement(tag, props, ...children)` call.
class JsElement {
  JsElement(this.tag, this.props, this.children);

  final String tag;
  final Map<String, Object?> props;
  final List<JsElement> children;

  @override
  String toString() => '<$tag $props>$children';
}

class _Token {
  _Token(this.kind, this.text, this.offset);

  /// One of: str, num, ident, punct.
  final String kind;
  final String text;
  final int offset;

  @override
  String toString() => '$kind($text)@$offset';
}

List<_Token> _tokenize(String src) {
  final tokens = <_Token>[];
  var i = 0;
  while (i < src.length) {
    final c = src[i];
    if (RegExp(r'\s').hasMatch(c)) {
      i++;
    } else if (src.startsWith('//', i)) {
      final end = src.indexOf('\n', i);
      i = end < 0 ? src.length : end;
    } else if (src.startsWith('/*', i)) {
      final end = src.indexOf('*/', i + 2);
      if (end < 0) throw FormatException('Unterminated comment', src, i);
      i = end + 2;
    } else if (c == '"' || c == "'") {
      final buf = StringBuffer();
      var j = i + 1;
      while (true) {
        if (j >= src.length) {
          throw FormatException('Unterminated string', src, i);
        }
        final ch = src[j];
        if (ch == c) break;
        if (ch == r'\') {
          final n = src[j + 1];
          buf.write(switch (n) {
            'n' => '\n',
            't' => '\t',
            _ => n,
          });
          j += 2;
        } else {
          buf.write(ch);
          j++;
        }
      }
      tokens.add(_Token('str', buf.toString(), i));
      i = j + 1;
    } else if (RegExp(r'[0-9.\-]').hasMatch(c) &&
        RegExp(r'-?(\d+\.?\d*|\.\d+)').matchAsPrefix(src, i) != null) {
      final m = RegExp(r'-?(\d+\.?\d*|\.\d+)([eE][+-]?\d+)?')
          .matchAsPrefix(src, i)!;
      tokens.add(_Token('num', m[0]!, i));
      i = m.end;
    } else if (RegExp(r'[A-Za-z_$]').hasMatch(c)) {
      final m = RegExp(r'[A-Za-z_$][A-Za-z0-9_$]*').matchAsPrefix(src, i)!;
      tokens.add(_Token('ident', m[0]!, i));
      i = m.end;
    } else if ('(){}[],:;=.'.contains(c)) {
      tokens.add(_Token('punct', c, i));
      i++;
    } else {
      throw FormatException('Unexpected character "$c"', src, i);
    }
  }
  return tokens;
}

class _Parser {
  _Parser(this.tokens, this.src);

  final List<_Token> tokens;
  final String src;
  int pos = 0;

  _Token get peek => tokens[pos];

  _Token expect(String kind, [String? text]) {
    final t = tokens[pos];
    if (t.kind != kind || (text != null && t.text != text)) {
      throw FormatException(
        'Expected $kind ${text ?? ''}, got $t',
        src,
        t.offset,
      );
    }
    pos++;
    return t;
  }

  bool accept(String kind, String text) {
    if (pos < tokens.length && peek.kind == kind && peek.text == text) {
      pos++;
      return true;
    }
    return false;
  }

  Map<String, Object?> object() {
    expect('punct', '{');
    final out = <String, Object?>{};
    while (!accept('punct', '}')) {
      final key = peek.kind == 'str' || peek.kind == 'ident'
          ? tokens[pos++].text
          : throw FormatException('Bad object key $peek', src, peek.offset);
      expect('punct', ':');
      if (out.containsKey(key)) {
        throw FormatException('Duplicate key $key', src, peek.offset);
      }
      out[key] = value();
      if (!accept('punct', ',')) {
        expect('punct', '}');
        break;
      }
    }
    return out;
  }

  Object? value() {
    final t = peek;
    switch (t.kind) {
      case 'str':
        pos++;
        return t.text;
      case 'num':
        pos++;
        return num.parse(t.text);
      case 'ident':
        if (t.text == 'true' || t.text == 'false') {
          pos++;
          return t.text == 'true';
        }
        if (t.text == 'null') {
          pos++;
          return null;
        }
        return element();
      case 'punct' when t.text == '{':
        return object();
    }
    throw FormatException('Unexpected value $t', src, t.offset);
  }

  JsElement element() {
    expect('ident', 'React');
    expect('punct', '.');
    expect('ident', 'createElement');
    expect('punct', '(');
    final tag = expect('str').text;
    expect('punct', ',');
    final props = accept('ident', 'null') ? <String, Object?>{} : object();
    final children = <JsElement>[];
    while (accept('punct', ',')) {
      children.add(element());
    }
    expect('punct', ')');
    return JsElement(tag, props, children);
  }
}

/// Parses `const icons = { name: React.createElement(...), ... }` from the
/// upstream `icon/generated/icons.js` module.
Map<String, JsElement> parseIconsModule(String src) {
  final tokens = _tokenize(src);
  final p = _Parser(tokens, src);
  // Skip to `const icons =`.
  while (!(p.peek.kind == 'ident' &&
      p.peek.text == 'icons' &&
      tokens[p.pos + 1].text == '=')) {
    p.pos++;
  }
  p.pos += 2;
  final obj = p.object();
  return {
    for (final e in obj.entries)
      e.key: e.value is JsElement
          ? e.value! as JsElement
          : throw FormatException('Icon ${e.key} is not an element'),
  };
}

/// Parses the first `React.createElement(...)` call at or after [from].
JsElement parseElementAt(String src, int from) {
  final start = src.indexOf('React.createElement(', from);
  if (start < 0) {
    throw FormatException('No React.createElement after offset $from');
  }
  // Cut at the call's matching ')' so trailing code is not tokenized.
  var depth = 0;
  String? quote;
  var end = -1;
  for (var i = start; i < src.length; i++) {
    final c = src[i];
    if (quote != null) {
      if (c == r'\') {
        i++;
      } else if (c == quote) {
        quote = null;
      }
    } else if (c == '"' || c == "'") {
      quote = c;
    } else if (c == '(') {
      depth++;
    } else if (c == ')') {
      depth--;
      if (depth == 0) {
        end = i + 1;
        break;
      }
    }
  }
  if (end < 0) {
    throw FormatException('Unbalanced React.createElement call', src, start);
  }
  final call = src.substring(start, end);
  return _Parser(_tokenize(call), call).element();
}
