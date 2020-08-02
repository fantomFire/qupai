// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoBean _$UserInfoBeanFromJson(Map<String, dynamic> json) {
  return UserInfoBean()
    ..user_img = json['user_img'] as String
    ..user_phone = json['user_phone'] as String
    ..user_name = json['user_name'] as String
    ..user_card_status = json['user_card_status'] as String
    ..user_invitation_code = json['user_invitation_code']
    ..user_level = json['user_level']
    ..surplus = json['surplus']
    ..user_nickname = json['user_nickname'] as String
    ..bonus = json['bonus']
    ..address = json['address'] as String;
}

Map<String, dynamic> _$UserInfoBeanToJson(UserInfoBean instance) =>
    <String, dynamic>{
      'user_img': instance.user_img,
      'user_phone': instance.user_phone,
      'user_name': instance.user_name,
      'user_card_status': instance.user_card_status,
      'user_invitation_code': instance.user_invitation_code,
      'user_level': instance.user_level,
      'surplus': instance.surplus,
      'user_nickname': instance.user_nickname,
      'bonus': instance.bonus,
      'address': instance.address,
    };
