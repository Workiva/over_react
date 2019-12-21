import 'dart:convert';
import 'dart:html';

import 'package:redux/redux.dart';
import 'package:test/test.dart';
import 'package:todo_client/src/local_storage.dart';
import 'package:todo_client/src/models/base_model.dart';
import 'package:todo_client/src/store.dart';

Store<AppState> testStore;
Store<AppState> initializeTestStore([AppState initialState]) {
  addTearDown(() {
    testStore = null;
    localTodoAppStorage = null;
    window.localStorage[TodoAppLocalStorage.localStorageKey] = '';
  });

  if (initialState != null) {
    localTodoAppStorage = TodoAppLocalStorage(initialState);
    expect(getCurrentLocalStorageSet(), initialState.toJson(), reason: 'test setup sanity check');
  }

  return testStore = Store<AppState>(
    appStateReducer,
    initialState: initializeState(),
  );
}

String getLocalStorage() => window.localStorage[TodoAppLocalStorage.localStorageKey];

Map<String, dynamic> getLocalStorageSetByKey(String key) => json.decode(getLocalStorage())[key];

Map<String, dynamic> getCurrentLocalStorageSet() => getLocalStorageSetByKey('current');

Iterable<Map<String, dynamic>> getSerializedListOfModels(List<BaseModel> models) {
  return models.map((model) => model.toJson());
}

bool itemShouldAppearSelected(BaseModel model, List<String> listOfIds) {
  return listOfIds.contains(model.id);
}
