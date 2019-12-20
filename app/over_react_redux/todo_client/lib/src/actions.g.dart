// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveLocalStorageStateAsPayload _$SaveLocalStorageStateAsPayloadFromJson(
    Map<String, dynamic> json) {
  return SaveLocalStorageStateAsPayload(
    json['name'] as String,
    previousName: json['previousName'] as String,
  );
}

Map<String, dynamic> _$SaveLocalStorageStateAsPayloadToJson(
        SaveLocalStorageStateAsPayload instance) =>
    <String, dynamic>{
      'name': instance.name,
      'previousName': instance.previousName,
    };
