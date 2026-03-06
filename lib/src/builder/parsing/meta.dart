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
import 'package:build/build.dart' show log;
import 'package:collection/collection.dart' show IterableExtension;
import 'package:meta/meta.dart';

import 'package:over_react/src/component_declaration/annotations.dart' as a;

import '../vendor/transformer_utils/src/analyzer_helpers.dart';

/// Returns the first annotation AST node on [node] of type [T],
/// or null if no matching annotations are found.
Annotation? _getMatchingAnnotation<T extends Object>(AnnotatedNode node) {
  final annotationClass = getAnnotationClassFromGeneric<T>();
  if (annotationClass == null) return null;

  return node.metadata.firstWhereOrNull((m) => m.name.name == annotationClass.className);
}

/// Utility class that allows partial instantiation of annotations, to support reading
/// annotation data in a context without a resolved AST. See [isIncomplete] for more info.
class InstantiatedMeta<TMeta extends Object> {
  /// The node of the [TMeta] annotation, if it exists.
  final Annotation metaNode;

  /// A reflectively-instantiated version of [metaNode], if it exists.
  final TMeta _value;

  /// The arguments passed to the metadata that are not supported by [value],
  /// (or by special handling in subclasses) and therefore not represented in the instantiation of
  /// [potentiallyIncompleteValue].
  final List<Expression> unsupportedArguments;

  InstantiatedMeta._(this.metaNode, this._value, this.unsupportedArguments);

  /// Returns an instance representing the first annotation of type [T]
  /// on [node], or null if there is no matching annotation.
  /// The original node will be available via [node].
  ///
  /// The instantiated annotation will be available via [value].
  static InstantiatedMeta<T>? fromNode<T extends Object>(AnnotatedNode node) {
    final metaNode = _getMatchingAnnotation<T>(node);
    if (metaNode == null) return null;

    final unsupportedArguments = <Expression>[];
    final value =
        instantiateAnnotationTyped<T>(node, onUnsupportedArgument: unsupportedArguments.add);

    if (value == null) return null;

    return InstantiatedMeta._(metaNode, value, unsupportedArguments);
  }

  /// Whether this node's metadata has arguments that could not be used to instantiate it
  /// reflectively (e.g., non-literal values), and therefore were omitted during instantiation.
  ///
  /// If this is true, the annotation must be accessed via [potentiallyIncompleteValue] and not [value].
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
  TMeta get potentiallyIncompleteValue => _value;
}

/// Utility that allows partial instantiation of a `Component`/`Component2` annotation.
///
/// See superclass for more information.
class InstantiatedComponentMeta<TMeta extends Object> extends InstantiatedMeta<TMeta> {
  static const String _subtypeOfParamName = 'subtypeOf';

  final Identifier? subtypeOfValue;

  InstantiatedComponentMeta._(
      Annotation metaNode, TMeta meta, List<Expression> unsupportedArguments, this.subtypeOfValue)
      : super._(metaNode, meta, unsupportedArguments);

  static InstantiatedComponentMeta<T>? fromNode<T extends Object>(AnnotatedNode node) {
    try {
      final instantiated = InstantiatedMeta.fromNode<T>(node);
      if (instantiated == null) return null;

      Identifier? subtypeOfValue;

      NamedExpression? subtypeOfParam = instantiated.unsupportedArguments
          .whereType<NamedExpression>()
          .firstWhereOrNull((expression) => expression.name.label.name == _subtypeOfParamName);

      if (subtypeOfParam != null) {
        final expression = subtypeOfParam.expression;
        if (expression is Identifier) {
          subtypeOfValue = expression;
          instantiated.unsupportedArguments.remove(subtypeOfParam);
        } else {
          throw Exception('`$_subtypeOfParamName` must be an identifier: $subtypeOfParam');
        }
      }

      return InstantiatedComponentMeta._(instantiated.metaNode, instantiated.value,
          instantiated.unsupportedArguments, subtypeOfValue);
    } catch (e, st) {
      // Log a severe error instead of throwing, so that the error doesn't propagate when we're doing parsing within
      // the analyzer plugin.
      // This severe error will fail the build and be presented to the consumer.
      log.severe('Error reading component annotation', e, st);
      return null;
    }
  }
}

