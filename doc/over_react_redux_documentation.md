# OverReact Redux

A Dart wrapper for React Redux, providing targeted state updates.

---

- **[Purpose](#purpose)**
  - [Benefits](#benefits)
- **[Examples](#examples)**
  - [Running the Examples](#running-the-examples)
- **[Using it in your project](#using-it-in-your-project)**
- **[ReduxProvider](#reduxprovider)**
- **[Hooks](#hooks)**
  - [useSelector](#useselector)
  - [useDispatch](#usedispatch)
  - [useStore](#usestore)
- **[Connect](#connect)**
  - [`connect` Parameters](#connect-parameters)
    - [mapStateToProps](#mapstatetoprops)
    - [mapDispatchToProps](#mapdispatchtoprops)
    - [mergeProps](#mergeprops)
    - [areStatesEqual](#arestatesequal)
    - [areOwnPropsEqual](#areownpropsequal)
    - [areStatePropsEqual](#arestatepropsequal)
    - [areMergedPropsEqual](#aremergedpropsequal)
    - [context](#context)
    - [pure](#pure)
    - [forwardRef](#forwardref)
- **[Using Multiple Stores](#using-multiple-stores)**
- **[Using Redux DevTools](#using-redux-devtools)**
  - [Integrating with DevTools](#integration-with-devtools)

## Purpose

OverReact Redux is a Dart wrapper around [React Redux](https://react-redux.js.org), a UI binding library that allows for
better Redux integration with React. This integration allows for APIs that align more closely with React design patterns
while also providing more direct access to store data.

### Benefits

> For a full list of benefits, see <https://react-redux.js.org/introduction/why-use-react-redux>.

While there are many benefits of using the library, a primary one is OverReact Redux allows for targeted updates
that only update components which receive data that has changed, rather than the whole component tree (as is the
behavior with React). By utilizing the `connect()` function in conjunction with `mapStateToProps()`, a component will
only update when a piece of information it uses is updated.

## Examples

### Individual component examples

There are some individual component examples within the `web/over_react_redux` directory.
Each example illustrates a different variation or use case of OverReact Redux. Additionally, the store files contain
comments that call out specifics pertaining to that example and provides further explanation.

#### Running the component examples

To run and experiment with the demo:

1. `pub get`
1. `webdev serve`
1. Navigate to `localhost:8080/over_react_redux/`
1. If you have the [React DevTools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en),
   you can view the isolated state updates based on the `mapStateToProps` when you turn on
   ["Highlight updates when components render."](https://github.com/facebook/react/pull/16989)

### Application example

There is a "Todo" example app built with OverReact Redux within the `app/over_react_redux` directory.
This app illustrates a full-scale implementation of an application that handles all of the data flow using redux.

#### Running the application

To run and experiment with the "Todo" app:

1. `cd app/over_react_redux/todo_client`
1. `pub get`
1. `webdev serve`
1. Navigate to `localhost:8080`
1. If you have the [React DevTools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en),
   you can view the isolated state updates based on the `mapStateToProps` when you turn on
   ["Highlight updates when components render."](https://github.com/facebook/react/pull/16989)

## Using it in your project

1. Add the `redux` package as a dependency in your `pubspec.yaml`.

    ```yaml
    dependencies:
      redux: '>=3.0.0'
    ```

1. Create your store and reducer. See the [example store](../web/over_react_redux/examples/simple/store.dart) for
   ways to do this.
1. Import OverReact Redux and your store into your `index.dart`.
    ```dart
    import 'package:over_react/over_react_redux.dart';
    ```
1. Wrap your component tree in a `ReduxProvider` and pass in the store.

    ```dart
    import 'package:over_react/over_react_redux.dart';
    import 'package:over_react/react_dom.dart' as react_dom;

    main() {
      react_dom.render(
        (ReduxProvider()..store = fooStore)(
          // ... React component tree with connected components
        ),
        mountNode,
      );
    }
    ```

1. Import OverReact Redux and your store into the file with your component.
1. Update your component class.

   1. Add a new `UiFactory`, without the usual annotation, and wrap it with `connect()`.
   1. Add the `ConnectPropsMixin` to your props class if needed. This mixin is needed if either of the following are true:
      - You _do not_ use the `mapDispatchToProps` parameter on `connect`.
      - You _do_ use `mapDispatchToProps` but want access to the `props.dipsatch` function. When using
        `mapDispatchToProps`, by default the `dispatch` property on `props` is removed. It can be added back
        using `ConnectPropsToMixin`.

    ```dart
    // AppState is a class that represents the application's state and can be defined in the same file as the store.
    UiFactory<FooProps> Foo = connect<AppState, FooProps>(
        ...
    )(_$Foo);

    // Use the ConnectPropsMixin to gain access to React Redux's dispatch function, which can be accessed via
    // props.dispatch.
    mixin FooPropsMixin on UiProps {
        ...
    }

    class FooProps = UiProps with ConnectPropsMixin, FooPropsMixin;

    class FooComponent extends UiComponent2<FooProps> {
        ...
    }
    ```

## ReduxProvider

Redux uses React 16's `Context` API to pass information through the component tree. Consequently, the tree must be
wrapped in a `Provider` to handle the context.

For this purpose, OverReact Redux has the `ReduxProvider` component. It is required to take in a store instance, and can
optionally take in a context object when using multiple stores.

**Example:**

```dart
react_dom.render(
  (ReduxProvider()..store = fooStore)(
    // ... React component tree with connected components
  ),
  mountNode,
);
```

## `connect`

### Overview

A wrapper around the JS react-redux `connect` function that supports OverReact components.

> See: <https://react-redux.js.org/api/connect>

> ![TIP]
> connect still works and is supported. However, we recommend using the hooks API as the default.

**Example:**

```dart
UiFactory<CounterProps> Counter = connect<CounterState, CounterProps>(
  mapStateToProps: (state) => (Counter()
    ..count = state.count
  ),
  mapDispatchToProps: (dispatch) => (Counter()
    ..increment = (() => dispatch(IncrementAction()))
  ),
)(_$Counter);
```

Note that any required props assigned in connect must have their validation disabled; see docs [here](./null_safety_and_required_props.md#disabling-validation-use-case-connect)
for more info. 

For example:
```dart
mixin CounterPropsMixin on UiProps {
  // Set in connect.
  late int count;
  late void Function() increment;
  
  // Must be set by consumers of the connected compoennt.
  late String requiredByConsumer;
}

@Props(disableRequiredPropValidation: {'count', 'increment'})
class CounterProps = UiProps with CounterPropsMixin, OtherPropsMixin;
```

### `connect` Parameters

- #### `mapStateToProps`

  - Used for selecting the part of the data from the store that the connected
    component needs.

    - Called every time the store state changes.
    - Receives the entire store state, and should return an object of data this component needs.

  - If you need access to the props provided to the connected component you can use `mapStateToPropsWithOwnProps`,
    the second argument will be `ownProps`.

    > See: <https://react-redux.js.org/using-react-redux/connect-mapstate#defining-mapstatetoprops>

  - If you need component-instance-specific initialization, such as to set up instance based selectors with
    memoization, you can use `makeMapStateToProps` or `makeMapStateToPropsWithOwnProps` to define factory functions,
    they will be called once when the component instantiates, and their returns will be used as the actual `mapStateToProps`.

    > See: <https://redux.js.org/recipes/computing-derived-data#sharing-selectors-across-multiple-components>

    > See: <https://react-redux.js.org/api/connect#factory-functions>

- #### `mapDispatchToProps`

  - Called with dispatch as the first argument.

    - You can make use of this by returning new functions that call dispatch() inside themselves,
      and either pass in a plain action directly or pass in the result of an action creator.

  - If you need access to the props provided to the connected component you can use `mapDispatchToPropsWithOwnProps`,
    the second argument will be `ownProps`.

    > See: <https://react-redux.js.org/using-react-redux/connect-mapdispatch#defining-mapdispatchtoprops-as-a-function>

  - If you need component-instance-specific initialization, such as to set up instance based selectors with
    memoization, you can use `makeMapDispatchToProps` or `makeMapDispatchToPropsWithOwnProps` to define factory functions,
    they will be called once when the component instantiates, and their returns will be used as the actual `mapDispatchToProps`.

    > See: <https://redux.js.org/recipes/computing-derived-data#sharing-selectors-across-multiple-components>

    > See: <https://react-redux.js.org/api/connect#factory-functions>

- #### `mergeProps`

  - Defines how the final props for the wrapped component are determined.
  - If you do not provide `mergeProps`, the wrapped component receives the default:
    ```dart
    {...ownProps, ...stateProps, ...dispatchProps}
    ```

- #### `areStatesEqual`

  - Does a simple `==` check by default.
  - Takes a function with the signature `(next: TReduxState, prev: TReduxState) => bool`.
  - When [pure](#pure), compares the incoming store state to its previous value in order to assess if this connected
    component should update. In the case that `mapStateToProps` is only concerned with a small piece of state but is
    also expensive to run, passing in a custom function for `areStatesEqual` may be beneficial to performance.

- #### `areOwnPropsEqual`

  - Does a shallow Map equality check by default.
  - Takes a function with the signature `(next: TProps, prev: TProps) => bool`.
  - When [pure](#pure), compares incoming props to its previous value. This comparison can be used to conduct
    operations such as being part of a process to whitelist certain props.

- #### `areStatePropsEqual`

  - Does a shallow Map equality check by default.
  - Takes a function with the signature `(next: TProps, prev: TProps) => bool`.
  - When [pure](#pure), compares the results of `mapStateToProps` with its previous value. Similar to other
    equality check callbacks, this provides the opportunity to optimize performance.

- #### `areMergedPropsEqual`

  - Does a shallow Map equality check by default.
  - Takes a function with the signature `(next: TProps, prev: TProps) => bool`.
  - Can be passed in for small performance improvements. Two possible cases are to implement `deepEqual` or
    `strictEqual`. > See: <https://react-redux.js.org/api/connect#aremergedpropsequal-next-object-prev-object-boolean>

- #### `context`

  - Can be utilized to provide a custom context object created with `createContext`.
  - `context` can be used to utilize multiple stores.
    > For more information on having multiple stores, see [Using Multiple Stores](#using-multiple-stores).

- #### `pure`

  - If `true` (default), connect performs several equality checks that are used to avoid unnecessary
    calls to `mapStateToProps`, `mapDispatchToProps`, `mergeProps`, and ultimately to `render`. These include
    `areStatesEqual`, `areOwnPropsEqual`, `areStatePropsEqual`, and `areMergedPropsEqual`.
  - While the defaults are probably appropriate 99% of the time, you may wish to override them with custom
    implementations for performance or other reasons.

- #### `forwardRef`
  - If `true`, the `ref` prop provided to the connected component will forward onto and return the wrapped component.

> [More information about the `connect` function](https://react-redux.js.org/api/connect#connect)

## Hooks

OverReact exposes wrappers around React Redux hook APIs, which serve as an alternative to the existing [`connect()`](#connect) Higher Order Component. 
These APIs allow you to subscribe to the Redux store and dispatch actions, without having to wrap your components 
in [`connect()`](#connect).

> [!TIP]
> **We recommend using the React-Redux hooks API as the default approach in your React components.**
>
> The existing connect API still works and will continue to be supported, but the hooks API is simpler, 
> requires less OverReact boilerplate, and doesn't involve suppressing validation for required props 
> (see [connect](#connect) docs for more info).

> See: <https://react-redux.js.org/api/hooks>

As with [`connect()`](#connect), you should start by wrapping your entire application in a 
[`ReduxProvider`](#reduxprovider) component to make the store available throughout the component tree:

```dart
import 'package:over_react/over_react_redux.dart';
import 'package:over_react/react_dom.dart' as react_dom;

main() {
  react_dom.render(
      (ReduxProvider()..store = yourReduxStoreInstance)(
        // Function components that use the hooks in this section go here.
      ), 
      querySelector('#id_of_mount_node'));
}
```

From there, you may import any of the hook APIs listed below and use them within your function components.

### useSelector()
```dart
TValue useSelector<TReduxState, TValue>(
  TValue Function(TReduxState state) selector, [
  bool Function(TValue tNextValue, TValue tPrevValue) equalityFn,
]);
```

Allows you to extract data from the Redux `Store` state, using a `selector` function.

The use of this hook will also subscribe your component to the Redux `Store`, and run your `selector` whenever
an action is dispatched.

* The `selector` should be pure since it is potentially executed multiple times and at arbitrary points in time.
* The `selector` is approximately equivalent to the `mapStateToProps` argument of [`connect`](#connect) conceptually.
* The `selector` will be called with the entire Redux `Store` state as its only argument.
* The `selector` will be run whenever the function component renders.

By default, the return value of `selector` is compared using strict JavaScript (`===`) equality. If you want to
customize how equality is defined, pass a comparator function to the `equalityFn` argument.

If you need to use a selector with custom `Context`, use [`createSelectorHook`](#custom-context-for-hooks) instead.

> See the [react-redux JS documentation](https://react-redux.js.org/api/hooks#useselector) for more details.

#### Example

> This example assumes that your `Counter` component is rendered as the descendant of a [`ReduxProvider`](#reduxprovider) component
  that is wired up to a Redux `Store` instance with a `CounterState` instance containing a field called `count`.

```dart
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'counter_state.dart';

mixin CounterProps on UiProps {}

UiFactory<CounterProps> Counter = uiFunction(
  (props) {
    final count = useSelector<CounterState, int>((state) => state.count);

    return Dom.div()('The current count is $count');
  },
  $CounterConfig, // ignore: undefined_identifier
);
```

#### Multiple Selectors

If you need to use multiple selectors in a single component, use [createSelectorHook](#custom-context-for-hooks) to
shadow `useSelector` as shown below to remove a bunch of unnecessary boilerplate as shown in the example below.

Consider the previous example, but instead of only needing to access `count` from the store, you need to access `count`, 
and two other field values as well. Using `useSelector` for all of these can get a little messy:

```dart
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'counter_state.dart';

mixin CounterProps on UiProps {}

UiFactory<CounterProps> Counter = uiFunction(
  (props) {
    final count = useSelector<CounterState, int>((state) => state.count);
    final foo = useSelector<CounterState, String>((state) => state.foo);
    final bar = useSelector<CounterState, Map>((state) => state.bar);

    return Dom.div()('The current $foo count is $count. $bar my dude.');
  },
  $CounterConfig, // ignore: undefined_identifier
);
```

Instead of needing to declare those generic parameters each time on `useSelector`, shadow it like so:

```dart
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'counter_state.dart';

/// All the types for state fields within `CounterState` will be inferred!
final useSelector = createSelectorHook<CounterState>();

mixin CounterProps on UiProps {}

UiFactory<CounterProps> Counter = uiFunction(
  (props) {
    final count = useSelector((state) => state.count);
    final foo = useSelector((state) => state.foo);
    final bar = useSelector((state) => state.bar);

    return Dom.div()('The current $foo count is $count. $bar my dude.');
  },
  $CounterConfig, // ignore: undefined_identifier
);
```

> __CAUTION:__ Be sure to not export the shadowed value of `useSelector` unless you know exactly what you're doing,
  and the consumers of your library expect the hook to always have the context of the state you parameterize it with. 

### useDispatch()

```dart
dynamic Function(dynamic action) useDispatch();
```

Returns a reference to the Redux `Store.dispatch()` function.

You may use it to dispatch actions as needed.

If you need to dispatch actions within a custom `Context`, use [`createDispatchHook`](#custom-context-for-hooks) instead.

> See the [react-redux JS documentation](https://react-redux.js.org/api/hooks#usedispatch) for more details.

#### Example

> This example assumes that your `Counter` component is rendered as the descendant of a [`ReduxProvider`](#reduxprovider) component
  that is wired up to a Redux `Store` instance with a `CounterState` instance containing a field called `count`.
>
> It also assumes that you have two actions wired up to your reducer - `IncrementAction` and `DecrementAction`.

```dart
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'counter_state.dart';

mixin CounterProps on UiProps {}

UiFactory<CounterProps> Counter = uiFunction(
  (props) {
    final count = useSelector<CounterState, int>((state) => state.count);
    final dispatch = useDispatch();

    return Dom.div()(
      Dom.div()('The current count is $count'),
      (Dom.button()
        ..onClick = (_) {
          dispatch(IncrementAction());
        }
      )('+'),
      (Dom.button()
        ..onClick = (_) {
          dispatch(DecrementAction());
        }
      )('-'),
    );
  },
  $CounterConfig, // ignore: undefined_identifier
);
```

### useStore()

```dart
Store<TReduxState> useStore<TReduxState>();
```

Returns a reference to the same Redux `Store` that was passed in to the [`ReduxProvider`](#reduxprovider)
component that the function component using the hook is a descendant of.

**This hook should probably not be used frequently.** Prefer [`useSelector()`](#useselector) as your primary choice.
However, this may be useful for less common scenarios that do require access to the `Store`,
such as replacing reducers.

If you need access to a specific store from a nested [`ReduxProvider`](#reduxprovider) with a custom `Context`, 
use [`createStoreHook`](#custom-context-for-hooks) instead.

> See the [react-redux JS documentation](https://react-redux.js.org/api/hooks#usestore) for more details.

### Custom Context For Hooks
The [`ReduxProvider`](#reduxprovider) component allows you to specify an alternate `Context` via `props.context`. 
This is useful if you're building a complex reusable component, and you don't want your store to collide with any 
Redux store your consumers' applications might use, or you're using [multiple Redux stores](#using-multiple-stores) 
in your application.

To access an alternate context via the hooks API, use the hook creator functions:

```dart
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';

// ------------------------------------
//  1. Declare the custom context
// ------------------------------------
final MyContext = createContext();
final useSelector = createSelectorHook<MyState>(MyContext);
final useDispatch = createDispatchHook(MyContext);
// This should probably not be used frequently. Prefer `createSelectorHook` as your primary choice.
// However, this may be useful for less common scenarios that do require access to the `Store`,
// such as replacing reducers.
final useStore = createStoreHook<MyState>(MyContext);

final myStore = Store(myReducer);

// ------------------------------------
//  2. Create a function component that
//  uses the shadowed `useSelector`.
// ------------------------------------
mixin MyComponentProps on UiProps {}

UiFactory<MyComponentProps> MyComponent = uiFunction(
  (props) {
    final count = useSelector((state) => state.count);
    // This should probably not be used frequently. Prefer `createSelectorHook` as your primary choice.
    // However, this may be useful for less common scenarios that do require access to the `Store`,
    // such as replacing reducers.
    final store = useStore();
    final dispatch = useDispatch();

    return Dom.div()('The current count is $count');
  },
  $MyComponentConfig, // ignore: undefined_identifier
);

// ------------------------------------
//  3. Render the function component
//  nested within the ReduxProvider
//  that is wired up to the 
//  custom context / store.
// ------------------------------------
main() {
  final app = (ReduxProvider()
    ..context = MyContext
    ..store = myStore
  )(
    MyComponent()(),
  );

  react_dom.render(app, querySelector('#id_of_mount_node'));
}
```

> __CAUTION:__ Be sure to not export the shadowed values of `useSelector`, `useDispatch` or `useStore` unless you know 
  exactly what you're doing, and the consumers of your library expect the hook to always have the context of the 
  state you parameterize it with.

> See the [react-redux JS documentation](https://react-redux.js.org/api/hooks#custom-context) for more details.


## Using Multiple Stores

An application can have multiple stores by both utilizing the `context` prop of `ReduxProvider` and setting the
`context` parameter on `connect`. While this is possible, it is not recommended.

> See: <https://redux.js.org/api/store#a-note-for-flux-users>

> See: <https://stackoverflow.com/questions/33619775/redux-multiple-stores-why-not>

**Multiple Stores Example:**

```dart
Store store1 = new Store<CounterState>(counterStateReducer, initialState: new CounterState(count: 0));
Store store2 = new Store<BigCounterState>(bigCounterStateReducer, initialState: new BigCounterState(bigCount: 100));

UiFactory<CounterProps> Counter = connect<CounterState, CounterProps>(
  mapStateToProps: (state) => (Counter()..count = state.count)
)(castUiFactory(_$Counter));

UiFactory<CounterProps> BigCounter = connect<BigCounterState, CounterProps>(
  mapStateToProps: (state) => (BigCounter()..count = state.bigCount),
  context: bigCounterContext,
)(castUiFactory(_$Counter));

react_dom.render(
  Dom.div()(
    (ReduxProvider()..store = store1)(
      (ReduxProvider()
        ..store = store2
        ..context = bigCounterContext
      )(
        Dom.div()(
          Dom.h3()('BigCounter Store2'),
          BigCounter()(
            Dom.h4()('Counter Store1'),
            Counter()(),
          ),
        ),
      ),
    ),
  ), querySelector('#content')
);
```

In the case that you need to have multiple stores, here are the steps to do so:

1. Create a `Context` instance to provide to the `ReduxProvider` and the components that will be in that context.
    ```dart
    final fooContext = createContext();
    ```
1. In the `connect` function wrapping the component, pass in the context instance.
    ```dart
    UiFactory<BarProps> Bar = connect<BarState, BarProps>(
      // ... mapStateToProps
      context: fooContext,
    )(castUiFactory(_$Bar));
    ```
1. Add an additional `ReduxProvider`, with its `context` prop set to the next Context instance and the `store` prop
   set to your additional store.
    ```dart
    // ... Wrapped in a reactDom.render()
    (ReduxProvider()..store = store1)(
      (ReduxProvider()
        ..store = store2
        ..context = bigCounterContext
      )(
        // ... connected componentry
      ),
    )
    ```
   
> To use multiple stores with function components / hooks, check out the [Custom Context for hooks](#custom-context-for-hooks) example.

## Using Redux DevTools

Redux DevTools can be set up easily by adding only a few lines of code.

> Additional information about `redux_dev_tools` and `DevToolsStore`s can be found [here](https://github.com/brianegan/redux_dev_tools#redux_dev_tools)

1. Add `redux_dev_tools` as a dev dependency in your `pubspec.yaml`.
    ```yaml
    dev_dependencies:
      redux_dev_tools: ^0.4.0
    ```
1. Import `redux_dev_tools` into your store file.
    ```dart
    import 'package:redux_dev_tools/redux_dev_tools.dart';
    ```
1. Change your `Store` to a `DevToolsStore` instance and add the constant `overReactReduxDevToolsMiddleware` to your middleware.
    ```diff
    - var store = new Store<AppState>(
    + var store = new DevToolsStore<AppState>(
        /*ReducerName*/,
        initialState: /*Default App State Object*/,
    +   middleware: [overReactReduxDevToolsMiddleware],
      );
    ```
   > **NOTE:** You should revert back to a normal `Store` without the `overReactReduxDevToolsMiddleware` prior to making your code public (via publishing a package or deploying to production) as it will be less performant and could be a security risk.
1. Get the Redux Devtools extension:
   - Chrome: https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en
   - Firefox: https://addons.mozilla.org/en-US/firefox/addon/reduxdevtools/

You can run your code and open the devtools in your browser!

`overReactReduxDevToolsMiddlewareFactory` is also available to pass [options](https://github.com/reduxjs/redux-devtools/blob/main/extension/docs/API/Arguments.md) into the initialization of the redux dev tools.

```dart
var store = new DevToolsStore<AppState>(
  /*ReducerName*/,
  initialState: /*Default App State Object*/,
  middleware: [overReactReduxDevToolsMiddlewareFactory(name: 'Some Custom Instance Name')],
)
```

### Integration With DevTools

In order to display the properties of Dart based `Action`s and `State` in the DevTools they must implement a `toJson` method. 

`toJson` can be manually added to the classes, or added with the help of something like the [json_serializable](https://pub.dev/packages/json_serializable) or [built_value](https://pub.dev/packages/built_value) and its serializers. In the event that a value is not directly encodeable to `json`, we will make an attempt to call `toJson` on the value.

State Example:
```dart
class FooState {
  bool foo = true;
  
  Map<String, dynamic> toJson() => {'foo':foo};
}
```

When converted, the result of `toJson` will be used to present the entire state.
```json lines
{
  "foo": true
}
```

Action Example:
```dart
class FooAction {
  bool foo = false;
  
  Map<String, dynamic> toJson() => {'foo':foo};
}
```

When converted, the class name will be the `type` property and `toJson` will become the `payload`
```json lines
{
  "type": "FooAction",
  "payload": {
    "foo": false
  }
}
```

Action (Enum) Example:
```dart
enum FooAction {
  ACTION_1,
  ACTION_2,
}
```
When an enum `Action` is used the value of the action in the enum will be used
```json lines
{"type": "ACTION_1"}
```

For a more encoding details check out the [redux_remote_devtools](https://pub.dev/packages/redux_remote_devtools)
