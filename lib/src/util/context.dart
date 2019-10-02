import 'package:meta/meta.dart';
import 'package:over_react/src/component_declaration/component_base.dart'
    as component_base;
import 'package:over_react/src/component_declaration/builder_helpers.dart'
    as builder_helpers;
import 'package:over_react/over_react.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react.dart' as react;

/// The return type of [createContext], Wraps [ReactContext] for use in Dart.
/// Allows access to [Provider] and [Consumer] Components.
///
/// __Should not be instantiated without using [createContext]__
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
/// Learn more at: https://reactjs.org/docs/context.html
class Context<TValue> {
  Context(this.Provider, this.Consumer, this.reactDartContext);

  /// The react.dart version of this context.
  final react.Context reactDartContext;

  /// The react.js version of this context.
  ReactContext get jsThis => reactDartContext.jsThis;

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
  final UiFactory<ProviderProps<TValue>> Provider;

  /// A React component that subscribes to context changes.
  ///
  /// Requires `ReactElement Function(TValue value)` as the only child. The value argument passed to the function will
  /// be equal to the `value` prop of the closest [Provider] for this context above in the tree. If there is no
  /// Provider for this context above, the `value` argument will be equal to the defaultValue that was passed
  /// to [createContext].
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
  final UiFactory<ConsumerProps<TValue>> Consumer;
}

/// [ProviderProps] is a typed props class for the [Provider] from a [Context] object created with [createContext].
///
/// Props:
/// [value] The value that you want to provide to all consumers.
///
/// See: <https://reactjs.org/docs/context.html#contextprovider>
class ProviderProps<TValue> extends component_base.UiProps
    with builder_helpers.GeneratedClass
    implements builder_helpers.UiProps {
  ProviderProps(JsBackedMap backingMap) : this._props = new JsBackedMap() {
    this._props = backingMap ?? new JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;

  @override
  String get propKeyNamespace => '';

  TValue get value => props['value'];
  set value(TValue v) => props['value'] = v;
}

/// [ConsumerProps] is a typed props class for the [Consumer] from a [Context] object created with [createContext].
///
/// See: <https://reactjs.org/docs/context.html#contextconsumer>
class ConsumerProps<TValue> extends component_base.UiProps
    with builder_helpers.GeneratedClass
    implements builder_helpers.UiProps {
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
  set unstable_observedBits(dynamic value) =>
      props['unstable_observedBits'] = value;

  @override
  String get propKeyNamespace => '';

  /// Creates a new component with this builder's props and the specified [children].
  ///
  /// _(alias for [build] with support for variadic children)_
  ///
  /// This method actually takes any number of children as arguments ([c2], [c3], ...) via [noSuchMethod].
  ///
  /// Restricted statically to 40 arguments until the dart2js fix in
  /// <https://github.com/dart-lang/sdk/pull/26032> is released.
  @override
  // ignore: invalid_override_different_default_values_positional
  ReactElement call(
      [covariant dynamic Function(TValue value) c1,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c2 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c3 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c4 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c5 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c6 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c7 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c8 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c9 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c10 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c11 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c12 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c13 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c14 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c15 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c16 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c17 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c18 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c19 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c20 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c21 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c22 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c23 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c24 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c25 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c26 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c27 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c28 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c29 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c30 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c31 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c32 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c33 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c34 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c35 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c36 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c37 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c38 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c39 = _nope,
      covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c40 = _nope]) {
    return componentFactory.build(props, c1 != null ? [c1] : []);
  }
}

const _nope = const _DO_NOT_USE_OR_YOU_WILL_BE_FIRED();

// ignore: camel_case_types
class _DO_NOT_USE_OR_YOU_WILL_BE_FIRED {
  const _DO_NOT_USE_OR_YOU_WILL_BE_FIRED();
}

/// Creates a [Context] object.
///
/// When React renders a component that subscribes to this [Context]
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
Context<TValue> createContext<TValue>(
    [TValue defaultValue, int Function(TValue, TValue) calculateChangedBits]) {
  react.Context reactDartContext = react.createContext(
      defaultValue,
      calculateChangedBits != null
          ? (dynamic arg1, dynamic arg2) => calculateChangedBits(arg1, arg2)
          : null);
  UiFactory<ProviderProps> Provider = ([map]) => (new ProviderProps<TValue>(map)
    ..componentFactory = reactDartContext.Provider);
  UiFactory<ConsumerProps> Consumer = ([map]) => (new ConsumerProps<TValue>(map)
    ..componentFactory = reactDartContext.Consumer);
  return Context<TValue>(Provider, Consumer, reactDartContext);
}
