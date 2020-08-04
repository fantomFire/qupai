// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerBean _$BannerBeanFromJson(Map<String, dynamic> json) {
  return BannerBean()
    ..id = json['id'] as num
    ..banner_pic = json['banner_pic'] as String
    ..creat_at = json['creat_at'] as String
    ..status = json['status'] as num;
}

Map<String, dynamic> _$BannerBeanToJson(BannerBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'banner_pic': instance.banner_pic,
      'creat_at': instance.creat_at,
      'status': instance.status,
    };
