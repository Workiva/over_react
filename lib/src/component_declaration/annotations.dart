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
  @override
  final String keyNamespace;
  const Props({this.keyNamespace: null});
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
  @override
  final String keyNamespace;
  const State({this.keyNamespace: null});
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
  /// Whether the component clones or passes through its children and needs to be
  /// treated as if it were the wrapped component when passed in to [web_skin_dart.ui_core.isComponentOfType].
  final bool isWrapper;

  /// The component class of this component's "parent type".
  ///
  /// Used to enable inheritance in component type-checking in [isComponentOfType].
  ///
  /// E.g., if component `Bar` is a subtype of component `Foo`:
  ///
  ///     @Factory()
  ///     UiFactory<...> Foo;
  ///     ...
  ///     @Component()
  ///     class FooComponent ... {...}
  ///
  ///     @Factory()
  ///     UiFactory<...> Bar;
  ///     ...
  ///     @Component(subtypeOf: FooComponent)
  ///     class BarComponent ... {...}
  ///
  /// then:
  ///
  ///     isComponentOfType(Bar()(), Bar); // true (due to normal type-checking)
  ///     isComponentOfType(Bar()(), Foo); // true (due to parent type-checking)
  final Type subtypeOf;

  const Component({
      this.isWrapper: false,
      this.subtypeOf
  });
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
  @override
  final String keyNamespace;
  const AbstractProps({this.keyNamespace: null});
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
  @override
  final String keyNamespace;
  const AbstractState({this.keyNamespace: null});
}

/// Annotation used with the `web_skin_dart` transformer to declare an abstract [UiComponent] class for an abstract component.
///
///     @AbstractComponent()
///     abstract class QuxComponent<TProps extends QuxProps> extends UiComponent<TProps> {}
class AbstractComponent {
  const AbstractComponent();
}

/// Annotation used with with the `web_skin_dart` transformer to declare a mixin for use in a [UiProps] class.
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
  @override
  final String keyNamespace;
  const PropsMixin({this.keyNamespace: null});
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
  @override
  final String keyNamespace;
  const StateMixin({this.keyNamespace: null});
}

/// Annotation used with the `web_skin_dart` transformer to customize individual accessors (props/state fields).
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
    this.key: null,
    this.keyNamespace: null
  });
}

/// Annotation used with the `web_skin_dart` transformer to express a specific prop is required to be set.
///
/// This is validated in `UiComponent.validateRequiredProps` which requires super calls into `componentWillMount` and
/// `componentWillReceiveProps`.
///
///     @Props()
///     abstract class FooProps {
///       @Required()
///       String bar;
///     }
class Required {
  /// Whether setting a prop to null is allowed.
  final bool isNullable;

  /// The message displayed when the prop is not set.
  final String message;

  const Required({this.isNullable: false, this.message});
}

abstract class TypedMap {
  String get keyNamespace;
}
