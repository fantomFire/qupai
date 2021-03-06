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

class PhysicalPage extends StatefulWidget {
  final int status;

  const PhysicalPage({Key key, this.status}) : super(key: key);

  @override
  _PhysicalPageState createState() => _PhysicalPageState();
}

class _PhysicalPageState extends State<PhysicalPage>
    with AutomaticKeepAliveClientMixin {
  bool isFail = false;
  int userId;
  EasyRefreshController _easyRefreshController = EasyRefreshController();

  bool _hasNoMore = true;
  int curPage = 1;
  List<GoodOrderBean> orderList = List();

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
            return _createByHomeOrder(index);
          },
          onRefresh: () async {
            curPage = 1;
            getListInfo(true);
          },
       /*   onLoadMore: () {
            curPage++;
          },*/
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _createByHomeOrder(index) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pushNamed(context, "/physical_detail", arguments: {
          'goods_order_id': "1"
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
                    "订单编号:2222222",
                    style: TextStyles.color_999999_12,
                  ),
                  TextView(
                    "已完成",
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
                    url: Urls.imageTest,
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
                            '我是商品名称呀',style: TextStyles.color_333333_14,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          TextView(
                            '库号：123456',style: TextStyles.color_999999_13,
                          ),
                          TextView(
                            '规格：121212',style: TextStyles.color_999999_13,
                          ),
                          Container(
                            width: double.infinity,
                            child: TextView(
                              '合计：121212',style: TextStyles.color_999999_13,
                              textAlign: TextAlign.right,
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
            Container(
              height: 56,
              child: Row(
                children: <Widget>[
                  Image.asset(UiUtils.getImgPath("tongzhi1"),width: 50,height: 20,),
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
                        border: Border.all(color: BaseColor.color_bbbb,width: 1)
                      ),
                      child: TextView('取消订单',style: TextStyles.color_bbb_13,),

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
                          border: Border.all(color: BaseColor.color_C60000,width: 1)
                      ),
                      child: TextView('取消订单',style: TextStyles.color_C60000_13,),

                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
  void getListInfo(bool init) async{
    HttpResponse response;
    if(widget.status==0){
      response = await HttpUtil.send(
          context, "post", Urls.buygoods, {'user_id':UiUtils.getUserId()},
          initState: init);
    }else if(widget.status==1){
      response = await HttpUtil.send(
          context, "post", Urls.togoods, {'user_id':UiUtils.getUserId()},
          initState: init);
    }else if(widget.status==2){
      response = await HttpUtil.send(
          context, "post", Urls.goodsnot, {'user_id':UiUtils.getUserId()},
          initState: init);
    }else if(widget.status==3){
      response = await HttpUtil.send(
          context, "post", Urls.goodsreceived, {'user_id':UiUtils.getUserId()},
          initState: init);
    }
    if(response.result){
      orderList.clear();
    /*  if(response.datas['order']!=null){
        for( int i = 0;i<response.datas['order'].length;i++){
          GoodOrderBean goodOrderBean = GoodOrderBean.fromJson(response.datas['order'][i]);
          orderList.add(goodOrderBean);
        }
      }*/
      setState(() {

      });
    }
  }
}
