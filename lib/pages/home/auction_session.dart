import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:qupai/model/good_item_bean.dart';
import 'package:qupai/model/good_list_bean.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/imageutil.dart';
import 'package:qupai/utils/time_utlils.dart';
import 'package:qupai/utils/uiutils.dart';

import '../../urls.dart';

class AuctionSessionPage extends StatefulWidget {
  final String status;

  AuctionSessionPage({Key key, this.status}) : super(key: key);

  @override
  _AuctionSessionPageState createState() => _AuctionSessionPageState();
}

class _AuctionSessionPageState extends State<AuctionSessionPage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  TabController _tabController; //需要定义一个Controller
  List tabs = ["可拍卖", "已拍卖"];
  String _day1;
  String _hour1;
  String _minute1;
  String _second1;
  Timer _timerIndex;
  int timeState = 0;
  List<GoodItemBean> kGoodList = List();
  List<GoodItemBean> yGoodList = List();
  GoodListBean goodList;

  @override
  void initState() {
    super.initState();
    getListInfo(widget.status, true);

    Future.delayed(Duration(milliseconds: 200)).then((e) {});
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timerIndex.cancel();
    _timerIndex = null;
    super.dispose();
  }

  // 下拉刷新数据
  Future<Null> _refreshData() async {}
  String waitNotice = "";

  void _timeFunc() {
    var _newDate = DateTime.now();
    const period = const Duration(seconds: 1);
    String currentDay = TimeUtils.getCurrentDate();

    var _diffS_begin = DateTime.parse("$currentDay ${goodList?.begin_time}");
    var _diffS_end = DateTime.parse("$currentDay ${goodList?.end_time}");

    _timerIndex = Timer.periodic(period, (timer) {
      //到时回调
      _diffS_begin = _diffS_begin.subtract(Duration(seconds: 1));
      _diffS_end = _diffS_end.subtract(Duration(seconds: 1));

      if (_diffS_begin.difference(_newDate).inSeconds > 0) {
        timeState = 0;
        var _surplus = _diffS_begin.difference(_newDate);
        int _day = (_surplus.inSeconds ~/ 3600) ~/ 24;
        int hour = (_surplus.inSeconds ~/ 3600) % 24;
        int minute = _surplus.inSeconds % 3600 ~/ 60;
        int second = _surplus.inSeconds % 60;
        _day1 = _day.toString() ?? '0';
        _hour1 = hour.toString() ?? '0';
        _minute1 = minute.toString() ?? '0';
        _second1 = second.toString() ?? '0';
        waitNotice = _day1 + ':' + _hour1 + ':' + _minute1 + ':' + _second1;

        //取消定时器，避免无限回调

      } else if (_diffS_begin.difference(_newDate).inSeconds < 0 &&
          _diffS_end.difference(_newDate).inSeconds > 0) {
        timeState = 1;
        var _surplus = _diffS_end.difference(_newDate);
        int _day = (_surplus.inSeconds ~/ 3600) ~/ 24;
        int hour = (_surplus.inSeconds ~/ 3600) % 24;
        int minute = _surplus.inSeconds % 3600 ~/ 60;
        int second = _surplus.inSeconds % 60;
        _day1 = _day.toString() ?? '0';
        _hour1 = hour.toString() ?? '0';
        _minute1 = minute.toString() ?? '0';
        _second1 = second.toString() ?? '0';
        waitNotice = _day1 + ':' + _hour1 + ':' + _minute1 + ':' + _second1;
      } else {
        timeState = 2;
        waitNotice = "";
        timer.cancel();
        timer=null;

      }
      setState(() {
      });
      // debugPrint(_text);
    });
  }

  Widget _headerWidget() {
    return goodList?.pic == null
        ? Container()
        : Container(
            height: ScreenUtil().getAdapterSize(220),
            width: MediaQuery.of(context).size.width,
            child: ImageLoadUtil(
                url: "${Urls.imageBase + goodList?.pic}", fit: BoxFit.cover));
  }

  Widget _listWaitingItemWidget(List<GoodItemBean> data, int index) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/auctionDetails",
              arguments: {"widget.status": data[index].id});
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(Urls.imageBase + data[index].goods_pic),
                  fit: BoxFit.fill,
                ),
                borderRadius:
                    BorderRadius.circular(ScreenUtil().getAdapterSize(10))),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: ScreenUtil().getAdapterSize(40),
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().getAdapterSize(5)),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data[index].goods_name,
                      style:
                          TextStyle(fontSize: ScreenUtil().getAdapterSize(15)),
                    ),
                    Text(
                      "￥ ${data[index].goods_price}",
                      style: TextStyle(
                          color: Color(0xffC60000),
                          fontSize: ScreenUtil().getAdapterSize(15)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _listFinishItemWidget(List<GoodItemBean> data, int index) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/auctionDetails",
              arguments: {"widget.status": data[index].id});
        },
        child: Stack(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage(Urls.imageBase + data[index].goods_pic),
                      fit: BoxFit.fill,
                    ),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().getAdapterSize(10))),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: ScreenUtil().getAdapterSize(40),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().getAdapterSize(5)),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data[index].goods_name,
                          style: TextStyle(
                              fontSize: ScreenUtil().getAdapterSize(15)),
                        ),
                        Text(
                          "￥ ${data[index].goods_price}",
                          style: TextStyle(
                              color: Color(0xffC60000),
                              fontSize: ScreenUtil().getAdapterSize(15)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            data[index].status != 1
                ? Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      data[index].status == 2
                          ? UiUtils.getImgPath("auction_doing")
                          : UiUtils.getImgPath("auction_finish"),
                      width: ScreenUtil().getAdapterSize(80),
                      height: ScreenUtil().getAdapterSize(80),
                      fit: BoxFit.fill,
                    ),
                  )
                : SizedBox()
          ],
        ));
  }
  int currentIndex = 0;
  Widget _bodyWidget() {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Column(
        children: <Widget>[
          _headerWidget(),
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().getAdapterSize(6),
                  horizontal: ScreenUtil().getAdapterSize(10)),
              color: timeState == 0
                  ? Color(0xff2BA245)
                  : timeState == 1 ? Color(0xffC60000) : Color(0xff999999),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.volume_up,
                        size: ScreenUtil().getAdapterSize(18),
                        color: Colors.white,
                      ),
                      Text(
                        timeState == 0 ? "预告中" : timeState == 1 ? "拍卖中" : "已结束",
                        style: TextStyle(
                          fontSize: ScreenUtil().getAdapterSize(12),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  timeState == 0
                      ? Text(
                          "距开始：" + waitNotice,
                          style: TextStyle(
                            fontSize: ScreenUtil().getAdapterSize(12),
                            color: Colors.white,
                          ),
                        )
                      : timeState == 1
                          ? Text(
                              "距结束：" + waitNotice,
                              style: TextStyle(
                                fontSize: ScreenUtil().getAdapterSize(12),
                                color: Colors.white,
                              ),
                            )
                          : SizedBox()
                ],
              )),
          Container(
              color: Theme.of(context).backgroundColor,
              child: TabBar(
                controller: _tabController,
                labelColor: Color(0xffC60000),
                indicatorColor: Color(0xffC60000),
                unselectedLabelColor: Colors.black,
                onTap: (index){
                   currentIndex = index;
                },
                tabs: tabs
                    .map((item) => Tab(
                          text: item,
                        ))
                    .toList(),
              )),
          Expanded(
            child: TabBarView(
              controller: _tabController,

              children: tabs.map((e) {
                return RefreshIndicator(
                    onRefresh: _refreshData,
                    color: Color(0xffC60000),
                    child:currentIndex==0? GridView.builder(
                        shrinkWrap: true,
                        itemCount: kGoodList.length,
                        physics: new NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(ScreenUtil().getAdapterSize(3)),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: ScreenUtil().getAdapterSize(3),
                          crossAxisSpacing: ScreenUtil().getAdapterSize(3),
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) {
                          return _listWaitingItemWidget(kGoodList, index);

                        }):GridView.builder(
                        shrinkWrap: true,
                        itemCount:yGoodList.length,
                        physics: new NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(ScreenUtil().getAdapterSize(3)),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: ScreenUtil().getAdapterSize(3),
                          crossAxisSpacing: ScreenUtil().getAdapterSize(3),
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) {
                          return _listFinishItemWidget(yGoodList, index);
                        }));
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: null,
      body: Stack(
        children: <Widget>[
          _bodyWidget(),
          Positioned(
              top: ScreenUtil().getAdapterSize(0),
              left: ScreenUtil().getAdapterSize(0),
              right: ScreenUtil().getAdapterSize(0),
              child: AppBar(
                backgroundColor: Colors.transparent,
                //把appbar的背景色改成透明
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                title: Text(
                  "拍卖专场",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: false,
                elevation: 0,
              )),
        ],
      ),
    );
  }

  void getListInfo(String status, bool initState) async {
    HttpResponse response = await HttpUtil.send(context, "post", Urls.goodsList,
        {'id': status, 'user_id': UiUtils.getUserId()},
        initState: initState);
    if (response.result) {
      goodList = GoodListBean.fromJson(response.datas);
      if (goodList.k_goods != null && goodList.k_goods.length > 0) {
        kGoodList = goodList.k_goods;
      }
      if (goodList.y_goods != null && goodList.y_goods.length > 0) {
        yGoodList = goodList.y_goods;
      }

      setState(() {});
      _timeFunc();
    }
  }

}
