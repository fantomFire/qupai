import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/common_views/refeshview_custom.dart';
import 'package:qupai/model/good_order_bean.dart';
import 'package:qupai/urls.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/imageutil.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';

class OrderScreenDemand extends StatefulWidget {
  final int status;

  const OrderScreenDemand({Key key, this.status}) : super(key: key);

  @override
  _OrderScreenDemandState createState() => _OrderScreenDemandState();
}

class _OrderScreenDemandState extends State<OrderScreenDemand>
    with AutomaticKeepAliveClientMixin {
  bool isFail = false;
  int userId;
  EasyRefreshController _easyRefreshController = EasyRefreshController();
  List<GoodOrderBean> orderList = List();

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
          childCount: orderList.length,
          childItem: (context, index) {
            return _createByHomeOrder(orderList[index]);
          },
          onRefresh: () async {
            curPage = 1;
            getListInfo(true);
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _createByHomeOrder(GoodOrderBean info) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pushNamed(context, getRout(info.status), arguments: {
          'id': info.id.toString(),
          'orderStatus': info.status
        }).then((v) {
          if (v != null) {
            _easyRefreshController.callRefresh();
          }
        });
      },
      child: Card(
        color: BaseColor.color_ffffff,
        margin: EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          children: <Widget>[
            Container(
              height: 26,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextView(
                    "订单编号: ${info.order_no}",
                    style: TextStyles.color_999999_12,
                  ),
                  TextView(
                    UiUtils.getOrderState(info.status),
                    style: TextStyles.color_999999_12,
                  ),
                ],
              ),
            ),
            Line(),
            Container(
              padding:
                  EdgeInsets.only(left: 10, top: 10, bottom: 13, right: 10),
              child: Row(
                children: <Widget>[
                  ImageLoadUtil(
                    url: Urls.imageBase + info.goods_pic,
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
                            '${info.goods_name}',
                            style: TextStyles.color_333333_14,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          TextView(
                            '库号：${info.number_stock}',
                            style: TextStyles.color_999999_13,
                          ),
                          TextView(
                            '规格：${info.goods_spec}',
                            style: TextStyles.color_999999_13,
                          ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextView(
                                  '合计：',
                                  style: TextStyles.color_999999_13,
                                  textAlign: TextAlign.right,
                                ),
                                TextView(
                                  '￥ ${info.goods_price}',
                                  style: TextStyles.color_C60000_13,
                                  textAlign: TextAlign.right,
                                )
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
            Line(),
            getBottomItem(info.status),
          ],
        ),
      ),
    );
  }

  void getListInfo(bool init) async {
    HttpResponse response;
    if (widget.status == 0) {
      response = await HttpUtil.send(
          context, "post", Urls.orderAll, {'user_id': UiUtils.getUserId()},
          initState: init);
    } else if (widget.status == 1) {
      response = await HttpUtil.send(
          context, "post", Urls.orderUnPaid, {'user_id': UiUtils.getUserId()},
          initState: init);
    } else if (widget.status == 2) {
      response = await HttpUtil.send(
          context, "post", Urls.orderConform, {'user_id': UiUtils.getUserId()},
          initState: init);
    } else if (widget.status == 3) {
      response = await HttpUtil.send(
          context, "post", Urls.orderAppeal, {'user_id': UiUtils.getUserId()},
          initState: init);
    } else if (widget.status == 4) {
      response = await HttpUtil.send(
          context, "post", Urls.orderCancel, {'user_id': UiUtils.getUserId()},
          initState: init);
    } else if (widget.status == 5) {
      response = await HttpUtil.send(context, "post", Urls.orderCompleted,
          {'user_id': UiUtils.getUserId()},
          initState: init);
    }
    if (response.result) {
      orderList.clear();
      if (response.datas['order'] != null) {
        for (int i = 0; i < response.datas['order'].length; i++) {
          GoodOrderBean goodOrderBean =
              GoodOrderBean.fromJson(response.datas['order'][i]);
          orderList.add(goodOrderBean);
        }
      }
      setState(() {});
    }
  }

  getBottomItem(int status) {
    //1待付款 2待确认 3申诉 4 已取消 5已完成6 待发货 7 待收货 8已收货
    if (status == 5) {
      return Container(
        height: 56,
        child: Row(
          children: <Widget>[
            Image.asset(
              UiUtils.getImgPath("more"),
              width: 50,
              height: 20,
            ),
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              child: Container(
                height: 25,
                width: 70,
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: BaseColor.color_bbbb, width: 1)),
                child: TextView(
                  '提货',
                  style: TextStyles.color_bbb_13,
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: 25,
                width: 70,
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border:
                        Border.all(color: BaseColor.color_C60000, width: 1)),
                child: TextView(
                  '转拍',
                  style: TextStyles.color_C60000_13,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (status == 1) {
      return Container(
        height: 56,
        child: Row(
          children: <Widget>[
            Image.asset(
              UiUtils.getImgPath("more"),
              width: 50,
              height: 20,
            ),
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              child: Container(
                height: 25,
                width: 70,
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: BaseColor.color_bbbb, width: 1)),
                child: TextView(
                  '取消订单',
                  style: TextStyles.color_bbb_13,
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: 25,
                width: 70,
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border:
                        Border.all(color: BaseColor.color_C60000, width: 1)),
                child: TextView(
                  '去付款',
                  style: TextStyles.color_C60000_13,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (status == 3) {
      return Container(
        height: 56,
        child: Row(
          children: <Widget>[
            Image.asset(
              UiUtils.getImgPath("more"),
              width: 50,
              height: 20,
            ),
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              child: Container(
                height: 25,
                width: 70,
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border:
                        Border.all(color: BaseColor.color_C60000, width: 1)),
                child: TextView(
                  '联系客服',
                  style: TextStyles.color_C60000_13,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (status == 4) {
      return Container(
        height: 56,
        child: Row(
          children: <Widget>[
            Image.asset(
              UiUtils.getImgPath("more"),
              width: 50,
              height: 20,
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  String getRout(int status) {
    if (status == 5) {
      return "/order_detail";
    }else if (status == 2) {
      return "/order_wait";
    }
  }
}
