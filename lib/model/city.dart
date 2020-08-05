import 'package:json_annotation/json_annotation.dart';

import 'district.dart';

part 'city.g.dart';

@JsonSerializable()
class City {

  int id;
  String code;
  String parentCode;
  String name;
  List<District> children;

  City();

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
