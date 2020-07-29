import 'package:json_annotation/json_annotation.dart';

import 'city.dart';

part 'province.g.dart';

@JsonSerializable()
class Province {

  int id;
  String code;
  String parentCode;
  String name;
  List<City> children;

  Province();

  factory Province.fromJson(Map<String, dynamic> json) => _$ProvinceFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceToJson(this);
}
