import 'dart:collection';
import 'dart:convert';
import 'dart:html';

import 'package:todo_client/src/store.dart';

/// The `window.localStorage` interface for our application.
TodoAppLocalStorage localTodoAppStorage;

/// A map interface for mutating `window.localStorage` values
/// used to persist [AppState] values across browser refreshes.
class TodoAppLocalStorage extends MapBase<String, /*encodable*/Object> {
  final AppState initialState;

  TodoAppLocalStorage([this.initialState]) {
    if (isInitialized) return;

    final emptyState = AppState(TodoAppLocalStorage.emptyStateKey,
      todos: [],
      users: [],
      selectedTodoIds: [],
      editableTodoIds: [],
      highlightedTodoIds: [],
      selectedUserIds: [],
      editableUserIds: [],
      highlightedUserIds: [],
    ).toJson();

    window.localStorage[localStorageKey] = json.encode({
      currentStateKey: this.initialState?.toJson() ?? {},
      defaultStateKey: this.initialState?.toJson() ?? {},
      emptyStateKey: emptyState,
    });
  }

  // --------------------  Utilities --------------------

  static bool isInitialized = window.localStorage[localStorageKey] != null;

  Map<String, dynamic> get _proxiedMap => json.decode(window.localStorage[localStorageKey]);

  void updateCurrentState(AppState newValue) {
    this[currentStateKey] = newValue.toJson();
  }

  void reset() {
    this[currentStateKey] = defaultStateJson;
  }

  Map<String, dynamic> get currentStateJson => this[currentStateKey];
  Map<String, dynamic> get defaultStateJson => this[defaultStateKey];
  Map<String, dynamic> get emptyStateJson => this[emptyStateKey];
  Map<String, Map<String, dynamic>> get mapOfCustomStatesJson => {
    ...Map.from(this)..removeWhere((key, value) => reservedStateKeys.contains(key))
  };

  // --------------------  MapBase implementations --------------------

  @override
  operator [](Object key) {
    return _proxiedMap[key];
  }

  @override
  void operator []=(key, value) {
    final updatedJson = Map.of(_proxiedMap);
    updatedJson[key] = value;
    window.localStorage[localStorageKey] = json.encode(updatedJson);
  }

  @override
  Iterable<String> get keys => _proxiedMap.keys;

  @override
  bool containsKey(Object key) => keys.contains(key);

  @override
  Iterable get values => _proxiedMap.values;

  @override
  bool containsValue(Object value) => values.contains(value);

  @override
  void addAll(Map<String, Object> other) {
    final updatedJson = Map.of(_proxiedMap)..addAll(other);
    window.localStorage[localStorageKey] = json.encode(updatedJson);
  }

  @override
  void clear() {
    this[currentStateKey] = emptyStateJson;
  }

  @override
  Object remove(Object key) {
    assert(!reservedStateKeys.contains(key));

    final updatedJson = Map.of(_proxiedMap);
    var valueRemoved = updatedJson.remove(key);

    window.localStorage[localStorageKey] = json.encode(updatedJson);
    return valueRemoved;
  }

  @override
  String toString() => window.localStorage[localStorageKey];

  static const String localStorageKey = 'todo_client.AppState';
  static const String currentStateKey = 'current';
  static const String emptyStateKey = 'empty';
  static const String defaultStateKey = 'default';
  static const List<String> reservedStateKeys = [
    currentStateKey,
    emptyStateKey,
    defaultStateKey,
  ];
}

