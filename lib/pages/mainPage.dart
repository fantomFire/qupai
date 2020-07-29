import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/cacahe_manager.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';

import '../common_views/customview.dart';
import '../login/entity/login_entity.dart';
import 'custom/customer_screen.dart';
import 'home/home_screen.dart';
import 'main/main_screen.dart';
import 'order/order_screen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>with SingleTickerProviderStateMixin  {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ["商城", "订单", "客服", "我的"];
  String user_id;
  PageController _pageController = PageController();

/*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  TextView getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new TextView(appBarTitles[curIndex],
          style: TextStyles.color_D68_14);
    } else {
      return new TextView(appBarTitles[curIndex],
          style: TextStyles.color_333333_12);
    }
  }

  /*
   * 根据image路径获取图片
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 16.0, height: 16.0);
  }

  @override
  void initState() {
    super.initState();
     user_id =  SpUtil.getString("user_id");
  setUserInfo();
    tabImages = [
      [
        getTabImage(UiUtils.getImgPath('home_normal')),
        getTabImage(UiUtils.getImgPath('home_select'))
      ],
      [
        getTabImage(UiUtils.getImgPath('order_normal')),
        getTabImage(UiUtils.getImgPath('tab_order_selected'))
      ],
      [
        getTabImage(UiUtils.getImgPath('kefu')),
        getTabImage(UiUtils.getImgPath('kefu_select'))
      ],
      [
        getTabImage(UiUtils.getImgPath('mine_normal')),
        getTabImage(UiUtils.getImgPath('mine_select'))
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).padding.top,
              ),
              Expanded(
                  child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: <Widget>[
                  HomeScreen(),
                  OrderScreen(),
                   CustomServiceScreen(),
                  //    ChatScreen(),
                  MainScreen(),
                ],
              )),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: BaseColor.color_ffffff,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: getTabIcon(0), title: getTabTitle(0)),
              BottomNavigationBarItem(
                  icon: getTabIcon(1), title: getTabTitle(1)),
              BottomNavigationBarItem(
                  icon: getTabIcon(2), title: getTabTitle(2)),
              BottomNavigationBarItem(
                  icon: getTabIcon(3), title: getTabTitle(3)),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _tabIndex,
            iconSize: 16.0,
            onTap: (index){
              setState(() {
               int current = _tabIndex;
                _tabIndex = index;
                if(_tabIndex!=0){
                  if(user_id?.isNotEmpty == true){

                    if(_tabIndex==2){
                      _tabIndex=current;
                      NavigatorUtil.pushNamed(context, "/tochat");
                    }else{
                      _pageController.jumpToPage(_tabIndex);
                    }
                    //_pageController.jumpToPage(_tabIndex);
                  }else{
                    NavigatorUtil.pushNamed(context,"/login");
                  }
                }else{
                  _pageController.jumpToPage(_tabIndex);
                }



              });

            },


          ),
        ),
        onWillPop: _doubleExit);
  }

  int _lastClickTime = 0;

  Future<bool> _doubleExit() {
    if (_tabIndex != 0) {
      // jumpTo(0);
      return new Future.value(false);
    }
    int nowTime = new DateTime.now().microsecondsSinceEpoch;
    if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
      return new Future.value(true);
    } else {
      ToastUtil.toast("再按一次退出程序");
      _lastClickTime = new DateTime.now().microsecondsSinceEpoch;
      new Future.delayed(const Duration(milliseconds: 1500), () {
        _lastClickTime = 0;
      });
      return new Future.value(false);
    }
  }

  void setUserInfo() async{
    if(user_id?.isNotEmpty == true) {
      LoginEntity entity = SpUtil.getObj(
          'user', (v) => LoginEntity.fromJson(v));
      CacheManager.instance.setUserInfo(entity);
      CacheManager.instance.setCookie(entity.user_token);
    }
  }
}
