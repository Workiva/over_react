// @dart=2.11
// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

extension Classish on NamedCompilationUnitMember {
  ClassishDeclaration asClassish() => ClassishDeclaration(this);
}

/// Provides a common interface for [ClassDeclaration], [MixinDeclaration],
/// and [ClassTypeAlias].
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

  Token get name => node.name;
  NodeList<Annotation> get metadata => node.metadata;

  TypeParameterList get typeParameters;
  List<ClassMember> get members;
  Token get classOrMixinKeyword;

  /// All interfaces used by this class, including mixin superclass constraints.
  List<NamedType> get interfaces;

  List<NamedType> get allSuperTypes {
    final superclass = this.superclass;
    return [
      ...interfaces,
      ...mixins,
      if (superclass != null) superclass,
    ];
  }

  //
  // Applies only to some subtypes

  WithClause get withClause;
  Token get abstractKeyword;
  bool get hasAbstractKeyword => abstractKeyword != null;
  NamedType get superclass;

  List<NamedType> get mixins => withClause?.mixinTypes ?? const [];
}

class _ClassishClass extends ClassishDeclaration {
  @override
  final ClassDeclaration node;

  _ClassishClass(this.node) : super._();

  @override
  Token get abstractKeyword => node.abstractKeyword;

  @override
  List<NamedType> get interfaces => [
        ...?node.implementsClause?.interfaces,
      ];

  @override
  NamedType get superclass => node.extendsClause?.superclass;

  @override
  WithClause get withClause => node.withClause;

  @override
  Token get classOrMixinKeyword => node.classKeyword;

  @override
  List<ClassMember> get members => node.members;

  @override
  TypeParameterList get typeParameters => node.typeParameters;
}

class _ClasssishMixin extends ClassishDeclaration {
  @override
  final MixinDeclaration node;

  _ClasssishMixin(this.node) : super._();

  @override
  Token get abstractKeyword => null;

  @override
  Token get classOrMixinKeyword => node.mixinKeyword;

  @override
  List<NamedType> get interfaces => [
        ...?node.implementsClause?.interfaces,
        ...?node.onClause?.superclassConstraints,
      ];

  @override
  NamedType get superclass => null;

  @override
  WithClause get withClause => null;

  @override
  List<ClassMember> get members => node.members;

  @override
  TypeParameterList get typeParameters => node.typeParameters;
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
  NamedType get superclass => node.superclass;

  @override
  TypeParameterList get typeParameters => node.typeParameters;

  @override
  WithClause get withClause => node.withClause;

  @override
  List<NamedType> get interfaces => [
        ...?node.implementsClause?.interfaces,
      ];
}
