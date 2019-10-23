# OverReact Redux
> A Dart React Redux wrapper for targeted state updates.

---
* __[Purpose](#purpose)__
    * [Advantages](#advantages)
* __[Using it in your project](#using-it-in-your-project)__
* __[The Connect Function](#the-connect-function)__
    * [Connect Parameters](#connect-parameters)

## Purpose
[React Redux](https://react-redux.js.org) is a UI binding library that allows for better Redux integration with React. 
This integration allows for APIs that align more closely with React design patterns while also providing more direct 
access to store data.

### Advantages

A full list of advtanges can be found [here](https://react-redux.js.org/introduction/why-use-react-redux). 
Especially useful for OverReact though, OverReact Redux allows for targeted updates that only update components 
that need to be, rather than the whole component tree (as is the behavior with React). By utilizing the 
`connect()` function in conjunction with `mapStateToProps()`, a component will only update when a piece of information 
it uses is updated.


## Using it in your project
1. Add the `redux` package as a dependency in your `pubspec.yaml`.

    ```yaml
    dependencies:
      redux: '>=3.0.0'
    ```
1. Add the `redux` and `react-redux` libraries into the body of your app's `index.html` under your React script tags
    ```html
      <script src="https://cdnjs.cloudflare.com/ajax/libs/redux/4.0.4/redux.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/react-redux/7.0.3/react-redux.js"></script>
    ```
1. [Create a store](linkToExampleFile).
1. Import OverReact Redux and your store into the file with your component.
    ```
    import 'package:over_react/over_react_redux.dart';
    ```
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
- `mapStateToProps` is used for selecting the part of the data from the store that the connected
 component needs.
   - It is called every time the store state changes.
   - It receives the entire store state, and should return an object of data this component needs.
If you need access to the props provided to the connected component you can use `mapStateToPropsWithOwnProps`,
the second argument will be `ownProps`. 

     See: <https://react-redux.js.org/using-react-redux/connect-mapstate#defining-mapstatetoprops>
- `mapDispatchToProps` will be called with dispatch as the first argument.
You will normally make use of this by returning new functions that call dispatch() inside themselves,
and either pass in a plain action directly or pass in the result of an action creator.
If you need access to the props provided to the connected component you can use `mapDispatchToPropsWithOwnProps`,
the second argument will be `ownProps`.

  See: <https://react-redux.js.org/using-react-redux/connect-mapdispatch#defining-mapdispatchtoprops-as-a-function>
- `mergeProps` if specified, defines how the final props for the wrapped component are determined.
If you do not provide `mergeProps`, the wrapped component receives {...ownProps, ...stateProps, ...dispatchProps}
by default.
- `areStatesEqual` does a simple `==` check by default.
- `areOwnPropsEqual` does a shallow Map equality check by default.
- `areStatePropsEqual` does a shallow Map equality check by default.
- `areMergedPropsEqual` does a shallow Map equality check by default.
- `context` can be utilized to provide a custom context object created with `createContext`.
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
