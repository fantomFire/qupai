import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/widgets/appbars.dart';
import 'order_page.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<String> _tabTitles = ["全部",'待付款', "待确认", "申诉", "已取消","已完成",];
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabTitles.length);
    _pageController = new PageController();
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

            AppBars.normalTitle(context, '我的买单'),
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
      ),
      OrderScreenDemand(
        status:1,
      ),
      OrderScreenDemand(
        status:2,
      ),
      OrderScreenDemand(
        status: 3,
      ),
      OrderScreenDemand(
        status: 4,
      ),
      OrderScreenDemand(
        status: 5,
      ),
    ];

  }
}