T? instantiateAnnotationTyped<T extends Object>(
  AnnotatedNode node, {
  dynamic Function(Expression argument)? onUnsupportedArgument,
}) {
  // TODO DRY up
  final annotationClass = getAnnotationClassFromGeneric<T>();
  if (annotationClass == null) return null;

  final annotation =
      node.metadata.firstWhereOrNull((m) => m.name.name == annotationClass.className);
  if (annotation == null) return null;

  final args = getAnnotationArgs(annotation, onUnsupportedArgument: onUnsupportedArgument);

  switch (annotationClass) {
    case _AnnotationClass.props:
      return a.Props(
        keyNamespace: args.named['keyNamespace'] as String?,
        disableRequiredPropValidation: args.named['disableRequiredPropValidation'] as Set<String>?,
        disableValidationForClassDefaultProps:
            args.named['disableValidationForClassDefaultProps'] as bool? ?? true,
      ) as T;
    case _AnnotationClass.abstractProps:
      return a.AbstractProps(
        keyNamespace: args.named['keyNamespace'] as String?,
      ) as T;
    case _AnnotationClass.propsMixin:
      // ignore: deprecated_member_use_from_same_package
      return a.PropsMixin(
        keyNamespace: args.named['keyNamespace'] as String?,
      ) as T;
    case _AnnotationClass.state:
      return a.State(
        keyNamespace: args.named['keyNamespace'] as String?,
      ) as T;
    case _AnnotationClass.abstractState:
      return a.AbstractState(
        keyNamespace: args.named['keyNamespace'] as String?,
      ) as T;
    case _AnnotationClass.stateMixin:
      // ignore: deprecated_member_use_from_same_package
      return a.StateMixin(
        keyNamespace: args.named['keyNamespace'] as String?,
      ) as T;
    case _AnnotationClass.component2:
      return a.Component2(
        isWrapper: args.named['isWrapper'] as bool? ?? false,
        subtypeOf: args.named['subtypeOf'] as Type?,
        isErrorBoundary: args.named['isErrorBoundary'] as bool? ?? false,
      ) as T;
    case _AnnotationClass.component:
      // ignore: deprecated_member_use_from_same_package
      return a.Component(
        isWrapper: args.named['isWrapper'] as bool? ?? false,
        subtypeOf: args.named['subtypeOf'] as Type?,
      ) as T;
    case _AnnotationClass.accessor:
      return a.Accessor(
        key: args.named['key'] as String?,
        keyNamespace: args.named['keyNamespace'] as String?,
        isRequired: (args.named['isRequired'] as bool?) ?? false,
        isNullable: (args.named['isNullable'] as bool?) ?? false,
        requiredErrorMessage: args.named['requiredErrorMessage'] as String?,
        doNotGenerate: (args.named['doNotGenerate'] as bool?) ?? false,
      ) as T;
  }
}

enum _AnnotationClass {
  props('Props'),
  abstractProps('AbstractProps'),
  propsMixin('PropsMixin'),
  state('State'),
  abstractState('AbstractState'),
  stateMixin('StateMixin'),
  component2('Component2'),
  component('Component'),
  accessor('Accessor');

  final String className;

  const _AnnotationClass(this.className);
}

@visibleForTesting
_AnnotationClass? getAnnotationClassFromGeneric<T>() {
  if (_isSubtypeOf<T, a.Props>()) return _AnnotationClass.props;
  if (_isSubtypeOf<T, a.AbstractProps>()) return _AnnotationClass.abstractProps;
  // ignore: deprecated_member_use_from_same_package
  if (_isSubtypeOf<T, a.PropsMixin>()) return _AnnotationClass.propsMixin;
  if (_isSubtypeOf<T, a.State>()) return _AnnotationClass.state;
  if (_isSubtypeOf<T, a.AbstractState>()) return _AnnotationClass.abstractState;
  // ignore: deprecated_member_use_from_same_package
  if (_isSubtypeOf<T, a.StateMixin>()) return _AnnotationClass.stateMixin;
  if (_isSubtypeOf<T, a.Component2>()) return _AnnotationClass.component2;
  // ignore: deprecated_member_use_from_same_package
  if (_isSubtypeOf<T, a.Component>()) return _AnnotationClass.component;
  if (_isSubtypeOf<T, a.Accessor>()) return _AnnotationClass.accessor;
  return null;
}

bool _isSubtypeOf<T, S>() => _SubtypeOfHelper<T>() is _SubtypeOfHelper<S>;

class _SubtypeOfHelper<T> {}
