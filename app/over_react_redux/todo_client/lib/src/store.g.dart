// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(json['name'] as String,
      todos: (json['todos'] as List)
          ?.map((e) =>
              e == null ? null : Todo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      users: (json['users'] as List)
          ?.map((e) =>
              e == null ? null : User.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      selectedTodoIds:
          (json['selectedTodoIds'] as List)?.map((e) => e as String)?.toList(),
      editableTodoIds:
          (json['editableTodoIds'] as List)?.map((e) => e as String)?.toList(),
      highlightedTodoIds: (json['highlightedTodoIds'] as List)
          ?.map((e) => e as String)
          ?.toList(),
      selectedUserIds:
          (json['selectedUserIds'] as List)?.map((e) => e as String)?.toList(),
      editableUserIds:
          (json['editableUserIds'] as List)?.map((e) => e as String)?.toList(),
      highlightedUserIds: (json['highlightedUserIds'] as List)
          ?.map((e) => e as String)
          ?.toList());
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'name': instance.name,
      'todos': instance.todos?.map((e) => e?.toJson())?.toList(),
      'users': instance.users?.map((e) => e?.toJson())?.toList(),
      'selectedTodoIds': instance.selectedTodoIds,
      'editableTodoIds': instance.editableTodoIds,
      'highlightedTodoIds': instance.highlightedTodoIds,
      'selectedUserIds': instance.selectedUserIds,
      'editableUserIds': instance.editableUserIds,
      'highlightedUserIds': instance.highlightedUserIds
    };
