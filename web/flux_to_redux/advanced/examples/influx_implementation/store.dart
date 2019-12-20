import 'dart:math';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:w_flux/w_flux.dart' as flux;

class UpdateBackgroundColorAction {}

class UpdateBlockOneBackgroundColorAction {}

class UpdateBlockTwoBackgroundColorAction {}

class UpdateBlockThreeBackgroundColorAction {}

class RandomColorActions {
  final flux.Action<String> changeMainBackgroundColor = flux.Action();

  final flux.Action<String> changeBlockOneBackgroundColor = flux.Action();

  final flux.Action<String> changeBlockTwoBackgroundColor = flux.Action();

  final flux.Action<String> changeBlockThreeBackgroundColor = flux.Action();
}

class RandomColorStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String mainBackgroundColor = 'gray';
  String blockOneBackgroundColor = 'red';

  RandomColorStore(this._actions) {
    triggerOnActionV2(_actions.changeMainBackgroundColor, _changeBackgroundColor);
    triggerOnActionV2(_actions.changeBlockOneBackgroundColor, _changeBlockOneBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    mainBackgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }

  _changeBlockOneBackgroundColor(String _) {
    blockOneBackgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class LowLevelStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String backgroundColor = 'Orange';

  LowLevelStore(this._actions) {
    triggerOnActionV2(_actions.changeBlockTwoBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class AnotherColorStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String backgroundColor = 'Blue';

  AnotherColorStore(this._actions) {
    triggerOnActionV2(_actions.changeBlockThreeBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

RandomColorStore inTransitionTopLevelReducer(flux.Store oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    randomColorStore.mainBackgroundColor = color;
    randomColorStore.trigger();
  } else if (action is UpdateBlockOneBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    randomColorStore.blockOneBackgroundColor = color;
    randomColorStore.trigger();
  }

  return oldState;
}

LowLevelStore inTransitionLowLevelReducer(flux.Store oldState, dynamic action) {
  if (action is UpdateBlockTwoBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    lowLevelStore.backgroundColor = color;
    lowLevelStore.trigger();
  }

  return oldState;
}

AnotherColorStore inTransitionSecondStoreReducer(flux.Store oldState, dynamic action) {
  if (action is UpdateBlockThreeBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    anotherColorStore.backgroundColor = color;
    anotherColorStore.trigger();
  }

  return oldState;
}

RandomColorActions randomColorActions = RandomColorActions();
RandomColorStore randomColorStore =
RandomColorStore(randomColorActions);
LowLevelStore lowLevelStore =
LowLevelStore(randomColorActions);
AnotherColorStore anotherColorStore = AnotherColorStore(randomColorActions);

Context randomColorStoreContext = createContext();
Context lowLevelStoreContext = createContext();
Context anotherColorStoreContext = createContext();

FluxToReduxAdapterStore randomColorStoreAdapter = FluxToReduxAdapterStore(
    randomColorStore, randomColorActions,
    reducer: inTransitionTopLevelReducer);
FluxToReduxAdapterStore lowLevelStoreAdapter = FluxToReduxAdapterStore(
    lowLevelStore, randomColorActions,
    reducer: inTransitionLowLevelReducer);
FluxToReduxAdapterStore anotherColorStoreAdapter = FluxToReduxAdapterStore(
    anotherColorStore, randomColorActions,
    reducer: inTransitionSecondStoreReducer);