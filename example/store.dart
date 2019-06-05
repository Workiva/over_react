import 'package:redux/redux.dart';
Store store = new Store<AppState>(_exampleReducer, initialState: new AppState()..basicProp = 'Hello' );


class AppState {
  String basicProp;
}


AppState _exampleReducer(AppState state, dynamic action) {
  return new AppState()..basicProp = 'Yeeee';
}

class ReduxAction {
  String type;
  dynamic value;

  ReduxAction(this.type, this.value);
}
