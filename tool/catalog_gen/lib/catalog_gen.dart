/// Builds the catalog app's data: API tables taken from the dartdoc comments
/// of the `cloudscape_flutter` sources, and the declared size of every
/// `@CsPreview`, for each entry in [manifest].
library;

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:catalog_gen/src/manifest.dart';

export 'package:catalog_gen/src/manifest.dart';

/// Sources, relative to the workspace root.
const sourceDir = 'packages/cloudscape_flutter/lib/src';

/// Output, relative to the workspace root.
const outputFile = 'apps/catalog/lib/src/generated/catalog_data.g.dart';

/// Finds the workspace root (the pubspec.yaml with a `workspace:` key).
Directory findWorkspaceRoot() {
  var dir = Directory.current.absolute;
  while (true) {
    final pubspec = File('${dir.path}/pubspec.yaml');
    if (pubspec.existsSync() &&
        RegExp(
          r'^workspace:',
          multiLine: true,
        ).hasMatch(pubspec.readAsStringSync())) {
      return dir;
    }
    if (dir.parent.path == dir.path) {
      throw StateError('No workspace root found');
    }
    dir = dir.parent;
  }
}

/// Writes [source] to [file] and runs `dart format` on it.
Future<void> writeFormatted(File file, String source) async {
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(source);
  final r = await Process.run(Platform.resolvedExecutable, [
    'format',
    file.path,
  ]);
  if (r.exitCode != 0) {
    throw StateError('dart format failed: ${r.stdout}${r.stderr}');
  }
}

// ---------------------------------------------------------------------------
// Model
// ---------------------------------------------------------------------------

/// One constructor or method parameter.
class ApiParam {
  /// Creates a parameter.
  const ApiParam({
    required this.name,
    required this.type,
    required this.isNamed,
    required this.isRequired,
    this.defaultValue,
    this.doc = '',
  });

  /// Name.
  final String name;

  /// Declared type (from the field for `this.x` parameters).
  final String type;

  /// Named vs positional.
  final bool isNamed;

  /// Required.
  final bool isRequired;

  /// Default value source, if any.
  final String? defaultValue;

  /// Doc comment (of the field, for `this.x` parameters).
  final String doc;
}

/// A constructor, method, getter or property.
class ApiMember {
  /// Creates a member.
  const ApiMember({
    required this.kind,
    required this.name,
    required this.signature,
    this.doc = '',
    this.params = const [],
  });

  /// `constructor`, `method`, `static method`, `getter`, `property`.
  final String kind;

  /// Display name: `CsBox`, `CsBox.text`, `gapOf`.
  final String name;

  /// One-line signature.
  final String signature;

  /// Doc comment.
  final String doc;

  /// Parameters (constructors and methods).
  final List<ApiParam> params;
}

/// A documented class.
class ApiClass {
  /// Creates a class.
  const ApiClass({
    required this.name,
    required this.superclass,
    required this.doc,
    required this.members,
  });

  /// Name.
  final String name;

  /// `extends` clause type, if any.
  final String? superclass;

  /// Doc comment.
  final String doc;

  /// Constructors first, then properties, getters and methods.
  final List<ApiMember> members;
}

/// An enum used by a documented class.
class ApiEnum {
  /// Creates an enum.
  const ApiEnum({required this.name, required this.doc, required this.values});

  /// Name.
  final String name;

  /// Doc comment.
  final String doc;

  /// `(name, doc)` per value.
  final List<(String, String)> values;
}

/// A preview scenario's declared size.
class PreviewInfo {
  /// Creates the info.
  const PreviewInfo(this.group, this.name, this.function, this.size);

  /// Registry group.
  final String group;

  /// Scenario name.
  final String name;

  /// Builder function.
  final String function;

  /// Declared `(width, height)`, if any.
  final (double, double)? size;
}

/// Everything known about one catalog page.
class CatalogPage {
  /// Creates a page.
  const CatalogPage({
    required this.entry,
    required this.summary,
    required this.classes,
    required this.enums,
    required this.previews,
  });

  /// Manifest entry.
  final ManifestEntry entry;

  /// One-line description.
  final String summary;

  /// API classes.
  final List<ApiClass> classes;

  /// Enums referenced by [classes].
  final List<ApiEnum> enums;

  /// Previews of the page's group, in source order.
  final List<PreviewInfo> previews;
}

// ---------------------------------------------------------------------------
// Extraction
// ---------------------------------------------------------------------------

