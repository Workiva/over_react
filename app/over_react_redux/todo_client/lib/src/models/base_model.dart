// @dart=2.12
abstract class BaseModel {
  /// Unique identifier. Assigned by server.
  String? get id;

  Map<String, dynamic> toJson();
}
