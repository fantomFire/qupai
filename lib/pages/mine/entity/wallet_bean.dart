import 'package:json_annotation/json_annotation.dart';

part 'wallet_bean.g.dart';

@JsonSerializable()
class WalletBean {
  num id; //": 21,
  String tx_order; //": "202008131601449656",
  num tx_type; //": 1,
  num u_id; //": 24,
  String nickname; //": null,
  String user_phone; //": "15667073887",
  String user_name; //": "张三",
  String tx_money; //": "100.00",
  String tx_balance; //": "900.00",
  String commission; //": "10.00",
  String com_balance; //": "890.00",
  String tx_way; //": "支付宝",
  String zfb_nickname; //": "落落",
  String zfb_account; //": "1599170862",
  String creattime; //": "2020-08-15 17:40:55",
  num status; //": 1,
  num is_status; //":1.充值记录2.手续费记录3.提现记录


  String money; //": "1000.00",
  String cz_balance; //": "1000.00",
  String remarks; //": "后台充值",
  String wx_nickname; //": null,
  String cz_order; //": null,

  WalletBean();

  factory WalletBean.fromJson(Map<String, dynamic> json) =>
      _$WalletBeanFromJson(json);

  Map<String, dynamic> toJson() => _$WalletBeanToJson(this);
}
