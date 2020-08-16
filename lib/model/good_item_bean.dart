import 'package:json_annotation/json_annotation.dart';
part 'good_item_bean.g.dart';
@JsonSerializable()
class GoodItemBean{
  var id;
  var u_id;
String goods_type;
  String goods_name;
  String goods_author;
  var number_stock;
  String goods_spec;
  String goods_price;
  String goods_pic;
  var special_type;
  var special_is;
  var special_id;
  var status;
  String special_name;
  String goods_detail;

  GoodItemBean();
  factory GoodItemBean.fromJson(Map<String, dynamic> json) =>
      _$GoodItemBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GoodItemBeanToJson(this);
}