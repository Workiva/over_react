import 'package:redux/redux.dart';
Store store = new Store<AppState>(_exampleReducer, initialState: new AppState()..somethingInState = 'default AppStste' );

class AppState {
  String somethingInState;
  dynamic anything;
}

AppState _exampleReducer(AppState state, dynamic action) {
  return new AppState()..somethingInState = 'reduced AppState';
}

class ReduxAction {
  String type;
  dynamic value;

  ReduxAction(this.type, this.value);
}
