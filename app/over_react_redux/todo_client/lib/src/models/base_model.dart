abstract class BaseModel {
  /// Unique identifier. Assigned by server.
  String get id;

  Map<String, dynamic> toJson();
}
