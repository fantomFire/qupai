import 'package:json_annotation/json_annotation.dart';
import 'good_item_bean.dart';
part 'good_list_bean.g.dart';

@JsonSerializable()
class GoodListBean {
  String user_id;
  var kjc;  // 1 不可提前进场 2 可提前进场
  String pic;
  String begin_time;
  String end_time;
  List<GoodItemBean> k_goods;
  List<GoodItemBean> y_goods;

  GoodListBean();

  factory GoodListBean.fromJson(Map<String, dynamic> json) =>
      _$GoodListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GoodListBeanToJson(this);
}
