# built_redux to OverReact Redux
> A document explaining the fundamentals of transitioning a [built_redux](https://github.com/davidmarne/built_redux) architecture to an OverReact Redux (aka just "Redux") architecture.
>
> NOTE: Before attempting to transition, make sure you understand the content from the general [Redux Documentation](https://github.com/johnpryan/redux.dart) and the [OverReact Redux Documentation](./over_react_redux_documentation.md). This guide covers differences between built_redux and Redux but does not try to comprehensively describe Redux.
---
* __[Goal](#goal)__
* __[Do I have to transition?](#do-i-have-to-transition-to-redux)__
* __[Reducer Builders and Combine Reducers](#reducer-builders-and-combine-reducers)__
* __[Converting SubState to mapStateToProps](#converting-substate-to-mapStateToProps)__
* __[Comparing the Two Systems](#comparing-the-two-systems)__
    * [Actions](#actions)
        * [Actions Comparison](#actions-comparison)
        * [Actions Refactor](#actions-refactor)
    * [Built Value](#built-value)
        * [Built Value vs Store Model](#built-value-vs-store-model)
        * [Built Value Refactor](#built-value-refactor)
    * [Reducers](#reducers)
        * [Reducers Comparison](#reducers-comparison)
        * [Reducer Refactor](#reducer-refactor)
    * [Store](#store)
    * [UI](#ui)
        * [Component Comparison](#component-comparison)
        * [UI Refactor](#ui-refactor)

## Goal
The goal of this document is explain major elements of transitioning from built_redux to Redux. This comparison is fairly direct, so the guide mainly focuses on the difference between specific entities of interest (actions, reducers, stores, components) with guidance on how to convert from one library to the other.

If, through this process, the document or examples miss any edge cases you encounter, please create an issue or reach out so it can be added.

## Do I have to transition to Redux?
No. OverReact Redux is meant to help to provide a recommended state management method for OverReact components, as well as provide benefits over [w_flux](https://github.com/workiva/w_flux) and [built_redux](https://github.com/davidmarne/built_redux). Those benefits may provide enough reason to make a refactor worthwhile. If, after evaluating the benefits and effort, the juice doesn't seem worth the squeeze, then no need to worry about it!

To evaluate if the refactor is worth it, the details of OverReact Redux can be found in the [OverReact Redux documentation](./over_react_redux_documentation.md). That document paired with this guide will illustrate the full scope of costs and benefits.

## Reducer Builders and Combine Reducers
built_redux uses the concept of `ReducerBuilder` to compose small reducers into a larger more complex reducer, while hiding the complexity. Redux has a similar tool - `combineReducers`. The snippet below illustrates a possible conversion from `ReducerBuilder` to `combineReducers`.
> For more  information, see the [combineReducers](https://github.com/johnpryan/redux.dart/blob/master/doc/combine_reducers.md) docs.

```dart
// Using `ReducerBuilder`
final reducerBuilder = ReducerBuilder<Counter, CounterBuilder>()
  ..add(CounterActionsNames.increment, increment)
  ..add(CounterActionsNames.decrement, decrement);

final store = Store<Counter, CounterBuilder, CounterActions>(
  reducerBuilder.build(),
  Counter(),
  CounterActions(),
);

// Using `combineReducers`
final incrementReducer = (ReduxState prevState, IncrementAction action) => 
    ReduxState.from(count: prevState.count + action.incrementBy);
final decrementReducer = (ReduxState prevState, DecrementAction action) => 
    ReduxState.from(count: prevState.count - action.decrementBy);

Reducer<ReduxState> countReducer = combineReducers([
  TypedReducer<ReduxState, IncremementAction>(incrementReducer),
  TypedReducer<ReduxState, DecrementAction>(decrementReducer),
]);

final store = Store<ReduxState>(countReducer, initialState: ReduxState.defaultState());
```

## Converting Substate to mapStateToProps
If you are using `BuiltReduxUiComponent` as your component's base class, you should have a `Substate` class that acts as the model for the data your component receives. This allows your component to only receive the pieces of state it needs to function.

This model fits perfectly with Redux because the premise is that a component should only be receiving pieces of state that it will make use of. Instead of a `Substate` class however, this is done by utilizing the `mapStateToProps` parameter of `connect`. When converting from built_redux to Redux, the `Substate` class properties can just be converted to props. Then, in `mapStateToProps`, the value of those props are tied to the app state and utilized within the component as props.

```dart
// Starting Props Class
// It's normal that the props class has few, if any, props because they values are coming from the substate
class _$ExampleComponentProps extends BuiltReduxUiProps<AppState, AppStateBuilder, AppActions> {}

// The starting substate
abstract class ExampleComponentState implements Built<AppSubstate, AppSubstateBuilder> {
  factory SimpleSubstate({String text}) => _$SimpleSubstate._(text: text);
  SimpleSubstate._();

  // The state field being pulled from the store is `text`
  String get text;
}

// After refactor
// connect call
UiFactory<ExampleComponentProps> ConnectedExampleComponent = connect<AppState, ExampleComponentProps>(
    // The `text` prop points to the `text` state field
    mapStateToProps: (state) => (ExampleComponent()..text = state.text),
)(ExampleComponent);

// Redux Props Class (e.g. a normal props class)
mixin ExampleComponentProps on UiProps {
  String text;
}
```

## Comparing the Two Systems
built_redux and OverReact Redux are comprised of the same main entities. Moving from built_redux to Redux then is just a matter of refactoring each relevant entity, along with the related UI. Note again that this document does not attempt to explain _how_ Redux works, and if any of the Redux implementation details aren't quite clear, check out the [Redux Documentation](https://github.com/johnpryan/redux.dart) and the [OverReact Redux Documentation](./over_react_redux_documentation.md).

### Actions

#### Actions Comparison
- built_redux actions:
    - are grouped in a single class (that extends Redux actions).
    - are dispatched directly via instantiation (e.g. `store.actions.increment()`).
    - have generated boilerplate.
- Redux actions:
    - typically "stand alone". In other words, they do not subclass a standard `ReduxActions` class.
    - are dispatched via passing an instatiated action instance into `store.dispatch`.
    - are typically very simple classes, sometimes carying data related to the action they are meant to trigger.

#### Actions Refactor
This refactor is really straightforward and should be close to a 1 to 1 transition. Outside of just breaking actions out into their own class, the main opportunity to re-use code is if an action's payload is a custom class. In that case, the custom class may be able to become its own action by simply renaming it. See the snippet below for an example:

```dart
// built_redux actions
abstract class CounterActions extends ReduxActions {
  ActionDispatcher<int> get increment;
  ActionDispatcher<int> get decrement;
  ActionDispatcher<CustomData> get customAction;
  ActionDispatcher<null> get simpleAction;
    
  CounterActions._();
  factory CounterActions() => new _$CounterActions();
}

class CustomData {
  var property1;
  var property2;

  CustomData(this.property1, this.property2);
}

// Redux actions
class IncrementAction {
  int incrementBy;

  IncrementAction(this.incrementBy);
}

class DecrementAction {
  int decrementBy;

  DecrementAction(this.incrementBy);
}

// Note that the `CustomData` class was just renamed and is now a Redux action class
class CustomAction {
  String property1;
  String property2;

  CustomData(this.property1, this.property2);
}

// Note that Redux actions without data don't need anything other than a simple declaration
class SimpleAction {}
```

### Built Value
The built_redux built value class is synonymous to Redux's store model or state class - they both represent a data model that the app state should pull from. The main difference is the terminology and generated aspect of a built value.

#### Built Value vs Store Model
- Built Value
    - implements the `Built` class.
    - holds all app state.
    - exposes getters for state values (setters are created by the builder).
    - can only be constructed via factory.
- Store Model
    - does not have to inherit from any parent class.
    - holds all app state.
    - exposes getters and setters for the state values.
    - can have multiple construction methods.

#### Built Value Refactor
Similar to Actions, this switch is extremely straight forward, and step by step instruction would likely be overkill. Instead, compare the differences in the code snippet below:

```dart
// built value class
abstract class Counter implements Built<Counter, CounterBuilder> {
  int get count;
  String get customActionValue;
  String get secondCustomActionValue;
  bool get simpleActionState;

  Counter._();
  factory Counter() => 
      _$Counter._(count: 0, customActionValue: '', secondCustomActionValue: '', simpleActionState: false);
}

// Redux state model
class ReduxState {
  // Declare the state fields as normal properties
  int count;
  String customActionValue;
  String secondCustomActionValue;
  bool simpleActionState;
  
  // Optionally create constructors for different scenarios
  
  // A constructor to grab the default state of the app
  ReduxState.defaultState() 
      : this.count = 0, this.customActionValue = '', this.secondCustomActionValue = '', this.simpleActionState = false;
  
  // A constructor that makes it easier to create new state models, updating only specific fields
  ReduxState.from(prevState, {
      int count, 
      String customActionValue,
      String secondCustomActionValue, 
      bool simpleActionState
  }) : this.count = count ?? prevState.count, 
      this.customActionValue = customActionValue ?? prevState.customActionValue,
      this.secondCustomActionValue = secondCustomActionValue ?? prevState.customActionValue,
      this.simpleActionState = simpleActionState ?? prevState.simpleActionState;
}
```

### Reducers

#### Reducers Comparison
- built_redux reducers:
    - are impure and mutate the `AppBuilder` instance.
    - take in the `AppBuilder` parameter.
    - are `void`.
    - look at the `action.name` property to determine the action type.
- Redux reducers:
    - are pure and should not mutate anything outside the scope of the reducer.
    - only have two parameters (the previous state and the action).
    - are not void - they return an instance of the store data model.
    - can use action class typing (e.g. using `is`) to detect action type.

#### Reducer Refactor
Reducers can get fairly complex and have lots of variations based on the architecture of the app. This refactor will show the most simplistic and direct way to refactor, but the OverReact Redux examples (in /web/over_react_redux/examples) have different implementation methods.
1. Add the typing for the state class. This will occur at:
    - the return type
    - the previous state parameter
1. Update the action parameter typing. This will either be `dynamic` or a parent class of all actions.
1. Remove the `AppBuilder` parameter.
1. Switch the action checks to look for the new Redux actions.
1. Update the mutation logic to create and modify a new instance of the state model.
1. Return that new state model.

```dart
// This example will use the actions from the Actions section of this doc

// built_redux reducer
void counterReducer(App prevState, Action<dynamic> action, AppBuilder builder) {
  if (action.name == AppActionsNames.increment.name)
    builder.count += action.payload as int;
  else if (action.name == AppActionsNames.decrement.name)
    builder.count -= action.payload as int;
  else if (action.name == AppActionsNames.customAction.name) {
    builder.customActionValue = action.payload.property1 as String;
    builder.secondCustomActionValue = action.payload.property2 as String;
  } else if (action.name == AppActionsNames.simpleAction.name)
    builder.simpleActionState = !prevState.simpleActionState;
}

// Redux reducer
ReduxState counterReducer(ReduxState prevState, dynamic action) {
  if (action is IncremementAction) {
    // Note the use of one of the constructors created in the built value refactor section
    return ReduxState.from(prevState, count: prevState.count + action.incrementBy);
  } else if (action is DecrementAction) {
    return ReduxState.from(prevState, count: prevState.count - action.decrementBy);
  } else if (action is CustomAction) {
    return ReduxState.from(prevState, customActionValue: action.property1, secondCustomActionValue: action.property2);
  } else if (action is SimpleAction) {
    return ReduxState.from(prevState, simpleActionState: !prevState.simpleActionState);
  }

  return prevState;
}
```

### Store
All that needs to be done here is switch out a line of code:
```dart
// built_redux store
final store = Store<Counter, CounterBuilder, CounterActions>(
  reducerBuilder.build(),
  Counter(),
  CounterActions(),
);

// Redux store
final store = Store<ReduxState>(counterReducer, initialState: ReduxState.defaultState());
```

### UI
Once all of the state pieces have been updated, the UiComponents are ready to be wrapped with `connect`. Another reminder that this doc will identify differences between built_redux and Redux, not dig into how `connect` works - see the general [Redux docs](./over_react_redux_documentation.md) for that.

#### Component Comparison
- built_redux components:
    - are standard UiComponents, this includes `UiComponent` and `UiComponent2`.
    - take in the `store` as an explicitly declared prop.
    - manage subscriptions to the store's stream.
    - listen to that stream for updates.
- Redux components:
    - are UiComponent2 factories wrapped in `connect`.
    - have no need to listen to streams or manage redrawing.
    - typically access store data by utilizing `mapStateToProps`.
    - trigger actions by using `mapDispatchToProps` or utilizing `props.dispatch`.

#### UI Refactor
- Wrap your tree in a `ReduxProvider`. All of your connected components need to be wrapped by a `ReduxProvider`. Usually this means that in your `react_dom.render()`, one of your first HOCs will be a `ReduxProvider` that takes in your Redux `Store` instance for its `store` prop.
    ```dart
    import 'dart:html';

    import 'package:react/react_client.dart';
    import 'package:react/react_dom.dart' as react_dom;
    import 'package:over_react/over_react_redux.dart';

    import './store.dart';
    import './components/component.dart';

    main() {
        react_dom.render(
            (ReduxProvider()..store = randomColorStore)(
                ConnectedComponent()(),
            ),
            querySelector('#content'));
    }
    ```
- Remove instances where the `Store` gets passed down the component tree.
- General Component Refactor (to be done to every component):
    - Starting with a `BuiltReduxUiComponent`:
        1. Upgrade the component to `UiComponent2`.
            - Generally this also means removing the built_redux stuff, including ensuring that the component prop class is a mixin on `UiProps`.
            - Check out the `UiComponent2` [transition guide](./ui_component2_transition.md) for pointers on going from `UiComponent` (which is what `BuiltReduxUiComponent` is backed by) to `UiComponent2`. If a component has overridden lifecycle methods that are removed, this will likely be the hardest part of the upgrade.
        1. Move your `Substate` class values into your component's props class. Using the `mapStateToProps` parameter of Redux's `connect` function is very similar to declaring a `Substate` class, and the properties from your `Substate` class can just be moved into props. Make sure at the end of this step that all references to the state in your component have a prop declared in the props class.
        
            > See the [Converting Substate to mapStateToProps](#converting-substate-to-mapStateToProps) section for more information.
        1. Continue on to the __In Either Case__ bullet below.
    - Starting with a standard `UiComponent` or `UiComponent2`:
        1. Make sure the component is `UiComponent2`.
        1. Remove any stream stuff. No more streams! :)
        1. Add a prop for all of the state values being used.
        1. Continue on to the __In Either Case__ bullet below.
    - In Either Case:
        1. Refactor the references to `store.stateValue` or `connectedState.stateValue` to `props.stateValue`. 
        1. (If you need actions) Decide if you're going to use `mapDispatchToProps` or `props.dispatch`.
            - If you are going to use `mapDispatchToProps`, create a prop for all of the actions this component uses.
            - If you are going to use `props.dispatch`, add the `ConnectPropsMixin` to the component's `props` class.
        1. (If you need actions) Replace built_redux actions with Redux actions. 
            - With `mapDispatchToProps`:
                - before: `props.store.actions.specificAction` 
                - after: `props.propCreatedInPreviousStep`
            - With `props.dispatch`:
                - before: `props.store.actions.specificAction`
                - after: `props.dispatch(SpecificAction())`
        1. Add `connect`.
            1. Declare a new `UiFactory` variable and set it equal to the value of `connect`. Connect will wrap your original, already created component factory.
            1. Using `mapStateToProps` to pass the state you need into the props you created earlier.
            1. If using `mapDispatchToProps`, set the action props declared earlier equal to a callback that dispatches the corresponding event.

        ```dart
        // Simple built_redux component
        // Assume there is a store with a state field `text` and an action `updateText`.
        UiFactory<SimpleProps> Simple = _$Simple;

        mixin SimpleProps on UiProps {
          Store<App, AppBuilder, AppActions> store;
        }

        class SimpleComponent extends UiComponent2<SimpleProps> {
          StreamSubscription _storeSub;

          @override
          componentDidMount() {
            _storeSub = props.store.stream.listen(_redraw);
          }

          _redraw(_) => forceUpdate();

          @override
          componentWillUnmount() {
            super.componentWillUnmount();
            _storeSub.cancel();
          }

          @override
          render() {
            return (
              Fragment()(
                // Assume there is a function `randomString` that generates random text
                (Dom.button()..onClick = props.store.actions.updateText(randomString()))('Change Text'),
                (Dom.div())(props.store.text)
               ) 
            );
          }
        }

        // Simple BuiltReduxUiComponent
        // Assume there is a store with a state field `text` and an action `updateText`.
        UiFactory<SimpleProps> Simple = _$Simple;

        mixin SimplePropsMixin on UiProps {}
  
        class SimpleProps = BuiltReduxUiProps<SimpleState, SimpleStateBuilder, SimpleActions> with SimplePropsMixin;

        class SimpleComponent extends BuiltReduxUiComponent<SimpleState, SimpleStateBuilder, SimpleActions,
            SimpleProps, SimpleSubState> {
          StreamSubscription _storeSub;

          @override
          SimpleSubState connect(SimpleState state) => SimpleSubState(text: state.text);

          @override
          bool get isPure => true;

          @override
          render() {
            return (
              Fragment()(
                // Assume there is a function `randomString` that generates random text
                (Dom.button()..onClick = props.actions.updateText(randomString()))('Change Text'),
                (Dom.div())(props.store.text)
              )   
            );
          }
        }

        abstract class SimpleSubstate implements Built<SimpleSubstate, SimpleSubstateBuilder> {
          factory SimpleSubstate({String text}) => _$SimpleSubstate._(text: text);
      
          SimpleSubstate._();

          String get text;
        }

        // The same component converted to a connected Redux component
        UiFactory<SimpleProps> ConnectedSimple = connect<ReduxState, SimpleProps>(
            mapStateToProps: (state) => (Simple()..text = state.text),
            mapDispatchToProps: (dispatch) => (Simple()..updateText = (Sring text) { dispatch(UpdateText()); }),
        )(Simple);

        UiFactory<SimpleProps> Simple = _$Simple;

        mixin SimpleProps on UiProps {
          String text;
          void Function(String newText) updateText;
        }

        @Component2()
        class SimpleComponent extends UiComponent2<SimpleProps> {
          @override
          render() {
            return (
              Fragment()(
                // Assume there is a function `randomString` that generates random text
                (Dom.button()..onClick = props.updateText(randomString()))('Change Text'),
                (Dom.div())(props.text),
              )   
            );
          }
        }
        ```
