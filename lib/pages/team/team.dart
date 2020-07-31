import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/uiutils.dart';

import '../../urls.dart';

class TeamPage extends StatefulWidget {
  TeamPage({Key key}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  int isSelect = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((e) {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 下拉刷新数据
  Future<Null> _refreshData() async {}

  Widget _headerWidget() {
    return Container(
        padding: EdgeInsets.fromLTRB(
            ScreenUtil().getAdapterSize(0),
            ScreenUtil().getAdapterSize(50),
            ScreenUtil().getAdapterSize(0),
            ScreenUtil().getAdapterSize(0)),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(UiUtils.getImgPath("teambg")),
            fit: BoxFit.cover,
          ),
        ),
        height: ScreenUtil().getAdapterSize(180),
        width: MediaQuery.of(context).size.width,
        child: SizedBox());
  }

  Widget _otherWidget(list) {
    return Container(
        margin: EdgeInsets.only(
            top: ScreenUtil().getAdapterSize(70),
            bottom: ScreenUtil().getAdapterSize(20)),
        padding:
            EdgeInsets.symmetric(horizontal: ScreenUtil().getAdapterSize(20)),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSelect = 0;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().getAdapterSize(0),
                          vertical: ScreenUtil().getAdapterSize(8)),
                      decoration: BoxDecoration(
                          color: isSelect == 0
                              ? Color(0xffC60000)
                              : Colors.transparent,
                          border: Border.all(color: Color(0xffC60000)),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      child: Text(
                        "我的团队",
                        style: TextStyle(
                            color: isSelect == 0 ? Colors.white : Colors.black,
                            fontSize: ScreenUtil().getAdapterSize(15)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      isSelect = 1;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().getAdapterSize(0),
                        vertical: ScreenUtil().getAdapterSize(8)),
                    decoration: BoxDecoration(
                        color: isSelect == 1
                            ? Color(0xffC60000)
                            : Colors.transparent,
                        border: Border.all(color: Color(0xffC60000)),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Text(
                      "我的直推",
                      style: TextStyle(
                          color: isSelect == 1 ? Colors.white : Colors.black,
                          fontSize: ScreenUtil().getAdapterSize(15)),
                    ),
                  ),
                ))
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().getAdapterSize(20),
                ),
                child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListView.separated(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _listItemWidget(list[index], index);
                      },
                      padding: EdgeInsets.all(ScreenUtil().getAdapterSize(10)),
                      //分割器构造器
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Colors.grey[300],
                          height: ScreenUtil().getAdapterSize(1),
                        );
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _listItemWidget(data, index) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: ScreenUtil().getAdapterSize(10)),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                  child: CachedNetworkImage(
                imageUrl:
                Urls.imageTest,
                width: ScreenUtil().getAdapterSize(40),
                height: ScreenUtil().getAdapterSize(40),
                fit: BoxFit.fill,
                // cache: true,
              )),
              SizedBox(
                width: ScreenUtil().getAdapterSize(10),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "昵称",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: ScreenUtil().getAdapterSize(14)),
                            ),
                            SizedBox(
                              width: ScreenUtil().getAdapterSize(10),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().getAdapterSize(6),
                                  vertical: ScreenUtil().getAdapterSize(3)),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xffECC29C),
                                    Color(0xffD2A74F)
                                  ]),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Text(
                                "会员等级",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().getAdapterSize(10)),
                              ),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: ScreenUtil().getAdapterSize(5),
                    ),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "手机号",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: ScreenUtil().getAdapterSize(12)),
                            ),
                            Text(
                              "加入时间",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: ScreenUtil().getAdapterSize(12)),
                            ),
                          ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _bodyWidget() {
    List list = [1, 2, 3, 4, 5, 6, 7];
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              _headerWidget(),
              Expanded(
                child: _otherWidget(list),
              )
            ],
          ),
        ),
        Positioned(
            top: ScreenUtil().getAdapterSize(80),
            left: 0,
            right: 0,
            child: Container(
                height: ScreenUtil().getAdapterSize(170),
                alignment: Alignment.center,
                child: Card(
                  margin: EdgeInsets.all(ScreenUtil().getAdapterSize(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: ScreenUtil().getAdapterSize(80),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  right: ScreenUtil().getAdapterSize(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("昵称"),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            ScreenUtil().getAdapterSize(6),
                                        vertical:
                                            ScreenUtil().getAdapterSize(3)),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xffECC29C),
                                          Color(0xffD2A74F)
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Text(
                                      "会员等级",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ScreenUtil().getAdapterSize(10)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("我的团队："),
                                Text("10",
                                    style: TextStyle(
                                      color: Color(0xffC60000),
                                    )),
                                Text("人"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("我的直推："),
                                Text("10",
                                    style: TextStyle(
                                      color: Color(0xffC60000),
                                    )),
                                Text("人"),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))),
        Positioned(
          top: ScreenUtil().getAdapterSize(83),
          left: ScreenUtil().getAdapterSize(30),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                    color: Colors.white, width: ScreenUtil().getAdapterSize(3)),
                shape: BoxShape.circle),
            child: ClipOval(
                child: CachedNetworkImage(
              imageUrl:
              Urls.imageTest,
              width: ScreenUtil().getAdapterSize(60),
              height: ScreenUtil().getAdapterSize(60),
              fit: BoxFit.fill,
              // cache: true,
            )),
          ),
        )
      ],
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
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent, //把appbar的背景色改成透明
                title: Text(
                  "团队",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: false,
                elevation: 0,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.mail_outline,
                          // size: ScreenUtil().getAdapterSize(18),
                          color: Colors.white),
                      onPressed: () {})
                ],
              )),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _headerWidget {}