// ignore: prefer_single_quotes
const defaultAppState = {"name":"default","todos":[{"id":"1e6c70ae-69c5-49a9-a605-68b4900e0e55","description":"Own Joe in Super Smash Bros","assignedUserId":"77dd23d7-19ce-4ba4-9075-cabb4572c83d","isCompleted":true,"isPublic":true,"notes": "6/25/2019"},{"id":"8f487d61-927f-436e-b794-f9749d520854","description":"Trim your beard","isCompleted":false,"isPublic":false,"notes":"Here's some notes about when it should be trimmed, how short, and so much more!","assignedUserId":"1b948c58-b0f3-4a9d-87d8-32c6862a1e18"},{"id":"81caf55e-c0c0-4e13-a271-98dca3d67d9e","description":"Get a haircut","isCompleted":false,"isPublic":false,"notes":"Self explanatory. Clean it up hippie.","assignedUserId":"c42ef2c2-aa37-42c1-bd2a-bb5d4935846e"},{"id":"23987b56-1e1a-4c52-963b-44cfeb35d368","description":"Take the kids to school","isCompleted":false,"isPublic":false,"notes":"","assignedUserId":"77dd23d7-19ce-4ba4-9075-cabb4572c83d"},{"id":"0009face-8b12-45aa-b2c4-251db7e46bec","description":"Explain that the platform is important","isCompleted":false,"isPublic":false,"notes":"Again.","assignedUserId":"5c261eca-7aca-47b8-a223-db83ff868444"},{"id":"eee66b2b-0028-411d-97af-91fdfe3ee89f","description":"Go to Disneyland","isCompleted":true,"isPublic":false,"notes":"","assignedUserId":"3859c1ca-a254-4522-85c5-8f6af8490eb4"},{"id":"f6542e94-c12e-4e29-bd0a-af838363686b","description":"Study for that one last final!","isCompleted":false,"isPublic":false,"notes":"","assignedUserId":"56590b19-c40d-4e76-9bfd-79e2f5fa57ee"},{"id":"0e5653a7-5287-4058-b1d2-0187198f1953","description":"Learn more of Behdad's sayings","isCompleted":false,"isPublic":false,"notes":"","assignedUserId":"b9186b2b-7606-4b9b-9cdc-96be45e6ef07"},{"id":"8d4686a4-0b2f-4a34-8756-2af328354653","description":"Finish Context","isCompleted":true,"isPublic":false,"notes":"","assignedUserId":"1b514273-a2d3-4e0c-a4fa-7b2dbdd89e7f"},{"id":"d28fb4f6-3336-4d7f-84b3-010b7a68d149","description":"Go to Disneyland again","isCompleted":false,"isPublic":false,"notes":"","assignedUserId":"3859c1ca-a254-4522-85c5-8f6af8490eb4"},{"id":"01362064-9b83-4103-83db-94a69a04e5e8","description":"Check unread messages in platform support chats","isCompleted":false,"isPublic":false,"notes":"","assignedUserId":"cfbe3200-dc71-48d2-a5f9-c2404f3a23b5"},{"id":"85501e1e-8433-4896-959a-30a289ed68f0","description":"Write tests for w_router","isCompleted":false,"isPublic":false,"notes":"","assignedUserId":"d487282b-20d9-480f-ae4f-5b93168b6717"},{"id":"67b1fa43-4eb1-4c27-8519-8886f379dc58","description":"Walk the dog","isCompleted":false,"isPublic":false,"notes":"","assignedUserId":"77dd23d7-19ce-4ba4-9075-cabb4572c83d"},{"id":"7a34cfb4-4368-4570-ae19-39732b8b3c96","description":"Find more \"retro\" pictures","isCompleted":false,"isPublic":false,"notes":"","assignedUserId":"5c261eca-7aca-47b8-a223-db83ff868444"}],"users":[{"id":"77dd23d7-19ce-4ba4-9075-cabb4572c83d","name":"Aaron Lademann","bio":""},{"id":"1b514273-a2d3-4e0c-a4fa-7b2dbdd89e7f","name":"Greg Littlefield","bio":""},{"id":"b9186b2b-7606-4b9b-9cdc-96be45e6ef07","name":"Joe Bingham","bio":""},{"id":"3859c1ca-a254-4522-85c5-8f6af8490eb4","name":"Keal Jones","bio":""},{"id":"56590b19-c40d-4e76-9bfd-79e2f5fa57ee","name":"Sydney Jodon","bio":""},{"id":"c42ef2c2-aa37-42c1-bd2a-bb5d4935846e","name":"Evan Weible","bio":""},{"id":"cfbe3200-dc71-48d2-a5f9-c2404f3a23b5","name":"Corwin Sheahan","bio":""},{"id":"ab0683c1-9bc5-4af2-be4d-43ec9d8516d0","name":"Smai Fullerton","bio":""},{"id":"3d035e0c-0dbc-4d80-bf8b-8613a0bd9b43","name":"Tod Bachman","bio":""},{"id":"bd4b321e-c216-4b51-ad83-cff92e72dabf","name":"Rob Becker","bio":""},{"id":"5c261eca-7aca-47b8-a223-db83ff868444","name":"Rob Duff","bio":""},{"id":"d487282b-20d9-480f-ae4f-5b93168b6717","name":"Trent Grover","bio":""},{"id":"ef803556-410a-4b96-ac49-f05642594a61","name":"Joel Leibow","bio":""},{"id":"f05227ed-ef5f-45c1-becd-84d39c04315c","name":"Aaron St. George","bio":""},{"id":"b9a45ddc-0ecc-4dba-90db-968e95c99ffe","name":"Olesia Thoms","bio":""},{"id":"06935491-fd09-4aa7-8994-d2725b9f0378","name":"Will Drach","bio":""},{"id":"1b948c58-b0f3-4a9d-87d8-32c6862a1e18","name":"Behdad Shayegan","bio":""}],"selectedTodoIds":[],"editableTodoIds":[],"highlightedTodoIds":[],"selectedUserIds":[],"editableUserIds":[],"highlightedUserIds":[]};
