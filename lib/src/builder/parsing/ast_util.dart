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
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react/src/builder/codegen/names.dart';
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart';

import 'ast_util/classish.dart';
import 'util.dart';

export 'ast_util/classish.dart';

/// Utils that allow for easier access into VariableDeclarationList
extension InitializerHelper on VariableDeclarationList {
  /// The initializer for the first variable in this list.
  Expression get firstInitializer => variables.first.initializer;

  /// The first variable in this list.
  VariableDeclaration get firstVariable => variables.first;
}

/// Utils built upon [InitializerHelper] that provide convenient getters into
/// the variables within a [VariableDeclarationList].
extension InitializerHelperTopLevel on TopLevelVariableDeclaration {
  /// The initializer for the first variable in this list.
  Expression get firstInitializer => variables.firstInitializer;

  /// The first variable in this list.
  VariableDeclaration get firstVariable => variables.firstVariable;

  /// Returns whether or not there is a generated config being used.
  bool get usesAGeneratedConfig {
    final generatedPrivateConfigName = FactoryNames(firstVariable.name.name).privateConfigName;
    // ignore: deprecated_member_use_from_same_package
    final generatedPublicConfigName = FactoryNames(firstVariable.name.name).publicConfigName;
    return firstInitializer != null &&
        anyDescendantIdentifiers(firstInitializer, (identifier) {
          return identifier.nameWithoutPrefix == generatedPrivateConfigName ||
              identifier.nameWithoutPrefix == generatedPublicConfigName;
        });
  }
}

/// Extension built on both [TypeNameHelper] and [NameHelper] to allow
/// for easy access to the `name` field of [Identifier]s.
extension TypeAnnotationNameHelper on TypeAnnotation {
  /// The unprefixed name of the node if the node is a [NamedType], or `null`
  /// if this type is not named.
  String get typeNameWithoutPrefix => tryCast<NamedType>()?.nameWithoutPrefix;
}

/// Extension built on [NameHelper] to allow for easy access to the `name`
/// field of [Identifier]s.
extension TypeNameHelper on NamedType {
  /// The type name without any namespace prefixes.
  String get nameWithoutPrefix => name.nameWithoutPrefix;
}

/// Utilities related to simplifying access to node identifier fields.
extension NameHelper on Identifier {
  /// The identifier without any prefixes (e.g., namespaces, classes, etc).
  String get nameWithoutPrefix {
    final self = this;
    return self is PrefixedIdentifier ? self.identifier.name : self.name;
  }

  bool get isFunctionType => ['uiFunction', 'uiForwardRef', 'uiJsComponent'].contains(this.name);
}

/// Utilities related to detecting a super class on a [MixinDeclaration]
extension SuperclassConstraint on MixinDeclaration {
  /// Returns whether [superclassName] appears in this mixin's `on` clause.
  ///
  /// Any identifier prefixes in the `on` clause are removed before comparison.
  bool hasSuperclassConstraint(String superclassName) {
    return onClause?.superclassConstraints?.any((s) => s.typeNameWithoutPrefix == superclassName) ??
        false;
  }
}

/// Utilities for determining if a [ClassOrMixinDeclaration] has an abstract getter.
extension AbstractGetter on ClassOrMixinDeclaration {
  /// Returns whether this class/mixin contains an abstract getter with the provided [name]
  /// and a return type exactly matching [type]
  bool hasAbstractGetter(String type, String name) =>
      members.whereType<MethodDeclaration>().any((member) =>
          member.isGetter &&
          !member.isSynthetic &&
          member.isAbstract &&
          member.name.name == name &&
          member.returnType?.toSource() == type);
}

