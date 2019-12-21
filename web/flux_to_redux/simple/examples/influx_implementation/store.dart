import 'dart:math';

import 'package:over_react/over_react_flux.dart';
import 'package:w_flux/w_flux.dart' as flux;

class FluxStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String _backgroundColor = 'gray';
  String get backgroundColor => _backgroundColor;

  FluxStore(this._actions) {
    triggerOnActionV2(_actions.changeBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(_) {
    _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class RandomColorActions {
  final flux.Action<String> changeBackgroundColor = flux.Action();
}

class UpdateBackgroundColorAction {}

FluxStore reducer(flux.Store oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    randomColorStore._backgroundColor = color;
    randomColorStore.trigger();
    return oldState;
  } else {
    return oldState;
  }
}

RandomColorActions randomColorActions = RandomColorActions();
FluxStore randomColorStore = FluxStore(randomColorActions);
FluxToReduxAdapterStore adaptedStore = FluxToReduxAdapterStore(randomColorStore, randomColorActions, reducer: reducer);
