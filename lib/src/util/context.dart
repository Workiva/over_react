// Copyright 2020 Workiva Inc.
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

import 'package:meta/meta.dart';
import 'package:over_react/src/component_declaration/builder_helpers.dart';
import 'package:over_react/src/util/prop_key_util.dart';

import 'package:react/react_client/component_factory.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react.dart' as react;

part 'context.over_react.g.dart';

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
/// Learn more at: https://react.dev/learn/passing-data-deeply-with-context
class Context<TValue> {
  // ignore: avoid_types_as_parameter_names
  Context(this.Provider, this.Consumer, this.reactDartContext);

  factory Context.fromReactDartContext(react.Context<TValue> reactDartContext) {
    ProviderProps<TValue> Provider([Map? map]) => (_$$ProviderProps<TValue>(map)..componentFactory = reactDartContext.Provider);
    ConsumerProps<TValue> Consumer([Map? map]) => (_$$ConsumerProps<TValue>(map)..componentFactory = reactDartContext.Consumer);
    return Context<TValue>(Provider, Consumer, reactDartContext);
  }

  factory Context.fromJsContext(ReactContext jsContext) {
    return Context.fromReactDartContext(react.Context<TValue>(
      ReactJsContextComponentFactoryProxy(jsContext.Provider, isProvider: true),
      ReactJsContextComponentFactoryProxy(jsContext.Consumer, isConsumer: true),
      jsContext,
    ));
  }

  /// The react.dart version of this context.
  final react.Context<TValue> reactDartContext;

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
  /// Learn More: <https://react.dev/reference/react/createContext#provider>
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
  /// Learn more: <https://react.dev/reference/react/createContext#consumer>
  final UiFactory<ConsumerProps<TValue>> Consumer;
}

// Trigger generation of concrete props classes we can use below in _ProviderPropsImpl/ _ConsumerPropsImpl.
UiFactory<ProviderProps> _Provider = _$_Provider; // ignore: unused_element
UiFactory<ConsumerProps> _Consumer = _$_Consumer; // ignore: unused_element

/// A typed props class for the [Context.Provider] from a [Context] object created with [createContext].
///
/// See: <https://react.dev/reference/react/createContext#provider>
class ProviderProps<TValue> = UiProps with _ProviderPropsMixin<TValue>;

// Private to mirror `ConsumerPropsMixin` being private.
@Props(keyNamespace: '')
mixin _ProviderPropsMixin<TValue> on UiProps {
  /// The value that you want to pass to all the components reading this context inside this provider,
  /// no matter how deep.
  ///
  /// The context value can be of any type.
  ///
  /// A component calling `useContext(SomeContext)` inside of the provider receives the value of
  /// the innermost corresponding context provider above it.
  late TValue value;
}

/// A typed props class for the [Context.Consumer] from a [Context] object created with [createContext].
///
/// See: <https://react.dev/reference/react/createContext#consumer>
class ConsumerProps<TValue> = UiProps with _ConsumerPropsMixin<TValue>;

// Private so we don't have to export this props mixin with its weird [call] override, which could mess with consumer code.
// Consumers shouldn't ever need to mix in these props, anyways.
@Props(keyNamespace: '')
mixin _ConsumerPropsMixin<TValue> on UiProps {
  /// __Use at your own risk.__
  ///
  /// This is an _experimental_ api that ReactJS is currently testing.
  /// It is not final and should be expected to change.
  @experimental
  dynamic unstable_observedBits;

  // We can't override call in the concrete props class, because the generated class only
  // `implements` it and doesn't extend it, so we'll have to override it here, in the mixin.

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
  ReactElement call([covariant dynamic Function(TValue value)? c1, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c2 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c3 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c4 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c5 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c6 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c7 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c8 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c9 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c10 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c11 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c12 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c13 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c14 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c15 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c16 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c17 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c18 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c19 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c20 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c21 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c22 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c23 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c24 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c25 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c26 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c27 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c28 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c29 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c30 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c31 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c32 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c33 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c34 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c35 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c36 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c37 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c38 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c39 = _nope, covariant _DO_NOT_USE_OR_YOU_WILL_BE_FIRED c40 = _nope]) {
    return componentFactory!.build(props, c1 != null ? [c1] : []);
  }
}

const _nope = _DO_NOT_USE_OR_YOU_WILL_BE_FIRED();

// ignore: camel_case_types
class _DO_NOT_USE_OR_YOU_WILL_BE_FIRED {
  const _DO_NOT_USE_OR_YOU_WILL_BE_FIRED();
}

