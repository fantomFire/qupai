// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Province _$ProvinceFromJson(Map<String, dynamic> json) {
  return Province()
    ..id = json['id'] as int
    ..code = json['code'] as String
    ..parentCode = json['parentCode'] as String
    ..name = json['name'] as String
    ..children = (json['children'] as List)
        ?.map(
            (e) => e == null ? null : City.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ProvinceToJson(Province instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'parentCode': instance.parentCode,
      'name': instance.name,
      'children': instance.children,
    };
