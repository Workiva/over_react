import 'dart:html';

import 'package:redux/redux.dart';
import 'package:test/test.dart';
import 'package:todo_client/src/local_storage.dart';
import 'package:todo_client/src/store.dart';

Store<AppState> testStore;
Store<AppState> initializeTestStore() {
  addTearDown(() {
    testStore = null;
    localTodoAppStorage = null;
    window.localStorage[TodoAppLocalStorage.localStorageKey] = '';
  });

  return testStore = Store<AppState>(
    appStateReducer,
    initialState: initializeState(),
  );
}
