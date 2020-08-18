import 'package:json_annotation/json_annotation.dart';
import 'package:qupai/pages/mine/entity/wallet_bean.dart';

part 'wallet_list_bean.g.dart';

@JsonSerializable()
class WalletListBean {
  String balance;
  List<WalletBean> jl;

  WalletListBean();

  factory WalletListBean.fromJson(Map<String, dynamic> json) =>
      _$WalletListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$WalletListBeanToJson(this);
}
