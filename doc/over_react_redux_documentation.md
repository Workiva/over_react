# OverReact Redux

A Dart wrapper for React Redux, providing targeted state updates.

---

- **[Purpose](#purpose)**
  - [Benefits](#benefits)
- **[Examples](#examples)**
  - [Running the Examples](#running-the-examples)
- **[Using it in your project](#using-it-in-your-project)**
- **[ReduxProvider](#reduxprovider)**
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
)(_$Counter);

UiFactory<CounterProps> BigCounter = connect<BigCounterState, CounterProps>(
  mapStateToProps: (state) => (BigCounter()..count = state.bigCount),
  context: bigCounterContext,
)(_$Counter);

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
    )(_$Bar);
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
