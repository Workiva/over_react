import 'package:redux/redux.dart';
import 'package:over_react/over_react.dart';
// General
Context bigCounterContext = createContext();

class Action {
  Action({this.type, this.value});

  final String type;
  final dynamic value;

  toJson() {
    return {'value': this.value};
  }
}

class IncrementAction extends Action {
  IncrementAction([value]):super(type: 'INCREMENT', value:value);
}

class DecrementAction extends Action {
  DecrementAction([value]):super(type: 'DECREMENT', value:value);
}


/////////////////////////////// STORE 1 "Counter" ///////////////////////////////
Store store1 = new Store<CounterState>(counterStateReducer, initialState: new CounterState(count: 0));

class CounterState {
  final int count;
  final String name;
  CounterState({
    this.count,
    this.name = "Counter",
  });
}

int _counterDecrementReducer(int currentCount, DecrementAction action) {
  return currentCount - (action?.value != null ? action.value : 1);
}

int _counterIncrementReducer(int currentCount, IncrementAction action) {
  return currentCount + (action?.value != null ? action.value : 1);
}

Reducer<int> counterActionsReducer = combineReducers<int>([
  new TypedReducer<int, IncrementAction>(_counterIncrementReducer),
  new TypedReducer<int, DecrementAction>(_counterDecrementReducer),
]);

CounterState counterStateReducer(CounterState state, action) => new CounterState(
  count: counterActionsReducer(state.count, action),
);

/////////////////////////////// STORE 2 "BigCounter" ///////////////////////////////
Store store2 = new Store<BigCounterState>(bigCounterStateReducer, initialState: new BigCounterState(bigCount: 100));

class BigCounterState {
  final int bigCount;
  final String name;
  BigCounterState({
    this.bigCount,
    this.name = "BigCounter",
  });
}

int _bigCounterDecrementReducer(int currentCount, DecrementAction action) {
  return currentCount - (action?.value != null ? action.value : 100);
}

int _bigCounterIncrementReducer(int currentCount, IncrementAction action) {
  return currentCount + (action?.value != null ? action.value : 100);
}

Reducer<int> bigCounterActionsReducer = combineReducers<int>([
  new TypedReducer<int, IncrementAction>(_bigCounterIncrementReducer),
  new TypedReducer<int, DecrementAction>(_bigCounterDecrementReducer),
]);

BigCounterState bigCounterStateReducer(BigCounterState state, action) => new BigCounterState(
  bigCount: bigCounterActionsReducer(state.bigCount, action),
);
