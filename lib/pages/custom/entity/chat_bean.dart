import 'package:json_annotation/json_annotation.dart';

part 'chat_bean.g.dart';
@JsonSerializable()
class ChatBean{
  var cs_id;
  String cs_wechat;
  String cs_image;
  var create_time;
  String cs_nickname;
  String cs_password;
  String user_name;
  var  cs_status;
  ChatBean();
  factory ChatBean.fromJson(Map<String, dynamic> json) => _$ChatBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ChatBeanToJson(this);
}