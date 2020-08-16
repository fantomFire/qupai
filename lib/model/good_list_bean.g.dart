// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'good_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodListBean _$GoodListBeanFromJson(Map<String, dynamic> json) {
  return GoodListBean()
    ..user_id = json['user_id'] as String
    ..kjc = json['kjc']
    ..pic = json['pic'] as String
    ..begin_time = json['begin_time'] as String
    ..end_time = json['end_time'] as String
    ..k_goods = (json['k_goods'] as List)
        ?.map((e) =>
            e == null ? null : GoodItemBean.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..y_goods = (json['y_goods'] as List)
        ?.map((e) =>
            e == null ? null : GoodItemBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GoodListBeanToJson(GoodListBean instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'kjc': instance.kjc,
      'pic': instance.pic,
      'begin_time': instance.begin_time,
      'end_time': instance.end_time,
      'k_goods': instance.k_goods,
      'y_goods': instance.y_goods,
    };
