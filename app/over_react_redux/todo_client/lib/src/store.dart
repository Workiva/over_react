import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

import 'package:todo_client/src/models/todo.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/local_storage.dart';

part 'store.g.dart';

@visibleForTesting
AppState initializeState() {
  AppState initialState;
  if (!TodoAppLocalStorage.isInitialized()) {
    // First load - give the user some data to work with, and set up our default / empty states.
    initialState = AppState.fromJson(defaultAppState);
    localTodoAppStorage = TodoAppLocalStorage(initialState);
  } else {
    localTodoAppStorage ??= TodoAppLocalStorage();
    initialState = AppState.fromJson(localTodoAppStorage.currentStateJson);
  }

  return initialState;
}

DevToolsStore<AppState> getStore() => DevToolsStore<AppState>(
  appStateReducer,
  initialState: initializeState(),
  middleware: [
    overReactReduxDevToolsMiddleware,
    localStorageMiddleware(),
  ],
);

@JsonSerializable(explicitToJson: true)
class AppState {
  String name;
  List<Todo> todos;
  List<User> users;
  List<String> selectedTodoIds;
  List<String> editableTodoIds;
  List<String> highlightedTodoIds;
  List<String> selectedUserIds;
  List<String> editableUserIds;
  List<String> highlightedUserIds;

  AppState(this.name, {
    this.todos,
    this.users,
    this.selectedTodoIds,
    this.editableTodoIds,
    this.highlightedTodoIds,
    this.selectedUserIds,
    this.editableUserIds,
    this.highlightedUserIds,
  }) : assert(name != null && name.isNotEmpty);

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}

@visibleForTesting
AppState appStateReducer(AppState state, dynamic action) {
  if (action is LocalStorageStateLoadedAction) {
    return action.value;
  }

  return AppState(stateNameReducer(state.name, action),
    todos: todosReducer(state.todos, action),
    users: usersReducer(state.users, action),
    editableTodoIds: editableTodosReducer(state.editableTodoIds, action),
    selectedTodoIds: selectedTodosReducer(state.selectedTodoIds, action),
    highlightedTodoIds: highlightedTodosReducer(state.highlightedTodoIds, action),
    editableUserIds: editableUsersReducer(state.editableUserIds, action),
    selectedUserIds: selectedUsersReducer(state.selectedUserIds, action),
    highlightedUserIds: highlightedUsersReducer(state.highlightedUserIds, action),
  );
}


// todo inject localTodoAppStorage as an arg instead of using a global variable
Middleware<AppState> localStorageMiddleware() {
  return (store, action, next) {
    next(action);

    if (action is LoadStateFromLocalStorageAction) {
      final localStorageState = AppState.fromJson(localTodoAppStorage[action.value]);
      store.dispatch(LocalStorageStateLoadedAction(localStorageState));
    } else if (action is SaveLocalStorageStateAsAction) {
      if (action.previousName != null) {
        // This is a rename; remove the old entry
        localTodoAppStorage.remove(action.previousName);
      }

      final stateName = action.name;
      // Run the reducer here so that the name is updated in response to the
      // current action before saving.
      // TODO use store.reducer once null DevToolsStore.reducer bug is fixed
      final stateWithUpdatedName = appStateReducer(store.state, action);
      localTodoAppStorage[stateName] = stateWithUpdatedName.toJson();
    }

    localTodoAppStorage?.updateCurrentState(store.state);
  };
}

// ------------ ITEM REDUCERS ------------------

final stateNameReducer = TypedReducer<String, SaveLocalStorageStateAsAction>((name, action) {
  return action.name;
});

final todosReducer = combineReducers<List<Todo>>([
  TypedReducer<List<Todo>, AddTodoAction>((todos, action) {
    return [action.value, ...todos];
  }),
  TypedReducer<List<Todo>, RemoveTodoAction>((todos, action) {
    return List.of(todos)..removeWhere((todo) => todo.id == action.value);
  }),
  TypedReducer<List<Todo>, UpdateTodoAction>((todos, action) {
    return todos.map((todo) {
      final updatedTodo = action.value;
      if (todo.id == updatedTodo.id) {
        return updatedTodo;
      }
      return todo;
    }).toList();
  }),
]);

final selectedTodosReducer = combineReducers<List<String>>([
  TypedReducer<List<String>, SelectTodoAction>((selectedTodoIds, action) {
    return [...selectedTodoIds, action.value];
  }),
  TypedReducer<List<String>, DeselectTodoAction>((selectedTodoIds, action) {
    return List.of(selectedTodoIds)..removeWhere((id) => id == action.value);
  }),
]);

final editableTodosReducer = combineReducers<List<String>>([
  TypedReducer<List<String>, BeginEditTodoAction>((editableTodoIds, action) {
    return [...editableTodoIds, action.value];
  }),
  TypedReducer<List<String>, FinishEditTodoAction>((editableTodoIds, action) {
    return List.of(editableTodoIds)..removeWhere((id) => id == action.value);
  }),
]);

final highlightedTodosReducer = combineReducers<List<String>>([
  TypedReducer<List<String>, HighlightTodosAction>((highlightedTodoIds, action) {
    return [...highlightedTodoIds, ...action.value];
  }),
  TypedReducer<List<String>, UnHighlightTodosAction>((highlightedTodoIds, action) {
    return List.of(highlightedTodoIds)..removeWhere((id) => action.value.contains(id));
  }),
]);

// ------------ USER REDUCERS ------------------

final usersReducer = combineReducers<List<User>>([
  TypedReducer<List<User>, AddUserAction>((users, action) {
    return [action.value, ...users];
  }),
  TypedReducer<List<User>, RemoveUserAction>((users, action) {
    return List.of(users)..removeWhere((user) => user.id == action.value);
  }),
  TypedReducer<List<User>, UpdateUserAction>((users, action) {
    return users.map((user) {
      final updatedUser = action.value;
      if (user.id == updatedUser.id) {
        return updatedUser;
      }
      return user;
    }).toList();
  }),
]);

Reducer<List<String>> selectedUsersReducer = combineReducers<List<String>>([
  TypedReducer<List<String>, SelectUserAction>((selectedUserIds, action) {
    return [...selectedUserIds, action.value];
  }),
  TypedReducer<List<String>, DeselectUserAction>((selectedUserIds, action) {
    return List.of(selectedUserIds)..removeWhere((id) => id == action.value);
  }),
]);

Reducer<List<String>> editableUsersReducer = combineReducers<List<String>>([
  TypedReducer<List<String>, BeginEditUserAction>((editableUserIds, action) {
    return [...editableUserIds, action.value];
  }),
  TypedReducer<List<String>, FinishEditUserAction>((editableUserIds, action) {
    return List.of(editableUserIds)..removeWhere((id) => id == action.value);
  }),
]);

final highlightedUsersReducer = combineReducers<List<String>>([
  TypedReducer<List<String>, HighlightUsersAction>((highlightedUserIds, action) {
    return [...highlightedUserIds, ...action.value];
  }),
  TypedReducer<List<String>, UnHighlightUsersAction>((highlightedUserIds, action) {
    return List.of(highlightedUserIds)..removeWhere((id) => action.value.contains(id));
  }),
]);
