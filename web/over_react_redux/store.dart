import 'package:redux/redux.dart';
import 'package:over_react/over_react.dart';

// Imports for DevTools
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

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

// This is the a normal store with no devtools
 Store store1 = Store<CounterState>(counterStateReducer, initialState: CounterState(count: 1));

// The is a store connected to the devtools
//Store store1 = DevToolsStore<CounterState>(counterStateReducer, initialState: CounterState(count: 1), middleware: [remoteDevtools]);


// Variables to spin up the devtools
//var remoteDevtools = RemoteDevToolsMiddleware('127.0.0.1:8000');
//
//Future initDevtools() async {
//  remoteDevtools.store = store1;
//  return remoteDevtools.connect();
//}

/// The application state class.
class CounterState {
  final int count;
  final String name;

  CounterState({
    this.count,
    this.name = "Counter",
  });

  /// Used for syntactically simple updates within the reducer.
  ///
  /// Because Redux is pure and does not allow state mutations,
  CounterState.updateState(CounterState oldState, {int count, String name})
      : this.count = count ?? oldState.count,
        this.name = name ?? oldState.name;

}

int _counterDecrementReducer(int currentCount, DecrementAction action) {
  return currentCount - (action?.value ?? 1);
}

int _counterIncrementReducer(int currentCount, IncrementAction action) {
  return currentCount + (action?.value ?? 1);
}

final counterActionsReducer = combineReducers<int>([
  TypedReducer<int, IncrementAction>(_counterIncrementReducer),
  TypedReducer<int, DecrementAction>(_counterDecrementReducer),
]);

CounterState counterStateReducer(CounterState state, action) => CounterState(
  count: counterActionsReducer(state.count, action),
);

/////////////////////////////// STORE 2 "BigCounter" ///////////////////////////////
final bigCounterContext = createContext();

Store store2 = Store<BigCounterState>(bigCounterStateReducer, initialState:  BigCounterState(bigCount: 100));

class BigCounterState {
  final int bigCount;
  final String name;
  BigCounterState({
    this.bigCount,
    this.name = "BigCounter",
  });
}

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

BigCounterState bigCounterStateReducer(BigCounterState state, action) => BigCounterState(
  bigCount: bigCounterActionsReducer(state.bigCount, action),
);
