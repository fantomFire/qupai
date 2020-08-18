import 'package:json_annotation/json_annotation.dart';

part 'other_bean.g.dart';

//适用一些简单的
@JsonSerializable()
class OtherBean {
  num yetxl;

  OtherBean();

  factory OtherBean.fromJson(Map<String, dynamic> json) =>
      _$OtherBeanFromJson(json);

  Map<String, dynamic> toJson() => _$OtherBeanToJson(this);
}