/// Utilities that provide for easier access to [AnnotatedNode] metadata.
extension MetadataHelper on AnnotatedNode {
  // Annotations don't always parse as expected, so `.name` can also include the constructor
  // even though it's supposed to be just the class name.
  static String _getAnnotationClassOrTopLevelVariableName(Annotation annotation) {
    var fullName = annotation.name.name;
    if (annotation.constructorName != null) {
      fullName = '$fullName.${annotation.constructorName.name}';
    }

    final segments = fullName.split('.');
    return segments.lastWhere((segment) {
      final withoutSpecialPrefixes = segment.replaceFirst(RegExp(r'^[_$]+'), '');
      if (withoutSpecialPrefixes.isEmpty) return false;
      return withoutSpecialPrefixes[0] == withoutSpecialPrefixes[0].toUpperCase();
    }, orElse: () => segments.last);
  }

  /// Returns the first annotation on this node whose class or variable name is [name].
  Annotation getAnnotationWithName(String name) {
    assert(!name.contains('.'), 'must be a class or variable name, unprefixed');

    return metadata.firstWhere(
        (annotation) => _getAnnotationClassOrTopLevelVariableName(annotation) == name,
        orElse: () => null);
  }

  /// Returns the first annotation on this node whose class or variable name is included in [names].
  Annotation getAnnotationWithNames(Set<String> names) {
    assert(
        !names.any((name) => name.contains('.')), 'must be a class or variable name, unprefixed');

    return metadata.firstWhere(
        (annotation) => names.contains(_getAnnotationClassOrTopLevelVariableName(annotation)),
        orElse: () => null);
  }

  /// Returns whether a node has an annotation whose class or variable name matches [name].
  ///
  /// Related: [getAnnotationWithName]
  bool hasAnnotationWithName(String name) => getAnnotationWithName(name) != null;

  /// Returns whether a node has an annotation whose class or variable name matches
  /// any of the values in [names].
  ///
  /// Related: [getAnnotationWithNames]
  bool hasAnnotationWithNames(Set<String> names) => getAnnotationWithNames(names) != null;
}

/// Span utilities for [SourceFile]s.
extension SourceFileSpanHelper on SourceFile {
  /// Returns a span for the given [AstNode] or [Token].
  ///
  /// If it's an [AstNode], the span starts after the doc comment and metadata (see [getSpanForNode]).
  FileSpan spanFor(SyntacticEntity nodeOrToken) =>
      nodeOrToken is AstNode ? getSpanForNode(this, nodeOrToken) as FileSpan : _getSpanForEntity(nodeOrToken);

  FileSpan _getSpanForEntity(SyntacticEntity node) => span(node.offset, node.end);
}

/// Returns whether [member] is static.
bool isStaticMember(ClassMember member) =>
    (member is MethodDeclaration && member.isStatic) ||
    (member is FieldDeclaration && member.isStatic);

/// Returns whether [classish] has one or more types it implements and does not
/// extend or mix in anything.
///
/// This also considers superclass constraints on mixins as "interfaces".
bool onlyImplementsThings(ClassishDeclaration classish) =>
    classish.interfaces.isNotEmpty &&
    classish.superclass == null &&
    classish.mixins.isEmpty &&
    classish.members.every(isStaticMember);

/// Returns whether any [Identifier] within [expression] matches the predicate [test].
bool anyDescendantIdentifiers(Expression expression, bool Function(Identifier) test) {
  final visitor = _AnyDescendantIdentifiersVisitor(test);
  expression.accept(visitor);
  return visitor.hasMatch;
}

/// Returns the [Identifier] within [expression] matches the predicate [test].
SimpleIdentifier getDescendantIdentifier(Expression expression, bool Function(Identifier) test) {
  final visitor = _AnyDescendantIdentifiersVisitor(test);
  expression.accept(visitor);
  return visitor.match;
}

class _AnyDescendantIdentifiersVisitor extends UnifyingAstVisitor<void> {
  final bool Function(Identifier) _test;

  bool hasMatch = false;
  SimpleIdentifier match;

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
      match = identifier;
    }

    super.visitSimpleIdentifier(identifier);
  }
}
