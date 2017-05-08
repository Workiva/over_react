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

library over_react.component_declaration.transformer_helpers;

import './component_base.dart' as component_base;
import './annotations.dart' as annotations;

export './annotations.dart';
export './component_base.dart'
    hide UiComponent, UiStatefulComponent, UiProps, UiState;

// ----------------------------------------------------------------------
//   Helpers and extras consumable by generated code and consumers of
//   generated code.
// ----------------------------------------------------------------------

/// Placeholder helper class that allows for accessing lists of prop keys
/// in a static yet unsafe way.
///
/// __For advanced usage only.__
@proxy
class $PropKeys implements List<String> {
  /// A placeholder that gets swapped out by the `over_react` transformer
  /// with the prop keys defined in [propsClass].
  const $PropKeys(Type propsClass);

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw new UngeneratedError(
        message: r'The $PropKeys class should not be used at runtime, '
                 r'but should be replaced with a list via the transformer.'
    );
  }
}

/// Placeholder helper class that allows for accessing lists of props
/// in a static yet unsafe way.
///
/// __For advanced usage only.__
@proxy
class $Props implements component_base.ConsumedProps {
  /// A placeholder that gets swapped out by the `over_react` transformer
  /// with the prop keys defined in [propsClass].
  const $Props(Type propsClass);

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw new UngeneratedError(
        message: r'The $Props class should not be used at runtime, '
                 r'but should be replaced with a list via the transformer.'
    );
  }
}

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
      throw new IllegalInstantiationError(runtimeType: this.runtimeType);
    }
  }
}


/// See: [component_base.UiComponent]
///
/// Use with the over_react transformer via the `@Component()` ([annotations.Component]) annotation.
///
/// For strongly-typed state, mix in [component_base.UiStatefulMixin] or extend from [UiStatefulComponent].
abstract class UiComponent<TProps extends UiProps> extends component_base.UiComponent<TProps> with GeneratedClass {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiComponent() {
    _throwIfNotGenerated();
  }

  /// The default consumed props, taken from the keys generated in the associated @[annotations.Props] class.
  @toBeGenerated
  Iterable<component_base.ConsumedProps> get $defaultConsumedProps => throw new UngeneratedError(member: #$defaultConsumedProps);

  /// The keys for the non-forwarding props defined in this component.
  ///
  /// For generated components, this defaults to the keys generated in the associated @[annotations.Props] class
  /// if this getter is not overridden.
  @override
  Iterable<component_base.ConsumedProps> get consumedProps => $defaultConsumedProps;

  /// Returns a typed props object backed by the specified [propsMap].
  /// Required to properly instantiate the generic [TProps] class.
  @override
  @toBeGenerated
  TProps typedPropsFactory(Map propsMap) => throw new UngeneratedError(member: #typedPropsFactory);
}


/// See: [component_base.UiStatefulComponent]
///
/// Use with the over_react transformer via the `@Component()` ([annotations.Component]) annotation.
abstract class UiStatefulComponent<TProps extends UiProps, TState extends UiState>
    extends UiComponent<TProps> with component_base.UiStatefulMixin<TState>
    implements component_base.UiStatefulComponent<TProps, TState> {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiStatefulComponent() {
    _throwIfNotGenerated();
  }

  /// Returns a typed state object backed by the specified [stateMap].
  ///
  /// Required to properly instantiate the generic [TState] class.
  @override
  @toBeGenerated
  TState typedStateFactory(Map stateMap) => throw new UngeneratedError(member: #typedStateFactory);
}

/// A [dart.collection.MapView]-like class with strongly-typed getters/setters for React props that
/// is also capable of creating React component instances.
///
/// For use as a typed view into existing props [Map]s, or as a builder to create new component
/// instances via a fluent-style interface.
///
/// Use with the over_react transformer via the `@Props()` ([annotations.Props]) annotation.
abstract class UiProps extends component_base.UiProps with GeneratedClass {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiProps() {
    _throwIfNotGenerated();
  }

  @toBeGenerated String get propKeyNamespace => throw new UngeneratedError(member: #propKeyNamespace);

  @override @toBeGenerated Map get props                 => throw new UngeneratedError(member: #props);
  @override @toBeGenerated Function get componentFactory => throw new UngeneratedError(member: #componentFactory);
}

/// A [dart.collection.MapView]-like class with strongly-typed getters/setters for React state.
///
/// Use with the over_react transformer via the `@State()` ([annotations.State]) annotation.
abstract class UiState extends component_base.UiState with GeneratedClass {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiState() {
    _throwIfNotGenerated();
  }

  @override @toBeGenerated Map get state => throw new UngeneratedError(member: #state);
}


// ----------------------------------------------------------------------
//   Errors/annotations related to code generation
// ----------------------------------------------------------------------

/// Annotation that denotes that a given member will be implemented via code generation.
///
/// Used in place of the `abstract` keyword so that subclasses don't have to be abstract.
const toBeGenerated = const _ToBeGenerated();

class _ToBeGenerated {
  const _ToBeGenerated();
}

/// Thrown when stubbed code (usually annotated with [ToBeGenerated]) that expects to be
/// overridden by generated code is called unexpectedly.
///
/// Usually this is due to improper usage of the code-generating transformer.
class UngeneratedError extends Error implements UnimplementedError {
  @override
  final String message;
  UngeneratedError({String message, Symbol member}) :
      this.message = message ?? "`$member` should be implemented by code generation";

  @override
  String toString() =>
      "UngeneratedError: $message.\n\n"
      "Ensure that the `over_react` transformer is included in your pubspec.yaml, "
      "and that this code is being run using Pub.";
}

/// Thrown when a class is directly instantiated when it should not be.
class IllegalInstantiationError extends Error {
  final String message;
  IllegalInstantiationError({String message, Type runtimeType}) :
      this.message = message ?? "`$runtimeType` cannot be instantated directly, but only indirectly via the UiFactory";

  @override
  String toString() =>
      "IllegalInstantiationError: $message.\n\n"
      "Be sure to follow usage instructions for over_react component classes.\n\n"
      "If you need to do something extra custom and want to implement everything without code generation, "
      "base classes are available by importing the "
      "`package:over_react/src/component_declaration/component_base.dart` "
      "library directly. ";
}
