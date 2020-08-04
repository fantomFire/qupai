import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/model/banner_bean.dart';
import 'package:qupai/model/home_bean.dart';
import 'package:qupai/model/special_s.dart';
import 'package:qupai/model/special_x.dart';
import 'package:qupai/urls.dart';
import 'package:qupai/utils/CommonUtil.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/imageutil.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool isChange = false;
  List list = ["1", '2', '3', '4'];
  HomeBean homeBean;

  List<BannerBean> bannerList = new List();
  List<SpecialSBean> specialsList = new List();
  List<SpecialXBean> specialxList = new List();
  String debugLable = 'Unknown';   /*错误信息*/
  final JPush jpush = new JPush(); /* 初始化极光插件*/
  @override
  void initState() {
    super.initState();
    initPlatformState();
    CommonUtil.initCache(context);
    getHomeInfo(true);
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      /*监听响应方法的编写*/
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
            print(">>>>>>>>>>>>>>>>>flutter 接收到推送: $message");
            setState(() {
              debugLable = "接收到推送: $message";
            });
          }
      );

    } on PlatformException {
      platformVersion = '平台版本获取失败，请检查！';
    }

    if (!mounted){
      return;
    }

    setState(() {
      debugLable = platformVersion;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: TextView(
          "趣拍",
          style: TextStyles.color_333333_18,
        ),
        centerTitle: false,
        elevation: 0,
        actions: <Widget>[
          ButtonBar(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.mail_outline,
                    color: BaseColor.color_333333,
                    // size: ScreenUtil().getAdapterSize(18),
                  ),
                  onPressed: () {})
            ],
          )
        ],
      ),
      body: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    bannerList.length > 0
                        ? _swiperWidget(bannerList)
                        : Container(),
                    Container(
                        height: 36,
                        padding: EdgeInsets.only(left: 15),
                        color: Theme.of(context).backgroundColor,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.volume_up,
                              size: 18,
                            ),
                            Expanded(
                              child: Text(
                                "趣拍交易正式上线了，欢迎大家前来体验！",
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                color: Theme.of(context).backgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/demonstrationSession");
                        },
                        child: homeBean?.show==null?Center(
                            child: Image.asset(
                          UiUtils.getImgPath("example"),
                          width: 162,
                          height: 80,
                          fit: BoxFit.fill,
                        )):ImageLoadUtil(
                          url: Urls.imageBase+homeBean?.show,
                          width: 162,
                          height: 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            barrierDismissible: false,
                            //// user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: Center(
                                  child: Text('提示'),
                                ),
                                content: Text(
                                  '正在开发中，敬请期待！',
                                  style: TextStyle(fontSize: 13),
                                ),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          '确认',
                                          style: TextStyle(
                                              color: Color(0xffC60000)),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context, "sure");
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Center(
                            child: Image.asset(
                          UiUtils.getImgPath("integral"),
                          width: 162,
                          height: 80,
                          fit: BoxFit.fill,
                        )),
                      ),
                    )
                  ],
                ),
              ),
              _morningWidget(),
              SizedBox(
                height: 10,
              ),
              _afternoonWidget(list),
            ],
          )),
    );
  }

