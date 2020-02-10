import 'package:redux/redux.dart';
import 'package:w_flux/w_flux.dart' as flux;
import 'package:over_react/over_react_flux.dart';

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
  ResetAction():super(type: 'RESET') {
   print('initializing');
  }
}

int initialValue = 0;

int _resetCounterReducer(int currentCount, ResetAction action){
  print('resetting');
  return initialValue;
}

class FluxActions {
  final flux.Action<int> incrementAction = flux.Action();
  final flux.Action<int> decrementAction = flux.Action();
  final flux.Action resetAction = flux.Action();
}

class FluxStore extends flux.Store with InfluxStoreMixin<CounterState> {
  FluxActions _actions;

  @override
  get reduxReducer => counterStateReducer;

  int get count => state.count;
  String get name => state.name;

  FluxStore(this._actions) {
    state = CounterState(count: initialValue);

    triggerOnActionV2(_actions.incrementAction, (count) => this.influxReducer(IncrementAction(count)));
    triggerOnActionV2(_actions.decrementAction, (count) => this.influxReducer(DecrementAction(count)));
    triggerOnActionV2(_actions.resetAction, (_) => this.influxReducer(ResetAction()));
  }
}

/////////////////////////////// STORE 1 "Counter" ///////////////////////////////
class CounterState {
  final int count;
  final String name;
  CounterState({
    this.count,
    this.name = 'Counter',
  });
}

int _counterDecrementReducer(int currentCount, DecrementAction action) {
  return currentCount - (action?.value != null ? action.value : 1);
}

int _counterIncrementReducer(int currentCount, IncrementAction action) {
  return currentCount + (action?.value != null ? action.value : 1);
}

Reducer<int> counterActionsReducer = combineReducers<int>([
  TypedReducer<int, IncrementAction>(_counterIncrementReducer),
  TypedReducer<int, DecrementAction>(_counterDecrementReducer),
  TypedReducer<int, ResetAction>(_resetCounterReducer),
]);

CounterState counterStateReducer(CounterState state, action) => CounterState(
  count: counterActionsReducer(state.count, action),
);

FluxActions fluxActions = FluxActions();
FluxStore fluxStore = FluxStore(fluxActions);
FluxToReduxAdapterStore store1 = FluxToReduxAdapterStore(fluxStore, fluxActions);

/////////////////////////////// STORE 2 "BigCounter" ///////////////////////////////
class FluxStore2 extends flux.Store with InfluxStoreMixin<BigCounterState> {
  FluxActions _actions;

  @override
  get reduxReducer => bigCounterStateReducer;

  int get count => state.bigCount;
  String get name => state.name;

  FluxStore2(this._actions) {
    state = BigCounterState(bigCount: initialValue);

    triggerOnActionV2(_actions.incrementAction, (count) =>
        this.influxReducer(IncrementAction(count)));
    triggerOnActionV2(_actions.decrementAction, (count) =>
        this.influxReducer(DecrementAction(count)));
    triggerOnActionV2(
        _actions.resetAction, (_) => this.influxReducer(ResetAction()));
  }
}

class BigCounterState {
  final int bigCount;
  final String name;
  BigCounterState({
    this.bigCount,
    this.name = 'BigCounter',
  });
}

int _bigCounterDecrementReducer(int currentCount, DecrementAction action) {
  return currentCount - (action?.value != null ? action.value : 100);
}

int _bigCounterIncrementReducer(int currentCount, IncrementAction action) {
  return currentCount + (action?.value != null ? action.value : 100);
}

Reducer<int> bigCounterActionsReducer = combineReducers<int>([
  TypedReducer<int, IncrementAction>(_bigCounterIncrementReducer),
  TypedReducer<int, DecrementAction>(_bigCounterDecrementReducer),
  TypedReducer<int, ResetAction>(_resetCounterReducer),
]);

BigCounterState bigCounterStateReducer(BigCounterState state, action) => BigCounterState(
  bigCount: bigCounterActionsReducer(state.bigCount, action),
);

FluxStore2 bigFluxCounter = FluxStore2(fluxActions);
FluxToReduxAdapterStore store2 = FluxToReduxAdapterStore(bigFluxCounter, fluxActions);
