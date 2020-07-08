// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    (json['types'] as List)
        ?.map((e) =>
            e == null ? null : ThingType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['things'] as List)
        ?.map(
            (e) => e == null ? null : Thing.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['homes'] as List)
        ?.map(
            (e) => e == null ? null : Home.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'things': instance.things,
      'types': instance.types,
      'homes': instance.homes,
    };
