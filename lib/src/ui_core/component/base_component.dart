/// Abstract classes for typed-prop UI components.
part of web_skin_dart.ui_core;

/// A component definition used as the base for all web_skin_dart components.
///
/// Mixes in React-specific props (key, ref, etc.) as well as CSS-class-related props used by components internally.
///
/// Serves as a builder for fluent-style component consumption with typed getters and setters for props.
/// Also functions as a MapView, for use internally and externally for typed prop consumption and manipulation.
abstract class BaseComponentDefinition extends ComponentDefinition with ReactProps, CssClassProps, UbiquitousDomProps {
  BaseComponentDefinition(ReactComponentFactory componentFactory, Map props) : super(componentFactory, props);
}

/// A component used as the base for all web_skin_dart components.
///
/// Contains built-in support for generic typed props and other utility methods.
abstract class BaseComponent<T extends ComponentDefinition> extends react.Component with TypedPropsGetter<T> {
  /// Utility function used for prop transfer
  Map copyProps({bool omitReservedReactProps: true, Iterable keysToOmit, Iterable<Iterable> keySetsToOmit}) {
    return getPropsToForward(this.props,
        omitReactProps: omitReservedReactProps,
        keysToOmit: keysToOmit,
        keySetsToOmit: keySetsToOmit
    );
  }

  /// Returns a new ClassNameBuilder with className and blacklist values added from [CssClassProps.className] and
  /// [CssClassProps.classNameBlackList], if they are specified.
  ///
  /// This method should be used as the basis for the classNames of components receiving forwarded props.
  ClassNameBuilder forwardingClassNameBuilder() {
    return new ClassNameBuilder.fromProps(props);
  }
}

/// A component used as the base for all stateful web_skin_dart components.
///
/// Contains built-in support for generic typed props/state and other utility methods.
abstract class BaseComponentWithState<T extends ComponentDefinition, S extends Map> extends BaseComponent<T> with TypedStateGetter<S> {}

typedef ComponentDefinition ComponentDefinitionFactory();

/// An abstract definition of a React component.
/// Serves as a builder for fluent-style component consumption with typed getters and setters for props.
/// Also functions as a MapView, for use internally and externally for typed prop consumption and manipulation.
abstract class ComponentDefinition extends MapView implements Function {
  /// The component factory used in [build].
  final ReactComponentFactory componentFactory;

  /// Returns a new instance that is backed by the specified props map and component factory.
  ComponentDefinition(ReactComponentFactory this.componentFactory, Map props) : super(props == null ? {} : props);

  /// The props maintained by this component definition and used passed into the component when built.
  /// In this case, it's the current MapView object.
  Map get props => this;

  /// Add an arbitrary prop key-value pair.
  void addProp(propKey, value) {
    props[propKey] = value;
  }

  /// Add a Map of arbitrary props.
  void addProps(Map propMap) {
    if (propMap == null) {
      return;
    }

    props.addAll(propMap);
  }

  /// Default method for component validation. (Called in checked mode only, during [build].)
  bool validate() {
    return true;
  }

  /// Create a new component with this builder's props and the specified children.
  JsObject build([dynamic children]) {
    assert(validate());
    return componentFactory(props, children);
  }

  /// Create a new component with this builder's props and the specified children. (alias for [build])
  JsObject call([dynamic children]) => build(children);
}

/// Helper function that wraps react.registerComponent. But also adds the ability specify if the
/// component is a wrapper component.
///
/// A wrapper component is a component that clones or passes through its children
/// but needs to be treated as if it were the wrapped component.
ReactComponentFactory registerComponent(react.Component dartComponentFactory(), {bool isWrapper: false}) {
  ReactDartComponentFactoryProxy reactComponentFactory = react.registerComponent(dartComponentFactory);
  if (isWrapper) {
    reactComponentFactory.type['isWrapper'] = true;
  }
  return reactComponentFactory;
}
