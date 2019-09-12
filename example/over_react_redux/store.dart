import 'package:redux/redux.dart';
import 'package:over_react/over_react.dart';

var someContext = createContext('test');
/////////////////////////////// SHARED ///////////////////////////////
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
Store store1 = Store<CounterState>(counterStateReducer, initialState: CounterState(count: 1));

class CounterState {
  final int count;
  final String name;
  CounterState({
    this.count,
    this.name = "Counter",
  });
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
