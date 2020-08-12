import 'package:json_annotation/json_annotation.dart';
import 'package:qupai/model/guide_bean.dart';

part 'user_guide_risk.g.dart';


@JsonSerializable()
class UserGuideRiskBean {
  UserGuideRiskBean();
  List<GuideBean> guide;
  List<GuideBean> risk;


  factory UserGuideRiskBean.fromJson(Map<String, dynamic> json) =>
      _$UserGuideRiskBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserGuideRiskBeanToJson(this);
}
