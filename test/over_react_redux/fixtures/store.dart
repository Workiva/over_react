import 'package:redux/redux.dart';

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

class ResetAction extends Action {
  ResetAction():super(type: 'RESET');
}

int initialValue = 0;

int _resetCounterReducer(int currentCount, ResetAction action){
  return initialValue;
}

/////////////////////////////// STORE 1 "Counter" ///////////////////////////////
Store store1 = new Store<CounterState>(counterStateReducer, initialState: new CounterState(count: initialValue));

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
  new TypedReducer<int, ResetAction>(_resetCounterReducer),
]);

CounterState counterStateReducer(CounterState state, action) => new CounterState(
  count: counterActionsReducer(state.count, action),
);

/////////////////////////////// STORE 2 "BigCounter" ///////////////////////////////
Store store2 = new Store<BigCounterState>(bigCounterStateReducer, initialState: new BigCounterState(bigCount: initialValue));

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
  new TypedReducer<int, ResetAction>(_resetCounterReducer),
]);

BigCounterState bigCounterStateReducer(BigCounterState state, action) => new BigCounterState(
  bigCount: bigCounterActionsReducer(state.bigCount, action),
);

