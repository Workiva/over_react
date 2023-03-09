// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      description: json['description'] as String? ?? '',
      id: json['id'] as String?,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isPublic: json['isPublic'] as bool? ?? false,
      notes: json['notes'] as String? ?? '',
      assignedUserId: json['assignedUserId'] as String? ?? '',
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'isPublic': instance.isPublic,
      'notes': instance.notes,
      'assignedUserId': instance.assignedUserId,
    };
