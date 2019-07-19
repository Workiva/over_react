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

import 'package:react/react_client.dart';
// FIXME 3.0.0-wip use public entrypoint
import 'package:react/src/react_client/js_backed_map.dart';

import './component_base.dart' as component_base;
import './annotations.dart' as annotations;

export './annotations.dart';
export './component_base.dart'
    hide UiComponent, UiStatefulComponent, UiComponent2, UiStatefulComponent2, UiProps, UiState;

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

mixin _GeneratedUiComponentStubs<TProps extends UiProps>
    on component_base.UiComponent<TProps>, GeneratedClass {
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

mixin _GeneratedUiStatefulComponentStubs<TProps extends UiProps, TState extends UiState>
    on component_base.UiStatefulComponent<TProps, TState>, GeneratedClass {
  /// Returns a typed state object backed by the specified [stateMap].
  ///
  /// Required to properly instantiate the generic [TState] class.
  @override
  @toBeGenerated
  TState typedStateFactory(Map stateMap) => throw new UngeneratedError(member: #typedStateFactory, message:
      '${#typedStateFactory}` should be implemented by code generation.\n\n'
      'This error may be due to your `UiState` class not being annotated with `@State()`,\n'
      'or because you are extending a stateful component without redeclaring your own `@State()`, like so:\n\n'
      '    @State()\n'
      '    class MyState extends SuperState {}\n'
  );
}

/// See: [component_base.UiComponent]
///
/// Use with the over_react builder via the `@Component()` ([annotations.Component]) annotation.
///
/// __Deprecated.__ Use [UiComponent2] instead. Will be removed in the `4.0.0` release.
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
/// __Deprecated.__ Use [UiStatefulComponent2] instead. Will be removed in the `4.0.0` release.
@Deprecated('4.0.0')
abstract class UiStatefulComponent<TProps extends UiProps, TState extends UiState>
    extends component_base.UiStatefulComponent<TProps, TState>
    with
        GeneratedClass,
        _GeneratedUiComponentStubs<TProps>,
        _GeneratedUiStatefulComponentStubs<TProps, TState> {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiStatefulComponent() {
    _throwIfNotGenerated();
  }
}

mixin _GeneratedUiComponent2Stubs<TProps extends UiProps>
    on component_base.UiComponent2<TProps>, GeneratedClass {
  /// Returns a typed props object backed by the specified [propsMap].
  ///
  /// Required to properly instantiate the generic [TProps] class.
  ///
  /// This should be used where possible over [typedPropsFactory] to allow for
  /// more efficient dart2js output.
  @override
  @toBeGenerated
  TProps typedPropsFactoryJs(JsBackedMap propsMap) => throw new UngeneratedError(member: #typedPropsFactoryJs, message:
    '${#typedPropsFactoryJs}` should be implemented by code generation.\n\n'
    'This error may be due to your `UiComponent2` or `UiStatefulComponent2` class not being annotated with `@Component2()`'
  );
}

/// See: [component_base.UiComponent2]
///
/// Use with the over_react builder via the `@Component2()` ([annotations.Component2]) annotation.
abstract class UiComponent2<TProps extends UiProps>
    extends component_base.UiComponent2<TProps>
    with
        GeneratedClass,
        _GeneratedUiComponentStubs<TProps>,
        _GeneratedUiComponent2Stubs<TProps> {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiComponent2() {
    _throwIfNotGenerated();
  }
}

/// See: [component_base.UiStatefulComponent2]
///
/// Use with the over_react builder via the `@Component2()` ([annotations.Component2]) annotation.
abstract class UiStatefulComponent2<TProps extends UiProps, TState extends UiState>
    extends component_base.UiStatefulComponent2<TProps, TState>
    with
        GeneratedClass,
        _GeneratedUiComponentStubs<TProps>,
        _GeneratedUiComponent2Stubs<TProps>,
        _GeneratedUiStatefulComponentStubs<TProps, TState> {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiStatefulComponent2() {
    _throwIfNotGenerated();
  }

  /// Returns a typed state object backed by the specified [stateMap].
  ///
  /// Required to properly instantiate the generic [TState] class.
  ///
  /// This should be used where possible over [typedStateFactory] to allow for
  /// more efficient dart2js output.
  @override
  @toBeGenerated
  TState typedStateFactoryJs(JsBackedMap stateMap) => throw new UngeneratedError(member: #typedStateFactory, message:
      '${#typedStateFactory}` should be implemented by code generation.\n\n'
      'This error may be due to your `UiState` class not being annotated with `@State()`,\n'
      'or because you are extending a stateful component without redeclaring your own `@State()`, like so:\n\n'
      '    @State()\n'
      '    class MyState extends SuperState {}\n'
  );
}

/// A [dart.collection.MapView]-like class with strongly-typed getters/setters for React props that
/// is also capable of creating React component instances.
///
/// For use as a typed view into existing props [Map]s, or as a builder to create new component
/// instances via a fluent-style interface.
///
/// Use with the over_react builder via the `@Props()` ([annotations.Props]) annotation.
abstract class UiProps extends component_base.UiProps with GeneratedClass {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiProps() {
    _throwIfNotGenerated();
  }

  @toBeGenerated String get propKeyNamespace => throw new UngeneratedError(member: #propKeyNamespace);

  @override @toBeGenerated Map get props => throw new UngeneratedError(member: #props);
}

/// A [dart.collection.MapView]-like class with strongly-typed getters/setters for React state.
///
/// Use with the over_react builder via the `@State()` ([annotations.State]) annotation.
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
/// Usually this is due to improper usage of the code-generating builder.
class UngeneratedError extends Error implements UnimplementedError {
  @override
  final String message;
  UngeneratedError({String message, Symbol member}) :
      this.message = message ?? "`$member` should be implemented by code generation";

  @override
  String toString() =>
      "UngeneratedError: $message.\n\n"
      "Ensure that you're running a build via build_runner.";
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
