import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:todo_client/src/models/base_model.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo implements BaseModel {
  /// Unique identifier. Assigned by server.
  @override
  final String id;

  /// Short description of item. Serves as the title.
  String description;

  /// Whether or not this item has been marked as completed.
  bool isCompleted;

  /// Whether or not this item is public. Public means anyone in the application
  /// can see it. Private means only the creator can see it.
  bool isPublic;

  /// Notes
  String notes;

  /// The id of the User object assigned to this instance.
  String assignedUserId;

  Todo({
    this.description = '',
    String id,
    this.isCompleted = false,
    this.isPublic = false,
    this.notes = '',
    this.assignedUserId = '',
  }) : id = id ?? Uuid().v4();

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  factory Todo.from(Todo todo) => Todo(
        description: todo.description,
        id: todo.id,
        isCompleted: todo.isCompleted,
        isPublic: todo.isPublic,
        notes: todo.notes,
        assignedUserId: todo.assignedUserId,
      );

  @override
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
