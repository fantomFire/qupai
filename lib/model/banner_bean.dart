import 'package:json_annotation/json_annotation.dart';

part 'banner_bean.g.dart';

@JsonSerializable()
class BannerBean {


  num id;
  String banner_pic;
  String creat_at;

  num status;
  BannerBean();
  factory BannerBean.fromJson(Map<String, dynamic> json) =>
      _$BannerBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BannerBeanToJson(this);
}
