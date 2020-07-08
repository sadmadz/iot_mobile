import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable()
class Home {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  Home.empty();

  Home(this.id, this.name, this.createdAt, this.updatedAt);

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);
}
