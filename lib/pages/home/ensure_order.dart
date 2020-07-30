import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnsureOrder extends StatefulWidget {
  @override
  _EnsureOrderState createState() => _EnsureOrderState();
}

class _EnsureOrderState extends State<EnsureOrder> with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List tabs = ["可拍卖", "已拍卖"];
@override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index.toDouble() == _tabController.animation.value) {
        if (_tabController.index == 0) {

        } else if (_tabController.index == 1) {
        }
      }
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                      return  Container();
                    }).toList(),
                  ),
                )
              ],
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
