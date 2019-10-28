# OverReact Redux
> A Dart React Redux wrapper for targeted state updates.

---
* __[Purpose](#purpose)__
    * [Benefits](#benefits)
* __[Demo Component](#examples)__
* __[Using it in your project](#using-it-in-your-project)__
* __[ReduxProvider](#reduxprovider)__
* __[Connect](#connect)__
    * [`connect` Parameters](#connect-parameters)
        * [mapStateToProps](#mapstatetoprops)
        * [mapDispatchToProps](#mapdispatchtoprops)
        * [mergeProps](#mergeprops)
        * [areStatesEqual](#arestatesequal)
        * [areOwnPropsEqual](#areownpropsequal)
        * [areStatePropsEqual](#arestatepropsequal)
        * [areMergedPropsEqual](#aremergedpropsequal)
        * [context](#context)
        * [pure](#pure)
        * [forwardRef](#forwardref)
* __[Using Multiple Stores](#using-multiple-stores)__
* __[Using Redux DevTools](#using-redux-devtools)__

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
A basic demo component is available in the `web` directory. In addition to running the app to see how it works, the 
[store](../web/over_react_redux/store.dart) and [component](../web/over_react_redux/components/counter.dart) have 
comments that provide additional explanation.

To run and experiment with the demo:
1. `pub get`
1. `pub run build_runner serve web`
1. Navigate to `localhost:8080/over_react_redux/`

If you would like to use the Redux DevTools, run the following in addition to running your server (as described above):
1. `npm install -g remotedev-server`
1. `remotedev --port 8000`
1. Navigate to `localhost:8000` to see the devtools
> __Note:__ Only the `ConnectedCounter Store1` state will display in the devtools because the example uses multiple 
stores.

## Using it in your project
1. Add the `redux` package as a dependency in your `pubspec.yaml`.

    ```yaml
    dependencies:
      redux: '>=3.0.0'
    ```
1. Create your store and reducer. See the [example store](../web/over_react_redux/store.dart) for ways to do this.
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
         )
       );
     }
    ```
1. Import OverReact Redux and your store into the file with your component.
1. Update your component class.
    - Add a new `UiFactory`, without the usual annotation, and wrap it with `connect()`.
    - Add the `ConnectPropsMixin` to your props class if needed. This mixin is needed if either of the following are 
    true:
        - You _do not_ use the `mapDispatchToProps` parameter on `connect`.
        - You _do_ use `mapDispatchToProps` but want access to the `props.dipsatch` function. When using 
        `mapDispatchToProps`, by default the `dispatch` property on `props` is removed. It can be added back 
        using `ConnectPropsToMixin`. 
    ```
    // AppState is a class that represents the application's state and can be defined in the same file as the store.
    UiFactory<FooProps> ConnectedFoo = connect<AppState, FooProps>()(Foo);
    
    @Factory()
    UiFactory<FoodProps> Foo = _$Foo;
    
    // Use the ConnectPropsMixin to gain access to React Redux's dispatch function, which can be accessed via 
    // props.dispatch.
    @Props()
    class _$FooProps extends UiProps with ConnectPropsMixin {
        ...
    }
    
    @Component2()
    class FooComponent extends UiComponent2<FooProps> {
        ...
    }
    ```
    
## ReduxProvider
Redux uses React 16's `Context` API to pass information through the component tree. Consequently, the tree must be 
wrapped in a `Provider` to handle the context.

For this purpose, OverReact Redux has the `ReduxProvider` component. It is required to take in a store instance, and can
 optionally take in a context object when using multiple stores.
 
 __Example:__
 ```dart
react_dom.render(
  (ReduxProvider()..store = fooStore)(
    // ... React component tree with connected components
  )
)
```
    
## `connect`
### `Overview`
A wrapper around the JS react-redux `connect` function that supports OverReact components.

__Example:__
```
UiFactory<CounterProps> ConnectedCounter = connect<CounterState, CounterProps>(
        mapStateToProps: (state) => (
          Counter()..count = state.count
        ),
        mapDispatchToProps: (dispatch) => (
          Counter()..increment = () => dispatch(INCREMENT_ACTION())
        ),
)(Counter);
```

### `connect` Parameters
- #### `mapStateToProps`
    - Used for selecting the part of the data from the store that the connected
 component needs.
        - Called every time the store state changes.
        - Receives the entire store state, and should return an object of data this component needs.
If you need access to the props provided to the connected component you can use `mapStateToPropsWithOwnProps`,
the second argument will be `ownProps`. 

        > See: <https://react-redux.js.org/using-react-redux/connect-mapstate#defining-mapstatetoprops>
- #### `mapDispatchToProps` 
    - Called with dispatch as the first argument.
    
        You can make use of this by returning new functions that call dispatch() inside themselves,
and either pass in a plain action directly or pass in the result of an action creator.
If you need access to the props provided to the connected component you can use `mapDispatchToPropsWithOwnProps`,
the second argument will be `ownProps`.

        > See: <https://react-redux.js.org/using-react-redux/connect-mapdispatch#defining-mapdispatchtoprops-as-a-function>
- #### `mergeProps` 
    - Defines how the final props for the wrapped component are determined.
If you do not provide `mergeProps`, the wrapped component receives the default: 
        ```dart
        {...ownProps, ...stateProps, ...dispatchProps}
        ```
- #### `areStatesEqual` 
    - Does a simple `==` check by default.
- #### `areOwnPropsEqual` 
    - Does a shallow Map equality check by default.
- #### `areStatePropsEqual` 
    - Does a shallow Map equality check by default.
- #### `areMergedPropsEqual` 
    - Does a shallow Map equality check by default.
- #### `context` 
    - Can be utilized to provide a custom context object created with `createContext`.
  - `context` can be used to utilize multiple stores. 
    > For more information on having multiple stores, see [Using Multiple Stores](#using-multiple-stores).
- #### `pure` 
    - If `true` (default), connect performs several equality checks that are used to avoid unnecessary
calls to `mapStateToProps`, `mapDispatchToProps`, `mergeProps`, and ultimately to `render`. These include
`areStatesEqual`, `areOwnPropsEqual`, `areStatePropsEqual`, and `areMergedPropsEqual`.
While the defaults are probably appropriate 99% of the time, you may wish to override them with custom
implementations for performance or other reasons.
- #### `forwardRef` 
    - If `true`, the `ref` prop provided to the connected component will be return the wrapped component.

> [More information about the `connect` function](https://react-redux.js.org/api/connect#connect)
  
## Using Multiple Stores
An application can have multiple stores by both utilizing the `context` prop of `ReduxProvider` and setting the 
`context` parameter on `connect`. While this is possible, it is not recommended.
> See: <https://redux.js.org/api/store#a-note-for-flux-users>

> See: <https://stackoverflow.com/questions/33619775/redux-multiple-stores-why-not>

__Multiple Stores Example:__
```dart
Store store1 = new Store<CounterState>(counterStateReducer, initialState: new CounterState(count: 0));
Store store2 = new Store<BigCounterState>(bigCounterStateReducer, initialState: new BigCounterState(bigCount: 100));

UiFactory<CounterProps> ConnectedCounter = connect<CounterState, CounterProps>(
      mapStateToProps: (state) => (Counter()..count = state.count)
    )(Counter);
    UiFactory<CounterProps> ConnectedBigCounter = connect<BigCounterState, CounterProps>(
      mapStateToProps: (state) => (Counter()..count = state.bigCount),
      context: bigCounterContext,
    )(Counter);
    react_dom.render(
      Dom.div()(
        (ReduxProvider()..store = store1)(
          (ReduxProvider()
            ..store = store2
            ..context = bigCounterContext
          )(
            Dom.div()(
              Dom.h3()('ConnectedBigCounter Store2'),
              ConnectedBigCounter()(
                Dom.h4()('ConnectedCounter Store1'),
                ConnectedCounter()(),
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
       UiFactory<BarProps> ConnectedBar = connect<BarState, BarProps>(
          // ... mapStateToProps
          context: fooContext,
       )(Bar);
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

1. Add `redux_remote_devtools` and `redux_dev_tools` as dependencies in your `pubspec.yaml`.
    ```
    dependencies:
      redux_dev_tools: 0.4.0
      redux_remote_devtools: ^0.0.11
    ```
    > __NOTE:__ The dependency on `redux_remote_devtools` being `>=0.0.11` is a hard line, as prior to this version 
    the package was tailored to Flutter and reliant on `dart:io`.
1. Import `redux_remote_devtools` and `redux_dev_tools` into your store file.
    ```
    import 'package:redux_remote_devtools/redux_remote_devtools.dart';
    import 'package:redux_dev_tools/redux_dev_tools.dart';
    ```
1. Create a store using a `DevToolsStore` rather then a traditional store.
    ```
    var store = new DevToolsStore<AppState>(/*ReducerName*/, initialState: /*Default App State Object*/, middleware: [remoteDevtools]);
    ```
1. Expose an `initDevtools()` function. This will be used to set up the devtools server.
    ```
    var remoteDevtools = RemoteDevToolsMiddleware('127.0.0.1:8000');
    
    Future initDevtools() async {
      remoteDevtools.store = store;
      return remoteDevtools.connect();
    }
    ```
1. Near the top of your `main.dart` file, spin up the `HttpSocketPlatform` and init the devtools.
    ```dart
     initDevtools();
    ```
1. In addition to running your web server as normal to view your application, you will also need to run the following
 simultaneously:
    1. Run `npm install -g remotedev-server` if you have not yet installed `remotedev-server`.
    1. `remotedev --port 8000`

You can now to go `127.0.0.1:8000` and see your devtools!