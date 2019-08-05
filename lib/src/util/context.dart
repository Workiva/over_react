import 'package:meta/meta.dart';
import 'package:over_react/src/component_declaration/component_base.dart' as component_base;
import 'package:over_react/src/component_declaration/builder_helpers.dart' as builder_helpers;
import 'package:over_react/over_react.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react.dart' as react;

class Context {
  Context(this.Provider, this.Consumer, this.reactDartContext);

  final react.ReactDartContext reactDartContext;

  /// Every [Context] object comes with a Provider component that allows consuming components to subscribe
  /// to context changes.
  ///
  /// Accepts a `value` prop to be passed to consuming components that are descendants of this [Provider].
  ///
  /// All consumers that are descendants of a Provider will re-render whenever the Provider’s value prop changes.
  /// The propagation from Provider to its descendant consumers is not subject to the shouldComponentUpdate method,
  /// so the consumer is updated even when an ancestor component bails out of the update.
  ///
  /// __Example__:
  ///
  ///     Context MyContext = createContext();
  ///     ...
  ///     class MyComponent extends UiComponent2<...> {
  ///       render() {
  ///         return (MyContext.Provider()..value = 'new context value')(
  ///           MyContext.Consumer()(
  ///             (value) {
  ///               return Dom.span()(
  ///                 '$value', // Outputs: 'new context value'
  ///               );
  ///             }
  ///           );
  ///         );
  ///       }
  ///     }
  ///
  /// Learn More: <https://reactjs.org/docs/context.html#contextprovider>
  @override
  final UiFactory<ProviderProps> Provider;

  /// A React component that subscribes to context changes.
  /// Requires a function as a child. The function receives the current context value and returns a React node.
  ///
  /// A UiComponent that subscribes to context changes.
  /// This lets you subscribe to a context.
  ///
  /// Requires a function as a child. The function receives the current context value and returns a ReactElement.
  /// The value argument passed to the function will be equal to the `value` prop of the closest [Provider] for this
  /// context above in the tree. If there is no Provider for this context above, the `value` argument will be equal
  /// to the defaultValue that was passed to createContext().
  ///
  /// __Example__:
  ///
  ///     Context MyContext = createContext();
  ///     ...
  ///     class MyComponent extends UiComponent2<...> {
  ///       render() {
  ///         return (MyContext.Provider()..value = 'new context value')(
  ///           MyContext.Consumer()(
  ///             (value) {
  ///               return Dom.span()(
  ///                 '$value', // Outputs: 'new context value'
  ///               );
  ///             }
  ///           );
  ///         );
  ///       }
  ///     }
  ///
  /// Learn more: <https://reactjs.org/docs/context.html#contextconsumer>
  @override
  final UiFactory<ConsumerProps> Consumer;

  ReactContext get jsThis => reactDartContext.jsThis;
}

class ProviderProps extends component_base.UiProps
    with
        builder_helpers.GeneratedClass
    implements
        builder_helpers.UiProps {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  // TODO 3.0.0-wip generate JsBackedMap-based implementation used when no backing map is provided, like we do for Component2
  ProviderProps(JsBackedMap backingMap)
      : this._props = new JsBackedMap() {
    this._props = backingMap ?? new JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;

  @override
  String get propKeyNamespace => '';

  dynamic get value => props['value'];
  set value(dynamic v) => props['value'] = v;
}

class ConsumerProps extends component_base.UiProps
    with
        builder_helpers.GeneratedClass
    implements
        builder_helpers.UiProps {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  // TODO 3.0.0-wip generate JsBackedMap-based implementation used when no backing map is provided, like we do for Component2
  ConsumerProps([Map props]) : this.props = props ?? new JsBackedMap();

  @override
  final Map props;

  /// __Use at your own risk.__
  ///
  /// This is an _experimental_ api that ReactJS is currently testing.
  /// It is not final and should be expected to change.
  @experimental
  dynamic get unstable_observedBits => props['unstable_observedBits'];

  /// __Use at your own risk.__
  ///
  /// This is an _experimental_ api that ReactJS is currently testing.
  /// It is not final and should be expected to change.
  @experimental
  set unstable_observedBits(dynamic value) => props['unstable_observedBits'] = value;

  @override
  String get propKeyNamespace => '';
}

/// Creates a [Context] object. When React renders a component that subscribes to this [Context]
/// object it will read the current context value from the closest matching Provider above it in the tree.
///
/// The `defaultValue` argument is only used when a component does not have a matching [Context.Provider]
/// above it in the tree. This can be helpful for testing components in isolation without wrapping them.
///
/// __Example__:
///
///     Context MyContext = createContext();
///     ...
///     class MyComponent extends UiComponent2<...> {
///       render() {
///         return (MyContext.Provider()..value = 'new context value')(
///           MyContext.Consumer()(
///             (value) {
///               return Dom.span()(
///                 '$value', // Outputs: 'new context value'
///               );
///             }
///           );
///         );
///       }
///     }
///
/// ___ OR ___
///
///     Context MyContext = createContext('test');
///     ...
///     class MyContextTypeComponent extends UiComponent2<...> {
///       @override
///       get contextType => MyContext.reactDartContext;
///
///       render() {
///         return Dom.span()(
///           '${this.context}', // Outputs: 'test'
///         );
///       }
///     }
///
/// Learn more: <https://reactjs.org/docs/context.html#reactcreatecontext>
Context createContext([dynamic defaultValue, int Function(dynamic, dynamic) calculateChangedBits]) {
  react.ReactDartContext reactDartContext = react.createContext(defaultValue, calculateChangedBits);
  UiFactory<ProviderProps> Provider = ([map]) => (new ProviderProps(map)..componentFactory = reactDartContext.Provider);
  UiFactory<ConsumerProps> Consumer = ([map]) => (new ConsumerProps(map)..componentFactory = reactDartContext.Consumer);
  return Context(Provider, Consumer, reactDartContext);
}

