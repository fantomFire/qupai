import 'package:json_annotation/json_annotation.dart';

part 'guide_bean.g.dart';

@JsonSerializable()
class GuideBean {
  GuideBean();

  num id;
  num status;
  String title;
  String content;
  String creat_at;

  factory GuideBean.fromJson(Map<String, dynamic> json) =>
      _$GuideBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GuideBeanToJson(this);
}
