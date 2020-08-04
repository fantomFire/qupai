import 'package:json_annotation/json_annotation.dart';

part 'special_x.g.dart';
@JsonSerializable()
class SpecialXBean{
String pic;
num id;
num type;
  SpecialXBean();
  factory SpecialXBean.fromJson(Map<String, dynamic> json) =>
      _$SpecialXBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialXBeanToJson(this);
}