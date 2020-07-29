// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_detail_bean_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntity _$MessageEntityFromJson(Map<String, dynamic> json) {
  return MessageEntity()
    ..id = json['id']
    ..user_nickname = json['user_nickname'] as String
    ..user_id = json['user_id']
    ..user_img = json['user_img'] as String
    ..cs_image = json['cs_image'] as String
    ..cs_nickname = json['cs_nickname'] as String
    ..conetent = json['conetent'] as String
    ..create_time = json['create_time']
    ..chat_type = json['chat_type']
    ..sender = json['sender'];
}

Map<String, dynamic> _$MessageEntityToJson(MessageEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_nickname': instance.user_nickname,
      'user_id': instance.user_id,
      'user_img': instance.user_img,
      'cs_image': instance.cs_image,
      'cs_nickname': instance.cs_nickname,
      'conetent': instance.conetent,
      'create_time': instance.create_time,
      'chat_type': instance.chat_type,
      'sender': instance.sender,
    };
