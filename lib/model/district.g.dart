// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

District _$DistrictFromJson(Map<String, dynamic> json) {
  return District()
    ..id = json['id'] as int
    ..code = json['code'] as String
    ..parentCode = json['parentCode'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$DistrictToJson(District instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'parentCode': instance.parentCode,
      'name': instance.name,
    };