/// Doc comment text without the `///` markers.
String docOf(AnnotatedNode node) {
  final c = node.documentationComment;
  if (c == null) return '';
  final lines = [
    for (final t in c.tokens)
      t.lexeme.replaceFirst(RegExp(r'^///\s?'), '').trimRight(),
  ];
  // Join wrapped lines into paragraphs; keep blank lines as breaks.
  final out = StringBuffer();
  for (final l in lines) {
    if (l.isEmpty) {
      out.write('\n\n');
    } else {
      if (out.isNotEmpty && !out.toString().endsWith('\n')) out.write(' ');
      out.write(l.trim());
    }
  }
  return out.toString().trim();
}

/// First sentence of [doc].
String firstSentence(String doc) {
  final para = doc.split('\n\n').first;
  final m = RegExp(r'^(.*?[.!?])(\s|$)').firstMatch(para);
  return (m?[1] ?? para).trim();
}

bool _isHidden(AnnotatedNode n) => n.metadata.any((a) {
  final name = a.name.name;
  return name == 'visibleForTesting' ||
      name == 'protected' ||
      name == 'override' ||
      name == 'internal';
});

String _clean(String s) => s.replaceAll(RegExp(r'\s+'), ' ').trim();

/// Parses one source file.
CompilationUnit parseFile(File f) =>
    parseString(content: f.readAsStringSync(), path: f.path).unit;

/// Extracts [className] from [unit].
ApiClass extractClass(CompilationUnit unit, String className) {
  final cls = unit.declarations.whereType<ClassDeclaration>().where(
    (c) => c.namePart.typeName.lexeme == className,
  );
  if (cls.isEmpty) {
    throw StateError('Class $className not found');
  }
  final c = cls.single;
  final members = c.body.members;

  final fields = <String, (String, String, bool)>{}; // name → type, doc, hidden
  for (final f in members.whereType<FieldDeclaration>()) {
    if (f.isStatic && f.fields.isConst) continue;
    for (final v in f.fields.variables) {
      fields[v.name.lexeme] = (
        f.fields.type == null ? 'dynamic' : _clean(f.fields.type!.toSource()),
        docOf(f),
        _isHidden(f) || f.isStatic,
      );
    }
  }

  List<ApiParam> params(FormalParameterList list) => [
    for (final p in list.parameters)
      if (p is! SuperFormalParameter && p.name != null) _param(p, fields),
  ];

  final ctors = <ApiMember>[];
  final props = <ApiMember>[];
  final getters = <ApiMember>[];
  final methods = <ApiMember>[];
  final ctorParamNames = <String>{};

  for (final m in members) {
    if (m is ConstructorDeclaration) {
      final name = m.name?.lexeme;
      if (name != null && name.startsWith('_')) continue;
      final ps = params(m.parameters);
      ctorParamNames.addAll(ps.map((p) => p.name));
      final full = name == null ? className : '$className.$name';
      ctors.add(
        ApiMember(
          kind: m.factoryKeyword != null ? 'factory' : 'constructor',
          name: full,
          signature: '$full${_paramListSource(m.parameters)}',
          doc: docOf(m),
          params: ps,
        ),
      );
    } else if (m is MethodDeclaration) {
      final name = m.name.lexeme;
      if (name.startsWith('_') || _isHidden(m) || m.isSetter) continue;
      if (const {'build', 'createState', 'createElement'}.contains(name)) {
        continue;
      }
      if (m.isOperator) continue;
      final ret = m.returnType == null ? '' : _clean(m.returnType!.toSource());
      if (m.isGetter) {
        getters.add(
          ApiMember(
            kind: m.isStatic ? 'static getter' : 'getter',
            name: name,
            signature: '$ret get $name'.trim(),
            doc: docOf(m),
          ),
        );
      } else {
        final list = m.parameters!;
        methods.add(
          ApiMember(
            kind: m.isStatic ? 'static method' : 'method',
            name: name,
            signature: '$ret $name${_paramListSource(list)}'.trim(),
            doc: docOf(m),
            params: params(list),
          ),
        );
      }
    }
  }
  for (final e in fields.entries) {
    final (type, doc, hidden) = e.value;
    if (e.key.startsWith('_') || hidden || ctorParamNames.contains(e.key)) {
      continue;
    }
    props.add(
      ApiMember(
        kind: 'property',
        name: e.key,
        signature: '$type ${e.key}',
        doc: doc,
      ),
    );
  }
  // Static fields that are not constants (e.g. test hooks) are hidden above.
  return ApiClass(
    name: className,
    superclass: c.extendsClause == null
        ? null
        : _clean(c.extendsClause!.superclass.toSource()),
    doc: docOf(c),
    members: [...ctors, ...props, ...getters, ...methods],
  );
}

