import 'package:json_annotation/json_annotation.dart';

part 'address_bean.g.dart';

@JsonSerializable()
class AddressBean {
  num id;
  num u_id;
  num status;
  String address_name;
  String address_phone;
  String address_region;
  String address_detailed;

  AddressBean();

  factory AddressBean.fromJson(Map<String, dynamic> json) =>
      _$AddressBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AddressBeanToJson(this);
}
