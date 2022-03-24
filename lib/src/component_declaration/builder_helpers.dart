// Copyright 2016 Workiva Inc.
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

library over_react.component_declaration.builder_helpers;

import '../../component_base.dart';
import '../../over_react.dart';
import './component_base.dart' as component_base;
import './annotations.dart' as annotations;

export './annotations.dart';
export './component_base.dart'
    hide UiComponent, UiStatefulComponent, UiProps, UiState;

// ----------------------------------------------------------------------
//   Base classes to be used by pre-generated code that stub out
//   to-be-generated members.
// ----------------------------------------------------------------------

class GeneratedClass {
  /// Whether this class has been generated.
  ///
  /// Used to allow certain behavior (e.g., instantiation) on generated implementation classes,
  /// while preventing it in the stubbed classes.
  ///
  /// This should ONLY be overridden by code generation; behavior is undefined otherwise.
  bool get $isClassGenerated => false;

  void _throwIfNotGenerated() {
    if (!this.$isClassGenerated) {
      throw IllegalInstantiationError(runtimeType: this.runtimeType);
    }
  }
}

/// Do not implement component_base.UiComponent via `implements` or `on`. This is
/// to work around https://github.com/dart-lang/sdk/issues/38098.
mixin _GeneratedUiComponentStubs<TProps extends UiProps>
    implements GeneratedClass {
  /// The default consumed props, taken from the keys generated in the associated @[annotations.Props] class.
  @toBeGenerated
  Iterable<component_base.ConsumedProps> get $defaultConsumedProps => throw UngeneratedError(member: #$defaultConsumedProps);

  /// The keys for the non-forwarding props defined in this component.
  ///
  /// For generated components, this defaults to the keys generated in the associated @[annotations.Props] class
  /// if this getter is not overridden.
  Iterable<component_base.ConsumedProps> get consumedProps => $defaultConsumedProps;

  /// Returns a typed props object backed by the specified [propsMap].
  /// Required to properly instantiate the generic [TProps] class.
  @toBeGenerated
  TProps typedPropsFactory(Map propsMap) => throw UngeneratedError(member: #typedPropsFactory);
}

/// See: [component_base.UiComponent]
///
/// Use with the over_react builder via the `@Component()` ([annotations.Component]) annotation.
///
/// __Deprecated.__ Use `UiComponent2` instead. Will be removed in the `4.0.0` release.
@Deprecated('4.0.0')
abstract class UiComponent<TProps extends UiProps>
    extends component_base.UiComponent<TProps>
    with
        GeneratedClass,
        _GeneratedUiComponentStubs<TProps> {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiComponent() {
    _throwIfNotGenerated();
  }
}

/// See: [component_base.UiStatefulComponent]
///
/// Use with the over_react builder via the `@Component()` ([annotations.Component]) annotation.
///
/// __Deprecated.__ Use `UiStatefulComponent2` instead. Will be removed in the `4.0.0` release.
@Deprecated('4.0.0')
abstract class UiStatefulComponent<TProps extends UiProps, TState extends UiState>
    extends component_base.UiStatefulComponent<TProps, TState>
    with
        GeneratedClass,
        _GeneratedUiComponentStubs<TProps> {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiStatefulComponent() {
    _throwIfNotGenerated();
  }

  @override
  @toBeGenerated
  TState typedStateFactory(Map stateMap) => throw UngeneratedError(member: #typedStateFactory,
      message: GeneratedErrorMessages.typedStateFactory);
}

/// A [dart.collection.MapView]-like class with strongly-typed getters/setters for React props that
/// is also capable of creating React component instances.
///
/// For use as a typed view into existing props [Map]s, or as a builder to create new component
/// instances via a fluent-style interface.
///
/// To be used with the over_react builder to generate concrete props implementations
/// with a component's declared props mixin(s).
abstract class UiProps extends component_base.UiProps with GeneratedClass {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiProps() {
    _throwIfNotGenerated();
  }

  @Deprecated(
      'Use `UiComponent2.propsMeta` (only available for new mixin-based-boilerplate) instead.'
      ' Will be removed in 4.0.0.')
  @toBeGenerated String get propKeyNamespace => throw UngeneratedError(member: #propKeyNamespace);

  @override @toBeGenerated Map get props => throw UngeneratedError(member: #props);

  /// A collection of metadata for the prop fields in all prop mixins used by
  /// this props instance's generated props class.
  ///
  /// Synonymous with [UiComponent2]'s `propsMeta`.
  ///
  /// This can be used to derive consumed props by usage in conjunction with [addUnconsumedProps]
  /// and [addUnconsumedDomProps].
  @toBeGenerated PropsMetaCollection get staticMeta => throw UngeneratedError(member: #meta);
}

abstract class UnstableUiProps extends component_base.UnstableUiProps with GeneratedClass implements UiProps {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UnstableUiProps() {
    _throwIfNotGenerated();
  }
}

/// A [dart.collection.MapView]-like class with strongly-typed getters/setters for React state.
///
/// To be used with the over_react builder to generate concrete state implementations
/// with a component's declared state mixin(s).
abstract class UiState extends component_base.UiState with GeneratedClass {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiState() {
    _throwIfNotGenerated();
  }

  @override @toBeGenerated Map get state => throw UngeneratedError(member: #state);
}

// ----------------------------------------------------------------------
//   Errors/annotations related to code generation
// ----------------------------------------------------------------------

/// Annotation that denotes that a given member will be implemented via code generation.
///
/// Used in place of the `abstract` keyword so that subclasses don't have to be abstract.
const toBeGenerated = _ToBeGenerated();

class _ToBeGenerated {
  const _ToBeGenerated();
}

/// Thrown when stubbed code (usually annotated with `ToBeGenerated`) that expects to be
/// overridden by generated code is called unexpectedly.
///
/// Usually this is due to improper usage of the code-generating builder.
class UngeneratedError extends Error implements UnimplementedError {
  @override
  final String message;
  UngeneratedError({String message, Symbol member}) :
      this.message = '${member != null ? '' : '`$member` should be implemented by code generation.\n\n'}$message';

  @override
  String toString() =>
      'UngeneratedError: ${message.trimRight()}.\n\n'
      'Ensure that you\'re running a build via build_runner.';
}

/// Thrown when a class is directly instantiated when it should not be.
class IllegalInstantiationError extends Error {
  final String message;
  IllegalInstantiationError({String message, Type runtimeType}) :
      this.message = message ?? '`$runtimeType` cannot be instantated directly, but only indirectly via the UiFactory';


  @override
  String toString() =>
      'IllegalInstantiationError: $message.\n\n'
      'Be sure to follow usage instructions for over_react component classes.\n\n'
      'If you need to do something extra custom and want to implement everything without code generation, '
      'base classes are available by importing the '
      '`package:over_react/src/component_declaration/component_base.dart` '
      'library directly. ';
}


abstract class GeneratedErrorMessages {
  static const String typedStateFactory = '\n\n'
      'This error may be due to your state not being picked up by the builder,'
      ' or because you are extending a stateful component without redeclaring your own state.'
      '\nDouble-check that your component has a state mixin and/or class and that its name matches'
      ' that of the factory/props/component (e.g., "Foo" in Foo/FooProps/FooState/FooComponent).';

  static const String component1AnnotationOnComponent2 = '\n\n'
        'This error may be due to using @Component() instead of @Component2() on your component extending from UiComponent2.';
}
