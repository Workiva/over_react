import 'dart:math';

import 'package:over_react/over_react_flux.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:w_flux/w_flux.dart' as flux;

class FluxStore extends flux.Store with InfluxStoreMixin<ReduxState> {
  RandomColorActions _actions;

  @override
  get reduxReducer => reducer;

  String get backgroundColor => state.backgroundColor;

  FluxStore(this._actions) {
    state = ReduxState('gray');
    triggerOnActionV2(_actions.changeBackgroundColor, (_) => this.influxReducer(UpdateBackgroundColorAction()));
  }
}

class RandomColorActions {
  final flux.Action<String> changeBackgroundColor = flux.Action();
}

class UpdateBackgroundColorAction {
  UpdateBackgroundColorAction();
}

ReduxState reducer(ReduxState oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    return ReduxState.from(oldState, backgroundColor: color);
  } else {
    return oldState;
  }
}

class ReduxState {
  String backgroundColor;

  ReduxState(this.backgroundColor);

  ReduxState.from(ReduxState oldState, {backgroundColor}) : this.backgroundColor = backgroundColor ?? oldState.backgroundColor;
}


RandomColorActions randomColorActions = RandomColorActions();
FluxStore randomColorStore = FluxStore(randomColorActions);
FluxToReduxAdapterStore adaptedStore =
    FluxToReduxAdapterStore<FluxStore, ReduxState>(randomColorStore, randomColorActions, middleware: [overReactReduxDevToolsMiddleware]);
