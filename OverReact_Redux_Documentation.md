# OverReact Redux
> A Dart React Redux wrapper for targeted state updates.

---
* __[Purpose](#purpose)__
    * [Advantages](#advantages)
* __[Using it in your project](#using-it-in-your-project)__
* __[ReduxProvider](#reduxprovider)__
* __[The Connect Function](#the-connect-function)__
    * [Connect Parameters](#connect-parameters)
        * [mapStateToProps](#mapstatetoprops)
        * [mapDispatchToProps](#mapdispatchtoprops)
        * [mergeProps](#mergeprops)
        * [areStatesEqual](#arestatesequal)
        * [areOwnPropsEqual](#areownpropsequal)
        * [areStatePropsEqual](#arestatepropsequal)
        * [areMergedPropsEqual](#aremergedpropsequal)
        * [context](#context)
* __[Using Multiple Stores](#using-multiple-stores)__
* __[Using Redux DevTools](#using-redux-devtools)__

## Purpose
[React Redux](https://react-redux.js.org) is a UI binding library that allows for better Redux integration with React. 
This integration allows for APIs that align more closely with React design patterns while also providing more direct 
access to store data. OverReact Redux is the Dart wrapper around that library.

### Advantages

A full list of advantages can be found [here](https://react-redux.js.org/introduction/why-use-react-redux). 
Especially useful for OverReact though, OverReact Redux allows for targeted updates that only update components 
that receive data which has changed, rather than the whole component tree (as is the behavior with React). By utilizing 
the `connect()` function in conjunction with `mapStateToProps()`, a component will only update when a piece of information 
it uses is updated.


## Using it in your project
1. Add the `redux` package as a dependency in your `pubspec.yaml`.

    ```yaml
    dependencies:
      redux: '>=3.0.0'
    ```
1. Create your store and reducer. See the [example store](./web/over_react_redux/store.dart) for ways to do this.
1. Import OverReact Redux and your store into your `index.dart`.
    ```dart
    import 'package:over_react/over_react_redux.dart';
    ```
1. Wrap your component tree in a `ReduxProvider` and pass in the store.
     ```dart
    reactDom.render(
      (ReduxProvider()..store = fooStore)(
        // ... React component tree with connected components
      )
    )
    ```
1. Import OverReact Redux and your store into the file with your component.
1. Wrap your `UiFactory` with `connect()` and add the `ConnectPropsMixin` to your props class.
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
wrapped in a `Provider` to hold the handle the context.

For this purpose, OverReact Redux has the `ReduxProvider` component. It is required to take in a store instance, and can
 optionally take in a context object when using multiple stores.
 
 __Example:__
 ```dart
reactDom.render(
  (ReduxProvider()..store = fooStore)(
    // ... React component tree with connected components
  )
)
```
    
## The Connect Function
A wrapper around the JS react-redux `connect` function that supports OverReact components.

__Example:__

    ```
    UiFactory<CounterProps> ConnectedCounter = connect<CounterState, CounterProps>(
            mapStateToProps: (state) => (
              Counter()..intProp = state.count
            ),
            mapDispatchToProps: (dispatch) => (
              Counter()..increment = () => dispatch(INCREMENT_ACTION())
            ),
    )(Counter);
    ```

### Connect Parameters
- #### `mapStateToProps` 
    - Is used for selecting the part of the data from the store that the connected
 component needs.
        - It is called every time the store state changes.
        - It receives the entire store state, and should return an object of data this component needs.
If you need access to the props provided to the connected component you can use `mapStateToPropsWithOwnProps`,
the second argument will be `ownProps`. 

     See: <https://react-redux.js.org/using-react-redux/connect-mapstate#defining-mapstatetoprops>
- #### `mapDispatchToProps` 
    - Will be called with dispatch as the first argument.
    
        You will normally make use of this by returning new functions that call dispatch() inside themselves,
and either pass in a plain action directly or pass in the result of an action creator.
If you need access to the props provided to the connected component you can use `mapDispatchToPropsWithOwnProps`,
the second argument will be `ownProps`.

  See: <https://react-redux.js.org/using-react-redux/connect-mapdispatch#defining-mapdispatchtoprops-as-a-function>
- #### `mergeProps` 
    - If specified, defines how the final props for the wrapped component are determined.
If you do not provide `mergeProps`, the wrapped component receives {...ownProps, ...stateProps, ...dispatchProps}
by default.
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
`context` is how you can utilize multiple stores. While supported, this is not recommended. :P

    See: <https://redux.js.org/api/store#a-note-for-flux-users>
    
    See: <https://stackoverflow.com/questions/33619775/redux-multiple-stores-why-not>

    __Example:__
    ```dart
    Store store1 = new Store<CounterState>(counterStateReducer, initialState: new CounterState(count: 0));
    Store store2 = new Store<BigCounterState>(bigCounterStateReducer, initialState: new BigCounterState(bigCount: 100));UiFactory<CounterProps> ConnectedCounter = connect<CounterState, CounterProps>(
          mapStateToProps: (state) => (Counter()..intProp = state.count)
        )(Counter);
        UiFactory<CounterProps> ConnectedBigCounter = connect<BigCounterState, CounterProps>(
          mapStateToProps: (state) => (Counter()..intProp = state.bigCount),
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
- `pure` if `true` (default), connect performs several equality checks that are used to avoid unnecessary
calls to `mapStateToProps`, `mapDispatchToProps`, `mergeProps`, and ultimately to `render`. These include
`areStatesEqual`, `areOwnPropsEqual`, `areStatePropsEqual`, and `areMergedPropsEqual`.
While the defaults are probably appropriate 99% of the time, you may wish to override them with custom
implementations for performance or other reasons.
- `forwardRef` if `true`, the `ref` prop provided to the connected component will be return the wrapped component.

  For more info see: https://react-redux.js.org/api/connect#connect
  
## Using Multiple Stores

An application can have multiple stores by utilizing the `context` parameter of `ReduxProvider`. While this is 
possible, it is not recommended. See the [context Connect() parameter](#context) for more information.

In the case that you need to have multiple stores, you use `context` to do so:
1. Create a `Context` instance to provide to the `ReduxProvider` and the components in that context.
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
1. In a ReduxProvider, pass in your context instance.
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

1. Add `redux_remote_devtools`, `redux_dev_tools`, and `socketcluster_client` as dependencies in your `pubspec.yaml`.
    ```
    dependencies:
      redux_dev_tools: 0.4.0
      redux_remote_devtools: ^0.0.7
      socketcluster_client: ^0.1.0
    ```
    
    > __NOTE__: You will need to override `socketcluster_client` with a fork from Github. This is a short term 
    solution while a PR waits to get merged:
    ```yaml
    dependency_overrides:
       socketcluster_client:
         git:
           url: https://github.com/kealjones-wk/socketcluster_client.git
           ref: auto-platform-selection
    ```
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

You can now to go `127.0.0.1:8000` and see your devtools!