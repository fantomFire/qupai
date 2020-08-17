// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_info_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyInfoBean _$BuyInfoBeanFromJson(Map<String, dynamic> json) {
  return BuyInfoBean()
    ..nickname = json['nickname'] as String
    ..username = json['username'] as String
    ..userphone = json['userphone'] as String;
}

Map<String, dynamic> _$BuyInfoBeanToJson(BuyInfoBean instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'username': instance.username,
      'userphone': instance.userphone,
    };
