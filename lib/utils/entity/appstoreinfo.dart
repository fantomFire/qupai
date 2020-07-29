import 'package:json_annotation/json_annotation.dart';
import 'package:qupai/utils/entity/versioninfo.dart';

part 'appstoreinfo.g.dart';

@JsonSerializable()
class AppStoreInfo {
  List<VersionInfo> results;

  AppStoreInfo();

  factory AppStoreInfo.fromJson(Map<String, dynamic> json) => _$AppStoreInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AppStoreInfoToJson(this);
}
