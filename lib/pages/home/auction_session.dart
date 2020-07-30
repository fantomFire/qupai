import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/uiutils.dart';


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
  List list = [
    {"widget.status": 1},
    {"widget.status": 2},
    {"widget.status": 2},
    {"widget.status": 3},
    {"widget.status": 3}
  ];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      _timeFunc("2020-07-28 18:00");
    });
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index.toDouble() == _tabController.animation.value) {
        if (_tabController.index == 0) {
          LogUtil.v("可拍卖", tag: "趣拍");
        } else if (_tabController.index == 1) {
          LogUtil.v("已拍卖", tag: "趣拍");
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timerIndex.cancel();
    super.dispose();
  }

  // 下拉刷新数据
  Future<Null> _refreshData() async {}

  void _timeFunc(time) {
    var _newDate = DateTime.now();
    const period = const Duration(seconds: 1);
    print(time);
    var _diffDate = DateTime.parse(time.toString());
    _timerIndex = Timer.periodic(period, (timer) {
      //到时回调
      _diffDate = _diffDate.subtract(Duration(seconds: 1));
      // count++;
      if (_diffDate.difference(_newDate).inSeconds <= 0) {
        //取消定时器，避免无限回调
        timer.cancel();
        timer = null;
      }
      // print();
      var _surplus = _diffDate.difference(_newDate);
      int _day = (_surplus.inSeconds ~/ 3600) ~/ 24;
      int hour = (_surplus.inSeconds ~/ 3600) % 24;
      int minute = _surplus.inSeconds % 3600 ~/ 60;
      int second = _surplus.inSeconds % 60;
      // formatTime(hour) + ":" + formatTime(minute) + ":" + formatTime(second);
      setState(() {
        _day1 = _day.toString() ?? '0';
        _hour1 = hour.toString() ?? '0';
        _minute1 = minute.toString() ?? '0';
        _second1 = second.toString() ?? '0';
        // _text = _diffDate.weekday.toString()+'  ' +_diffDate.hour.toString()+':' + _diffDate.minute.toString() +':'+ _diffDate.second.toString();
      });
      // debugPrint(_text);
    });
  }

  Widget _headerWidget() {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        height: ScreenUtil().getAdapterSize(220),
        width: MediaQuery.of(context).size.width,
        child: SizedBox());
  }

  Widget _listWaitingItemWidget(data, index) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/auctionDetails",
              arguments: {"widget.status": data["widget.status"]});
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
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
                      "商品名",
                      style:
                          TextStyle(fontSize: ScreenUtil().getAdapterSize(15)),
                    ),
                    Text(
                      "￥3000",
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

  Widget _listFinishItemWidget(data, index) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/auctionDetails",
              arguments: {"widget.status": data["widget.status"]});
        },
        child: Stack(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
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
                          "商品名",
                          style: TextStyle(
                              fontSize: ScreenUtil().getAdapterSize(15)),
                        ),
                        Text(
                          "￥3000",
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
            data["widget.status"] != 1
                ? Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      data["widget.status"] == 2
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
              color: widget.status == '1'
                  ? Color(0xff2BA245)
                  : widget.status == '2'
                      ? Color(0xffC60000)
                      : Color(0xff999999),
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
                        widget.status == '1'
                            ? "预告中"
                            : widget.status == '2' ? "拍卖中" : "已结束",
                        style: TextStyle(
                          fontSize: ScreenUtil().getAdapterSize(12),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  _day1 != null &&
                          _hour1 != null &&
                          _minute1 != null &&
                          _second1 != null
                      ? widget.status == '1'
                          ? Text(
                              "距开始：" +
                                  _day1 +
                                  "天" +
                                  _hour1 +
                                  ":" +
                                  _minute1 +
                                  ":" +
                                  _second1,
                              style: TextStyle(
                                fontSize: ScreenUtil().getAdapterSize(12),
                                color: Colors.white,
                              ),
                            )
                          : widget.status == '2'
                              ? Text(
                                  "距结束：" +
                                      _day1 +
                                      "天" +
                                      _hour1 +
                                      ":" +
                                      _minute1 +
                                      ":" +
                                      _second1,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().getAdapterSize(12),
                                    color: Colors.white,
                                  ),
                                )
                              : SizedBox()
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
                    child: GridView.builder(
                        // shrinkWrap: true,
                        itemCount: list.length,
                        // physics: new NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(ScreenUtil().getAdapterSize(3)),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: ScreenUtil().getAdapterSize(3),
                          crossAxisSpacing: ScreenUtil().getAdapterSize(3),
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) {
                          return _tabController.index == 0
                              ? _listWaitingItemWidget(list[index], index)
                              : _listFinishItemWidget(list[index], index);
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
                backgroundColor: Colors.transparent, //把appbar的背景色改成透明
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
}
