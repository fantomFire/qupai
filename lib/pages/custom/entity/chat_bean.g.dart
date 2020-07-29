// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatBean _$ChatBeanFromJson(Map<String, dynamic> json) {
  return ChatBean()
    ..cs_id = json['cs_id']
    ..cs_wechat = json['cs_wechat'] as String
    ..cs_image = json['cs_image'] as String
    ..create_time = json['create_time']
    ..cs_nickname = json['cs_nickname'] as String
    ..cs_password = json['cs_password'] as String
    ..user_name = json['user_name'] as String
    ..cs_status = json['cs_status'];
}

Map<String, dynamic> _$ChatBeanToJson(ChatBean instance) => <String, dynamic>{
      'cs_id': instance.cs_id,
      'cs_wechat': instance.cs_wechat,
      'cs_image': instance.cs_image,
      'create_time': instance.create_time,
      'cs_nickname': instance.cs_nickname,
      'cs_password': instance.cs_password,
      'user_name': instance.user_name,
      'cs_status': instance.cs_status,
    };
