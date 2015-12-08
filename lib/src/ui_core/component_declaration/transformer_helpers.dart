library web_skin_dart.component_declaration.transformer_helpers;

import './component_base.dart' as component_base;

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
  const $PropKeys(Symbol propsClass);

  dynamic noSuchMethod(Invocation invocation) {
    throw new UngeneratedError(
        message: r'The $PropKeys class should not be used at runtime, '
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


/// The basis for a web_skin_dart component, extending [react.Component]. (Successor to [BaseComponent]).
///
/// Includes support for strongly-typed props and utilities for prop and CSS classname forwarding.
///
/// Use with the web_skin_dart transformer via the `@Component()` ([Component]) annotation.
abstract class UiComponent<TProps extends UiProps> extends component_base.UiComponent<TProps> with GeneratedClass {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiComponent() {
    _throwIfNotGenerated();
  }

  /// The default consumed prop keys, taken from the keys generated in the associated @[Props] class.
  @toBeGenerated
  Iterable<Iterable<String>> get $defaultConsumedPropKeys => throw new UngeneratedError(member: #$defaultConsumedPropKeys);

  /// The keys for the non-forwarding props defined in this component.
  ///
  /// For generated components, this defaults to the keys generated in the associated @[Props] class
  /// if this getter is not overridden.
  @override
  Iterable<Iterable<String>> get consumedPropKeys => $defaultConsumedPropKeys;

  /// Returns a typed props object backed by the specified [propsMap].
  /// Required to properly instantiate the generic [TProps] class.
  @override
  @toBeGenerated
  TProps typedPropsFactory(Map propsMap) => throw new UngeneratedError(member: #typedPropsFactory);
}


/// The basis for a stateful web_skin_dart component, extending [react.Component]. (Successor to [BaseComponentWithState]).
///
/// Includes support for strongly-typed props and state and utilities for prop and CSS classname forwarding.
///
/// Use with the web_skin_dart transformer via the `@Component()` ([Component]) annotation.
abstract class UiStatefulComponent<TProps extends UiProps, TState extends UiState>
    extends component_base.UiStatefulComponent<TProps, TState> with GeneratedClass {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiStatefulComponent() {
    _throwIfNotGenerated();
  }

  /// The default consumed prop keys, taken from the keys generated in the associated @[Props] class.
  @toBeGenerated
  Iterable<Iterable<String>> get $defaultConsumedPropKeys => throw new UngeneratedError(member: #$defaultConsumedPropKeys);

  /// The keys for the non-forwarding props defined in this component.
  ///
  /// For generated components, this defaults to the keys generated in the associated @[Props] class
  /// if this getter is not overridden.
  @override
  Iterable<Iterable<String>> get consumedPropKeys => $defaultConsumedPropKeys;

  /// Returns a typed props object backed by the specified [propsMap].
  /// Required to properly instantiate the generic [TProps] class.
  @override
  @toBeGenerated
  TProps typedPropsFactory(Map propsMap) => throw new UngeneratedError(member: #typedPropsFactory);

  /// Returns a typed state object backed by the specified [stateMap].
  /// Required to properly instantiate the generic [TState] class.
  @override @toBeGenerated TState typedStateFactory(Map stateMap) => throw new UngeneratedError(member: #typedStateFactory);
}

/// A [dart.collection.MapView]-like class with strongly-typed getters/setters for React props that
/// is also capable of creating React component instances.
///
/// For use as a typed view into existing props [Maps], or as a builder to create new component
/// instances via a fluent-style interface.
///
/// (Successor to [ComponentDefinition]).
///
/// Use with the web_skin_dart transformer via the `@Props()` ([Props]) annotation.
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
/// Use with the web_skin_dart transformer via the `@State()` ([State]) annotation.
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
  final String message;
  UngeneratedError({String message, Symbol member}) :
      this.message = message ?? "`$member` should be implemented by code generation";

  String toString() =>
      "UngeneratedError: $message.\n\n"
      "Ensure that the `web_skin_dart` transformer is included in your pubspec.yaml, "
      "and that this code is being run using Pub.";
}

/// Thrown when a class is directly instantiated when it should not be.
class IllegalInstantiationError extends Error {
  final String message;
  IllegalInstantiationError({String message, Type runtimeType}) :
      this.message = message ?? "`$runtimeType` cannot be instantated directly, but only indirectly via the UiFactory";

  String toString() =>
      "IllegalInstantiationError: $message.\n\n"
      "Be sure to follow usage instructions for web_skin_dart component classes.\n\n"
      "If you need to do something extra custom and want to implement everything without code generation, "
      "base classes are available by importing the "
      "`package:web_skin_dart/src/ui_core/component_declaration/component_base.dart` "
      "library directly. ";
}
