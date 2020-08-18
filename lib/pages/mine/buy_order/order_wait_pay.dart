import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/model/good_order_bean.dart';
import 'package:qupai/pages/mine/buy_order/CommonOrder.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/imageutil.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';
import 'package:qupai/widgets/appbars.dart';

import '../../../urls.dart';
class OrderWaitPay extends StatefulWidget {
  final String id;
final int orderStatus;
  const OrderWaitPay({Key key, this.id, this.orderStatus}) : super(key: key);
  @override
  _OrderWaitPayState createState() => _OrderWaitPayState();
}

class _OrderWaitPayState extends State<OrderWaitPay> {
  GoodOrderBean goodOrderBean;
  @override
  void initState() {
    super.initState();
    getGoodDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffD63432), Color(0xffFE8564)]),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 34),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            NavigatorUtil.pop(context);
                          },
                          child: Container(width: 44, height: 44, child: Image.asset(UiUtils.getImgPath('icon_back'), width: 10, height: 18)),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 44),
                          alignment: Alignment.center,
                          child: TextView("订单详情", style:TextStyle(color: BaseColor.color_ffffff,fontSize: 18,fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 30,left: 16),
                  child:   TextView(widget.orderStatus==2?"等待买家确认":'等待买家付款',style: TextStyles.color_ffffff_17,),
                ),
                  widget.orderStatus==1? Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 12,left: 16),
                    child:   TextView('剩23时26分53秒自动取消',style: TextStyles.color_ffffff_11,),
                  ):Container(),

                ],
              ),
            ),
            SizedBox(height: 10,),
            CommonOrder(goodOrderBean: goodOrderBean,),
          ],
        ),
      ),
        bottomNavigationBar: widget.orderStatus==1? Container(
        height: ScreenUtil().getAdapterSize(50),
        color: Theme.of(context).backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {

                },
                child: Container(
                  alignment: Alignment.center,
                  color: BaseColor.color_bbbb,
                  height: ScreenUtil().getAdapterSize(50),
                  child: Text(
                    "取消订单",
                    style:
                    TextStyle(color: BaseColor.color_ffffff, fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().getAdapterSize(50),
                  color: Color(0xffC60000),
                  child: Text(
                    "去支付",
                    style: TextStyles.color_ffffff_17,
                  ),
                ),
              ),
            )
          ],
        ),
      ):Container(),
    );
  }

  void getGoodDetail(String id)async {
    HttpResponse response = await HttpUtil.send(
        context, "post", Urls.orderDetail, {'id': id},
        initState: true);
    if (response.datas != null) {
       goodOrderBean = GoodOrderBean.fromJson(response.datas);
    }
    setState(() {

    });
  }


  }



