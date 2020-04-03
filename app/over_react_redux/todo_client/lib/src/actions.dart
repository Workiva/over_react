import 'package:json_annotation/json_annotation.dart';

import 'package:todo_client/src/models/todo.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/store.dart';

part 'actions.g.dart';

class _Action< /*JsonSerializable*/ T> {
  _Action(this.value);

  final T value;

  dynamic toJson() {
    // JSON-encodable objects need to be either nested in a JSON primitive (map/list)
    // or returned as a primitive.
    // Try calling `toJson`.
    try {
      return (value as dynamic).toJson();
    } catch (_) {}

    // Otherwise, assume it's a JSON primitive
    return value;
  }
}

class LoadStateFromLocalStorageAction extends _Action<String> {
  LoadStateFromLocalStorageAction(String value) : super(value);
}

class LocalStorageStateLoadedAction extends _Action<AppState> {
  LocalStorageStateLoadedAction(AppState value) : super(value);
}

@JsonSerializable()
class SaveLocalStorageStateAsAction {
  final String name;
  final String previousName;

  SaveLocalStorageStateAsAction(this.name, {this.previousName});

  factory SaveLocalStorageStateAsAction.fromJson(Map<String, dynamic> json) =>
      _$SaveLocalStorageStateAsActionFromJson(json);
  Map<String, dynamic> toJson() => _$SaveLocalStorageStateAsActionToJson(this);
}

// ------------ ITEM ACTIONS ------------------

class SelectTodoAction extends _Action<String> {
  SelectTodoAction(String value) : super(value);
}

class DeselectTodoAction extends _Action<String> {
  DeselectTodoAction(String value) : super(value);
}

class BeginEditTodoAction extends _Action<String> {
  BeginEditTodoAction(String value) : super(value);
}

class FinishEditTodoAction extends _Action<String> {
  FinishEditTodoAction(String value) : super(value);
}

class HighlightTodosAction extends _Action<List<String>> {
  HighlightTodosAction(List<String> value) : super(value);
}

class UnHighlightTodosAction extends _Action<List<String>> {
  UnHighlightTodosAction(List<String> value) : super(value);
}

class AddTodoAction extends _Action<Todo> {
  AddTodoAction(Todo value) : super(value);
}

class RemoveTodoAction extends _Action<String> {
  RemoveTodoAction(String value) : super(value);
}

class UpdateTodoAction extends _Action<Todo> {
  UpdateTodoAction(Todo value) : super(value);
}

// ------------ USER ACTIONS ------------------

class SelectUserAction extends _Action<String> {
  SelectUserAction(String value) : super(value);
}

class DeselectUserAction extends _Action<String> {
  DeselectUserAction(String value) : super(value);
}

class BeginEditUserAction extends _Action<String> {
  BeginEditUserAction(String value) : super(value);
}

class FinishEditUserAction extends _Action<String> {
  FinishEditUserAction(String value) : super(value);
}

class HighlightUsersAction extends _Action<List<String>> {
  HighlightUsersAction(List<String> value) : super(value);
}

class UnHighlightUsersAction extends _Action<List<String>> {
  UnHighlightUsersAction(List<String> value) : super(value);
}

class AddUserAction extends _Action<User> {
  AddUserAction(User value) : super(value);
}

class RemoveUserAction extends _Action<String> {
  RemoveUserAction(String value) : super(value);
}

class UpdateUserAction extends _Action<User> {
  UpdateUserAction(User value) : super(value);
}
