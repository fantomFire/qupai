import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:qupai/utils/native_utils.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/uiutils.dart';
class AuctionDetailsPage extends StatefulWidget {
  final String  status;
  AuctionDetailsPage({Key key, this.status}) : super(key: key);

  @override
  _AuctionDetailsPageState createState() => _AuctionDetailsPageState();
}

class _AuctionDetailsPageState extends State<AuctionDetailsPage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  TabController _tabController; //需要定义一个Controller
  List tabs = ["可拍卖", "已拍卖"];
  bool isChange = false;
  List _swperListData = [
    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"
  ];
  String _day1;
  String _hour1;
  String _minute1;
  String _second1;
  Timer _timerIndex;
  List list = [1, 2, 3, 4, 5, 6, 7];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      _timeFunc("2020-07-28 18:00");
    });
    _tabController = TabController(length: tabs.length, vsync: this);
    //底部加载更多监听
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          ScreenUtil().getAdapterSize(160)) {
        setState(() {
          isChange = true;
        });
      } else {
        setState(() {
          isChange = false;
        });
      }
    });
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

  Widget _headerWidget(list) {
    return Container(
      height: ScreenUtil().getAdapterSize(220),
      child: AspectRatio(
        aspectRatio: 3 / 1.5, //适配所有终端
        child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: list[index],
                fit: BoxFit.fill,
              );
            },
            itemCount: list.length,
            autoplay: true,
            onTap: (index) {
              // Navigator.pushNamed(context, '/productContent',
              //       arguments: {'id': _swperListData[index].banner_id});
            },
            pagination: SwiperPagination(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(bottom: 10, right: 10),
                builder: FractionPaginationBuilder(
                    color: Color.fromRGBO(200, 200, 200, 0.5),
                    activeColor: Color(0xffC60000),
                    fontSize: ScreenUtil().getAdapterSize(13),
                    activeFontSize: ScreenUtil().getAdapterSize(15))),
            autoplayDisableOnInteraction: true),
      ),
    );
  }

  Widget _infoWidget(data) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: ScreenUtil().getAdapterSize(10),
            horizontal: ScreenUtil().getAdapterSize(10)),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().getAdapterSize(10),
                    horizontal: ScreenUtil().getAdapterSize(10)),
                color: Theme.of(context).backgroundColor,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: ScreenUtil().getAdapterSize(3),
                          height: ScreenUtil().getAdapterSize(18),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(198, 0, 0, 1),
                                  Color.fromRGBO(254, 133, 100, 1)
                                ]),
                                borderRadius: BorderRadius.circular(3)),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().getAdapterSize(10),
                        ),
                        Text(
                          "拍卖规格",
                          style: TextStyle(
                              fontSize: ScreenUtil().getAdapterSize(14),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "库号：123456789",
                          style: TextStyle(
                            fontSize: ScreenUtil().getAdapterSize(11),
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "作者：XXX",
                          style: TextStyle(
                            fontSize: ScreenUtil().getAdapterSize(11),
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "规格：60X60",
                          style: TextStyle(
                            fontSize: ScreenUtil().getAdapterSize(11),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            Container(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().getAdapterSize(10),
                    horizontal: ScreenUtil().getAdapterSize(10)),
                margin: EdgeInsets.only(
                  bottom: ScreenUtil().getAdapterSize(10),
                ),
                color: Theme.of(context).backgroundColor,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: ScreenUtil().getAdapterSize(3),
                          height: ScreenUtil().getAdapterSize(18),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(198, 0, 0, 1),
                                  Color.fromRGBO(254, 133, 100, 1)
                                ]),
                                borderRadius: BorderRadius.circular(3)),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().getAdapterSize(10),
                        ),
                        Text(
                          "转拍流程",
                          style: TextStyle(
                              fontSize: ScreenUtil().getAdapterSize(14),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "1、选择拍品",
                          style: TextStyle(
                            fontSize: ScreenUtil().getAdapterSize(11),
                            color: Colors.grey,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: ScreenUtil().getAdapterSize(11),
                          color: Colors.grey,
                        ),
                        Text(
                          "2、拍下拍品",
                          style: TextStyle(
                            fontSize: ScreenUtil().getAdapterSize(11),
                            color: Colors.grey,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: ScreenUtil().getAdapterSize(11),
                          color: Colors.grey,
                        ),
                        Text(
                          "3、确认付款",
                          style: TextStyle(
                            fontSize: ScreenUtil().getAdapterSize(11),
                            color: Colors.grey,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: ScreenUtil().getAdapterSize(11),
                          color: Colors.grey,
                        ),
                        Text(
                          "4、确认收款",
                          style: TextStyle(
                            fontSize: ScreenUtil().getAdapterSize(11),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            Container(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().getAdapterSize(10),
                    horizontal: ScreenUtil().getAdapterSize(10)),
                margin: EdgeInsets.only(
                  bottom: ScreenUtil().getAdapterSize(10),
                ),
                color: Theme.of(context).backgroundColor,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "拍品描述",
                          style: TextStyle(
                              fontSize: ScreenUtil().getAdapterSize(14),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "详细描述",
                          style: TextStyle(
                            fontSize: ScreenUtil().getAdapterSize(11),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            Container(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().getAdapterSize(10),
                    horizontal: ScreenUtil().getAdapterSize(10)),
                color: Theme.of(context).backgroundColor,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: ScreenUtil().getAdapterSize(3),
                          height: ScreenUtil().getAdapterSize(18),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(198, 0, 0, 1),
                                  Color.fromRGBO(254, 133, 100, 1)
                                ]),
                                borderRadius: BorderRadius.circular(3)),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().getAdapterSize(10),
                        ),
                        Text(
                          "帮助",
                          style: TextStyle(
                              fontSize: ScreenUtil().getAdapterSize(14),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "帮助描述",
                          style: TextStyle(
                            fontSize: ScreenUtil().getAdapterSize(11),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ));
  }

  Widget _bodyWidget() {
    return RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              _headerWidget(_swperListData),
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
                            widget.status == 1
                                ? "预告中"
                                : widget.status == 2
                                    ? "拍卖中"
                                    : "已结束",
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
                          ? widget.status == 1
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
                              : widget.status == 2
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
                                        fontSize:
                                            ScreenUtil().getAdapterSize(12),
                                        color: Colors.white,
                                      ),
                                    )
                                  : SizedBox()
                          : SizedBox()
                    ],
                  )),
              _infoWidget({})
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _bodyWidget(),
          Positioned(
              top: ScreenUtil().getAdapterSize(0),
              left: ScreenUtil().getAdapterSize(0),
              right: ScreenUtil().getAdapterSize(0),
              child: AppBar(
                backgroundColor: isChange
                    ? Theme.of(context).backgroundColor
                    : Colors.transparent, //把appbar的背景色改成透明
                iconTheme: IconThemeData(
                  color: isChange ? Colors.black : Colors.white,
                ),
                title: Text(
                  "拍品详情",
                  style:
                      TextStyle(color: isChange ? Colors.black : Colors.white),
                ),
                centerTitle: isChange ? true : false,
                elevation: 0,
              )),
          widget.status!= 1
              ? Positioned(
                  top: ScreenUtil().getAdapterSize(80),
                  left: ScreenUtil().getAdapterSize(0),
                  right: ScreenUtil().getAdapterSize(0),
                  child: Center(
                    child: Image.asset(
                      widget.status == 2
                          ? UiUtils.getImgPath("auction_doing")
                          : UiUtils.getImgPath("auction_finish"),
                      width: ScreenUtil().getAdapterSize(80),
                      height: ScreenUtil().getAdapterSize(80),
                      fit: BoxFit.fill,
                    ),
                  ))
              : SizedBox()
        ],
      ),
      bottomNavigationBar: Container(
        height: ScreenUtil().getAdapterSize(50),
        color: Theme.of(context).backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      NavigatorUtil.pushReplacementNamed(context, '/main_page');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: ScreenUtil().getAdapterSize(50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(UiUtils.getImgPath('home_normal'),
                              width: ScreenUtil().getAdapterSize(20),
                              height: ScreenUtil().getAdapterSize(20)),
                          Text(
                            "首页",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: ScreenUtil().getAdapterSize(50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(UiUtils.getImgPath('service'),
                              width: ScreenUtil().getAdapterSize(20),
                              height: ScreenUtil().getAdapterSize(20)),
                          Text(
                            "客服",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                  child: FlatButton(
                color: widget.status == '2'
                    ? Color(0xffC60000)
                    : Color(0xffBBBBBB),
                colorBrightness: Brightness.dark,
                child: Container(
                  child: Center(
                    child: Text(
                      "立即购买",
                      style:
                          TextStyle(fontSize: ScreenUtil().getAdapterSize(15)),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                onPressed: () {
                   NavigatorUtil.pushNamed(context, "/ensureOrder");


                },
              )),
            )
          ],
        ),
      ),
    );
  }
}
