// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appstoreinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppStoreInfo _$AppStoreInfoFromJson(Map<String, dynamic> json) {
  return AppStoreInfo()
    ..results = (json['results'] as List)
        ?.map((e) =>
            e == null ? null : VersionInfo.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AppStoreInfoToJson(AppStoreInfo instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
