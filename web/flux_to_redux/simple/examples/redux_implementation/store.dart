import 'dart:math';

import 'package:redux/redux.dart' as redux;

class UpdateBackgroundColorAction {}

class ReduxState {
  String backgroundColor;

  ReduxState.defaultState() : this.backgroundColor = 'gray';

  ReduxState.update(ReduxState oldState, {backgroundColor})
      : this.backgroundColor = backgroundColor ?? oldState.backgroundColor;
}

ReduxState reducer(ReduxState oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return ReduxState.update(oldState, backgroundColor: color);
  }

  return oldState;
}

redux.Store randomColorStore = redux.Store<ReduxState>(reducer,
    initialState: ReduxState.defaultState());
