// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerBean _$CustomerBeanFromJson(Map<String, dynamic> json) {
  return CustomerBean()
    ..cs_id = json['cs_id']
    ..cs_wechat = json['cs_wechat'] as String
    ..create_time = json['create_time']
    ..cs_qrcode = json['cs_qrcode'] as String
    ..cs_nickname = json['cs_nickname'] as String;
}

Map<String, dynamic> _$CustomerBeanToJson(CustomerBean instance) =>
    <String, dynamic>{
      'cs_id': instance.cs_id,
      'cs_wechat': instance.cs_wechat,
      'create_time': instance.create_time,
      'cs_qrcode': instance.cs_qrcode,
      'cs_nickname': instance.cs_nickname,
    };
