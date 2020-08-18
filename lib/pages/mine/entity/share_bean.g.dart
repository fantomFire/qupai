// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareBean _$ShareBeanFromJson(Map<String, dynamic> json) {
  return ShareBean()
    ..id = json['id'] as num
    ..u_id = json['u_id'] as num
    ..order_no = json['order_no'] as String
    ..money = json['money'] as String
    ..remarks = json['remarks'] as String
    ..m_id = json['m_id'] as num
    ..creattime = json['creattime'] as String
    ..userpic = json['userpic'] as String
    ..nickname = json['nickname'] as String
    ..level = json['level'] as num
    ..phone = json['phone'] as String
    ..tx_order = json['tx_order'] as String
    ..tx_type = json['tx_type'] as num
    ..user_phone = json['user_phone'] as String
    ..user_name = json['user_name'] as String
    ..tx_money = json['tx_money'] as String
    ..tx_balance = json['tx_balance'] as String
    ..commission = json['commission'] as String
    ..com_balance = json['com_balance'] as String
    ..tx_way = json['tx_way'] as String
    ..zfb_nickname = json['zfb_nickname'] as String
    ..zfb_account = json['zfb_account'] as String
    ..status = json['status'] as num
    ..is_status = json['is_status'] as num;
}

Map<String, dynamic> _$ShareBeanToJson(ShareBean instance) => <String, dynamic>{
      'id': instance.id,
      'u_id': instance.u_id,
      'order_no': instance.order_no,
      'money': instance.money,
      'remarks': instance.remarks,
      'm_id': instance.m_id,
      'creattime': instance.creattime,
      'userpic': instance.userpic,
      'nickname': instance.nickname,
      'level': instance.level,
      'phone': instance.phone,
      'tx_order': instance.tx_order,
      'tx_type': instance.tx_type,
      'user_phone': instance.user_phone,
      'user_name': instance.user_name,
      'tx_money': instance.tx_money,
      'tx_balance': instance.tx_balance,
      'commission': instance.commission,
      'com_balance': instance.com_balance,
      'tx_way': instance.tx_way,
      'zfb_nickname': instance.zfb_nickname,
      'zfb_account': instance.zfb_account,
      'status': instance.status,
      'is_status': instance.is_status,
    };
