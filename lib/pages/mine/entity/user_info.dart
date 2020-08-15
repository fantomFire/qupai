import 'package:json_annotation/json_annotation.dart';
part 'user_info.g.dart';
@JsonSerializable()
class UserInfoBean{
  num id;//": 24,
  num p_id;//": 0,
  String invite;//": "360010",
  String user_phone;//": "15667073887",
  String user_password;//": "8ddcff3a80f4189ca1c9d4d902c3c909",
  String user_name;//": null,
  String user_cid;//": null,
  String user_pic;//": null,
  String nickname;//": "",
  num level;//": 1,
  String level_date;//": null,
  String balance;//": "0.00",
  String integral;//": null,积分
  String com_balance;//": null,
  String wx_pic;//": null,
  String wx_name;//": null,
  String wx_account;//": null,
  String zfb_pic;//": null,
  String zfb_name;//": null,
  String zfb_account;//": null,
  String zfb_tx_account;//": null,
  String zfb_tx_name;//": null,
  String bank_name;//": null,
  String bank_open;//": null,
  String bank_branch;//": null,
  String bank_account;//": null,
  String creat_at;//": "2020-08-13 22:19:29",
  num cancel_num;//": 0,
  num is_disable;//": 1,
  String token;//": "553a9a5e6286e75941635894886113e8",
  num is_xt;//": 1,
  String address;//": ""
  UserInfoBean();
  factory UserInfoBean.fromJson(Map<String, dynamic> json) =>
      _$UserInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoBeanToJson(this);

}