import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:qupai/utils/CommonUtil.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();
  List _swperListData = [
    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"
  ];
  int _page = 1;
  bool isChange = false;
  List list = [
    {"status": 1},
    {"status": 2},
    {"status": 3},
    {"status": 1}
  ];


  @override
  void initState() {
    super.initState();
    CommonUtil.initCache(context);



  }

  @override
  Widget build(BuildContext context) {
  /*  SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: BaseColor.color_ffffff);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);*/

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        automaticallyImplyLeading: false,
        title: Text("趣拍"),
        centerTitle: false,
        elevation: 0,
        actions: <Widget>[
          ButtonBar(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.mail_outline,
                    // size: ScreenUtil().getAdapterSize(18),
                  ),
                  onPressed: () {})
            ],
          )
        ],
      ),
      body:RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    _swperListData.length > 0
                        ? _swiperWidget(_swperListData)
                        : SizedBox(),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 10),
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
                                style: TextStyle(
                                    fontSize: 12),
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
                        child: Center(
                            child: Image.asset(
                              UiUtils.getImgPath("example"),
                              width: 162,
                              height: 80,
                              fit: BoxFit.fill,
                            )),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            barrierDismissible: false, //// user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: Center(
                                  child: Text('提示'),
                                ),
                                content: Text(
                                  '正在开发中，敬请期待！',
                                  style: TextStyle(
                                      fontSize: 13),
                                ),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          '确认',
                                          style:
                                          TextStyle(color: Color(0xffC60000)),
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
              _morningWidget(list),
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
    _getSwiper();
  }
  @override
  bool get wantKeepAlive => true;


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  //上午
  Widget _morningWidget(list) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10),
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffF1F1F1)),
            padding: EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("上午场"),
                Text("9:30-11:30",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey))
              ],
            ),
          ),
          Container(
              height: list.length * 140,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(), //禁止滚动
                itemCount: list.length,
                itemExtent:140,
                itemBuilder: (BuildContext context, int index) {
                  return _listMorningItemWidget(list[index], index);
                },
              ))
        ],
      ),
    );
  }

  Widget _listMorningItemWidget(data, index) {
    return GestureDetector(
        onTap: () {
          if (index == 0) {
            Navigator.pushNamed(context, "/auctionSession",arguments: {"status":data["status"]});
          } else {
            Navigator.pushNamed(context, "/auctionSession",arguments: {"status":data["status"]});
          }
        },
        child: Container(
          height: 140,
          margin: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                fit: BoxFit.fill,
              ),
              borderRadius:
              BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(
                  horizontal: 5),
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
                      width: 55,
                      height: 27,
                      alignment: Alignment.center,
                      child: Text(
                        index == 0 ? "特价场" : "普通场",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12),
                      )),
                  data["status"] == 1
                      ? Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 5),
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
                              color: Colors.white,
                              fontSize:10),
                        )
                      ],
                    ),
                  )
                      : data["status"] == 2
                      ? Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 5),
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
                              color: Colors.green,
                              fontSize:
                             10),
                        )
                      ],
                    ),
                  )
                      : data["status"] == 3
                      ? Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal:
                       4),
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
                              color: Colors.red,
                              fontSize: 10),
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
  void _getSwiper() {}
  //轮播图
  Widget _swiperWidget( swperListData) {
    return Container(
      height: 180,
      child: AspectRatio(
        aspectRatio: 3 / 1, //适配所有终端
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
      padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10),
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffF1F1F1)),
            padding: EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("下午场"),
                Text("14:30-16:30",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey))
              ],
            ),
          ),
          Container(
              height: list.length * 140,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(), //禁止滚动
                itemCount: list.length,
                itemExtent: 140,
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
            Navigator.pushNamed(context, "/auctionSession",arguments: {"status":data["status"]});
          } else {
            Navigator.pushNamed(context, "/auctionSession",arguments: {"status":data["status"]});
          }
        },
        child: Container(
          height: 140,
          margin: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                fit: BoxFit.fill,
              ),
              borderRadius:
              BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(
                  horizontal: 5),
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
                      width:55,
                      height: 27,
                      alignment: Alignment.center,
                      child: Text(
                        index == 0 ? "特价场" : "普通场",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12),
                      )),
                  data["status"] == 1
                      ? Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 5),
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
                              color: Colors.white,
                              fontSize: 10),
                        )
                      ],
                    ),
                  )
                      : data["status"] == 2
                      ? Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 5),
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
                              color: Colors.green,
                              fontSize:
                              10),
                        )
                      ],
                    ),
                  )
                      : data["status"] == 3
                      ? Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal:
                        4),
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
                              color: Colors.red,
                              fontSize: 10),
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
  
  
}
