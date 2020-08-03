import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:qupai/pages/mine/physical_order/physical_page.dart';
import 'package:qupai/pages/mine/sell_order/sell_page.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/widgets/appbars.dart';
class PhysicalScreen extends StatefulWidget {
  @override
  _PhysicalScreenState createState() => _PhysicalScreenState();
}

class _PhysicalScreenState extends State<PhysicalScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<String> _tabTitles = ["全部",'待发货', "待收货","已完成",];
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
      PhysicalPage(
        status: 0,
      ),
      PhysicalPage(
        status:1,
      ),
      PhysicalPage(
        status:2,
      ),
      PhysicalPage(
        status: 3,
      ),

    ];

  }
}
