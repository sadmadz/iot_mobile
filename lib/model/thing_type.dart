import 'package:json_annotation/json_annotation.dart';

part 'thing_type.g.dart';

@JsonSerializable()
class ThingType {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'name')
  String name;

  ThingType.empty();

  ThingType(this.id, this.code, this.name);

  factory ThingType.fromJson(Map<String, dynamic> json) => _$ThingTypeFromJson(json);
}
