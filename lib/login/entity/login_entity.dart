import 'package:json_annotation/json_annotation.dart';
part 'login_entity.g.dart';
@JsonSerializable()
class LoginEntity {
  var user_id;
  String user_name;
  String user_phone;
  String user_img;
  var user_level;
  String user_status;
  var up_level_id;
  var user_invitation_code;
  String user_card_name;
  String user_token;
  String user_id_card;
  var create_time;
  String user_password;
  LoginEntity();
  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginEntityToJson(this);
}
