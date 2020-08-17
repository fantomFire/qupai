import 'package:json_annotation/json_annotation.dart';
import 'package:qupai/model/order_info_bean.dart';

import 'buy_info_bean.dart';
import 'good_info_bean.dart';

part 'sell_order_detail.g.dart';
@JsonSerializable()
class SellOrderDetail{
  var order_status;
  String payvoucher;
  GoodInfoBean goods;
  OrderInfoBean orderinfo;
  BuyInfoBean buyer;
  SellOrderDetail();

  factory SellOrderDetail.fromJson(Map<String, dynamic> json) =>
      _$SellOrderDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SellOrderDetailToJson(this);
}