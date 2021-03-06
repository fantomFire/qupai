import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/model/buy_info_bean.dart';
import 'package:qupai/model/good_info_bean.dart';
import 'package:qupai/model/good_order_bean.dart';
import 'package:qupai/model/order_info_bean.dart';
import 'package:qupai/model/sell_order_detail.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/imageutil.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';
import 'package:qupai/widgets/appbars.dart';

import '../../../urls.dart';
class SellDetail extends StatefulWidget {
  final String id;

  const SellDetail({Key key, this.id}) : super(key: key);
  @override
  _SellDetailState createState() => _SellDetailState();
}

class _SellDetailState extends State<SellDetail> {
  SellOrderDetail goodOrderBean;
  GoodInfoBean goods;
  OrderInfoBean orderinfo;
  BuyInfoBean buyer;

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
                  child:   TextView('等待买家付款',style: TextStyles.color_ffffff_17,),
                ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 12,left: 16),
                    child:   TextView('剩23时26分53秒自动取消',style: TextStyles.color_ffffff_11,),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
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
                          "订单编号: ${goods?.orderno}",
                          style: TextStyles.color_999999_12,
                        ),
                        TextView(
                          UiUtils.getOrderState(goodOrderBean?.order_status),
                          style: TextStyles.color_999999_12,
                        ),
                      ],
                    ),
                  ),
                  Line(),
                  Container(
                    padding: EdgeInsets.only(left: 10,top: 10,bottom: 13,right: 10),
                    child: Row(
                      children: <Widget>[
                        ImageLoadUtil(
                          url: Urls.imageBase+goods?.goods_pic,
                          width: 90,
                          height: 90,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child:Container(
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextView(
                                  goods?.goodsname,style: TextStyles.color_333333_14,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                TextView(
                                  '作者：${ goods?.goodsauthor}',style: TextStyles.color_999999_13,
                                ),
                                TextView(
                                  '规格：${ goods?.goodsspec}',style: TextStyles.color_999999_13,
                                ),
                                Container(

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      TextView(
                                        '库号：${ goods?.numberstock}',style: TextStyles.color_999999_13,
                                      ),
                                      TextView(
                                        '合计：${ goods?.goodsprice} ',style: TextStyles.color_999999_13,
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
                  Line(height: 10,),
                  Container(
                    height: 44,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 16),
                    child: TextView('订单信息',style: TextStyles.color_333333_16,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Row(
                      children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextView('订单编号',style: TextStyles.color_333333_13,),
                          ),
                        Expanded(
                          flex: 2,
                          child: TextView('${ orderinfo?.orderno}',style: TextStyles.color_333333_13,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16,top: 14),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextView('创建时间',style: TextStyles.color_333333_13,),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextView('${ orderinfo?.creattime??""}',style: TextStyles.color_333333_13,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16,top: 14),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextView('付款时间',style: TextStyles.color_333333_13,),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextView('${ orderinfo?.payat??""}',style: TextStyles.color_333333_13,),
                        ),
                      ],
                    ),
                  ),
              /*    Container(
                    padding: EdgeInsets.only(left: 16,top: 14),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextView('确认收款时间:',style: TextStyles.color_333333_13,),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextView('${ goodOrderBean?.qr_time??""}',style: TextStyles.color_333333_13,),
                        ),
                      ],
                    ),
                  ),*/
                  Container(
                    padding: EdgeInsets.only(left: 16,top: 14,bottom: 14,right: 16),
                    width: double.infinity,
                    child: TextView('联系电话：${ buyer?.userphone}（可联系商家处理）',style: TextStyles.color_999999_11,textAlign: TextAlign.right,),

                  ),
                  Line(height: 10,),
                  Container(
                    height: 44,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 16),
                    child: TextView('买家信息',style: TextStyles.color_333333_16,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextView('买家昵称',style: TextStyles.color_333333_13,),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextView(buyer?.nickname,style: TextStyles.color_333333_13,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16,top: 14),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextView('买家真实姓名',style: TextStyles.color_333333_13,),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextView(buyer?.username,style: TextStyles.color_333333_13,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16,top: 14),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextView('联系电话',style: TextStyles.color_333333_13,),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextView(buyer?.userphone,style: TextStyles.color_333333_13,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                    "立即购买",

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
        context, "post", Urls.sellDetail, {'id':id},
        initState: true);

    if (response.datas != null) {
      goodOrderBean = SellOrderDetail.fromJson(response.datas);
      if(goodOrderBean!=null){
        goods = goodOrderBean.goods;
        orderinfo = goodOrderBean.orderinfo;
        buyer = goodOrderBean.buyer;
      }
    }
    setState(() {

    });


  }
}
