// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletBean _$WalletBeanFromJson(Map<String, dynamic> json) {
  return WalletBean()
    ..id = json['id'] as num
    ..tx_order = json['tx_order'] as String
    ..tx_type = json['tx_type'] as num
    ..u_id = json['u_id'] as num
    ..nickname = json['nickname'] as String
    ..user_phone = json['user_phone'] as String
    ..user_name = json['user_name'] as String
    ..tx_money = json['tx_money'] as String
    ..tx_balance = json['tx_balance'] as String
    ..commission = json['commission'] as String
    ..com_balance = json['com_balance'] as String
    ..tx_way = json['tx_way'] as String
    ..zfb_nickname = json['zfb_nickname'] as String
    ..zfb_account = json['zfb_account'] as String
    ..creattime = json['creattime'] as String
    ..status = json['status'] as num
    ..is_status = json['is_status'] as num
    ..money = json['money'] as String
    ..cz_balance = json['cz_balance'] as String
    ..remarks = json['remarks'] as String
    ..wx_nickname = json['wx_nickname'] as String
    ..cz_order = json['cz_order'] as String;
}

Map<String, dynamic> _$WalletBeanToJson(WalletBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tx_order': instance.tx_order,
      'tx_type': instance.tx_type,
      'u_id': instance.u_id,
      'nickname': instance.nickname,
      'user_phone': instance.user_phone,
      'user_name': instance.user_name,
      'tx_money': instance.tx_money,
      'tx_balance': instance.tx_balance,
      'commission': instance.commission,
      'com_balance': instance.com_balance,
      'tx_way': instance.tx_way,
      'zfb_nickname': instance.zfb_nickname,
      'zfb_account': instance.zfb_account,
      'creattime': instance.creattime,
      'status': instance.status,
      'is_status': instance.is_status,
      'money': instance.money,
      'cz_balance': instance.cz_balance,
      'remarks': instance.remarks,
      'wx_nickname': instance.wx_nickname,
      'cz_order': instance.cz_order,
    };
