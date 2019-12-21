import 'dart:math';

import 'package:redux/redux.dart' as redux;

class UpdateBackgroundColorAction {}

class UpdateBlockOneBackgroundColorAction {}

class UpdateBlockTwoBackgroundColorAction {}

class UpdateBlockThreeBackgroundColorAction {}

class ReduxState {
  String mainBackgroundColor;
  String blockOneBackgroundColor;
  String blockTwoBackgroundColor;
  String blockThreeBackgroundColor;

  ReduxState.defaultState()
      : this.mainBackgroundColor = 'gray',
        this.blockOneBackgroundColor = 'red',
        this.blockTwoBackgroundColor = 'orange',
        this.blockThreeBackgroundColor = 'blue';

  ReduxState.update(ReduxState oldState,
      {mainBackgroundColor, blockOneBackgroundColor, blockTwoBackgroundColor, blockThreeBackgroundColor})
      : this.mainBackgroundColor = mainBackgroundColor ?? oldState.mainBackgroundColor,
        this.blockOneBackgroundColor = blockOneBackgroundColor ?? oldState.blockOneBackgroundColor,
        this.blockTwoBackgroundColor = blockTwoBackgroundColor ?? oldState.blockTwoBackgroundColor,
        this.blockThreeBackgroundColor = blockThreeBackgroundColor ?? oldState.blockThreeBackgroundColor;
}

ReduxState afterTransitionReducer(ReduxState oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return ReduxState.update(oldState, mainBackgroundColor: color);
  } else if (action is UpdateBlockOneBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return ReduxState.update(oldState, blockOneBackgroundColor: color);
  } else if (action is UpdateBlockTwoBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return ReduxState.update(oldState, blockTwoBackgroundColor: color);
  } else if (action is UpdateBlockThreeBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return ReduxState.update(oldState, blockThreeBackgroundColor: color);
  }

  return oldState;
}

redux.Store reduxStore = redux.Store<ReduxState>(afterTransitionReducer, initialState: ReduxState.defaultState());
