import 'package:json_annotation/json_annotation.dart';

part 'share_bean.g.dart';

@JsonSerializable()
class ShareBean {
  num id;//": 5,
  num u_id;//": 24,
  String order_no;//": null,
  String money;//": "10.00",
  String remarks;//": "收入",
  num m_id;//": 2,
  String creattime;//": "2020-08-15 17:58:33",
  String userpic;//": "upload/20200805/timg.jpg",
  String nickname;//": "小红同学",
  num level;//": 5,
  String phone;//": "13643570622"
  String tx_order;//": "202008131601445696",
  num tx_type;//": 2,

  String user_phone;//": "15667073887",
  String user_name;//": "张三",
  String tx_money;//": "10.00",
  String tx_balance;//": "10.00",
  String commission;//": "10.00",
  String com_balance;//": "900.00",
  String tx_way;//": null,
  String zfb_nickname;//": null,
  String zfb_account;//": null,
  num status;//": 1,
  num is_status;//": 1

  ShareBean();

  factory ShareBean.fromJson(Map<String, dynamic> json) =>
      _$ShareBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ShareBeanToJson(this);
}
