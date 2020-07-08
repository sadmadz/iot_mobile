// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thing _$ThingFromJson(Map<String, dynamic> json) {
  return Thing(
    json['id'] as int,
    json['name'] as String,
    json['home'] == null
        ? null
        : Home.fromJson(json['home'] as Map<String, dynamic>),
    json['type'] == null
        ? null
        : ThingType.fromJson(json['type'] as Map<String, dynamic>),
    json['status'] as String,
    json['description'] as String,
    json['thing_row'] as String,
    json['thing_column'] as String,
    json['created_at'] as String,
    json['updated_at'] as String,
  );
}

Map<String, dynamic> _$ThingToJson(Thing instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'home': instance.home,
      'type': instance.type,
      'status': instance.status,
      'description': instance.description,
      'thing_row': instance.thingRow,
      'thing_column': instance.thingColumn,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
