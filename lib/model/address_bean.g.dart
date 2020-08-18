// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressBean _$AddressBeanFromJson(Map<String, dynamic> json) {
  return AddressBean()
    ..id = json['id'] as num
    ..u_id = json['u_id'] as num
    ..status = json['status'] as num
    ..address_name = json['address_name'] as String
    ..address_phone = json['address_phone'] as String
    ..address_region = json['address_region'] as String
    ..address_detailed = json['address_detailed'] as String;
}

Map<String, dynamic> _$AddressBeanToJson(AddressBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'u_id': instance.u_id,
      'status': instance.status,
      'address_name': instance.address_name,
      'address_phone': instance.address_phone,
      'address_region': instance.address_region,
      'address_detailed': instance.address_detailed,
    };
