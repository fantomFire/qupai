import 'package:json_annotation/json_annotation.dart';

part 'order_info_bean.g.dart';

@JsonSerializable()
class OrderInfoBean {
  String orderno;
  String creattime;
  String payat;


  OrderInfoBean();
  factory OrderInfoBean.fromJson(Map<String, dynamic> json) =>
      _$OrderInfoBeanFromJson(json);
  Map<String, dynamic> toJson() => _$OrderInfoBeanToJson(this);
}
