import 'dart:math';

import 'package:redux/redux.dart' as redux;

class UpdateBackgroundColorAction {}

class RandomColorState {
  String backgroundColor;

  RandomColorState.defaultState() : this.backgroundColor = 'gray';

  RandomColorState.update(RandomColorState oldState, {backgroundColor})
      : this.backgroundColor = backgroundColor ?? oldState.backgroundColor;
}

RandomColorState reducer(RandomColorState oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return RandomColorState.update(oldState, backgroundColor: color);
  }

  return oldState;
}

redux.Store randomColorStore = redux.Store<RandomColorState>(reducer,
    initialState: RandomColorState.defaultState());
