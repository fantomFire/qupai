// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletListBean _$WalletListBeanFromJson(Map<String, dynamic> json) {
  return WalletListBean()
    ..balance = json['balance'] as String
    ..jl = (json['jl'] as List)
        ?.map((e) =>
            e == null ? null : WalletBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$WalletListBeanToJson(WalletListBean instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'jl': instance.jl,
    };
