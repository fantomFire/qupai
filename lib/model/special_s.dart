import 'package:json_annotation/json_annotation.dart';

part 'special_s.g.dart';
@JsonSerializable()
class SpecialSBean{
String pic;
num id;
num type;
  SpecialSBean();
  factory SpecialSBean.fromJson(Map<String, dynamic> json) =>
      _$SpecialSBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialSBeanToJson(this);
}