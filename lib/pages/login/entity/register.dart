import 'package:json_annotation/json_annotation.dart';
part 'register.g.dart';
@JsonSerializable()
class RegisterEntity {
  String user_name;

  String user_phone;

  String user_password;

  var user_invitation_code;

  RegisterEntity();

  factory RegisterEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisterEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterEntityToJson(this);
}
