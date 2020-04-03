import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:todo_client/src/models/base_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements BaseModel {
  /// Unique identifier. Assigned by server.
  @override
  final String id;

  /// First and last name. Used as a display name.
  String name;

  /// Short description of the user.
  String bio;

  User({
    this.name = '?',
    String id,
    this.bio = '',
  }) : id = id ?? Uuid().v4();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  factory User.from(User user) => User(
        name: user.name,
        id: user.id,
        bio: user.bio,
      );

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
