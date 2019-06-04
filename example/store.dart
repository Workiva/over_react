import 'package:redux/redux.dart';
Store store = new Store<AppState>(_exampleReducer);


class AppState {
  String basicProp;
}


AppState _exampleReducer(AppState state, dynamic action) {
  if (action.type == 'UPDATE_TEXT') {
    state.basicProp = action.text;
  }
  return state;
}

class ReduxAction {
  String type;
  dynamic value;

  ReduxAction(this.type, this.value);
}