ApiParam _param(FormalParameter p, Map<String, (String, String, bool)> fields) {
  final name = p.name!.lexeme;
  final field = fields[name];
  final String type;
  if (p.type != null) {
    type = _clean(p.type!.toSource());
  } else if (p is FieldFormalParameter && field != null) {
    type = field.$1;
  } else if (p.functionTypedSuffix != null) {
    type = 'Function';
  } else {
    type = 'dynamic';
  }
  final doc = p is FieldFormalParameter ? (field?.$2 ?? '') : docOf(p);
  return ApiParam(
    name: name,
    type: type,
    isNamed: p.isNamed,
    isRequired: p.isRequired,
    defaultValue: p.defaultClause == null
        ? null
        : _clean(p.defaultClause!.value.toSource()),
    doc: doc,
  );
}

String _paramListSource(FormalParameterList list) {
  final pos = <String>[];
  final opt = <String>[];
  final named = <String>[];
  for (final p in list.parameters) {
    if (p is SuperFormalParameter) continue;
    final s = _clean(p.toSource().replaceAll(RegExp(r'^\s*@\w+\s*'), ''));
    if (p.isNamed) {
      named.add(s);
    } else if (p.isOptionalPositional) {
      opt.add(s);
    } else {
      pos.add(s);
    }
  }
  return '(${[...pos, if (opt.isNotEmpty) '[${opt.join(', ')}]', if (named.isNotEmpty) '{${named.join(', ')}}'].join(', ')})';
}

/// Enums declared in [units] and referenced by [classes].
List<ApiEnum> extractEnums(
  Iterable<CompilationUnit> units,
  List<ApiClass> classes,
) {
  final referenced = <String>{
    for (final c in classes)
      for (final m in c.members) ...[
        for (final p in m.params) ..._typeNames(p.type),
        if (m.kind == 'property') ..._typeNames(m.signature),
      ],
  };
  final out = <ApiEnum>[];
  for (final u in units) {
    for (final e in u.declarations.whereType<EnumDeclaration>()) {
      final name = e.namePart.typeName.lexeme;
      if (name.startsWith('_') || !referenced.contains(name)) continue;
      out.add(
        ApiEnum(
          name: name,
          doc: docOf(e),
          values: [for (final v in e.body.constants) (v.name.lexeme, docOf(v))],
        ),
      );
    }
  }
  return out;
}

Iterable<String> _typeNames(String type) =>
    RegExp(r'[A-Za-z_]\w*').allMatches(type).map((m) => m[0]!);

/// Every `@CsPreview` under [libDir].
List<PreviewInfo> extractPreviews(Directory libDir) {
  final out = <PreviewInfo>[];
  final files =
      libDir
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  for (final f in files) {
    if (!f.readAsStringSync().contains('@CsPreview')) continue;
    final v = _PreviewVisitor(out);
    parseFile(f).accept(v);
  }
  return out;
}

class _PreviewVisitor extends RecursiveAstVisitor<void> {
  _PreviewVisitor(this.out);

  final List<PreviewInfo> out;

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    for (final a in node.metadata) {
      if (a.name.name != 'CsPreview') continue;
      String? group;
      String? name;
      (double, double)? size;
      for (final arg in a.arguments!.arguments.whereType<NamedArgument>()) {
        final label = arg.name.lexeme;
        final e = arg.argumentExpression;
        if (label == 'group' && e is StringLiteral) group = e.stringValue;
        if (label == 'name' && e is StringLiteral) name = e.stringValue;
        if (label == 'size' && e is InstanceCreationExpression) {
          final args = e.argumentList.arguments;
          size = (
            _num(args[0].argumentExpression),
            _num(args[1].argumentExpression),
          );
        }
        if (label == 'size' && e is MethodInvocation) {
          // `Size(w, h)` parses as a method invocation without resolution.
          final args = e.argumentList.arguments;
          size = (
            _num(args[0].argumentExpression),
            _num(args[1].argumentExpression),
          );
        }
      }
      if (group == null || name == null) {
        throw StateError(
          '@CsPreview on ${node.name.lexeme} needs literal group and name',
        );
      }
      out.add(PreviewInfo(group, name, node.name.lexeme, size));
    }
  }

  double _num(Expression e) => switch (e) {
    IntegerLiteral(:final value) => value!.toDouble(),
    DoubleLiteral(:final value) => value,
    _ => throw StateError('Preview size must be numeric literals: $e'),
  };
}

