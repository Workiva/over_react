// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo(
      description: json['description'] as String,
      id: json['id'] as String,
      isCompleted: json['isCompleted'] as bool,
      isPublic: json['isPublic'] as bool,
      notes: json['notes'] as String,
      assignedUserId: json['assignedUserId'] as String);
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'isPublic': instance.isPublic,
      'notes': instance.notes,
      'assignedUserId': instance.assignedUserId
    };
