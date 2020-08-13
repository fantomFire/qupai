// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginEntity _$LoginEntityFromJson(Map<String, dynamic> json) {
  return LoginEntity()
    ..user_id = json['user_id']
    ..user_phone = json['user_phone'] as String
    ..user_token = json['user_token'] as String;

}

Map<String, dynamic> _$LoginEntityToJson(LoginEntity instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'user_phone': instance.user_phone,
      'user_token': instance.user_token,
    };
