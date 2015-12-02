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
  /// Used to allow certain behavior (e.g., instantiation) to generated implementation classes,
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

// TODO: mirror comment from sans_generation
abstract class UiComponent<TProps extends UiProps> extends component_base.UiComponent<TProps> with GeneratedClass {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiComponent() {
    _throwIfNotGenerated();
  }

  /// The keys for the non-forwarding props defined in this component.
  ///
  /// For generated components, this defaults to the keys generated in the associated @[Props] class
  /// unless [consumedPropKeys] returns non-null.
  @override @toBeGenerated Iterable<Iterable<String>> get consumedPropKeys;

  @override @toBeGenerated TProps typedPropsFactory(Map propsMap) => throw new UngeneratedError(member: #typedPropsFactory);
}

// TODO: mirror comment from sans_generation
abstract class UiStatefulComponent<TProps extends UiProps, TState extends UiState>
    extends component_base.UiStatefulComponent<TProps, TState> with GeneratedClass {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiStatefulComponent() {
    _throwIfNotGenerated();
  }

  /// The keys for the non-forwarding props defined in this component.
  ///
  /// For generated components, this defaults to the keys generated in the associated @[Props] class
  /// unless [consumedPropKeys] returns non-null.
  @override @toBeGenerated Iterable<Iterable<String>> get consumedPropKeys;

  @override @toBeGenerated TState typedStateFactory(Map stateMap) => throw new UngeneratedError(member: #typedStateFactory);
  @override @toBeGenerated TProps typedPropsFactory(Map propsMap) => throw new UngeneratedError(member: #typedStateFactory);
}

// TODO: mirror comment from sans_generation
abstract class UiProps extends component_base.UiProps with GeneratedClass, MapViewMixinStubs {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiProps() {
    _throwIfNotGenerated();
  }

  @toBeGenerated String get propKeyNamespace => throw new UngeneratedError(member: #propKeyNamespace);

  @override @toBeGenerated Map get props                 => throw new UngeneratedError(member: #props);
  @override @toBeGenerated Function get componentFactory => throw new UngeneratedError(member: #componentFactory);
}

// TODO: mirror comment from sans_generation
abstract class UiState extends component_base.UiState with GeneratedClass, MapViewMixinStubs {
  /// This class should not be instantiated directly, and throws an error to indicate this.
  UiState() {
    _throwIfNotGenerated();
  }

  @override @toBeGenerated Map get state => throw new UngeneratedError(member: #state);
}


class MapViewMixinStubs {
  @toBeGenerated operator [](Object key)          => throw new UngeneratedError(member: #[]);
  @toBeGenerated void operator []=(key, value)    => throw new UngeneratedError(member: #[]=);
  @toBeGenerated void addAll(Map other)           => throw new UngeneratedError(member: #addAll);
  @toBeGenerated void clear()                     => throw new UngeneratedError(member: #clear);
  @toBeGenerated bool containsKey(Object key)     => throw new UngeneratedError(member: #containsKey);
  @toBeGenerated bool containsValue(Object value) => throw new UngeneratedError(member: #containsValue);
  @toBeGenerated void forEach(void f(key, value)) => throw new UngeneratedError(member: #forEach);
  @toBeGenerated bool get isEmpty                 => throw new UngeneratedError(member: #isEmpty);
  @toBeGenerated bool get isNotEmpty              => throw new UngeneratedError(member: #isNotEmpty);
  @toBeGenerated Iterable get keys                => throw new UngeneratedError(member: #keys);
  @toBeGenerated int get length                   => throw new UngeneratedError(member: #length);
  @toBeGenerated putIfAbsent(key, ifAbsent())     => throw new UngeneratedError(member: #putIfAbsent);
  @toBeGenerated remove(Object key)               => throw new UngeneratedError(member: #remove);
  @toBeGenerated Iterable get values              => throw new UngeneratedError(member: #values);
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
      "base classes are available in the `` library. "; // FIXME add library path
}
