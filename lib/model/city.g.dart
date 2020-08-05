// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) {
  return City()
    ..id = json['id'] as int
    ..code = json['code'] as String
    ..parentCode = json['parentCode'] as String
    ..name = json['name'] as String
    ..children = (json['children'] as List)
        ?.map((e) =>
            e == null ? null : District.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'parentCode': instance.parentCode,
      'name': instance.name,
      'children': instance.children,
    };
