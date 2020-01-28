import 'dart:math';

import 'package:over_react/over_react_flux.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:w_flux/w_flux.dart' as flux;

/// An Influx store
///
/// [1]: Use the InfluxStoreMixin
/// [2]: Pass in the Redux state class for the Mixin's typing
/// [3]: Override the [reduxReducer] and point to the Redux [reducer]
/// [4]: Point getters to the [state] field coming from the mixin
/// [5]: Initialize the [state] field
/// [6]: Update the [state] field using Redux actions instead of a function
class FluxStore extends flux.Store with /*[1]*/ InfluxStoreMixin< /*[2]*/ ReduxState> {
  RandomColorActions _actions;

  @override
  get reduxReducer => reducer; // [3]

  String get backgroundColor => state.backgroundColor; // [4]

  FluxStore(this._actions) {
    // [5]
    state = ReduxState('gray');
    // [6]
    triggerOnActionV2(_actions.changeBackgroundColor, (_) => this.influxReducer(UpdateBackgroundColorAction()));
  }
}

class RandomColorActions {
  final flux.Action<String> changeBackgroundColor = flux.Action();
}

class UpdateBackgroundColorAction {
  UpdateBackgroundColorAction();
}

/// A normal Redux reducer that will be used by the Influx store and later by the
/// Redux store.
ReduxState reducer(ReduxState oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    final color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    return ReduxState.from(oldState, backgroundColor: color);
  } else {
    return oldState;
  }
}

/// A normal Redux store that will be used by the Influx store, the adapted Influx
/// store, and later the Redux store.
class ReduxState {
  String backgroundColor;

  ReduxState(this.backgroundColor);

  ReduxState.from(ReduxState oldState, {backgroundColor})
      : this.backgroundColor = backgroundColor ?? oldState.backgroundColor;
}

RandomColorActions randomColorActions = RandomColorActions();
FluxStore randomColorStore = FluxStore(randomColorActions);
FluxToReduxAdapterStore adaptedStore = FluxToReduxAdapterStore<FluxStore, ReduxState>(
    randomColorStore, randomColorActions,
    middleware: [overReactReduxDevToolsMiddleware]);
