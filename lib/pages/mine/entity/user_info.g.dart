// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoBean _$UserInfoBeanFromJson(Map<String, dynamic> json) {
  return UserInfoBean()
    ..id = json['id'] as num
    ..p_id = json['p_id'] as num
    ..invite = json['invite'] as String
    ..user_phone = json['user_phone'] as String
    ..user_password = json['user_password'] as String
    ..user_name = json['user_name'] as String
    ..user_cid = json['user_cid'] as String
    ..user_pic = json['user_pic'] as String
    ..nickname = json['nickname'] as String
    ..level = json['level'] as num
    ..level_date = json['level_date'] as String
    ..balance = json['balance'] as String
    ..integral = json['integral'] as String
    ..com_balance = json['com_balance'] as String
    ..wx_pic = json['wx_pic'] as String
    ..wx_name = json['wx_name'] as String
    ..wx_account = json['wx_account'] as String
    ..zfb_pic = json['zfb_pic'] as String
    ..zfb_name = json['zfb_name'] as String
    ..zfb_account = json['zfb_account'] as String
    ..zfb_tx_account = json['zfb_tx_account'] as String
    ..zfb_tx_name = json['zfb_tx_name'] as String
    ..bank_name = json['bank_name'] as String
    ..bank_open = json['bank_open'] as String
    ..bank_branch = json['bank_branch'] as String
    ..bank_account = json['bank_account'] as String
    ..creat_at = json['creat_at'] as String
    ..cancel_num = json['cancel_num'] as num
    ..is_disable = json['is_disable'] as num
    ..token = json['token'] as String
    ..is_xt = json['is_xt'] as num
    ..address = json['address'] as String;
}

Map<String, dynamic> _$UserInfoBeanToJson(UserInfoBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'p_id': instance.p_id,
      'invite': instance.invite,
      'user_phone': instance.user_phone,
      'user_password': instance.user_password,
      'user_name': instance.user_name,
      'user_cid': instance.user_cid,
      'user_pic': instance.user_pic,
      'nickname': instance.nickname,
      'level': instance.level,
      'level_date': instance.level_date,
      'balance': instance.balance,
      'integral': instance.integral,
      'com_balance': instance.com_balance,
      'wx_pic': instance.wx_pic,
      'wx_name': instance.wx_name,
      'wx_account': instance.wx_account,
      'zfb_pic': instance.zfb_pic,
      'zfb_name': instance.zfb_name,
      'zfb_account': instance.zfb_account,
      'zfb_tx_account': instance.zfb_tx_account,
      'zfb_tx_name': instance.zfb_tx_name,
      'bank_name': instance.bank_name,
      'bank_open': instance.bank_open,
      'bank_branch': instance.bank_branch,
      'bank_account': instance.bank_account,
      'creat_at': instance.creat_at,
      'cancel_num': instance.cancel_num,
      'is_disable': instance.is_disable,
      'token': instance.token,
      'is_xt': instance.is_xt,
      'address': instance.address,
    };
