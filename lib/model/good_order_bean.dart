import 'package:json_annotation/json_annotation.dart';
part 'good_order_bean.g.dart';
@JsonSerializable()
class GoodOrderBean{
  var id;
  var u_id;
  var goods_id;
  String goods_type;
  String goods_name;
  String goods_author;
  var number_stock;
  String goods_spec;
  String goods_price;
  String goods_pic;
  String order_no;
  String creat_at;
  String pay_at;
  String buyer_at;
  String remarks;
  String pay_voucher;
  var status;     //1待付款 2待确认 3申诉 4 已取消 5已完成6 待发货 7 待收货 8已收货
  String special_name;
  String goods_detail;
  var qr_time;
  String sj_phone;

  GoodOrderBean();
  factory GoodOrderBean.fromJson(Map<String, dynamic> json) =>
      _$GoodOrderBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GoodOrderBeanToJson(this);
}