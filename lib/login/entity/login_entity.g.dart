// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginEntity _$LoginEntityFromJson(Map<String, dynamic> json) {
  return LoginEntity()
    ..user_id = json['user_id']
    ..user_name = json['user_name'] as String
    ..user_phone = json['user_phone'] as String
    ..user_img = json['user_img'] as String
    ..user_level = json['user_level']
    ..user_status = json['user_status'] as String
    ..up_level_id = json['up_level_id']
    ..user_invitation_code = json['user_invitation_code']
    ..user_card_name = json['user_card_name'] as String
    ..user_token = json['user_token'] as String
    ..user_id_card = json['user_id_card'] as String
    ..create_time = json['create_time']
    ..user_password = json['user_password'] as String;
}

Map<String, dynamic> _$LoginEntityToJson(LoginEntity instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'user_name': instance.user_name,
      'user_phone': instance.user_phone,
      'user_img': instance.user_img,
      'user_level': instance.user_level,
      'user_status': instance.user_status,
      'up_level_id': instance.up_level_id,
      'user_invitation_code': instance.user_invitation_code,
      'user_card_name': instance.user_card_name,
      'user_token': instance.user_token,
      'user_id_card': instance.user_id_card,
      'create_time': instance.create_time,
      'user_password': instance.user_password,
    };
