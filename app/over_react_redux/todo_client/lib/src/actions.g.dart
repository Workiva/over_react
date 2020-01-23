// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveLocalStorageStateAsAction _$SaveLocalStorageStateAsActionFromJson(
    Map<String, dynamic> json) {
  return SaveLocalStorageStateAsAction(
    json['name'] as String,
    previousName: json['previousName'] as String,
  );
}

Map<String, dynamic> _$SaveLocalStorageStateAsActionToJson(
        SaveLocalStorageStateAsAction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'previousName': instance.previousName,
    };
