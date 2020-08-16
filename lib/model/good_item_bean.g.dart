// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'good_item_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodItemBean _$GoodItemBeanFromJson(Map<String, dynamic> json) {
  return GoodItemBean()
    ..id = json['id']
    ..u_id = json['u_id']
    ..goods_type = json['goods_type'] as String
    ..goods_name = json['goods_name'] as String
    ..goods_author = json['goods_author'] as String
    ..number_stock = json['number_stock']
    ..goods_spec = json['goods_spec'] as String
    ..goods_price = json['goods_price'] as String
    ..goods_pic = json['goods_pic'] as String
    ..special_type = json['special_type']
    ..special_is = json['special_is']
    ..special_id = json['special_id']
    ..status = json['status']
    ..bz = json['bz'] as String
    ..special_name = json['special_name'] as String
    ..goods_detail = json['goods_detail'] as String;
}

Map<String, dynamic> _$GoodItemBeanToJson(GoodItemBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'u_id': instance.u_id,
      'goods_type': instance.goods_type,
      'bz': instance.bz,
      'goods_name': instance.goods_name,
      'goods_author': instance.goods_author,
      'number_stock': instance.number_stock,
      'goods_spec': instance.goods_spec,
      'goods_price': instance.goods_price,
      'goods_pic': instance.goods_pic,
      'special_type': instance.special_type,
      'special_is': instance.special_is,
      'special_id': instance.special_id,
      'status': instance.status,
      'special_name': instance.special_name,
      'goods_detail': instance.goods_detail,
    };
