import 'package:flutter/material.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/model/good_order_bean.dart';
import 'package:qupai/urls.dart';
import 'package:qupai/utils/imageutil.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';

class CommonOrder extends StatelessWidget {
  final GoodOrderBean goodOrderBean;

  const CommonOrder({Key key, this.goodOrderBean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BaseColor.color_ffffff,
      child: Column(
        children: <Widget>[
          Container(
            height: 26,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextView(
                  "订单编号: ${goodOrderBean?.order_no}",
                  style: TextStyles.color_999999_12,
                ),
                TextView(
                  UiUtils.getOrderState(goodOrderBean?.status),
                  style: TextStyles.color_999999_12,
                ),
              ],
            ),
          ),
          Line(),
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 13, right: 10),
            child: Row(
              children: <Widget>[
                goodOrderBean?.goods_pic == null
                    ? Container()
                    : ImageLoadUtil(
                        url: Urls.imageBase + goodOrderBean?.goods_pic,
                        width: 90,
                        height: 90,
                        fit: BoxFit.fill,
                      ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    height: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextView(
                          goodOrderBean?.goods_name,
                          style: TextStyles.color_333333_14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        TextView(
                          '作者：${goodOrderBean?.goods_author}',
                          style: TextStyles.color_999999_13,
                        ),
                        TextView(
                          '规格：${goodOrderBean?.goods_spec}',
                          style: TextStyles.color_999999_13,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextView(
                                '库号：${goodOrderBean?.number_stock}',
                                style: TextStyles.color_999999_13,
                              ),
                              TextView(
                                '合计：${goodOrderBean?.goods_price} ',
                                style: TextStyles.color_999999_13,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Line(
            height: 10,
          ),
          Container(
            height: 44,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16),
            child: TextView(
              '订单信息',
              style: TextStyles.color_333333_16,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextView(
                    '订单编号',
                    style: TextStyles.color_333333_13,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextView(
                    '${goodOrderBean?.order_no}',
                    style: TextStyles.color_333333_13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, top: 14),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextView(
                    '创建时间',
                    style: TextStyles.color_333333_13,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextView(
                    '${goodOrderBean?.creat_at ?? ""}',
                    style: TextStyles.color_333333_13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, top: 14),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextView(
                    '付款时间',
                    style: TextStyles.color_333333_13,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextView(
                    '${goodOrderBean?.buyer_at ?? ""}',
                    style: TextStyles.color_333333_13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, top: 14),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextView(
                    '确认收款时间:',
                    style: TextStyles.color_333333_13,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextView(
                    '${goodOrderBean?.qr_time ?? ""}',
                    style: TextStyles.color_333333_13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, top: 14, bottom: 14, right: 16),
            width: double.infinity,
            child: TextView(
              '联系电话：${goodOrderBean?.sj_phone}（可联系商家处理）',
              style: TextStyles.color_999999_11,
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
