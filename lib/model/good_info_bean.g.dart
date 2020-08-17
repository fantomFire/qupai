// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'good_info_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodInfoBean _$GoodInfoBeanFromJson(Map<String, dynamic> json) {
  return GoodInfoBean()
    ..orderno = json['orderno'] as String
    ..goodsname = json['goodsname'] as String
    ..goodsauthor = json['goodsauthor'] as String
    ..goodsspec = json['goodsspec'] as String
    ..numberstock = json['numberstock'] as String
    ..goodsprice = json['goodsprice'] as String
    ..goods_pic = json['goods_pic'] as String;
}

Map<String, dynamic> _$GoodInfoBeanToJson(GoodInfoBean instance) =>
    <String, dynamic>{
      'orderno': instance.orderno,
      'goodsname': instance.goodsname,
      'goodsauthor': instance.goodsauthor,
      'goodsspec': instance.goodsspec,
      'numberstock': instance.numberstock,
      'goodsprice': instance.goodsprice,
      'goods_pic': instance.goods_pic,
    };
