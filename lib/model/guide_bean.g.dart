// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideBean _$GuideBeanFromJson(Map<String, dynamic> json) {
  return GuideBean()
    ..id = json['id'] as num
    ..status = json['status'] as num
    ..title = json['title'] as String
    ..content = json['content'] as String
    ..creat_at = json['creat_at'] as String;
}

Map<String, dynamic> _$GuideBeanToJson(GuideBean instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'title': instance.title,
      'content': instance.content,
      'creat_at': instance.creat_at,
    };