// 下拉刷新数据
  Future<Null> _refreshData() async {
    _page = 1;
  getHomeInfo(false);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //上午
  Widget _morningWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(0xffF1F1F1)),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "上午场",
                  style: TextStyle(
                      fontSize: 18,
                      color: BaseColor.color_333333,
                      fontWeight: FontWeight.bold),
                ),
                Text("9:30-11:30",
                    style: TextStyle(fontSize: 12, color: Colors.grey))
              ],
            ),
          ),
          Container(
              child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), //禁止滚动
            itemCount: specialsList.length,
            itemBuilder: (BuildContext context, int index) {
              return _listMorningItemWidget(specialsList[index], index);
            },
          ))
        ],
      ),
    );
  }

  Widget _listMorningItemWidget(SpecialSBean data, index) {
    return GestureDetector(
        onTap: () {
            Navigator.pushNamed(context, "/auctionSession",
                arguments: {"status": data.type.toString()});
        },
        child: Container(
          height: 170,
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(Urls.imageTest),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(UiUtils.getImgPath("home_typebg")),
                          fit: BoxFit.fill,
                        ),
                      ),
                      width: 58,
                      height: 23,
                      alignment: Alignment.center,
                      child: Text(
                        index == 0 ? "特价场" : "普通场",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                  data == '1'
                      ? Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.schedule,
                                size: 12,
                                color: Colors.white,
                              ),
                              Text(
                                "未开拍",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )
                            ],
                          ),
                        )
                      : data == '2'
                          ? Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.2),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.update,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "拍卖中",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 10),
                                  )
                                ],
                              ),
                            )
                          : data == '3'
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.2),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.power_settings_new,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "已结束",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 10),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox()
                ],
              ),
            ),
          ),
        ));
  }
  //轮播图
  Widget _swiperWidget(  List<BannerBean> bannerList) {
    return Container(
      height: 180,
      child: AspectRatio(
        aspectRatio: 3 / 1, //适配所有终端
        child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: Urls.imageBase+bannerList[index].banner_pic,
                fit: BoxFit.fill,
              );
            },
            itemCount: bannerList.length,
            autoplay: true,
            onTap: (index) {
              var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + 3000);
              var localNotification = LocalNotification(
                id: 234,
                title: '我是推送测试标题',
                buildId: 1,
                content: '看到了说明已经成功了',
                fireTime: fireDate,
                subtitle: '一个测试',
              );
              jpush.sendLocalNotification(localNotification).then((res) {
                setState(() {
                  debugLable = res;
                });
              });

              // Navigator.pushNamed(context, '/productContent',
              //       arguments: {'id': _swperListData[index].banner_id});
            },
            pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                    color: Color.fromRGBO(200, 200, 200, 0.5),
                    activeColor: Color(0xffC60000),
                    size: 5,
                    activeSize: 6)),
            autoplayDisableOnInteraction: true),
      ),
    );
  }

  //下午
  Widget _afternoonWidget(list) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(0xffF1F1F1)),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "下午场",
                  style: TextStyle(
                      fontSize: 18,
                      color: BaseColor.color_333333,
                      fontWeight: FontWeight.bold),
                ),
                Text("14:30-16:30",
                    style: TextStyle(fontSize: 12, color: Colors.grey))
              ],
            ),
          ),
          Container(
              child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), //禁止滚动
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return _listAfternoonItemWidget(list[index], index);
            },
          ))
        ],
      ),
    );
  }

  Widget _listAfternoonItemWidget(data, index) {
    return GestureDetector(
        onTap: () {
          if (index == 0) {
            Navigator.pushNamed(context, "/auctionSession",
                arguments: {"status": data});
          } else {
            Navigator.pushNamed(context, "/auctionSession",
                arguments: {"status": data});
          }
        },
        child: Container(
          height: 170,
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(Urls.imageTest),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(UiUtils.getImgPath("home_typebg")),
                          fit: BoxFit.fill,
                        ),
                      ),
                      width: 58,
                      height: 23,
                      alignment: Alignment.center,
                      child: Text(
                        index == 0 ? "特价场" : "普通场",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                  data == '1'
                      ? Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.schedule,
                                size: 12,
                                color: Colors.white,
                              ),
                              Text(
                                "未开拍",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )
                            ],
                          ),
                        )
                      : data == '2'
                          ? Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.2),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.update,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "拍卖中",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 10),
                                  )
                                ],
                              ),
                            )
                          : data == '3'
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.2),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.power_settings_new,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "已结束",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 10),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox()
                ],
              ),
            ),
          ),
        ));
  }

  void getHomeInfo(bool bool) async {
    HttpResponse response = await HttpUtil.send(
        context, "post", Urls.homeInfo, {},
        initState: bool);
    if (response.result) {
      homeBean = HomeBean.fromJson(response.datas);
      if (homeBean?.banner != null && homeBean.banner.length > 0) {
        bannerList = homeBean.banner;
      }
      if (homeBean?.special_s != null && homeBean.special_s.length > 0) {
        specialsList = homeBean.special_s;
      }
      if (homeBean?.special_x != null && homeBean.special_x.length > 0) {
        specialxList = homeBean.special_x;
      }

      setState(() {

      });
    }
  }
}
