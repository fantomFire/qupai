// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'good_order_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodOrderBean _$GoodOrderBeanFromJson(Map<String, dynamic> json) {
  return GoodOrderBean()
    ..id = json['id']
    ..u_id = json['u_id']
    ..goods_id = json['goods_id']
    ..goods_type = json['goods_type'] as String
    ..goods_name = json['goods_name'] as String
    ..goods_author = json['goods_author'] as String
    ..number_stock = json['number_stock']
    ..goods_spec = json['goods_spec'] as String
    ..goods_price = json['goods_price'] as String
    ..goods_pic = json['goods_pic'] as String
    ..order_no = json['order_no'] as String
    ..creat_at = json['creat_at'] as String
    ..pay_at = json['pay_at'] as String
    ..buyer_at = json['buyer_at'] as String
    ..remarks = json['remarks'] as String
    ..pay_voucher = json['pay_voucher'] as String
    ..status = json['status']
    ..special_name = json['special_name'] as String
    ..goods_detail = json['goods_detail'] as String
    ..qr_time = json['qr_time']
    ..sj_phone = json['sj_phone'] as String;
}

Map<String, dynamic> _$GoodOrderBeanToJson(GoodOrderBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'u_id': instance.u_id,
      'goods_id': instance.goods_id,
      'goods_type': instance.goods_type,
      'goods_name': instance.goods_name,
      'goods_author': instance.goods_author,
      'number_stock': instance.number_stock,
      'goods_spec': instance.goods_spec,
      'goods_price': instance.goods_price,
      'goods_pic': instance.goods_pic,
      'order_no': instance.order_no,
      'creat_at': instance.creat_at,
      'pay_at': instance.pay_at,
      'buyer_at': instance.buyer_at,
      'remarks': instance.remarks,
      'pay_voucher': instance.pay_voucher,
      'status': instance.status,
      'special_name': instance.special_name,
      'goods_detail': instance.goods_detail,
      'qr_time': instance.qr_time,
      'sj_phone': instance.sj_phone,
    };