/// Creates a [Context] object.
///
/// When React renders a component that subscribes to this [Context]
/// object it will read the current context value from the closest matching Provider above it in the tree.
///
/// To create a context with a non-nullable generic type, use [createContextInit] instead
/// (caveat: requires a default value).
///
/// __Example__:
///
/// ```dart
/// final MyContext = createContext<String?>();
///
/// example() {
///   return Fragment()(
///     (MyContext.Provider()..value = 'new context value')(
///       // Consume using either a function component, class component, or Context.Consumer utility.
///       // Each of the following children renders a span with 'new context value'.
///       ExampleFunctionConsumer()(),
///       ExampleClassConsumer()(),
///       MyContext.Consumer()(
///         (value) => Dom.span()(value),
///       ),
///     ),
///
///     // When not nested in a matching Provider, the default value (null) is used.
///     // To provide a default value, use createContextInit instead of createContext.
///     ExampleFunctionConsumer()(), // Renders an empty span.
///   );
/// }
///
/// mixin ExampleFunctionConsumerProps on UiProps {}
/// UiFactory<ExampleFunctionConsumerProps> ExampleFunctionConsumer = uiFunction((props) {
///   final contextValue = useContext(MyContext);
///   return Dom.span()(contextValue);
/// }, _$ExampleFunctionConsumerConfig);
///
/// UiFactory<ExampleClassConsumerProps> ExampleClassConsumer = castUiFactory(_$ExampleClassConsumer);
/// mixin ExampleClassConsumerProps on UiProps {}
/// class ExampleClassConsumerComponent extends UiComponent2<ExampleClassConsumerProps> {
///   @override
///   get contextType => MyContext.reactDartContext;
///
///   render() {
///     return Dom.span()(this.context);
///   }
/// ```
///
/// Learn more: <https://react.dev/reference/react/createContext>
Context<TValue?> createContext<TValue>([
  // TODO(FED-2136) uncomment this deprecation
  // @Deprecated('Use `createContextInit` instead to create contexts with initial values.'
  //      ' Since the argument to createContextInit is required, it can be used to create a context that holds a non-nullable type,'
  //      ' whereas this function can only create contexts with nullable type arguments.')
  TValue? defaultValue,
  int Function(TValue?, TValue?)? calculateChangedBits,
]) => createContextInit(defaultValue, calculateChangedBits);

/// Creates a [Context] object.
///
/// When React renders a component that subscribes to this [Context]
/// object it will read the current context value from the closest matching Provider above it in the tree.
///
/// [defaultValue] must be provided in order to create a context with a non-nullable generic type,
/// and is only used when a component does not have a matching [Context.Provider] above it in the tree.
/// This can be helpful for testing components in isolation without wrapping them.
///
/// To create a context without a default value, use [createContext] (caveat: the generic type has to be nullable).
///
/// __Example__:
///
/// ```dart
/// final MyContext = createContext<String>('default value');
///
/// example() {
///   return Fragment()(
///     (MyContext.Provider()..value = 'new context value')(
///       // Consume using either a function component, class component, or Context.Consumer utility.
///       // Each of the following children renders a span with 'new context value'.
///       ExampleFunctionConsumer()(),
///       ExampleClassConsumer()(),
///       MyContext.Consumer()(
///         (value) => Dom.span()(value),
///       ),
///     ),
///
///     // When not nested in a matching Provider, the default value is used.
///     ExampleFunctionConsumer()(), // Renders a span with 'default value'.
///   );
/// }
///
/// mixin ExampleFunctionConsumerProps on UiProps {}
/// UiFactory<ExampleFunctionConsumerProps> ExampleFunctionConsumer = uiFunction((props) {
///   final contextValue = useContext(MyContext);
///   return Dom.span()(contextValue);
/// }, _$ExampleFunctionConsumerConfig);
///
/// UiFactory<ExampleClassConsumerProps> ExampleClassConsumer = castUiFactory(_$ExampleClassConsumer);
/// mixin ExampleClassConsumerProps on UiProps {}
/// class ExampleClassConsumerComponent extends UiComponent2<ExampleClassConsumerProps> {
///   @override
///   get contextType => MyContext.reactDartContext;
///
///   render() {
///     return Dom.span()(this.context);
///   }
/// }
/// ```
///
/// Learn more: <https://react.dev/reference/react/createContext>
Context<TValue> createContextInit<TValue>(TValue defaultValue, [int Function(TValue, TValue)? calculateChangedBits]) {
  final reactDartContext = react.createContext<TValue>(defaultValue, calculateChangedBits != null ? (dynamic arg1, dynamic arg2) => calculateChangedBits(arg1 as TValue, arg2 as TValue) : null);
  return Context<TValue>.fromReactDartContext(reactDartContext);
}
