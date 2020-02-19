import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:over_react/src/builder/generation/parsing/util.dart';
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart';

extension InitializerHelper on VariableDeclarationList {
  Expression get firstInitializer => variables.first.initializer;
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


/// Provides a common interface for [ClassOrMixinDeclaration] and [ClassTypeAlias].
abstract class ClassishDeclaration<T extends NamedCompilationUnitMember> {
  factory ClassishDeclaration(T node) {
    if (node is ClassDeclaration) {
      return _ClassishDeclaration_ClassDeclaration(node);
    } else if (node is ClassTypeAlias) {
      return _ClassishDeclaration_ClassTypeAlias(node);
    } else if (node is MixinDeclaration) {
      return _ClassishDeclaration_MixinDeclaration(node);
    }

    throw ArgumentError.value(node, 'node', 'must be one of: ClassDeclaration, ClassTypeAlias, MixinDeclaration');
  }

  ClassishDeclaration._(this.node);

  final T node;


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
  bool get isAbstract => abstractKeyword != null;
  List<TypeName> get interfaces;
  List<TypeName> get mixins => withClause?.mixinTypes ?? const [];

}

mixin _ClassishDeclaration_ClassOrMixinDeclaration<T extends ClassOrMixinDeclaration> on ClassishDeclaration<T> {
  @override
  Token get leftBracket => node.leftBracket;

  @override
  List<ClassMember> get members => node.members;

  @override
  Token get rightBracket => node.rightBracket;

  @override
  TypeName get superclass => null;

  @override
  TypeParameterList get typeParameters => node.typeParameters;

  @override
  WithClause get withClause => null;
}

class _ClassishDeclaration_ClassDeclaration<T extends ClassDeclaration> extends ClassishDeclaration<T> with _ClassishDeclaration_ClassOrMixinDeclaration {
  _ClassishDeclaration_ClassDeclaration(T node) : super._(node);

  @override
  Token get abstractKeyword => node.abstractKeyword;

  @override
  // TODO: implement interfaces
  List<TypeName> get interfaces => [
    ...?node.implementsClause?.interfaces,
  ];
}

class _ClassishDeclaration_MixinDeclaration<T extends MixinDeclaration> extends ClassishDeclaration<T> with _ClassishDeclaration_ClassOrMixinDeclaration {
  _ClassishDeclaration_MixinDeclaration(T node) : super._(node);

  @override
  // TODO: implement abstractKeyword
  Token get abstractKeyword => null;

  @override
  List<TypeName> get interfaces => [
    ...?node.implementsClause?.interfaces,
    ...?node.onClause?.superclassConstraints,
  ];
}

class _ClassishDeclaration_ClassTypeAlias<T extends ClassTypeAlias> extends ClassishDeclaration<T> {
  _ClassishDeclaration_ClassTypeAlias(T node) : super._(node);

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
