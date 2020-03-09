import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart';

import 'ast_util/classish.dart';
import 'util.dart';

export 'ast_util/classish.dart';

extension InitializerHelper on VariableDeclarationList {
  Expression get firstInitializer => variables.first.initializer;
  VariableDeclaration get firstVariable => variables.first;
}

extension InitializerHelper2 on TopLevelVariableDeclaration {
  Expression get firstInitializer => variables.firstInitializer;
  VariableDeclaration get firstVariable => variables.firstVariable;
}

extension TypeAnnotationNameHelper on TypeAnnotation {
  String get typeNameWithoutPrefix => tryCast<NamedType>()?.nameWithoutPrefix;
}

extension TypeNameHelper on NamedType {
  String get nameWithoutPrefix => name.nameWithoutPrefix;
}

extension NameHelper on Identifier {
  String get nameWithoutPrefix {
    final self = this;
    return self is PrefixedIdentifier ? self.identifier.name : self.name;
  }
}

extension SuperclassConstraint on MixinDeclaration {
  bool hasSuperclassConstraint(String superclassName) {
    return onClause?.superclassConstraints?.any((s) => s.typeNameWithoutPrefix == superclassName) ??
        false;
  }
}

extension MetadataHelper on AnnotatedNode {
  Annotation getAnnotationWithName(String name) =>
      metadata.firstWhere((element) => element.name.nameWithoutPrefix == name, orElse: () => null);

  Annotation getAnnotationWithNames(Set<String> names) => metadata
      .firstWhere((element) => names.contains(element.name.nameWithoutPrefix), orElse: () => null);

  bool hasAnnotationWithName(String name) => getAnnotationWithName(name) != null;
  bool hasAnnotationWithNames(Set<String> names) => getAnnotationWithNames(names) != null;
}

extension SourceFileSpanHelper on SourceFile {
  FileSpan spanFor(SyntacticEntity nodeOrToken) =>
      nodeOrToken is AstNode ? getSpanForNode(this, nodeOrToken) : _getSpanForEntity(nodeOrToken);

  /// Returns a [SourceSpan] spanning from the beginning to the end of the given
  /// [node]. The preceding comment and metadata will be excluded if
  /// [skipCommentAndMetadata] is true.
  FileSpan _getSpanForEntity(SyntacticEntity node) => span(node.offset, node.end);
}

bool onlyImplementsThings(ClassishDeclaration classish) =>
    classish.interfaces.isNotEmpty &&
    classish.superclass == null &&
    classish.mixins.isEmpty &&
    classish.members.isEmpty;

bool anyDescendantIdentifiers(Expression expression, bool Function(Identifier) test) {
  final visitor = _AnyDescendantIdentifiersVisitor(test);
  expression.accept(visitor);
  return visitor.hasMatch;
}

class _AnyDescendantIdentifiersVisitor extends UnifyingAstVisitor<void> {
  final bool Function(Identifier) _test;

  bool hasMatch = false;

  _AnyDescendantIdentifiersVisitor(this._test);

  @override
  void visitNode(AstNode node) {
    // Short-circuit and stop traversing recursively.
    if (hasMatch) return;

    super.visitNode(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier identifier) {
    if (_test(identifier)) {
      hasMatch = true;
    }

    super.visitSimpleIdentifier(identifier);
  }
}
