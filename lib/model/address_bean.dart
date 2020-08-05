import 'package:json_annotation/json_annotation.dart';

part 'address_bean.g.dart';

@JsonSerializable()
class AddressBean {
  var address_id;
  var user_id;
  String address_people;

  String address_add;

  String address_phone;

  String address_status;
  String address_province;
  String address_city;
  String address_district;
  var create_time;

  AddressBean();

  factory AddressBean.fromJson(Map<String, dynamic> json) =>
      _$AddressBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AddressBeanToJson(this);
}
