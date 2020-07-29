import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/common_views/refeshview_custom.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';

class OrderScreenDemand extends StatefulWidget {

  final int status;

  const OrderScreenDemand({Key key, this.status})
      : super(key: key);

  @override
  _OrderScreenDemandState createState() => _OrderScreenDemandState();
}

class _OrderScreenDemandState extends State<OrderScreenDemand>
    with AutomaticKeepAliveClientMixin {
  bool isFail = false;
  int userId;
  EasyRefreshController _easyRefreshController = EasyRefreshController();

  bool _hasNoMore = true;
  int curPage = 1;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: 5),
        constraints: BoxConstraints.expand(),
        child: RefreshViewCustom(
          _easyRefreshController,
          failState: isFail,
          noMore: _hasNoMore,
          reRefresh: () {

            setState(() {
              isFail = false;
            });
          },
          childCount: 3,
          childItem: (context, index) {
            return
                 _createByHomeOrder(index);

          },
          onRefresh: () async{
            curPage = 1;
          },
          onLoadMore: () {
            curPage++;
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _createByHomeOrder(index) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
         /*   NavigatorUtil.pushNamed(context, "/order_detail", arguments: {
              'goods_order_id': orderList[index].goods_order_id.toString()
            }).then((v) {
              if (v != null) {
             _easyRefreshController.callRefresh();
              }
            });*/
          },
          child: Container(
            color: BaseColor.color_ffffff,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: <Widget>[
                Container(
                  height: 26,
                  alignment: Alignment.centerLeft,
                  child: TextView(
                    "订单编号:2222222",
                    style: TextStyles.color_999999_12,
                  ),
                ),
                Line(),
             /*   Container(
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      ImageUtil(
                        url: "${Urls.imageBase}${orderList[index].goods_oimg}",
                        width: 90,
                        height: 90,
                        fit: BoxFit.fill,
                      ),
                      Expanded(
                        child: Container(
                          height: 110,
                          margin: EdgeInsets.only(left: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              TextView(
                                orderList[index]?.goods_title,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: BaseColor.color_333333),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Row(
                                children: <Widget>[
                                  *//*TextView(
                                    "分类",
                                    style: TextStyles.color_999999_14,
                                  ),*//*
                                  Expanded(
                                    flex: 3,
                                      child: Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 4),
                                    child: TextView(
                                      UiUtils.getSub(
                                          orderList[index].order_goods_subcate),
                                      style: TextStyles.color_999999_13,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  )),
                                  Expanded(
                                    flex: 1,
                                      child: Container(
                                    margin: EdgeInsets.only(right: 5),
                                    alignment: Alignment.centerRight,
                                    child: TextView(
                                      'X ${StringUtils.parsInt(orderList[index].goods_order_num)}',
                                      style: TextStyles.color_D68_14,
                                    ),
                                  ))
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: TextView(
                                  '￥ ${StringUtils.parsInt(orderList[index].price)}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: BaseColor.color_eb332a),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: TextView(
                                      '共 ${StringUtils.parsInt(orderList[index].goods_order_num)} 件合计: ${StringUtils.parsInt(orderList[index].order_price)}',
                                      style: TextStyles.color_999999_12,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      width: 65,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: getHomeColor(orderList[index]),
                                      ),
                                      child: TextView(
                                        getHomeStateButton(orderList[index]),
                                        style: TextStyles.color_ffffff_14,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),*/
                Line(),
//                Container(
//                  margin: EdgeInsets.only(top: 10, bottom: 10),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          TextView(
//                            "本金",
//                            style: TextStyles.color_333333_13,
//                          ),
//                          Container(
//                            margin: EdgeInsets.only(top: 10),
//                            child: TextView(
//                              orderList[index].order_price.toString(),
//                              style: TextStyles.color_D68_12,
//                            ),
//                          )
//                        ],
//                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          TextView(
//                            "挂卖天数",
//                            style: TextStyles.color_333333_13,
//                          ),
//                          Container(
//                            margin: EdgeInsets.only(top: 10),
//                            child: TextView(
//                              "  orderList[index].good",
//                              style: TextStyles.color_D68_12,
//                            ),
//                          )
//                        ],
//                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          TextView(
//                            "利率",
//                            style: TextStyles.color_333333_13,
//                          ),
//                          Container(
//                            margin: EdgeInsets.only(top: 10),
//                            child: TextView(
//                              "orderList[index].",
//                              style: TextStyles.color_D68_12,
//                            ),
//                          )
//                        ],
//                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          TextView(
//                            "预计收入",
//                            style: TextStyles.color_333333_13,
//                          ),
//                          Container(
//                            margin: EdgeInsets.only(top: 10),
//                            child: TextView(
//                              "892222",
//                              style: TextStyles.color_D68_12,
//                            ),
//                          )
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
              ],
            ),
          ),
        ),
        Line(
          height: 10,
        )
      ],
    );
  }

}
