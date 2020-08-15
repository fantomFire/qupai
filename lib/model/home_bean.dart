import 'package:json_annotation/json_annotation.dart';
import 'package:qupai/model/special_s.dart';
import 'package:qupai/model/special_x.dart';

import 'banner_bean.dart';

part 'home_bean.g.dart';

@JsonSerializable()
class HomeBean {
  List<BannerBean> banner;
  String show;
  String integral_pic;
  String s_begin;
  String s_end;
  String x_begin;
  String x_end;
  String notice;
  List<SpecialSBean> special_s;
  List<SpecialXBean> special_x;
  HomeBean();
  factory HomeBean.fromJson(Map<String, dynamic> json) =>
      _$HomeBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBeanToJson(this);
}
