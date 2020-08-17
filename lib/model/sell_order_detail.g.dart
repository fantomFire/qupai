// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sell_order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellOrderDetail _$SellOrderDetailFromJson(Map<String, dynamic> json) {
  return SellOrderDetail()
    ..order_status = json['order_status']
    ..payvoucher = json['payvoucher'] as String
    ..goods = json['goods'] == null
        ? null
        : GoodInfoBean.fromJson(json['goods'] as Map<String, dynamic>)
    ..orderinfo = json['orderinfo'] == null
        ? null
        : OrderInfoBean.fromJson(json['orderinfo'] as Map<String, dynamic>)
    ..buyer = json['buyer'] == null
        ? null
        : BuyInfoBean.fromJson(json['buyer'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SellOrderDetailToJson(SellOrderDetail instance) =>
    <String, dynamic>{
      'order_status': instance.order_status,
      'payvoucher': instance.payvoucher,
      'goods': instance.goods,
      'orderinfo': instance.orderinfo,
      'buyer': instance.buyer,
    };
