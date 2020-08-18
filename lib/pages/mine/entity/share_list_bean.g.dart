// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareListBean _$ShareListBeanFromJson(Map<String, dynamic> json) {
  return ShareListBean()
    ..balance = json['balance'] as String
    ..incomeinfo = (json['incomeinfo'] as List)
        ?.map((e) =>
            e == null ? null : ShareBean.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..zc = (json['zc'] as List)
        ?.map((e) =>
            e == null ? null : ShareBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ShareListBeanToJson(ShareListBean instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'incomeinfo': instance.incomeinfo,
      'zc': instance.zc,
    };