/// Builds every page of [manifest] from the sources under [root].
List<CatalogPage> buildPages(Directory root) {
  final src = '${root.path}/$sourceDir';
  final previews = extractPreviews(Directory(src));

  final groups = previews.map((p) => p.group).toSet();
  final names = manifest.map((e) => e.name).toSet();
  final missing = groups.difference(names);
  if (missing.isNotEmpty) {
    throw StateError(
      'Preview groups without a catalog entry: ${missing.join(', ')}. '
      'Add them to tool/catalog_gen/lib/src/manifest.dart.',
    );
  }
  final ids = <String>{};
  for (final e in manifest) {
    if (!ids.add(e.id)) throw StateError('Duplicate catalog id ${e.id}');
    if (!categoryOrder.contains(e.category)) {
      throw StateError('Unknown category ${e.category} for ${e.name}');
    }
  }

  final pages = <CatalogPage>[];
  for (final e in manifest) {
    final units = <CompilationUnit>[];
    final classes = <ApiClass>[];
    for (final s in e.api) {
      final unit = parseFile(File('$src/${s.file}'));
      units.add(unit);
      for (final c in s.classes) {
        classes.add(extractClass(unit, c));
      }
    }
    final summary =
        e.summary ?? firstSentence(classes.isEmpty ? '' : classes.first.doc);
    pages.add(
      CatalogPage(
        entry: e,
        summary: summary,
        classes: classes,
        enums: extractEnums(units, classes),
        previews: previews.where((p) => p.group == e.name).toList(),
      ),
    );
  }
  return pages;
}

// ---------------------------------------------------------------------------
// Emission
// ---------------------------------------------------------------------------

String _str(String s) => jsonEncode(s).replaceAll(r'$', r'\$');

String _strOrNull(String? s) => s == null ? 'null' : _str(s);

String _emitParam(ApiParam p) =>
    'CatalogParam(name: ${_str(p.name)}, type: ${_str(p.type)}, '
    'isNamed: ${p.isNamed}, isRequired: ${p.isRequired}, '
    'defaultValue: ${_strOrNull(p.defaultValue)}, doc: ${_str(p.doc)},)';

String _emitMember(ApiMember m) =>
    'CatalogMember(kind: ${_str(m.kind)}, name: ${_str(m.name)}, '
    'signature: ${_str(m.signature)}, doc: ${_str(m.doc)}, '
    'params: [${m.params.map(_emitParam).join(',')}],)';

String _emitClass(ApiClass c) =>
    'CatalogClass(name: ${_str(c.name)}, '
    'superclass: ${_strOrNull(c.superclass)}, doc: ${_str(c.doc)}, '
    'members: [${c.members.map(_emitMember).join(',')}],)';

String _emitEnum(ApiEnum e) =>
    'CatalogEnum(name: ${_str(e.name)}, doc: ${_str(e.doc)}, values: ['
    '${e.values.map((v) => '(${_str(v.$1)}, ${_str(v.$2)})').join(',')}],)';

String _emitPreview(PreviewInfo p) =>
    'CatalogPreview(name: ${_str(p.name)}, function: ${_str(p.function)}, '
    'width: ${p.size?.$1}, height: ${p.size?.$2},)';

/// The generated Dart library for [pages].
String emit(List<CatalogPage> pages) {
  final b = StringBuffer()
    ..writeln('// GENERATED by tool/catalog_gen. Do not edit.')
    ..writeln('// Regenerate: dart run melos run catalog:generate')
    ..writeln('// Source: tool/catalog_gen/lib/src/manifest.dart + dartdoc of')
    ..writeln('// packages/cloudscape_flutter/lib/src.')
    ..writeln()
    ..writeln("import 'package:cs_catalog/src/catalog_model.dart';")
    ..writeln()
    ..writeln('/// Navigation order of categories.')
    ..writeln(
      'const List<String> catalogCategories = '
      '[${categoryOrder.map(_str).join(', ')},];',
    )
    ..writeln()
    ..writeln('/// Every catalog page.')
    ..writeln('const List<CatalogEntry> catalogEntries = [');
  for (final p in pages) {
    final e = p.entry;
    b.writeln(
      'CatalogEntry(id: ${_str(e.id)}, name: ${_str(e.name)}, '
      'category: ${_str(e.category)}, phase: ${e.phase}, '
      'planNumber: ${e.planNumber}, slug: ${_strOrNull(e.slug)}, '
      'summary: ${_str(p.summary)}, '
      'classes: [${p.classes.map(_emitClass).join(',')}], '
      'enums: [${p.enums.map(_emitEnum).join(',')}], '
      'previews: [${p.previews.map(_emitPreview).join(',')}],),',
    );
  }
  b.writeln('];');
  return b.toString();
}
