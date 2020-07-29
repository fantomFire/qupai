import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:qupai/values/baseColor.dart';
import 'order_page.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<String> _tabTitles = ["全部",'待发货', "待确认", "挂售", "待支付",];
  TabController _tabController;
  PageController _pageController;
  List<EasyRefreshController> _easyRefreshControllers = new List();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabTitles.length);
    _pageController = new PageController();
    for (int i = 0; i < _tabTitles.length; i++) {
      _easyRefreshControllers.add(new EasyRefreshController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: BaseColor.color_ffffff_pagege,
        body: Column(
          children: <Widget>[
            Container(
              child: TabBar(
                onTap: (index) {
                  _pageController.jumpToPage(index);
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                indicatorColor: BaseColor.color_FFB003,
                labelColor: BaseColor.color_FFB003,
                unselectedLabelColor: BaseColor.color_333333,
                labelStyle: TextStyle(fontSize: 15),
                controller: _tabController,
                labelPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                indicatorPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                tabs: _tabTitles.map((title) {
                  return Tab(
                    text: title,
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  _tabController.animateTo(index);
                },
                children: getPages(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  List<Widget> getPages() {

    return [
      OrderScreenDemand(
        status: 0,
       // easyRefreshController: _easyRefreshControllers[0],

      ),
      OrderScreenDemand(
        status:1,
     //   easyRefreshController: _easyRefreshControllers[1],

      ),
      OrderScreenDemand(
        status:4,
        //easyRefreshController: _easyRefreshControllers[2],
      ),
      OrderScreenDemand(
        status: 3,
     //   easyRefreshController: _easyRefreshControllers[3],
      ),
      OrderScreenDemand(
        status: 5,
       // easyRefreshController: _easyRefreshControllers[4],
      ),

    ];

  }
  void refresh() {
    if (_easyRefreshControllers != null && _easyRefreshControllers.length != 0) {
      for (int i = 0; i < _easyRefreshControllers.length; i++) {
        if (_easyRefreshControllers[i] != null) {
          _easyRefreshControllers[i].callRefresh();
        }
      }
    }
  }
}
