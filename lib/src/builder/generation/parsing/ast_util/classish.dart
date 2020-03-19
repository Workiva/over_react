import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

extension Classish on NamedCompilationUnitMember {
  ClassishDeclaration asClassish() => ClassishDeclaration(this);
}

/// Provides a common interface for [ClassOrMixinDeclaration] and [ClassTypeAlias].
abstract class ClassishDeclaration {
  factory ClassishDeclaration(NamedCompilationUnitMember node) {
    if (node is ClassDeclaration) {
      return _ClassishClass(node);
    } else if (node is ClassTypeAlias) {
      return _ClassishClassTypeAlias(node);
    } else if (node is MixinDeclaration) {
      return _ClasssishMixin(node);
    }

    throw ArgumentError.value(
        node, 'node', 'must be one of: ClassDeclaration, ClassTypeAlias, MixinDeclaration');
  }

  ClassishDeclaration._();

  NamedCompilationUnitMember get node;

  //
  // Shared

  SimpleIdentifier get name => node.name;
  NodeList<Annotation> get metadata => node.metadata;

  TypeParameterList get typeParameters;
  List<ClassMember> get members;
  Token get classOrMixinKeyword;
  List<TypeName> get interfaces;

  List<TypeName> get allSuperTypes => [
        ...interfaces,
        ...mixins,
        if (superclass != null) superclass,
      ];

  //
  // Applies only to some subtypes

  WithClause get withClause;
  Token get abstractKeyword;
  bool get hasAbstractKeyword => abstractKeyword != null;
  TypeName get superclass;

  List<TypeName> get mixins => withClause?.mixinTypes ?? const [];
}

abstract class _ClassishClassOrMixin extends ClassishDeclaration {
  _ClassishClassOrMixin._() : super._();

  @override
  ClassOrMixinDeclaration get node;

  @override
  List<ClassMember> get members => node.members;

  @override
  TypeParameterList get typeParameters => node.typeParameters;
}

class _ClassishClass extends _ClassishClassOrMixin {
  @override
  final ClassDeclaration node;

  _ClassishClass(this.node) : super._();

  @override
  Token get abstractKeyword => node.abstractKeyword;

  @override
  List<TypeName> get interfaces => [
        ...?node.implementsClause?.interfaces,
      ];

  @override
  TypeName get superclass => node.extendsClause?.superclass;

  @override
  WithClause get withClause => node.withClause;

  @override
  Token get classOrMixinKeyword => node.classKeyword;
}

class _ClasssishMixin extends _ClassishClassOrMixin {
  @override
  final MixinDeclaration node;

  _ClasssishMixin(this.node) : super._();

  @override
  Token get abstractKeyword => null;

  @override
  Token get classOrMixinKeyword => node.mixinKeyword;

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

class _ClassishClassTypeAlias extends ClassishDeclaration {
  @override
  final ClassTypeAlias node;

  _ClassishClassTypeAlias(this.node) : super._();

  @override
  Token get abstractKeyword => node.abstractKeyword;

  @override
  Token get classOrMixinKeyword => node.typedefKeyword;

  @override
  List<ClassMember> get members => const [];

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
