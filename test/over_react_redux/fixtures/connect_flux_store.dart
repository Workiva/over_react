import 'package:redux/redux.dart';
import 'package:w_flux/w_flux.dart' as flux;
import 'package:over_react/over_react_flux.dart';

import 'redux_actions.dart';

int initialValue = 0;

int _resetCounterReducer(int currentCount, ResetAction action) {
  return initialValue;
}

class FluxActions {
  final flux.Action<int> incrementAction = flux.Action();
  final flux.Action<int> decrementAction = flux.Action();
  final flux.Action resetAction = flux.Action();
  final flux.Action mutateStoreDirectly = flux.Action();
}

class FluxStore extends flux.Store with InfluxStoreMixin<FluxCounterState> {
  FluxActions _actions;

  @override
  get reduxReducer => counterStateReducer;

  int get count => state.count;
  String get name => state.name;
  List<String> get listYouDefShouldntMutate =>
      state.listThatYouDefShouldntMutate;

  FluxStore(this._actions) {
    state = FluxCounterState(count: initialValue);

    triggerOnActionV2(
        _actions.incrementAction, (_) => this.influxReducer(IncrementAction()));
    triggerOnActionV2(
        _actions.decrementAction, (_) => this.influxReducer(DecrementAction()));
    triggerOnActionV2(
        _actions.resetAction, (_) => this.influxReducer(ResetAction()));
    triggerOnActionV2(_actions.mutateStoreDirectly,
        (_) => this.influxReducer(MutateStoreDirectlyAction()));
  }
}

/////////////////////////////// STORE 1 "Counter" ///////////////////////////////
class FluxCounterState {
  final int count;
  final String name;
  List<String> listThatYouDefShouldntMutate = [];

  FluxCounterState({
    this.count,
    this.name = 'Counter',
  });
}

FluxCounterState counterStateReducer(FluxCounterState state, Object action) {
  if (action is IncrementAction) {
    return FluxCounterState(count: state.count + (action?.value ?? 1));
  } else if (action is DecrementAction) {
    return FluxCounterState(count: state.count - (action?.value ?? 1));
  } else if (action is ResetAction) {
    return FluxCounterState(count: initialValue);
  } else if (action is MutateStoreDirectlyAction) {
    state.listThatYouDefShouldntMutate.add('woops');
  }

  return state;
}

FluxActions fluxActions = FluxActions();
FluxStore fluxStore = FluxStore(fluxActions);
FluxToReduxAdapterStore store1 =
    FluxToReduxAdapterStore(fluxStore, fluxActions);

/////////////////////////////// STORE 2 "BigCounter" ///////////////////////////////
class FluxStore2 extends flux.Store with InfluxStoreMixin<BigCounterState> {
  FluxActions _actions;

  @override
  get reduxReducer => bigCounterStateReducer;

  int get count => state.bigCount;
  String get name => state.name;

  FluxStore2(this._actions) {
    state = BigCounterState(bigCount: initialValue);

    triggerOnActionV2(_actions.incrementAction,
        (count) => this.influxReducer(IncrementAction(count)));
    triggerOnActionV2(_actions.decrementAction,
        (count) => this.influxReducer(DecrementAction(count)));
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

BigCounterState bigCounterStateReducer(BigCounterState state, action) =>
    BigCounterState(
      bigCount: bigCounterActionsReducer(state.bigCount, action),
    );

FluxActions bigFluxActions = FluxActions();
FluxStore2 bigFluxCounter = FluxStore2(bigFluxActions);
FluxToReduxAdapterStore store2 =
    FluxToReduxAdapterStore(bigFluxCounter, bigFluxActions);

/////////////////////////////// STORE 3 "AnotherFluxStore" ///////////////////////////////
// Just created for testing context
FluxActions anotherFluxActionsInstance = FluxActions();
FluxStore anotherFluxStore = FluxStore(anotherFluxActionsInstance);
FluxToReduxAdapterStore store3 =
    FluxToReduxAdapterStore(anotherFluxStore, anotherFluxActionsInstance);

/////////////////////////////// STORE 4 "ConnectableFluxStore" ///////////////////////////////
class TestConnectableFluxStore extends flux.Store {
  FluxActions _actions;

  var _count = 0;
  int get count => _count;

  var _name = 'ConnectableFluxStore';
  String get name => _name;

  TestConnectableFluxStore(this._actions) {
    triggerOnActionV2(_actions.incrementAction, _incrementAction);
    triggerOnActionV2(_actions.decrementAction, _decrementAction);
    triggerOnActionV2(_actions.resetAction, _resetAction);
  }

  void _incrementAction(int count) {
    _count += count ?? 1;
  }

  void _decrementAction(int count) {
    _count -= count ?? 1;
  }

  void _resetAction(_) {
    _count = 0;
  }
}

FluxActions connectableStoreActions = FluxActions();
TestConnectableFluxStore connectableFluxStore =
    TestConnectableFluxStore(connectableStoreActions);
TestConnectableFluxStore anotherConnectableFluxStore =
    TestConnectableFluxStore(connectableStoreActions);
ConnectFluxAdapterStore connectableFluxAdaptedStore =
    ConnectFluxAdapterStore(connectableFluxStore, connectableStoreActions);
