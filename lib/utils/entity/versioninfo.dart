import 'package:json_annotation/json_annotation.dart';

part 'versioninfo.g.dart';

@JsonSerializable()
class VersionInfo {

  String version;

  VersionInfo();

  factory VersionInfo.fromJson(Map<String, dynamic> json) => _$VersionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VersionInfoToJson(this);
}
