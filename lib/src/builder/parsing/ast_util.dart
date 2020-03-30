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
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart';

import 'ast_util/classish.dart';
import 'util.dart';

export 'ast_util/classish.dart';

/// Utils that allow for easier access into VariableDeclarationList
extension InitializerHelper on VariableDeclarationList {
  Expression get firstInitializer => variables.first.initializer;

  VariableDeclaration get firstVariable => variables.first;
}

/// Utils built upon [InitializerHelper] that provide convenient getters into
/// the variables within a [VariableDeclarationList].
extension InitializerHelperTopLevel on TopLevelVariableDeclaration {
  Expression get firstInitializer => variables.firstInitializer;

  VariableDeclaration get firstVariable => variables.firstVariable;
}

/// Extension built on both [TypeNameHelper] and [NameHelper] to allow
/// for easy access to the `name` field of [Identifier]s.
extension TypeAnnotationNameHelper on TypeAnnotation {
  /// Get the name of the node if the node is a [NamedType], otherwise return
  /// `null`.
  String get typeNameWithoutPrefix => tryCast<NamedType>()?.nameWithoutPrefix;
}

/// Extension built on [NameHelper] to allow for easy access to the `name`
/// field of [Identifier]s.
extension TypeNameHelper on NamedType {
  String get nameWithoutPrefix => name.nameWithoutPrefix;
}

/// Utilities related to simplifying access to node identifier fields.
extension NameHelper on Identifier {
  /// Ubiquitously access the name of a identifiers without concern about prefixes.
  String get nameWithoutPrefix {
    final self = this;
    return self is PrefixedIdentifier ? self.identifier.name : self.name;
  }
}

/// Utilities related to detecting a super class on a [MixinDeclaration]
extension SuperclassConstraint on MixinDeclaration {
  /// Detects if a mixin is being limited to certain superclass (equal to [superclassName]).
  ///
  /// Returns false if [superclassName] is not specified or the mixin's `onClause`
  /// is `null`.
  bool hasSuperclassConstraint(String superclassName) {
    return onClause?.superclassConstraints?.any((s) => s.typeNameWithoutPrefix == superclassName) ??
        false;
  }
}

/// Utilities for determining if a [ClassOrMixinDeclaration] has an abstract getter.
extension AbstractGetter on ClassOrMixinDeclaration {
  /// Verifies the provided [name] and return [type] are not connected to an abstract getter.
  ///
  /// Only returns true if [name] exists on the node and is the expected [type],
  /// in addition to being an abstract getter.
  ///
  /// [name] should get the name of the getter and [type] should be its return type.
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

  /// Find the first annotation on this node whose class or variable name is [name].
  Annotation getAnnotationWithName(String name) {
    assert(!name.contains('.'), 'must be a class or variable name, unprefixed');

    return metadata.firstWhere(
        (annotation) => _getAnnotationClassOrTopLevelVariableName(annotation) == name,
        orElse: () => null);
  }

  /// Find the first annotation on this node whose class or variable name is  included in [names].
  Annotation getAnnotationWithNames(Set<String> names) {
    assert(
        !names.any((name) => name.contains('.')), 'must be a class or variable name, unprefixed');

    return metadata.firstWhere(
        (annotation) => names.contains(_getAnnotationClassOrTopLevelVariableName(annotation)),
        orElse: () => null);
  }

  /// Detects if a node has an annotation with a name that matches [name].
  ///
  /// Related: [getAnnotationWithName]
  bool hasAnnotationWithName(String name) => getAnnotationWithName(name) != null;

  /// Detects if a node has an annotation with a name that matches a `String` included
  /// in [names].
  ///
  /// Related: [getAnnotationWithNames]
  bool hasAnnotationWithNames(Set<String> names) => getAnnotationWithNames(names) != null;
}

/// Span utilities for [SourceFile]s.
extension SourceFileSpanHelper on SourceFile {
  /// Returns the [FileSpan] for a given node.
  ///
  /// If the entity is an [AstNode], simply uses [getSpanForNode]. Otherwise, the
  /// entity is a `Token` and will have its span evaluated with [span].
  FileSpan spanFor(SyntacticEntity nodeOrToken) =>
      nodeOrToken is AstNode ? getSpanForNode(this, nodeOrToken) : _getSpanForEntity(nodeOrToken);

  /// Returns a [FileSpan] spanning from the beginning to the end of the given
  /// [node].
  FileSpan _getSpanForEntity(SyntacticEntity node) => span(node.offset, node.end);
}

/// Evaluates if a [ClassishDeclaration] implements a class but does not extend
/// or mix in anything.
///
/// This also considers superclass constraints on mixins as "interfaces".
bool onlyImplementsThings(ClassishDeclaration classish) =>
    classish.interfaces.isNotEmpty &&
    classish.superclass == null &&
    classish.mixins.isEmpty &&
    classish.members.isEmpty;

/// Evaluates [test] on [expression] and returns `true` if [expression] has an
/// [Identifier] that passes the test.
///
/// If [test] returns `true` on any [Identifier] then this will also.
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
