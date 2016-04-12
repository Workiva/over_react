/// Abstract classes for typed-prop UI components.
part of web_skin_dart.ui_core;

/// A component definition used as the base for all web_skin_dart components.
///
/// Mixes in React-specific props (key, ref, etc.) as well as CSS-class-related props used by components internally.
///
/// Serves as a builder for fluent-style component consumption with typed getters and setters for props.
/// Also functions as a MapView, for use internally and externally for typed prop consumption and manipulation.
@deprecated
abstract class BaseComponentDefinition extends ComponentDefinition with ReactPropsMixin, CssClassPropsMixin, UbiquitousDomPropsMixin {
  BaseComponentDefinition(ReactComponentFactory componentFactory, Map props) : super(componentFactory, props);
}

typedef Element _getDOMNodeTypedef();
typedef dynamic _refTypedef(String ref);

/// A component used as the base for all web_skin_dart components.
///
/// Contains built-in support for generic typed props and other utility methods.
@deprecated
abstract class BaseComponent<T extends ComponentDefinition> extends react.Component with TypedPropsGetter<T> {
  /// Get the DOM node of the component.
  ///
  /// Overridden for strong typing.
  @override
  _getDOMNodeTypedef get getDOMNode => super.getDOMNode;

  /// Returns the component of the specified [ref].
  /// > `react.Component` if it is a Dart component
  /// > DOM node if it is a DOM component.
  ///
  /// Overridden for strong typing.
  @override
  _refTypedef get ref => super.ref;

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
@deprecated
abstract class BaseComponentWithState<T extends ComponentDefinition, S extends Map> extends BaseComponent<T> with TypedStateGetter<S> {}

@deprecated
typedef ComponentDefinition ComponentDefinitionFactory();

/// An abstract definition of a React component.
/// Serves as a builder for fluent-style component consumption with typed getters and setters for props.
/// Also functions as a MapView, for use internally and externally for typed prop consumption and manipulation.
@deprecated
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
  ReactElement build([dynamic children]) {
    assert(validate());
    return componentFactory(props, children);
  }

  /// Create a new component with this builder's props and the specified children. (alias for [build])
  /// Creates a new component with this builder's props and the specified [children].
  /// (alias for [build] with support for variadic children)
  ///
  /// This method actually takes any number of children as arguments ([c2], [c3], ...) via [noSuchMethod].
  ReactElement call([children, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]);

  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #call && invocation.isMethod) {
      var parameters = []
        ..add(props)
        ..addAll(invocation.positionalArguments);

      return Function.apply(componentFactory, parameters);
    }

    return super.noSuchMethod(invocation);
  }
}
