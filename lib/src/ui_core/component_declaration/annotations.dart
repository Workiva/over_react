// Dummy annotations that would be used by Pub code generator
library web_skin_dart.component_declaration.annotations;

/// Annotation used with the `web_skin_dart` transformer to declare a [UiFactory] for a component.
///
///     @Factory()
///     UiFactory<FooProps> Foo;
///
/// Must be accompanied by a [Props] and [Component] declaration.
class Factory {
  const Factory();
}

/// Annotation used with the `web_skin_dart` transformer to declare a [UiProps] class for a component.
///
/// Props are declared as fields, which act as stubs for generated getters/setters that proxy Map key-value pairs.
///
///     @Props()
///     class FooProps extends UiProps {
///       String bar;
///     }
///
/// Must be accompanied by a [Factory] and [Component] declaration.
class Props implements TypedMap {
  /// A custom namespace for the keys of props defined in the annotated class,
  /// overriding the default of `'${propsClassName}.'`.
  final String keyNamespace;
  const Props({String this.keyNamespace: null});
}

/// Annotation used with the `web_skin_dart` transformer to declare a [UiState] class for a component.
///
/// State properties are declared as fields, which act as stubs for generated getters/setters that proxy Map key-value pairs.
///
///     @State()
///     class FooState extends UiState {
///       bool baz;
///     }
///
/// Optional. Must be accompanied by a [Factory], [Props], and [Component] declaration.
class State implements TypedMap {
  /// A custom namespace for the keys of state properties defined in the annotated class,
  /// overriding the default of `'${stateClassName}.'`.
  final String keyNamespace;
  const State({String this.keyNamespace: null});
}

/// Annotation used with the `web_skin_dart` transformer to declare a [UiComponent] class for a component.
///
///     @Component()
///     class FooComponent extends UiComponent<FooProps> {
///       render() => Dom.div()(props.bar);
///     }
///
/// Must be accompanied by a [Factory] and [Props] declaration.
class Component {
  final bool isWrapper;
  const Component({bool this.isWrapper: false});
}

/// Annotation used with the `web_skin_dart` transformer to declare an abstract [UiProps] class for an abstract component.
///
/// Props are declared as fields, which act as stubs for generated getters/setters that proxy Map key-value pairs.
///
///     @AbstractProps()
///     abstract class QuxProps extends UiProps {
///       int quux;
///     }
class AbstractProps implements TypedMap {
  /// A custom namespace for the keys of props defined in the annotated class,
  /// overriding the default of `'${propsClassName}.'`.
  final String keyNamespace;
  const AbstractProps({String this.keyNamespace: null});
}

/// Annotation used with the `web_skin_dart` transformer to declare an abstract [UiProps] class for an abstract component.
///
/// State properties are declared as fields, which act as stubs for generated getters/setters that proxy Map key-value pairs.
///
///     @AbstractState()
///     abstract class QuxState extends UiState {
///       String corge;
///     }
class AbstractState implements TypedMap {
  /// A custom namespace for the keys of state properties defined in the annotated class,
  /// overriding the default of `'${stateClassName}.'`.
  final String keyNamespace;
  const AbstractState({String this.keyNamespace: null});
}

/// Annotation used with the `web_skin_dart` transformer to declare an abstract [UiComponent] class for an abstract component.
///
///     @AbstractComponent()
///     abstract class QuxComponent<TProps extends QuxProps> extends UiComponent<TProps> {
///
///     }
class AbstractComponent {
  const AbstractComponent();
}

/// Annotation used with the `web_skin_dart` transformer to declare a mixin for use in a [UiProps] class.
///
/// Props are declared as fields, which act as stubs for generated getters/setters that proxy Map key-value pairs.
///
///     @PropsMixin()
///     abstract class GraultPropsMixin {
///       Map get props;
///
///       Object garply;
///     }
///
/// Classes using this annotation must include the abstract `props` getter.
class PropsMixin implements TypedMap {
  /// A custom namespace for the keys of props defined in the annotated class,
  /// overriding the default of `'${propsClassName}.'`.
  final String keyNamespace;
  const PropsMixin({String this.keyNamespace: null});
}

/// Annotation used with the `web_skin_dart` transformer to declare a mixin for use in a [UiState] class.
///
/// State properties are declared as fields, which act as stubs for generated getters/setters that proxy Map key-value pairs.
///
///     @StateMixin()
///     abstract class WaldoStateMixin {
///       Map get state;
///
///       dynamic fred;
///     }
///
/// Classes using this annotation must include the abstract `state` getter.
class StateMixin implements TypedMap {
  /// A custom namespace for the keys of state properties defined in the annotated class,
  /// overriding the default of `'${stateClassName}.'`.
  final String keyNamespace;
  const StateMixin({String this.keyNamespace: null});
}

/// Annotation with the `web_skin_dart` transformer to customize individual accessors (props/state properties).
///
///     @Props()
///     abstract class FooProps {
///       @Accessor(keyNamespace: '', key: 'custom_key')
///       String bar;
///     }
class Accessor {
  /// A key for the annotated accessor, overriding the default of the accessor's name.
  final String key;

  /// A custom namespace for the key namespace of the annotated accessor,
  /// overriding the default of `'${enclosingClassName}.'`.
  final String keyNamespace;

  const Accessor({
    String this.key: null,
    String this.keyNamespace: null
  });
}

abstract class TypedMap {
  String get keyNamespace;
}
