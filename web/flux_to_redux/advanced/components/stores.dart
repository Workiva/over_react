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

class UpdateBlockOneBackgroundColorAction {}

class UpdateBlockTwoBackgroundColorAction {}

class UpdateBlockThreeBackgroundColorAction {}

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
Context secondStoreContext = createContext();

FluxToReduxAdapterStore beforeTransitionTopLevelAdapter = FluxToReduxAdapterStore(beforeTransitionStore, beforeTransitionActions);
FluxToReduxAdapterStore beforeTransitionSecondStoreAdapter = FluxToReduxAdapterStore(beforeTransitionStore2, beforeTransitionActions);

///////////////////////////// IN TRANSITION STORES \\\\\\\\\\\\\\\\\\\\\\\\\\\\
class InTransitionTopLevelStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String mainBackgroundColor = 'gray';
  String blockOneBackgroundColor = 'red';

  InTransitionTopLevelStore(this._actions) {
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

class InTransitionLowLevelStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String backgroundColor = 'Orange';

  InTransitionLowLevelStore(this._actions) {
    triggerOnActionV2(_actions.changeBlockTwoBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class InTransitionSecondStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String backgroundColor = 'Blue';

  InTransitionSecondStore(this._actions) {
    triggerOnActionV2(_actions.changeBlockThreeBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

InTransitionTopLevelStore inTransitionTopLevelReducer(flux.Store oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    inTransitionTopLevelStore.mainBackgroundColor = color;
    inTransitionTopLevelStore.trigger();
  } else if (action is UpdateBlockOneBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    inTransitionTopLevelStore.blockOneBackgroundColor = color;
    inTransitionTopLevelStore.trigger();
  }

  return oldState;
}

InTransitionLowLevelStore inTransitionLowLevelReducer(flux.Store oldState, dynamic action) {
  if (action is UpdateBlockTwoBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    inTransitionLowLevelStore.backgroundColor = color;
    inTransitionLowLevelStore.trigger();
  }

  return oldState;
}

InTransitionSecondStore inTransitionSecondStoreReducer(flux.Store oldState, dynamic action) {
  if (action is UpdateBlockThreeBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    inTransitionSecondStore.backgroundColor = color;
    inTransitionSecondStore.trigger();
  }

  return oldState;
}

class RandomColorFluxStore extends TopLevelStore {
  RandomColorFluxStore(RandomColorActions actions) : super(actions);

  @override
  _changeBackgroundColor(String color) {
      _backgroundColor = color ?? '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

RandomColorActions inTransitionActions = RandomColorActions();
InTransitionTopLevelStore inTransitionTopLevelStore = InTransitionTopLevelStore(inTransitionActions);
InTransitionLowLevelStore inTransitionLowLevelStore = InTransitionLowLevelStore(inTransitionActions);
InTransitionSecondStore inTransitionSecondStore = InTransitionSecondStore(inTransitionActions);

Context inTransitionTopLevelStoreContext = createContext();
Context inTransitionLowLevelStoreContext = createContext();
Context inTransitionSecondStoreContext = createContext();

FluxToReduxAdapterStore inTransitionTopLevelAdapter = FluxToReduxAdapterStore(inTransitionTopLevelStore, inTransitionActions, reducer: inTransitionTopLevelReducer);
FluxToReduxAdapterStore inTransitionLowLevelAdapter = FluxToReduxAdapterStore(inTransitionLowLevelStore, inTransitionActions, reducer: inTransitionLowLevelReducer);
FluxToReduxAdapterStore inTransitionSecondStoreAdapter = FluxToReduxAdapterStore(inTransitionSecondStore, inTransitionActions, reducer: inTransitionSecondStoreReducer);


/////////////////////////// AFTER TRANSITION STORES \\\\\\\\\\\\\\\\\\\\\\\\\\
class AfterTransitionState {
  String mainBackgroundColor;
  String blockOneBackgroundColor;
  String blockTwoBackgroundColor;
  String blockThreeBackgroundColor;

  AfterTransitionState.defaultState()
      : this.mainBackgroundColor = 'gray',
        this.blockOneBackgroundColor = 'red',
        this.blockTwoBackgroundColor = 'orange',
        this.blockThreeBackgroundColor = 'blue';



  AfterTransitionState.update(AfterTransitionState oldState,
      {mainBackgroundColor, blockOneBackgroundColor, blockTwoBackgroundColor, blockThreeBackgroundColor}) :
        this.mainBackgroundColor = mainBackgroundColor ?? oldState.mainBackgroundColor,
        this.blockOneBackgroundColor = blockOneBackgroundColor ?? oldState.blockOneBackgroundColor,
        this.blockTwoBackgroundColor = blockTwoBackgroundColor ?? oldState.blockTwoBackgroundColor,
        this.blockThreeBackgroundColor = blockThreeBackgroundColor ?? oldState.blockThreeBackgroundColor;
}

AfterTransitionState afterTransitionReducer(AfterTransitionState oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return AfterTransitionState.update(oldState, mainBackgroundColor: color);
  } else if (action is UpdateBlockOneBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return AfterTransitionState.update(oldState, blockOneBackgroundColor: color);
  } else if (action is UpdateBlockTwoBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return AfterTransitionState.update(oldState, blockTwoBackgroundColor: color);
  } else if (action is UpdateBlockThreeBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return AfterTransitionState.update(oldState, blockThreeBackgroundColor: color);
  }

  return oldState;
}

redux.Store afterTransitionStore = redux.Store<AfterTransitionState>(afterTransitionReducer, initialState: AfterTransitionState.defaultState());
