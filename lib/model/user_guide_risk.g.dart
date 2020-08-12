// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_guide_risk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGuideRiskBean _$UserGuideRiskBeanFromJson(Map<String, dynamic> json) {
  return UserGuideRiskBean()
    ..guide = (json['guide'] as List)
        ?.map((e) =>
            e == null ? null : GuideBean.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..risk = (json['risk'] as List)
        ?.map((e) =>
            e == null ? null : GuideBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserGuideRiskBeanToJson(UserGuideRiskBean instance) =>
    <String, dynamic>{
      'guide': instance.guide,
      'risk': instance.risk,
    };
