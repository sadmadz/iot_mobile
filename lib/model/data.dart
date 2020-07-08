import 'package:iot/model/home.dart';
import 'package:iot/model/thing.dart';
import 'package:iot/model/thing_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {


  @JsonKey(name: 'things')
  List<Thing> things;

  @JsonKey(name: 'types')
  List<ThingType> types;

  @JsonKey(name: 'homes')
  List<Home> homes;

  Data.empty();

  Data(this.types, this.things, this.homes);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
