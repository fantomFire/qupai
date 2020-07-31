import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/widgets/appbars.dart';

import 'order_page.dart';

class EnsureOrder extends StatefulWidget {
  @override
  _EnsureOrderState createState() => _EnsureOrderState();
}

class _EnsureOrderState extends State<EnsureOrder>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  PageController _pageController;

  List tabs = ["订单", "商户信息"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _pageController = new PageController();
    _tabController.addListener(() {
      if (_tabController.index.toDouble() == _tabController.animation.value) {
        if (_tabController.index == 0) {
        } else if (_tabController.index == 1) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBars.normalTitle(context, "确认订单"),
          Container(
              height: 35,
              child: TabBar(
                controller: _tabController,
                labelColor: Color(0xffC60000),
                indicator: const BoxDecoration(),
                unselectedLabelColor: Colors.black,
                onTap: (index) {
                  _pageController.jumpToPage(index);
                },
                tabs: tabs
                    .map((item) => Tab(
                  text: item,
                ))
                    .toList(),
              )),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [OrderPage(), OrderPage()],
              onPageChanged: (index) {
                _tabController.animateTo(index);
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
