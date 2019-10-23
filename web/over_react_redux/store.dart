import 'package:redux/redux.dart';
import 'package:over_react/over_react.dart';

/////////////////////////////// SHARED ///////////////////////////////

/// An action class can be created to add typing to the actions passed into dispatch.
///
/// While it makes life easier, this practice is optional as all as the reducer receives
/// a valid type and value parameter.
class Action {
  Action({this.type, this.value});

  final String type;
  final dynamic value;

  toJson() {
    return {'value': this.value};
  }
}

// Actions to be passed into dispatch().
class IncrementAction extends Action {
  IncrementAction([value]):super(type: 'INCREMENT', value:value);
}

class DecrementAction extends Action {
  DecrementAction([value]):super(type: 'DECREMENT', value:value);
}

/////////////////////////////// STORE 1 "Counter" ///////////////////////////////

/// The store the combines the reducer and default state of.
Store store1 = Store<CounterState>(smallCountReducer, initialState: CounterState.defaultState());

/// The store state class with the properties that make up the entire store.
class CounterState {
  final int count;
  final String name;

  CounterState({
    this.count,
    this.name = "Counter",
  });

  /// A default state constructor.
  ///
  /// This is optional and is just useful for creating the initial state or
  /// resetting the state to default (if you ever need to).
  CounterState.defaultState({this.count = 1, this.name = "Counter"});

  /// Used for syntactically simple updates within the reducer.
  ///
  /// Because Redux is pure and does not allow state mutations, a constructor
  /// that defaults to setting properties to the old state allows for DRYer code
  /// in the reducers.
  CounterState.updateState(CounterState oldState, {int count, String name})
      : this.count = count ?? oldState.count,
        this.name = name ?? oldState.name;
}


/// The reducer used to update the store.
///
/// This can be a switch, if, or use [combineReducers] as seen below.
CounterState smallCountReducer(CounterState oldState, dynamic action) {
  if (action is DecrementAction) {
    return CounterState.updateState(oldState, count: oldState.count - 1);
  } else if (action is IncrementAction) {
    return CounterState.updateState(oldState, count: oldState.count + 1);
  } else {
    return oldState;
  }
}

/////////////////////////////// STORE 2 "BigCounter" ///////////////////////////////

/// A new context that is used to differentiate the second store from the first.
///
/// An application can have multiple stores by using the React 16 [Context] API.
final bigCounterContext = createContext();

/// The second store.
Store store2 = Store<BigCounterState>(bigCounterStateReducer, initialState: BigCounterState(bigCount: 100));

/// A simplistic store state object.
class BigCounterState {
  final int bigCount;
  final String name;
  BigCounterState({
    this.bigCount,
    this.name = "BigCounter",
  });
}

/// Reducers for the store that combined via [combineReducers].
int _bigCounterDecrementReducer(int currentCount, DecrementAction action) {
  return currentCount - (action?.value ?? 100);
}

int _bigCounterIncrementReducer(int currentCount, IncrementAction action) {
  return currentCount + (action?.value ?? 100);
}

final bigCounterActionsReducer = combineReducers<int>([
  TypedReducer<int, IncrementAction>(_bigCounterIncrementReducer),
  TypedReducer<int, DecrementAction>(_bigCounterDecrementReducer),
]);

/// The reducer, that composed of the smaller more specific reducers, that
/// returns the store state.
BigCounterState bigCounterStateReducer(BigCounterState state, action) => BigCounterState(
  bigCount: bigCounterActionsReducer(state.bigCount, action),
);
