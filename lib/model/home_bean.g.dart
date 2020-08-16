// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBean _$HomeBeanFromJson(Map<String, dynamic> json) {
  return HomeBean()
    ..banner = (json['banner'] as List)
        ?.map((e) =>
            e == null ? null : BannerBean.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..show = json['show'] as String
    ..integral_pic = json['integral_pic'] as String
    ..s_begin = json['s_begin'] as String
    ..s_end = json['s_end'] as String
    ..x_begin = json['x_begin'] as String
    ..x_end = json['x_end'] as String
    ..notice = json['notice'] as String
    ..special_s = (json['special_s'] as List)
        ?.map((e) =>
            e == null ? null : SpecialSBean.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..special_x = (json['special_x'] as List)
        ?.map((e) =>
            e == null ? null : SpecialXBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HomeBeanToJson(HomeBean instance) => <String, dynamic>{
      'banner': instance.banner,
      'show': instance.show,
      'integral_pic': instance.integral_pic,
      's_begin': instance.s_begin,
      's_end': instance.s_end,
      'x_begin': instance.x_begin,
      'x_end': instance.x_end,
      'notice': instance.notice,
      'special_s': instance.special_s,
      'special_x': instance.special_x,
    };
