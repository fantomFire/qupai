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
  var special_type; //1上午场 2 下午场
  var special_is;   //1 特价场 2，普通场
  var special_id;
  var status;
  var is_xj ; // 1 下架 2 上架
  String special_name;
  String goods_detail;
  String bz;


  GoodItemBean();
  factory GoodItemBean.fromJson(Map<String, dynamic> json) =>
      _$GoodItemBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GoodItemBeanToJson(this);
}