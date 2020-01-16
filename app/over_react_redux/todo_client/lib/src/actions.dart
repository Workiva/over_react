import 'package:json_annotation/json_annotation.dart';

import 'package:todo_client/src/models/todo.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/store.dart';

part 'actions.g.dart';

class Action</*JsonSerializable*/T> {
  Action({this.type, this.value});

  final String type;
  final T value;

  Map<String, dynamic> toJson() {
    return {'value': this.value};
  }
}

class LoadStateFromLocalStorageAction extends Action<String> {
  LoadStateFromLocalStorageAction([String value]) : super(type: 'LOAD_STATE_FROM_LOCAL_STORAGE', value: value);
}

@JsonSerializable()
class SaveLocalStorageStateAsPayload {
  final String name;
  final String previousName;

  SaveLocalStorageStateAsPayload(this.name, {this.previousName});

  factory SaveLocalStorageStateAsPayload.fromJson(Map<String, dynamic> json) => _$SaveLocalStorageStateAsPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$SaveLocalStorageStateAsPayloadToJson(this);
}

class SaveLocalStorageStateAsAction extends Action<SaveLocalStorageStateAsPayload> {
  SaveLocalStorageStateAsAction([SaveLocalStorageStateAsPayload value]) : super(type: 'SAVE_LOCAL_STORAGE_STATE_AS', value: value);
}

class LocalStorageStateLoadedAction extends Action<AppState> {
  LocalStorageStateLoadedAction(AppState value) : super(type: 'LOCAL_STORAGE_STATE_LOADED', value: value);
}

// ------------ ITEM ACTIONS ------------------

class SelectTodoAction extends Action<String> {
  SelectTodoAction([String value]) : super(type: 'SELECT_TODO', value: value);
}

class DeselectTodoAction extends Action<String> {
  DeselectTodoAction([String value]) : super(type: 'DESELECT_TODO', value: value);
}

class BeginEditTodoAction extends Action<String> {
  BeginEditTodoAction([String value]) : super(type: 'EDIT_TODO_BEGIN', value: value);
}

class FinishEditTodoAction extends Action<String> {
  FinishEditTodoAction([String value]) : super(type: 'EDIT_TODO_FINISH', value: value);
}

class HighlightTodosAction extends Action<List<String>> {
  HighlightTodosAction([List<String> value]) : super(type: 'HIGHLIGHT_TODOS', value: value);
}

class UnHighlightTodosAction extends Action<List<String>> {
  UnHighlightTodosAction([List<String> value]) : super(type: 'UNHIGHLIGHT_TODOS', value: value);
}

class AddTodoAction extends Action<Todo> {
  AddTodoAction([Todo value]) : super(type: 'ADD_TODO', value: value);
}

class RemoveTodoAction extends Action<String> {
  RemoveTodoAction([String value]) : super(type: 'REMOVE_TODO', value: value);
}

class UpdateTodoAction extends Action<Todo> {
  UpdateTodoAction([Todo value]) : super(type: 'UPDATE_TODO', value: value);
}

// ------------ USER ACTIONS ------------------

class SelectUserAction extends Action<String> {
  SelectUserAction([String value]) : super(type: 'SELECT_USER', value: value);
}

class DeselectUserAction extends Action<String> {
  DeselectUserAction([String value]) : super(type: 'DESELECT_USER', value: value);
}

class BeginEditUserAction extends Action<String> {
  BeginEditUserAction([String value]) : super(type: 'EDIT_USER_BEGIN', value: value);
}

class FinishEditUserAction extends Action<String> {
  FinishEditUserAction([String value]) : super(type: 'EDIT_USER_FINISH', value: value);
}

class HighlightUsersAction extends Action<List<String>> {
  HighlightUsersAction([List<String> value]) : super(type: 'HIGHLIGHT_USERS', value: value);
}

class UnHighlightUsersAction extends Action<List<String>> {
  UnHighlightUsersAction([List<String> value]) : super(type: 'UNHIGHLIGHT_USERS', value: value);
}

class AddUserAction extends Action<User> {
  AddUserAction([User value]) : super(type: 'ADD_USER', value: value);
}

class RemoveUserAction extends Action<String> {
  RemoveUserAction([String value]) : super(type: 'REMOVE_USER', value: value);
}

class UpdateUserAction extends Action<User> {
  UpdateUserAction([User value]) : super(type: 'UPDATE_USER', value: value);
}
