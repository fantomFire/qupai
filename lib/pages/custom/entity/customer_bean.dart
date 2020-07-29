import 'package:json_annotation/json_annotation.dart';

part 'customer_bean.g.dart';
@JsonSerializable()
class CustomerBean{
  var cs_id;
  String cs_wechat ;
  var create_time;
  String cs_qrcode ;
  String cs_nickname;
  CustomerBean();
  factory CustomerBean.fromJson(Map<String, dynamic> json) => _$CustomerBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerBeanToJson(this);
}
