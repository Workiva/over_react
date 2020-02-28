import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart';

import 'util.dart';

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

extension MetaDataHelper on AnnotatedNode {
  bool hasAnnotationWithName(String name) => metadata.any((element) => element.name.nameWithoutPrefix == name);
  bool hasAnnotationWithNames(Set<String> names) => metadata.any((element) => names.contains(element.name.nameWithoutPrefix));
}

extension SourceFileSpanHelper on SourceFile {
  FileSpan spanFor(SyntacticEntity nodeOrToken) => nodeOrToken is AstNode
        ? getSpanForNode(this, nodeOrToken)
        : _getSpanForEntity(nodeOrToken);

  /// Returns a [SourceSpan] spanning from the beginning to the end of the given
  /// [node]. The preceding comment and metadata will be excluded if
  /// [skipCommentAndMetadata] is true.
  FileSpan _getSpanForEntity(SyntacticEntity node) => span(node.offset, node.end);
}

extension Classish on NamedCompilationUnitMember {
  ClassishDeclaration asClassish() => ClassishDeclaration(this);
}

bool onlyImplementsThings(ClassishDeclaration classish) =>
    classish.interfaces.isNotEmpty && classish.superclass == null && classish.mixins.isEmpty && classish.members.isEmpty;

/// Provides a common interface for [ClassOrMixinDeclaration] and [ClassTypeAlias].
abstract class ClassishDeclaration {
  factory ClassishDeclaration(NamedCompilationUnitMember node) {
    if (node is ClassDeclaration) {
      return _ClassishDeclaration_ClassDeclaration(node);
    } else if (node is ClassTypeAlias) {
      return _ClassishDeclaration_ClassTypeAlias(node);
    } else if (node is MixinDeclaration) {
      return _ClassishDeclaration_MixinDeclaration(node);
    }

    throw ArgumentError.value(node, 'node', 'must be one of: ClassDeclaration, ClassTypeAlias, MixinDeclaration');
  }

  ClassishDeclaration._();

  NamedCompilationUnitMember get node;

  // Shared
  SimpleIdentifier get name => node.name;
  NodeList<Annotation> get metadata => node.metadata;
  WithClause get withClause;
  TypeParameterList get typeParameters;

  // Unified
  Token get abstractKeyword;
  TypeName get superclass;
  Token get leftBracket;
  Token get rightBracket;
  List<ClassMember> get members;

  // Niceties
  bool get hasAbstractKeyword => abstractKeyword != null;
  List<TypeName> get interfaces;
  List<TypeName> get mixins => withClause?.mixinTypes ?? const [];

}

mixin _ClassishDeclaration_ClassOrMixinDeclaration on ClassishDeclaration {
  @override
  ClassOrMixinDeclaration get node;

  @override
  Token get leftBracket => node.leftBracket;

  @override
  List<ClassMember> get members => node.members;

  @override
  Token get rightBracket => node.rightBracket;

  @override
  TypeParameterList get typeParameters => node.typeParameters;
}

class _ClassishDeclaration_ClassDeclaration extends ClassishDeclaration with _ClassishDeclaration_ClassOrMixinDeclaration {
  @override
  final ClassDeclaration node;

  _ClassishDeclaration_ClassDeclaration(this.node) : super._();

  @override
  Token get abstractKeyword => node.abstractKeyword;

  @override
  // TODO: implement interfaces
  List<TypeName> get interfaces => [
    ...?node.implementsClause?.interfaces,
  ];

  @override
  TypeName get superclass => node.extendsClause?.superclass;

  @override
  WithClause get withClause => node.withClause;
}

class _ClassishDeclaration_MixinDeclaration extends ClassishDeclaration with _ClassishDeclaration_ClassOrMixinDeclaration {
  @override
  final MixinDeclaration node;

  _ClassishDeclaration_MixinDeclaration(this.node) : super._();

  @override
  Token get abstractKeyword => null;

  @override
  List<TypeName> get interfaces => [
    ...?node.implementsClause?.interfaces,
    ...?node.onClause?.superclassConstraints,
  ];

  @override
  TypeName get superclass => null;

  @override
  WithClause get withClause => null;
}

class _ClassishDeclaration_ClassTypeAlias extends ClassishDeclaration {
  @override
  final ClassTypeAlias node;

  _ClassishDeclaration_ClassTypeAlias(this.node) : super._();

  @override
  Token get abstractKeyword => node.abstractKeyword;

  @override
  Token get leftBracket => null;

  @override
  List<ClassMember> get members => const [];

  @override
  Token get rightBracket => null;

  @override
  TypeName get superclass => node.superclass;

  @override
  TypeParameterList get typeParameters => node.typeParameters;

  @override
  WithClause get withClause => node.withClause;

  @override
  List<TypeName> get interfaces => [
    ...?node.implementsClause?.interfaces,
  ];
}
