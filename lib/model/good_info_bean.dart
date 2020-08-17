import 'package:json_annotation/json_annotation.dart';

part 'good_info_bean.g.dart';
@JsonSerializable()
class GoodInfoBean{
  String orderno;
  String goodsname;
  String goodsauthor;
  String goodsspec;
  String numberstock;
  String goodsprice;
  String goods_pic;

  GoodInfoBean();

  factory GoodInfoBean.fromJson(Map<String, dynamic> json) =>
      _$GoodInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GoodInfoBeanToJson(this);

}