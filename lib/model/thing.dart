import 'package:iot/model/thing_type.dart';
import 'package:json_annotation/json_annotation.dart';

import 'home.dart';

part 'thing.g.dart';

@JsonSerializable()
class Thing {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'home')
  Home home;

  @JsonKey(name: 'type')
  ThingType type;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'thing_row')
  String thingRow;

  @JsonKey(name: 'thing_column')
  String thingColumn;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  Thing.empty();

  Thing(this.id, this.name, this.home, this.type, this.status, this.description,
      this.thingRow, this.thingColumn, this.createdAt, this.updatedAt);

  factory Thing.fromJson(Map<String, dynamic> json) => _$ThingFromJson(json);
}
