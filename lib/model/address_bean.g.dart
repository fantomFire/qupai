// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressBean _$AddressBeanFromJson(Map<String, dynamic> json) {
  return AddressBean()
    ..address_id = json['address_id']
    ..user_id = json['user_id']
    ..address_people = json['address_people'] as String
    ..address_add = json['address_add'] as String
    ..address_phone = json['address_phone'] as String
    ..address_status = json['address_status'] as String
    ..address_province = json['address_province'] as String
    ..address_city = json['address_city'] as String
    ..address_district = json['address_district'] as String
    ..create_time = json['create_time'];
}

Map<String, dynamic> _$AddressBeanToJson(AddressBean instance) =>
    <String, dynamic>{
      'address_id': instance.address_id,
      'user_id': instance.user_id,
      'address_people': instance.address_people,
      'address_add': instance.address_add,
      'address_phone': instance.address_phone,
      'address_status': instance.address_status,
      'address_province': instance.address_province,
      'address_city': instance.address_city,
      'address_district': instance.address_district,
      'create_time': instance.create_time,
    };
