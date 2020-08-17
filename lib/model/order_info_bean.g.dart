// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_info_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderInfoBean _$OrderInfoBeanFromJson(Map<String, dynamic> json) {
  return OrderInfoBean()
    ..orderno = json['orderno'] as String
    ..creattime = json['creattime'] as String
    ..payat = json['payat'] as String;
}

Map<String, dynamic> _$OrderInfoBeanToJson(OrderInfoBean instance) =>
    <String, dynamic>{
      'orderno': instance.orderno,
      'creattime': instance.creattime,
      'payat': instance.payat,
    };
