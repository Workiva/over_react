import 'package:redux/redux.dart';
import 'package:w_flux/w_flux.dart' as flux;
import 'package:over_react/over_react_flux.dart';

import 'redux_actions.dart';

int initialValue = 0;

int _resetCounterReducer(int currentCount, ResetAction action){
  return initialValue;
}

class FluxActions {
  final flux.Action<int> incrementAction = flux.Action();
  final flux.Action<int> decrementAction = flux.Action();
  final flux.Action resetAction = flux.Action();
  final flux.Action mutateStoreDirectly = flux.Action();
}

class FluxStore extends flux.Store with InfluxStoreMixin<CounterState> {
  FluxActions _actions;

  @override
  get reduxReducer => counterStateReducer;

  int get count => state.count;
  String get name => state.name;
  List<String> get listYouDefShouldntMutate => state.listThatYouDefShouldntMutate;

  FluxStore(this._actions) {
    state = CounterState(count: initialValue);

    triggerOnActionV2(_actions.incrementAction, (_) => this.influxReducer(IncrementAction()));
    triggerOnActionV2(_actions.decrementAction, (_) => this.influxReducer(DecrementAction()));
    triggerOnActionV2(_actions.resetAction, (_) => this.influxReducer(ResetAction()));
    triggerOnActionV2(_actions.mutateStoreDirectly, (_) => this.influxReducer(MutateStoreDirectlyAction()));
  }
}

/////////////////////////////// STORE 1 "Counter" ///////////////////////////////
class CounterState {
  final int count;
  final String name;
  List<String> listThatYouDefShouldntMutate = [];

  CounterState({
    this.count,
    this.name = 'Counter',
  });
}

CounterState counterStateReducer(CounterState state, Object action) {

  if (action is IncrementAction) {
    return CounterState(count: state.count + (action?.value ?? 1));
  } else if (action is DecrementAction) {
    return CounterState(count: state.count - (action?.value ?? 1));
  } else if (action is ResetAction) {
    return CounterState(count: initialValue);
  } else if (action is MutateStoreDirectlyAction) {
    state.listThatYouDefShouldntMutate.add('woops');
  }

  return state;
}

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

FluxActions bigFluxActions = FluxActions();
FluxStore2 bigFluxCounter = FluxStore2(bigFluxActions);
FluxToReduxAdapterStore store2 = FluxToReduxAdapterStore(bigFluxCounter, bigFluxActions);

FluxActions anotherFluxActionsInstance = FluxActions();
FluxStore anotherFluxStore = FluxStore(anotherFluxActionsInstance);
FluxToReduxAdapterStore store3 = FluxToReduxAdapterStore(anotherFluxStore, anotherFluxActionsInstance);
