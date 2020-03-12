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

import 'dart:mirrors' as mirrors;

import 'package:analyzer/dart/ast/ast.dart';

import '../../util.dart';
import 'ast_util.dart';

/// Returns the first annotation AST node on [member] of type [annotationType],
/// or null if no matching annotations are found.
Annotation _getMatchingAnnotation(AnnotatedNode member, Type annotationType) {
  // Be sure to use `originalDeclaration` so that generic parameters work.
  final classMirror = mirrors.reflectClass(annotationType).originalDeclaration;
  final className = mirrors.MirrorSystem.getName(classMirror.simpleName);
  return member.getAnnotationWithName(className);
}

/// Utility class that allows for easy access to an annotated node's
/// instantiated annotation.
class InstantiatedMeta<TMeta> {
  /// The node of the [TMeta] annotation, if it exists.
  final Annotation metaNode;

  /// A reflectively-instantiated version of [metaNode], if it exists.
  final TMeta _value;

  /// The arguments passed to the metadata that are not supported by [getValue],
  /// (or by special handling in subclasses) and therefore not represented in the instantiation of [value].
  final List<Expression> unsupportedArguments;

  /// Construct a [NodeWithMeta] instance from an [AnnotatedNode].
  /// The original node will be available via [node].
  /// The instantiated annotation of type `TMeta` will be available via [value].
  InstantiatedMeta._(this.metaNode, this._value, this.unsupportedArguments);

  factory InstantiatedMeta(AnnotatedNode node) {
    final metaNode = _getMatchingAnnotation(node, TMeta);
    final unsupportedArguments = <Expression>[];
    final value =
        instantiateAnnotationTyped<TMeta>(node, onUnsupportedArgument: unsupportedArguments.add);

    if (value == null) return null;

    return InstantiatedMeta._(metaNode, value, unsupportedArguments);
  }

  /// Whether this node's metadata has arguments that could not be initialized using [getValue]
  /// (or by special handling in subclasses), and therefore cannot represented in the instantiation of [value].
  bool get isIncomplete => unsupportedArguments.isNotEmpty;

  /// A reflectively-instantiated version of [metaNode], if it exists.
  ///
  /// Throws a [StateError] if this node's metadata is incomplete.
  TMeta get value {
    if (isIncomplete) {
      throw StateError('Metadata is incomplete; unsupported arguments $unsupportedArguments. '
          'Use `potentiallyIncompleteMeta` instead.');
    }
    return _value;
  }

  /// A reflectively-instantiated version of [metaNode], if it exists.
  TMeta get potentiallyIncompleteMeta => _value;
}

/// Utility class that allows for easy access to an annotated node's
/// instantiated annotation.
class InstantiatedComponentMeta<TMeta> extends InstantiatedMeta<TMeta> {
  static const String _subtypeOfParamName = 'subtypeOf';

  final Identifier subtypeOfValue;

  /// Construct a [NodeWithMeta] instance from an [AnnotatedNode].
  /// The original node will be available via [node].
  /// The instantiated annotation of type `TMeta` will be available via [meta].
  InstantiatedComponentMeta._(
      Annotation metaNode, TMeta meta, List<Expression> unsupportedArguments, this.subtypeOfValue)
      : super._(metaNode, meta, unsupportedArguments);

  factory InstantiatedComponentMeta(AnnotatedNode node) {
    final instantiated = InstantiatedMeta<TMeta>(node);

    if (instantiated == null) return null;

    Identifier subtypeOfValue;

    NamedExpression subtypeOfParam = instantiated.unsupportedArguments.firstWhere((expression) {
      return expression is NamedExpression && expression.name.label.name == _subtypeOfParamName;
    }, orElse: () => null);

    if (subtypeOfParam != null) {
      if (subtypeOfParam.expression is Identifier) {
        subtypeOfValue = subtypeOfParam.expression;
        instantiated.unsupportedArguments.remove(subtypeOfParam);
      } else {
        throw '`$_subtypeOfParamName` must be an identifier: $subtypeOfParam';
      }
    }

    return InstantiatedComponentMeta._(instantiated.metaNode, instantiated.value,
        instantiated.unsupportedArguments, subtypeOfValue);
  }
}
