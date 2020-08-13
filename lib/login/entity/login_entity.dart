import 'package:json_annotation/json_annotation.dart';
part 'login_entity.g.dart';
@JsonSerializable()
class LoginEntity {
  var user_id;
  String user_phone;
  String user_token;
  LoginEntity();
  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginEntityToJson(this);
}
