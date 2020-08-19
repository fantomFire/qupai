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
class OrderDetail extends StatefulWidget {
  final String id;
final int orderStatus;
  const OrderDetail({Key key, this.id, this.orderStatus}) : super(key: key);
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  GoodOrderBean goodOrderBean;
  @override
  void initState() {
    super.initState();
    getGoodDetail(widget.id);
    getChangeInfo(widget.id);
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
                  margin: EdgeInsets.only(top: 45,left: 16),
                  child:   TextView('交易成功',style: TextStyles.color_ffffff_17,),
                ),
                ],
              ),
            ),
            SizedBox(height: 10,),
          CommonOrder(goodOrderBean: goodOrderBean) ,
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: ScreenUtil().getAdapterSize(50),
        color: Theme.of(context).backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  color: BaseColor.color_bbbb,
                  height: ScreenUtil().getAdapterSize(50),
                  child: Text(
                    "提货",
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
                    "转拍",
                    style: TextStyles.color_ffffff_17,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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

  void getChangeInfo(String id) async{

    HttpResponse response = await HttpUtil.send(
        context, "post", Urls.orderChange, {'id': id},
        initState: true);
  }


  }



