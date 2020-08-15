// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterEntity _$RegisterEntityFromJson(Map<String, dynamic> json) {
  return RegisterEntity()
    ..user_name = json['user_name'] as String
    ..user_phone = json['user_phone'] as String
    ..user_password = json['user_password'] as String
    ..user_invitation_code = json['user_invitation_code'];
}

Map<String, dynamic> _$RegisterEntityToJson(RegisterEntity instance) =>
    <String, dynamic>{
      'user_name': instance.user_name,
      'user_phone': instance.user_phone,
      'user_password': instance.user_password,
      'user_invitation_code': instance.user_invitation_code,
    };
