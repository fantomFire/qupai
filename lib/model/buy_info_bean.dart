import 'package:json_annotation/json_annotation.dart';

part 'buy_info_bean.g.dart';
@JsonSerializable()
class BuyInfoBean{
String nickname;
String username;
String userphone;

  BuyInfoBean();
  factory BuyInfoBean.fromJson(Map<String, dynamic> json) =>
      _$BuyInfoBeanFromJson(json);
  Map<String, dynamic> toJson() => _$BuyInfoBeanToJson(this);
}