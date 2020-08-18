import 'package:json_annotation/json_annotation.dart';
import 'package:qupai/pages/mine/entity/share_bean.dart';
import 'package:qupai/pages/mine/entity/wallet_bean.dart';

part 'share_list_bean.g.dart';

@JsonSerializable()
class ShareListBean {
  String balance;
  List<ShareBean> incomeinfo;
  List<ShareBean> zc;

  ShareListBean();

  factory ShareListBean.fromJson(Map<String, dynamic> json) =>
      _$ShareListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ShareListBeanToJson(this);
}
