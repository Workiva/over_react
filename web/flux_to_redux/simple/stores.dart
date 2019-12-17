import 'dart:math';

import 'package:over_react/over_react_flux.dart';
import 'package:redux/redux.dart' as redux;
import 'package:w_flux/w_flux.dart' as flux;

////////////////////////////////// SHARED \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
class ExampleFluxStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String _backgroundColor = 'gray';
  String get backgroundColor => _backgroundColor;

  ExampleFluxStore(this._actions) {
    triggerOnActionV2(_actions.changeBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class RandomColorActions {
  final flux.Action<String> changeBackgroundColor = flux.Action();
}

class UpdateBackgroundColorAction {}

/////////////////////////// BEFORE TRANSITION STORES \\\\\\\\\\\\\\\\\\\\\\\\\\
RandomColorActions beforeTransitionActions = RandomColorActions();
ExampleFluxStore beforeTransitionStore = ExampleFluxStore(beforeTransitionActions);
FluxToReduxAdapterStore beforeTransitionAdaptedStore = FluxToReduxAdapterStore(beforeTransitionStore, beforeTransitionActions);

///////////////////////////// IN TRANSITION STORES \\\\\\\\\\\\\\\\\\\\\\\\\\\\
RandomColorFluxStore reducer(flux.Store oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    store._backgroundColor = color;
    store.trigger();
    return oldState;
  } else {
    return oldState;
  }
}

class RandomColorFluxStore extends ExampleFluxStore {
  RandomColorFluxStore(RandomColorActions actions) : super(actions);

  @override
  _changeBackgroundColor(String color) {
      _backgroundColor = color ?? '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

RandomColorActions actions = RandomColorActions();
RandomColorFluxStore store = RandomColorFluxStore(actions);
FluxToReduxAdapterStore adaptedStore = FluxToReduxAdapterStore(store, actions, reducer: reducer);

/////////////////////////// AFTER TRANSITION STORES \\\\\\\\\\\\\\\\\\\\\\\\\\
class AfterTransitionState {
  String backgroundColor;

  AfterTransitionState.defaultState() : this.backgroundColor = 'gray';

  AfterTransitionState.update(AfterTransitionState oldState, {backgroundColor}) : this.backgroundColor = backgroundColor ?? oldState.backgroundColor;
}

AfterTransitionState afterTransitionReducer(AfterTransitionState oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return AfterTransitionState.update(oldState, backgroundColor: color);
  }

  return oldState;
}

redux.Store afterTransitionStore = redux.Store<AfterTransitionState>(afterTransitionReducer, initialState: AfterTransitionState.defaultState());
