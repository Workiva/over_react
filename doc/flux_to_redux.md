# Flux to Redux Transition Guide
> A document explaining the fundamentals of transitioning a Flux architecture to a Redux architecture.
>
> NOTE: Before attempting to transition, make sure you understand the content from the general [Redux Documentation](https://github.com/johnpryan/redux.dart) and the [OverReact Redux Documentation](./over_react_redux_documentation.md). This guide covers differences between Flux to Redux but does not try to comprehensively describe Redux.
---
* __[Goal](#goal)__
* __[Do I have to transition?](#do-i-have-to-transition-to-redux)__
* __[A Simple Example](#a-simple-example)__
    * [A Basic Flux App](#a-basic-flux-app)
    * [The Redux Version](#the-redux-version)
    * [Basic Example: The Main Differences](#basic-example-the-main-differences)
    * [Basic Conversion Step by Step](#basic-conversion-step-by-step)
* __[An Advanced Example](#an-advanced-example)__
    * [An Advanced Flux App](#an-advanced-flux-app)
    * [Converted to Redux](#converted-to-redux)
    * [Advanced Conversion Step by Step](#advanced-conversion-step-by-step)
    * [What if the Advanced Conversion is too Daunting?](#what-if-the-advanced-conversion-is-too-daunting?)
* __[Influx Architecture](#influx-architecture)__
    * [What is Influx?](#what-is-influx?)
    * [Should You Use It](#should-you-implement-an-influx-architecture-during-the-transition?)
        * [Advantages](#advantages)
        * [Disadvantes](#disadvantages)
    * [Important Terms](#important-terms)
    * [Steps to an Influx Refactor](#steps-to-an-influx-refactor)
        * [Phase 1: Get Ready to Refactor](#phase-1:-get-ready-to-refactor)
        * [Phase 2: Update Stores](#phase-2:-incrementally-update-stores)
        * [Phase 3: Influx to Redux](#phase-3:-influx-to-redux)

## Goal
The goal of this document is explain major elements of transitioning from Flux to Redux. This includes explanation of both a simple and more advanced conversion, and the introduction of a new architecture as a last resort for the most extreme cases.

If, through this process, the document or examples miss any edge cases you encounter, please create an issue or reach out so it can be added.

## Do I have to transition to Redux?
No. OverReact Redux is meant to help to provide a recommended state management method for OverReact components, as well as provide benefits over [w_flux](https://github.com/workiva/w_flux) and [built_redux](https://github.com/davidmarne/built_redux). Those benefits may provide enough reason to make a refactor worthwhile. If, after evaluating the benefits and effort, the juice doesn't seem worth the squeeze, then no need to worry about it!

To evaluate if the refactor is worth it, the details of OverReact Redux can be found in the [OverReact Redux documentation](./over_react_redux_documentation.md). That document paired with this guide will illustrate the full scope of costs and benefits.

## A Simple Example
To illustrate the basic changes that will occur, this section will go through a basic Flux architecture and then show that same system with Redux instead. This section will also have a step by step list of instructions for an update as straightforward as this one. An actual working example can be found in the [Flux to Redux Example](../web/flux_to_redux/simple/readme.md).

> NOTE: This section does not cover the complexities of having multiple stores, which presents more challenges than a single store. For a more complex example [see the advanced example below](#an-advanced-example).

### A Basic Flux App
For our example, here are our different items of interest:
- __The Flux Store Class__, `RandomColorStore`
- __The Actions Class__, `RandomColorActions`
- __The instances of these classes__, `randomColorStore` and `randomColorActions`
- __The Store Object:__ Our store, called `randomColorStore`, is instantiated with `randomColorActions` being passed in.
- __The UI:__ The only component is a BigBlock component that receives randomColorActions and randomColorStore as props. Updates are triggered by calling `props.actions.changeBackgroundColor` and state is accessed by using `props.store.state`. The actual UI itself is just the component, with its background color set to the state background color, and a button that triggers the action to update the state background color.

```dart
import 'package:w_flux/w_flux.dart' as flux;

// A flux store responsible for displaying a random background color.
class RandomColorStore extends flux.Store {
    /// The collection of actions this store will be subscribing to.
    RandomColorActions _actions;

    /// Public data
    String _backgroundColor = 'gray';
    String get backgroundColor => _backgroundColor;

    RandomColorStore(this._actions) {
    // Subscribe to an action. When the action fires:
    // 1. call _changeBackgroundColor
    // 2. trigger an update
        triggerOnActionV2(_actions.changeBackgroundColor, _changeBackgroundColor);
    }

    _changeBackgroundColor(String _) {
        // Update the state, which will be reflected in the public getter
        _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    }
}
```

```dart
import 'package:w_flux/w_flux.dart' as flux;

/// A collection of actions.
class RandomColorActions {
  /// An action instance that can be used to dispatch events to subscribers.
  final changeBackgroundColor = flux.Action<String>();
}
```

```dart
// This same actions object will also be passed into components,
// so that the `Action` instances used to dispatch events are the same ones
// that have been listened to by the store.
final randomColorActions = RandomColorActions();
final randomColorStore = RandomColorStore(randomColorActions);
```

<img height=400 src="./FluxArchitecture.png" alt='Flux Architecture'>

### The Redux Version
For our example, here are our different items of interest:
- __The State Class__, `ReduxState`
- __Actions__, a single action class called `UpdateBackgroundColorAction`
- __The Reducer__, `randomColorReducer`
- __The Store Object__, `randomColorStore`
- __The UI:__ All of our UI componentry is wrapped in a `ReduxProvider`. The provider takes in a `store` prop, to which we pass `randomColorStore`. The only component is a `BigBlock` connected component. Updates are triggered by calling `props.dispatch(UpdateBackgroundColorAction())`, and since it's a connected component (using [`mapStateToProps`](./over_react_redux_documentation.md#mapstatetoprops)) state is accessed via normal props usage.

```dart
// A regular Dart class that represents the application data model
class RandomColorState {
    // The state values the app needs
    String backgroundColor;

    // A constructor used to establish the default state
    RandomColorState.defaultState() : this.backgroundColor = 'gray';

    // A convenience constructor used by the reducer to return new instances of the class
    RandomColorState.update(RandomColorState oldState, {String backgroundColor})
        : this.backgroundColor = backgroundColor ?? oldState.backgroundColor;
}
```

```dart
// The only action for our application
class UpdateBackgroundColorAction {}
```

```dart
// A simple reducer that has a case for every action (in this case, a single one)
RandomColorState reducer(RandomColorState oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    // Return a new state class instance, changing the background color
    return RandomColorState.update(oldState, backgroundColor: color);
  }

  return oldState;
}
```

```dart
import 'package:redux/redux.dart' as redux;

// Instantiate a store using the reducer and state class
redux.Store randomColorStore = redux.Store<RandomColorState>(reducer, initialState: RandomColorState.defaultState());
```

<img height=400 src="./ReduxArchitecture.png" alt='Redux Architecture'>

### Basic Example: The Main Differences
- __We replace the Flux store with both a state class and a reducer.__ In Redux, we do not define a class that is responsible for handling state updates. Rather, we create the model to represent the state and a function to describe updates. Then, use them in the instantiation of a Redux `Store` object.
- __Actions are not held in an overarching wrapper class.__ Typically in Redux, actions "stand alone" from each other. Our reducer should have cases for all the actions that exist, but unlike Flux there is no need to knit our store and actions together by actually providing an actions instance to the store. Consequently, actions are broken away, pulled directly into the component, and triggered by passing an action instance into `dispatch` - the centralized dispatcher accessible via `props` if mixing in `ConnectPropsMixin`, or [`mapDispatchToProps`](./over_react_redux_documentation.md#mapdispatchtoprops).
- __In Redux, the entire store is not passed to components via props.__ OverReact Redux's [`connect` function](./over_react_redux_documentation.md#connect) uses context to allow you to access the store's state without passing it through multiple layers of components, and also provides a mechanism to map the relevant parts of state directly to props (and optionally only rerender when those props change). `connect` is paired with wrapping the component tree in a [`ReduxProvider` component](./over_react_redux_documentation.md#reduxprovider).

### Basic Conversion Step by Step
> NOTE: This document does not attempt to teach _how_ to use Redux. If any of these steps cause confusion on the implementation details of Redux, see the [OverReact Redux Documentation](./over_react_redux_documentation.md).
1. __Refactor the actions.__ Remove the action container class, and replace action instances with classes.
    ```dart
    // Before
    class ExampleActions {
      final Action<void> randomizeBackgroundColor = Action();
      final Action<String> setBackgroundColor = Action();
    }
     
    // After
    class RandomizeBackgroundColorAction {}
    class SetBackgroundColorAction {
      final String backgroundColor;
      SetBackgroundColorAction(this.backgroundColor);
    }
    ```

    If your `Action` receives a custom class as typing for the action payload, that class could be a great starting point for the creation of your new Redux action.

    ```dart
    // Before
    class ExampleActions {
        final Action<SetBackgroundColorPayload> randomizeBackgroundColor = Action();
    }

    class SetBackgroundColorPayload {
        String backgroundColor;
        SetBackgroundColorAction(this.backgroundColor);
    }
    
    // After
    class SetBackgroundColorAction {
        final String backgroundColor;
        SetBackgroundColorAction(this.backgroundColor);
    }
    ```

1. __Pull state mutation logic out of the store and into a reducer.__ Typically within a Flux store you have a `triggerOnActionV2` call that identifies an action and a function used to respond to that action. In many cases, that same logic should be perfect for a reducer.
    ```dart
    import 'package:w_flux/w_flux.dart' as flux;

    // Before transition
    class ExampleFluxStore extends flux.Store {
        FluxActions _actions;

        String _backgroundColor = 'Gray';
        String get backgroundColor = _backgroundColor;

        // Constructor
        ExampleFluxStore(this._actions) {
            triggerOnActionV2(_actions.changeBackgroundColor, _changeBackgroundColor);
        }

        // Function to update the _backgroundColor state field
        _changeBackgroundColor(_) {
            _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
        }
    }

    // After being transitioned to a reducer...
    ExampleState reducer(ExampleState oldState, dynamic /*or an action type*/ action) {
        // Assumes an action called ChangeBackgroundColor was created in step 1
        if (action is ChangeBackgroundColor) {
            final color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
            return ExampleState.update(color: color);
        }

        return oldState;
    }
    ```
1. __Create the state model.__ After pulling out state mutation logic, this should be as simple as renaming the class, not inheriting from the Flux store class, and cleaning up anything unrelated to the actual state fields. 
1. __Instantiate the store class, using the state model and reducer.__
1. __Add a `ReduxProvider` around the component tree.__ This will take in the store instantiated in step 4 as the component's `store` prop.
1. __Refactor componentry to not longer be a `FluxUiComponent` and instead be a connected `UiComponent2`.__ In terms of moving away from Flux, the simplest case is that props and prop calls need to be updated. Props will need to be added to make room for the ones consumed by the Redux component, and any `props.actions` calls need to be updated to `props.dispatch` (unless you're using `mapDispatchToProps`). 

## An Advanced Example
In the case a Flux app has a complex store architecture that involves multiple stores, whether they be nested under one store or be completely separate, the transition process has a few additional catches. 

This section builds on the [simple example](#a-simple-example), so ensure that section makes sense conceptually before looking at multiple stores.

### An Adanced Flux App
- __The Flux Store Classes:__ `RandomColorStore`, `MidLevelStore`, `LowLevelStore`, and `AnotherColorStore`. `RandomCOlorStore`, `MidLevelStore`, and `LowLevelStore` are nested within each other while `AnotherColorStore` is completely separate.

    Despite there being four stores, all of them have the same job: handle a single random color property. Therefore, they are all nearly identical objects. Naturally in the real world they would likely be drastically different, but for simplicity sake and keeping the focus on the big picture they are all left the same.
- __The Store Objects:__ `bigStore` and `littleStore`
- __The Actions Class__, `RandomColorActions`
- __The Actions Object__, `randomColorActions`
- __The UI:__ The only complex component is a `BigBlock` component that receives `randomColorActions`, `bigStore`, and `littleStore` as props. Updates are triggered by using the action prop. Naturally now state is accessed via:
    - props.bigStore.state
    - props.bigStore.midLevelStore.state
    - props.bigStore.midLevelStore.lowLevelStore.state
    - props.littlebig_Store.state

    Our `BigBlock` component renders three `SmallBlock` components. Each one connects to a different store's state, with the remaining background color being tied to `BigBlock` itself. 
    
    `BigBlock` also has four buttons - one connected to each action that changes the background color property of one of the stores (and thereby updating the component background color).

    A Flux specific part of the `BigBlock` component is that we need to set the `redrawOne` to listen to the story at every level.

```dart
import 'package:w_flux/w_flux.dart' as flux;
    
// A nested store
class RandomColorStore extends flux.Store {
    RandomColorActions _actions;
    // MidLevelStore looks nearly identical to `RandomColorStore`, but has a different
    // store object (`LowLevelStore`) nested within it.
    MidLevelStore midLevelStore = MidLevelStore(randomColorActions);

    /// Public data
    String _backgroundColor = 'gray';
    String get backgroundColor => _backgroundColor;

    RandomColorStore(this._actions) {
        triggerOnActionV2(_actions.changeMainBackgroundColor, _changeBackgroundColor);
    }

    _changeBackgroundColor(String _) {
        _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    }
}

// A seperate store, making the total store count be equal to 4
class AnotherColorStore extends flux.Store {
    RandomColorActions _actions;

    /// Public data
    String _backgroundColor = 'Blue';
    String get backgroundColor => _backgroundColor;

    AnotherColorStore(this._actions) {
        triggerOnActionV2(_actions.changeBlockThreeBackgroundColor, _changeBackgroundColor);
    }

    _changeBackgroundColor(String _) {
        _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    }
}
```

```dart
import 'package:w_flux/w_flux.dart' as flux;
    
// A shared action class for all the stores, with an action to update each background color
class RandomColorActions {
    final flux.Action<String> changeMainBackgroundColor = flux.Action();

    final flux.Action<String> changeBlockOneBackgroundColor = flux.Action();

    final flux.Action<String> changeBlockTwoBackgroundColor = flux.Action();

    final flux.Action<String> changeBlockThreeBackgroundColor = flux.Action();
}
```

```dart
// Instatiate the actions
RandomColorActions randomColorActions = RandomColorActions();

// Instatiate the stores
RandomColorStore bigStore = RandomColorStore(randomColorActions);
AnotherColorStore littleStore = AnotherColorStore(randomColorActions);
```

<img height=400 src="./AdvancedFluxArchitecture.png" alt='Redux Architecture'>

### Converted to Redux
The Redux app doesn't really have any surprises, and at a high level is very similar to the simple example:
- __The State Class:__ we have a class (`ReduxState`) that has four properties: 
    - mainBackgroundColor
    - blockOneBackgroundColor
    - blockTwoBackgroundColor
    - blockThreeBackgroundColor
- __Actions:__ we have four actions as their own classes; one class for each state class property.
- __The Reducer:__ as probably expected, our reducer is also similar to the simple app but with a condition for each action. This reducer is especially contrived because the simplicity of the store data makes each case the same with the only difference being the property the update is pointed at. A more complex usage could leverage [Combine Reducers](https://github.com/johnpryan/redux.dart/blob/master/doc/combine_reducers.md).
- __The Store Object:__ same as the simple example.
- __The UI:__ like the simple example, our component tree is wrapped in a `ReduxProvider`. Otherwise the component architecture is the same as the Flux version, minus the Flux-y parts. We have a connected `UiComponent2` called `BigBlock` that maps the store state to props, which passes the props to its three `LittleBlock`s, with four buttons to trigger the background actions. Naturally all the Flux parts were removed, including the `redrawOn` override.

```dart
// A regular Dart class that represents the application data model
class ReduxState {
    // All of the state fields for the application
    String mainBackgroundColor;
    String blockOneBackgroundColor;
    String blockTwoBackgroundColor;
    String blockThreeBackgroundColor;

    // A constructor for creating the default app state
    ReduxState.defaultState()
        : this.mainBackgroundColor = 'gray',
        this.blockOneBackgroundColor = 'red',
        this.blockTwoBackgroundColor = 'orange',
        this.blockThreeBackgroundColor = 'blue';

    // A convenience constructor for creating new instances of the state class
    ReduxState.update(ReduxState oldState,
        {mainBackgroundColor, blockOneBackgroundColor, blockTwoBackgroundColor,         blockThreeBackgroundColor})
        : this.mainBackgroundColor = mainBackgroundColor ?? oldState.mainBackgroundColor,
        this.blockOneBackgroundColor = blockOneBackgroundColor ?? oldState.blockOneBackgroundColor,
        this.blockTwoBackgroundColor = blockTwoBackgroundColor ?? oldState.blockTwoBackgroundColor,
        this.blockThreeBackgroundColor = blockThreeBackgroundColor ?? oldState.blockThreeBackgroundColor;
}
```

```dart
// An action for updating each state property
class UpdateBackgroundColorAction {}

class UpdateBlockOneBackgroundColorAction {}

class UpdateBlockTwoBackgroundColorAction {}

class UpdateBlockThreeBackgroundColorAction {}
```

```dart
// A simple reducer that has a case for every action.
// Because the example is relatively contrived to keep things simple, there are other
// ways this could be done given that all the actions are pretty much the same,
// but the reducer was written more verbosely to capture the core idea.
ReduxState afterTransitionReducer(ReduxState oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return ReduxState.update(oldState, mainBackgroundColor: color);
  } else if (action is UpdateBlockOneBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return ReduxState.update(oldState, blockOneBackgroundColor: color);
  } else if (action is UpdateBlockTwoBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return ReduxState.update(oldState, blockTwoBackgroundColor: color);
  } else if (action is UpdateBlockThreeBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return ReduxState.update(oldState, blockThreeBackgroundColor: color);
  }

  return oldState;
}
```

```dart
import 'package:redux/redux.dart' as redux;
    
// Instantiate a store using the reducer and state class
redux.Store reduxStore = redux.Store<ReduxState>(afterTransitionReducer, initialState: ReduxState.defaultState());
```

<img height=400 src="./AdvancedReduxArchitecture.png" alt='Redux Architecture'>

### How is the transition process different with more stores?
__You should still only have one Redux store.__ If that doesn't sound scary, you're in good shape and everything is great! Some libraries won't have an issue with that, and in that case it's as simple as following the steps in the next section.

If having one store sounds unfeasible or raises a lot of concerns, there's more to talk about. The authors of Redux have said ([1](https://redux.js.org/api/store#a-note-for-flux-users), [2](https://stackoverflow.com/questions/33619775/redux-multiple-stores-why-not)) that more than one store is not needed, and the exceptions are related to performance and not architecture. The concession is that there are supported ways to have multiple stores, but those are to be used as a last resort and should not be part of an initial refactor attempt.

This leads to the difference in the transition process. Not only do the stores have to come together, but componentry needs to reflect that the data is coming from a single source. 

### Advanced Conversion Step by Step
> These steps are just a set that make sense for general situations and may not make sense for every library. If the path forward is unclear, they can be referred to for guidance but may need adjustment or supplemental steps.
1. __Diagram store and component relationships.__ While perhaps challenging and time consuming, creating a diagram that illustrates generally which components care about which stores could prove invaluable to planning the update process.
1. __Break the refactor into groups that includes the stateful layer and the UI layer.__ Are there small chunks of the system that can be updated without touching the messiest knots in the system? If so, identify them. If this step seems particularly challenging or reveals large roadblocks, consider an [Influx architecture](#influx-architecture)
1. __For each group, refactor all the stores.__ By doing the stores and reducers at the same time, you can completely invalidate a single store at a time. In other words, you can move all the necessary state logic into the new state class and move the state mutation logic into the reducer. Then, the entire Flux store can be deleted.

    If you have already created a state class and a reducer for an earlier store group, continue adding to the same reducer and state class. Worth noting is that these app examples use a very simplistic reducer approach, and understanding the options with reducers may be worthwhile. Because there are multiple ways to implement reducers, it is likely one will make more sense than others.
1. __Create any new action classes that are necessary.__ After refactoring a Flux store, it should be clear which actions need to be converted to Redux actions.
1. __Refactor components into connected components.__ Update the component to `UiComponent2`, removing all Flux boilerplate, and wrapping the already declared factory with the `connect` call.
1. __Move on to the next group.__ If the refactor has multiple groups of stores and components, move on to the next one.
1. __Add a `ReduxProvider` around the component tree.__ Once it makes sense, wrap the tree in the `ReduxProvider` component.

### What if the Advanced Conversion is too Daunting?
The advanced conversion might sound like a huge initiative with numerous unknowns and complexities. If that's the case the first question is whether Redux will offer the benefits to justify a large initiative. Our [OverReact Redux documentation](./over_react_redux_documentation.md) includes some of the benefits, and there are many [articles online](https://www.google.com/search?q=the+benefits+of+redux&oq=the+benefits+of+redux) that provide more examples. 

If Redux makes sense but the conversion project seems extremely challenging, we have a middleground: introducing __Influx__.

## Influx Architecture
### What is Influx?
Influx is just the term we're giving to an architecture that is both Redux and Flux at the same time. To aid in the transition from Flux to Redux, we have built some utilities to allow Flux and Connected (Redux) components to all talk to the same store. It's a transitional architecture that allows the library to be non-commital to the state management system, ultimately allowing the transition from Flux to Redux to be a much more incremental process.

### Should you implement an Influx architecture during the transition?
__tl;dr__

__If you assess your architecture and are confident you can go straight from Flux to Redux, you should not use Influx. If you are not confident, you should consider it.__

The Influx architecture is not a required part of the process, and may make your life more difficult by adding extra steps. There are both advantages and disadvantages, and assessing how large the refactor is will likely provide the largest indication of whether or not it makes sense.

### Advantages
- __You can split the effort into very tangible subtasks.__ Stores can be updated to Redux without necessarily updating the Flux components. Components reliant on multiple stores can talk to Flux stores and Redux stores at the same time. Ultimately, this means a library can pick and choose the areas that can be updated and do them one at a time.
- __Inability to update entirely to `Component2` is not a blocker.__ Since `connected` components need to be `Component2`, the Redux refactor may be blocked by those efforts. This option allows the library to update the state system to a Redux friendly architecture while [updating components to `UiComponent2`](./ui_component2_transition.md) and `connect` at the same time.
- __The workflow is much less complex.__ While heavily piggybacked off the first two advantages, it's worth noting the workflow benefits of the incremental update. There shouldn't be as many massive merges or code reviews, and the granularity of tasks should make it clearer where manual testing is needed and when tests need to be written or updated. Ultimately this reduces the project complexity and the risk of regressions.
- __The actual update process can be easier to reason about in complex scenarios.__ Influx merges Flux and Redux to provide a "halfway" point that is a fairly straightforward transition both from Flux and to Redux. For those complex scenarios, it may seem daunting to transition straight to Redux, and Influx can lower the barrier. 

### Disadvantages
- __Takes extra time as there are ultimately two refactors instead of one (however minimal the second one will be).__ While ideally the second refactor (from Influx to Redux) should be an easy lift, the middle steps still add effort that could otherwise be avoided.
- __Does not provide any performance gains until the transition is complete.__ The Redux `connected` components will update on every store update as long as Flux is in the mix. This mimics the behavior of Flux, but takes away the largest benefit of connecting to Redux.
- __Can add complexity and code to a possibly already complex state architecture.__ There are additional boilerplate and utilities necessary to maintain an Influx architecture that are completely unnecessary to Redux, making Influx more verbose and a little more confusing.

In summary, Influx adds steps to the transition process, but can make the work easier to break up.

### Important Terms
If this architecture is appealing, there are a few new classes and utilities it will be beneficial to be aware of.
- __Adapted Influx Store:__ The instance returned from wrapping an Influx store with a `FluxToReduxAdapterStore`.
- __`composeHocs`:__ If a component takes in multiple stores, it needs to be connected to all of them. This function allows you to combine multiple `connect` or `connectFlux` calls using a flat list, as opposed to nesting them inside each other.
- __`connectFlux`:__ Like [`connect`](./over_react_redux_documentation.md#connect), but for Flux stores instead of Redux stores. This is useful because it is one step closer to a Redux connected component without being Redux. If, for any reason, implementing the Redux side of Influx is presenting challenges, `connectFlux` provides a good middle ground.
- __`FluxToReduxAdapterStore`:__ This is a class that wraps an Influx store and makes it look like a Redux store. It is the cornerstone of Influx because pure Flux components will stay connected to the original store instance, but Redux components and connected Flux components (using `connectFlux`) will connect to the instatiated `FluxToReduxAdapaterStore` object. This works by passing in an Influx store instance and a Flux `Actions` instance.
- __Influx store:__ A Flux store that has implemented the `InfluxStoreMixin` and converted its internal logic (constructor, getters, overrides) to match the Influx pattern.
- __`InfluxStoreMixin`:__ A mixin that attaches to a Flux store in order to add necessary Influx utilities. Namely, the method `influxReducer` must be accessible on the Flux store class, and `influxReducer` expects the class to have a `reduxReducer` method and a `state` field. The `state` field is essentially a proxy for a Redux state class, and makes it so that state class can be built slowly over time without any need to refactor it again.
- __`ReduxMultiProvider`:__ This Component has a similar purpose as that of `composeHocs`, but for a `ReduxProvider` instead. This allows you to "provide" multiple stores via different contexts via one component invocation, as opposed to nesting multiple `ReduxProvider`s inside each other.

### Steps to an Influx Refactor
Influx has two steps to the refactor. The first is to go from Flux to Influx. This part of the process can take as long as it needs to and is meant to be an incremental transition. The next step is to go from Influx to Redux, which should be a swift refactor of stores with a light UI refactor.

#### Phase 1: Get Ready to Refactor

__Goal:__ Make a game plan for the refactor process. This phase can take as long as it needs to, but should be done in its entirety before attempting Phase 2.

1. __Diagram store and component relationships.__ Similar to the Advanced conversion, it still makes sense to understand the current state of the architecture. For Influx in particular, the focus should be on revealing what stores the specific components are reliant on. In some cases, stores may also be reliant on other stores, which should also be noted. At the end of this step, the goal is to be able to point to any component and easily understand all the stores that component relies on.
1. __Break the refactor into groups that includes the stateful layer and the UI layer.__ This will also be like Advanced conversion. The difference is that coming out of this step, stores and the UI should be broken into tangible groups to be refactored. These groups will be the core of the refactor plan. Ideally, each group should be independent enough that it can be updated without touching any other group. The groups should also be as small as possible, while also making sense, to allow for the most incremental update possible. If diagraming the library architecture (during the previous step) went well, this should be as easy as looking at the diagram and noting the groups that emerge.

#### Phase 2: Incrementally Update Stores

__Goal:__ Update all stores to be either Influx or Redux and update all components to Redux connected components. This phase can be done incrementally, and should be repeated for every store or every group of tightly coupled stores. Consequently, the steps should be read through the lens of that specific store or group of stores.

1. __Refactor relevant stores to be flat.__ State should be lifted up or broken out into their own instances so that stores are not nested. Redux holds firmly that an application should have only one store. However, while refactoring to a single store Redux architecture, Influx can have multiple stores. The rule is that stores cannot be nested.
1. __Decide which stores will be Redux and which stores will be Influx.__ An Influx implementation can have both Redux stores and Influx stores. The rules are:
    - A Redux component can talk to both a Redux store and an adapted Influx store at the same time.
    - A Flux component can talk to an Influx store and a Flux store at the same time.
    - A `connectFlux` component can talk to an adapted Influx store.

    The result of these rules is that a store can be converted directly to Redux [iff](https://en.wikipedia.org/wiki/If_and_only_if) it will be used exclusively by Redux components, but a component can be converted to a Redux component if it will pull data from either an adapted Influx store or a traditional Flux store.

    If the stores are not overly complex and all of the related UI can be updated to Redux connected components (extending from `UiComponent2`), then going straight to Redux may be a good option.

    If, given the size of the store or number of components affected, this is not ideal, the store should be converted to Influx. 
1. __Refactor the store.__ 
    If the store is moving to Redux, follow the [simple store conversion](#basic-conversion-step-by-step). If the store is moving to Influx:
    1. __Create the Redux actions.__ Any actions that the connected UI components will need access to should be made into a Redux action.
    1. __Create a Redux state class for the store.__ Any state that is mutated by the Redux actions should be present in the Redux state class.
    1. __Create the Redux reducer for the store.__ This should just combine the actions and the Redux state class - any action should have a condition within the reducer, and ultimately all fields on the state store should have a way to be updated.
    1. __Convert the Flux store to an Influx store:__
        1. __Add the `InfluxStoreMixin` to the original Flux store.__ This is what makes it an "Influx" store, and adds the fields required by an Influx architecture. The model for `state` field is the Redux state class created earlier, and it should be passed into the mixin's typing.
        1. __Initialize the default Redux state in the Influx contructor.__ 
        1. __Refactor actions passed into `triggerOnActionV2`.__ Like a Flux store, the Influx store will watch for Flux actions to be triggered. Instead of triggering a function that mutates the inner state however, a callback should pass a corresponding Redux action instance into `this.influxReducer`.
        1. __Override the `reduxReducer` getter on the class.__ The `reduxReducer` getter should point to the Redux reducer function created earlier.
        1. __Update the store fields.__ The end result of this step is that the Influx store (previously the Flux store) should have a getter for every Redux state class field. The getters should point to corresponding values on the `state` field. 
        
        Updating getters isn't necessary as the correct fields should be accessible via `influxStoreInstance.state.reduxProperty`, but refactoring the getters means that any Flux components pointing to this store do not need to be refactored. If it is preferable just to remove getters in favor of accessing the `state` fields directly, any original getters or fields that correspond to a value moved to the Redux state class should be removed.

        ```dart
        import 'package:over_react/over_react_redux.dart';
        import 'package:w_flux/w_flux.dart' as flux;

        // An Influx Store
        // Add the `InfluxStoreMixin` and use the Redux state class for the generic typing.
        class ExampleInfluxStore extends flux.Store with InfluxStoreMixin<ReduxStateClass> {
            ExampleFluxActions _actions;

            // Point the `reduxReducer` getter at the Redux stete's reducer.
            @override
            get reduxReducer => lowLevelReduxReducer;

            /// Use getters to point to state properties.
            String get backgroundColor => state.backgroundColor;

            ExampleInfluxStore(this._actions) {
                state = ReduxStateClass.defaultState();
                triggerOnActionV2(_actions.exampleFluxAction, 
                    (_) => this.influxReducer(ExampleReduxAction()));
            }
        }

        class ExampleReduxAction {}

        class ExampleFluxActions {
            final flux.Action<String> exampleFluxAction = flux.Action();
        }
        ```
1. __Add adapter stores where necessary.__ Each store that will be Influx should be wrapped with a `FluxToReduxAdapterStore` to give Flux and Connected Flux access as well. In other words, if the store was updated to Redux directly or will only talk to Redux components, this step can be skipped.
    
    `FluxToReduxAdapterStore` takes in an Influx store and an actions instance. It should also receive the Influx store class and the Redux state class as generics.
    ``` dart
    FluxToReduxAdapterStore influxAdapterStore =
        FluxToReduxAdapterStore<ExampleInfluxStore, ReduxStateClass>(exampleInfluxStoreInstance, exampleFluxActionsInstance);
    ```
1. __Create `Context` instances for the necessary stores.__ If a component will use multiple stores, a `Context` instance is required. The [OverReact Redux docs](./over_react_redux_documentation.md) have examples of having multiple stores, which describes the fundamentals of why this is necessary. In the end, it is most likely that the majority of `FluxToReduxAdapterStore` instances will need a `Context` instance. 
1. __Wrap the component tree in a either a `ReduxProvider` or a `ReduxMultiProvider`.__ If there are multiple stores, a `ReduxMultiProvider` is more elegant and is encouraged. The store instances passed in should be the `FluxToReduxAdapterStore` instances, not the normal Flux store instances.
1. __Refactor components.__ See the specific component type below for a reminder on which store instance is correct and any "gotchas" in the refactor. In general, remember that if a component talks to multiple stores, `composeHocs` can be used to simplify the connected factory declarations.
    - __A Flux component__ will operate exactly the same way. 
        - Pass in the Influx store instance as a prop (which should already be done). Not the `FluxToReduxAdapterStore` instance, but _the same Influx store instance_ used to istantiate the `FluxToReduxAdapterStore` object. 
        - The actions prop should also be _the same action class instance_ passed into the `FluxToReduxAdapterStore` constructor. 
    - __A Redux component__ will use the `connect` function. 
        - The `pure` parameter on `connect` should be set to `false`, or else it will not receive regular updates. 
        - If the component tree was wrapped in a `ReduxMultiProvider`, the `context` parameter should also be set to the relevant store context.
    - __A Connected Flux component__ is essentially the same as a Redux component.
        - The only exception is thate `mapDispatchToProps` (Redux `connect` parameter) is `mapActionsToProps` for a Connected Flux component.
1. __Continue this process of refactoring stores and components__ until most components are Redux components.

#### Phase 3: Influx to Redux

__Goal:__ Remove any Influx stores and combine the Redux stores.

1. __Remove the Influx stores.__ Because each store should be backed completely by a Redux state class, one should be able to completely delete the Influx store.
1. __Remove the Flux actions class.__
1. __Combine the Redux Stores.__ Redux holds strongly that an application should have a single store as the source of truth. A store can be a complex class with properties that are essentially their own state model, but they should live within a single class. If this is not possible, multiple stores can be used but it is highly discouraged.

    ```dart
    // Before combining
    class FirstStateClass {
        var field1;
        var field2;
    }

    class SecondStateClass {
        var field3;
        var field4;
    }

    // Possible refactor options
    class WrapperStateClass {
        FirstStateClass firstState;
        SecondStateClass secondState;
    }

    class FlattenedStateClass {
        var field1;
        var field2;
        var field3;
        var field4;
    }
    ```
1. __Instantiate the Redux stores.__ `FluxToReduxAdapterStore` instances can be removed during this step and just switched out with Redux store instantiations.
    ```dart
    redux.Store reduxStore = redux.Store<ReduxState>(reduxReducer, initialState: ReduxState.defaultState());
    ```
1. __Update context instances.__ If, after combining the stores, there is only a single store instance, all context instances can be removed. This is the best practice and it is rare that context will need to be used. If there are multiple stores, a context instance will be necessary for each store.
1. __Refactor UI.__ Generally static analysis should indicate the majority of things that need to be fixed after refactoring the store architecture, but the following are the cases that the analyzer will be catching:
    - (Ideally) Remove any `combineHocs` and `ReduxMultiProvider` calls. These should be switched out for simple `ReduxProvier` and `connect` calls. If you are using multiple stores however, they may still be useful in some cases, but it is likely there will still be some cleanup involved.
    - Refactor any `state` references. How extensive this is depends on the new store architecture and how closely it matches the Influx architecture, but it is extremely likely that fields got moved and now components are looking for state in the wrong place.
    - Update any `connectFlux` to `connect`. Up until Phase 3, `connectFlux` components would have functioned without an issue, but they now need to be moved over entirely to `connect`. 

Woohoo! Your library should now be updated to Redux!!
