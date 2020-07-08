// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thing_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThingType _$ThingTypeFromJson(Map<String, dynamic> json) {
  return ThingType(
    json['id'] as int,
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$ThingTypeToJson(ThingType instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };
