import 'package:json_annotation/json_annotation.dart';
part 'user_info.g.dart';
@JsonSerializable()
class UserInfoBean{
  String user_img;
  String user_phone;
  String user_name;
  String user_card_status;
  var user_invitation_code;
  var user_level;
  var surplus;
String user_nickname;
  var bonus;

  String address;
  UserInfoBean();
  factory UserInfoBean.fromJson(Map<String, dynamic> json) =>
      _$UserInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoBeanToJson(this);

}