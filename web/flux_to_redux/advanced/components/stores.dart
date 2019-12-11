import 'dart:math';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:redux/redux.dart' as redux;
import 'package:w_flux/w_flux.dart' as flux;

////////////////////////////////// SHARED \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

class TopLevelStore extends flux.Store {
  RandomColorActions _actions;
  MidLevelStore midLevelStore = MidLevelStore(beforeTransitionActions);

  /// Public data
  String _backgroundColor = 'gray';
  String get backgroundColor => _backgroundColor;

  TopLevelStore(this._actions) {
    triggerOnActionV2(_actions.changeMainBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class MidLevelStore extends flux.Store {
  RandomColorActions _actions;

  LowLevelStore lowLevelStore = LowLevelStore(beforeTransitionActions);

  /// Public data
  String _backgroundColor = 'Red';
  String get backgroundColor => _backgroundColor;

  MidLevelStore(this._actions) {
    triggerOnActionV2(_actions.changeBlockOneBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    print('ayyy');
    _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class LowLevelStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String _backgroundColor = 'Orange';
  String get backgroundColor => _backgroundColor;

  LowLevelStore(this._actions) {
    triggerOnActionV2(_actions.changeBlockTwoBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class SecondStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String _backgroundColor = 'Blue';
  String get backgroundColor => _backgroundColor;

  SecondStore(this._actions) {
    triggerOnActionV2(_actions.changeBlockThreeBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class UpdateBackgroundColorAction {}

class RandomColorActions {
  final flux.Action<String> changeMainBackgroundColor = flux.Action();

  final flux.Action<String> changeBlockOneBackgroundColor = flux.Action();

  final flux.Action<String> changeBlockTwoBackgroundColor = flux.Action();

  final flux.Action<String> changeBlockThreeBackgroundColor = flux.Action();
}

/////////////////////////// BEFORE TRANSITION STORES \\\\\\\\\\\\\\\\\\\\\\\\\\
RandomColorActions beforeTransitionActions = RandomColorActions();
TopLevelStore beforeTransitionStore = TopLevelStore(beforeTransitionActions);
SecondStore beforeTransitionStore2 = SecondStore(beforeTransitionActions);

Context topLevelStoreContext = createContext();
Context midLevelStoreContext = createContext();
Context lowLevelStoreContext = createContext();
Context secondStoreContext = createContext();


FluxToReduxAdapterStore topLevelStoreAdapter = FluxToReduxAdapterStore(beforeTransitionStore, actions);
FluxToReduxAdapterStore midLevelStoreAdapter = FluxToReduxAdapterStore(midLevelStore, actions);
FluxToReduxAdapterStore lowLevelStoreAdapter = FluxToReduxAdapterStore(lowLevelStore, actions);
FluxToReduxAdapterStore secondStoreAdapter = FluxToReduxAdapterStore(beforeTransitionStore2, actions);

///////////////////////////// IN TRANSITION STORES \\\\\\\\\\\\\\\\\\\\\\\\\\\\
RandomColorFluxStore reducer(flux.Store oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
//    store._backgroundColor = color;
//    store.trigger();
    return oldState;
  } else {
    return oldState;
  }
}

class RandomColorFluxStore extends TopLevelStore {
  RandomColorFluxStore(RandomColorActions actions) : super(actions);

  @override
  _changeBackgroundColor(String color) {
      _backgroundColor = color ?? '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

RandomColorActions actions = RandomColorActions();
TopLevelStore topLevelStore = TopLevelStore(actions);
MidLevelStore midLevelStore = MidLevelStore(actions);
LowLevelStore lowLevelStore = LowLevelStore(actions);
SecondStore secondStore = SecondStore(actions);


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
