import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';

import 'cacahe_manager.dart';
import 'navigator_util.dart';

class UiUtils {
  static final int minClickDelayTime = 1000;
  static int lastClickTime = 0;
  static String imgPath = "https://t1.hddhhn.com/uploads/tu/201604/121/22.jpg";

  static bool notFastClick() {
    bool flag = false;
    int curClickTime = DateTime.now().millisecondsSinceEpoch;
    if ((curClickTime - lastClickTime) >= minClickDelayTime) {
      flag = true;
    }
    lastClickTime = curClickTime;
    return flag;
  }

  static bool checkPhone(String phone) {
    RegExp exp = RegExp(r'^1[3|4|5|6|7|8|9][0-9]\d{8}$');
    return exp.hasMatch(phone);
  }

  static bool checkIdCard(String idCard) {
    RegExp exp = RegExp(r'(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)');
    return exp.hasMatch(idCard);
  }

  static String getSub(List<String> content) {
    StringBuffer sb = StringBuffer();
    if (content != null) {
      for (var i in content) {
        sb.write(i.toString());
        sb.write("     ");
      }
      return sb.toString().trim();
    }
    return "";
  }

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getEmoPath(String name, {String format: 'png'}) {
    return 'assets/images/arclist/$name.$format';
  }

  static String getUserId() {
    return SpUtil.getString("user_id");
  }

  static void showTipDialog(BuildContext context, String content,
      {dynamic onSubmit,
      dynamic onQuit,
      bool hasNoQuit: false,
      bool willPop: false,
      String title: '提示',
      bool barrierDismissible: false}) {
    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => WillPopScope(
          child: new AlertDialog(
            title: Container(
              alignment: Alignment.center,
              child: new Text(
                title,
                style: TextStyles.color_333333_17,
              ),
            ),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new TextView(
                    content,
                    style: TextStyles.color_666666_13,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Offstage(
                offstage: hasNoQuit,
                child: new FlatButton(
                  child: new Text(
                    "取消",
                    style: TextStyles.color_666666_15,
                  ),
                  onPressed: () {
                    NavigatorUtil.pop(context);
                    if (onQuit != null) {
                      onQuit();
                    }
                  },
                ),
              ),
              new FlatButton(
                child: new Text(
                  "确定",
                  style: TextStyles.color_2192fc_15,
                ),
                onPressed: () {
                  NavigatorUtil.pop(context);
                  if (onSubmit != null) {
                    onSubmit();
                  }
                },
              )
            ],
          ),
          onWillPop: () async {
            if (willPop && barrierDismissible) {
              onQuit();
            }
            return Future.value(willPop);
          }),
    );
  }

  static void showRateDialog(BuildContext context, String rate, String content,
      {dynamic onSubmit,
      dynamic onQuit,
      bool hasNoQuit: false,
      bool willPop: false,
      String title: '提示',
      bool barrierDismissible: false}) {
    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => WillPopScope(
          child: new AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView("预约费用 ￥", style: TextStyles.color_333333_14),
                      Container(
                        margin: EdgeInsets.only(left: 6),
                        child: TextView(
                          "$content",
                          style: TextStyles.color_cc0000_14,
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.center,
                    child: TextView("(预约扣除 $rate %费用,参与抢购挂售,当日返回)",
                        style: TextStyles.color_333333_14),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                height: 44,
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        color: BaseColor.color_dddddd,
                        child: Text(
                          "取消",
                          style: TextStyles.color_666666_15,
                        ),
                      ),
                      onTap: () {
                        NavigatorUtil.pop(context);
                        if (onQuit != null) {
                          onQuit();
                        }
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        color: BaseColor.color_d68,
                        child: new Text(
                          "立即预约",
                          style: TextStyles.color_ffffff_15,
                        ),
                      ),
                      onTap: () {
                        NavigatorUtil.pop(context);
                        if (onSubmit != null) {
                          onSubmit();
                        }
                      },
                    )
                  ],
                ),
              ),
              /* Offstage(
                offstage: hasNoQuit,
                child: new GestureDetector(
                  child:Container(
                    width: 80,
                    height: 44,
                    child: Text(
                      "取消",
                      style: TextStyles.color_666666_15,
                    ),
                  ),
                  onTap: () {
                    NavigatorUtil.pop(context);
                    if (onQuit != null) {
                      onQuit();
                    }
                  },
                ),
              ),
              new GestureDetector(
                child:Container(
                  width: 80,
                  height: 35,
                  color: BaseColor.color_d68,
                  child:  new Text(
                    "立即预约",
                    style: TextStyles.color_ffffff_15,
                  ),
                ),
                onTap: () {
                  NavigatorUtil.pop(context);
                  if (onSubmit != null) {
                    onSubmit();
                  }
                },
              )*/
            ],
          ),
          onWillPop: () async {
            if (willPop && barrierDismissible) {
              onQuit();
            }
            return Future.value(willPop);
          }),
    );
  }

  static void showVersionDialog(BuildContext context, String content,
      {dynamic onSubmit,
      dynamic onQuit,
      bool hasNoQuit: false,
      bool willPop: false,
      String title: '提示',
      bool barrierDismissible: false}) {
    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => WillPopScope(
          child: new AlertDialog(
            title: Container(
              alignment: Alignment.center,
              child: new Text(
                title,
                style: TextStyles.color_333333_17,
              ),
            ),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new TextView(
                    content,
                    style: TextStyles.color_666666_13,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Offstage(
                offstage: hasNoQuit,
                child: new FlatButton(
                  child: new Text(
                    "稍后更新",
                    style: TextStyles.color_666666_15,
                  ),
                  onPressed: () {
                    NavigatorUtil.pop(context);
                    if (onQuit != null) {
                      onQuit();
                    }
                  },
                ),
              ),
              new FlatButton(
                child: new Text(
                  "立即更新",
                  style: TextStyles.color_2192fc_15,
                ),
                onPressed: () {
                  NavigatorUtil.pop(context);
                  if (onSubmit != null) {
                    onSubmit();
                  }
                },
              )
            ],
          ),
          onWillPop: () async {
            if (willPop && barrierDismissible) {
              onQuit();
            }
            return Future.value(willPop);
          }),
    );
  }

  static void showFukuanDialog(BuildContext context, String content,
      {dynamic onSubmit,
      dynamic onQuit,
      bool hasNoQuit: false,
      bool willPop: false,
      String title: '温馨提示',
      bool barrierDismissible: false}) {
    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => WillPopScope(
          child: new AlertDialog(
            title: Container(
              alignment: Alignment.center,
              child: new Text(
                title,
                style: TextStyles.color_333333_17,
              ),
            ),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new TextView(
                    content,
                    style: TextStyles.color_D68_14,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Offstage(
                offstage: hasNoQuit,
                child: new FlatButton(
                  child: new Text(
                    "取消",
                    style: TextStyles.color_666666_15,
                  ),
                  onPressed: () {
                    NavigatorUtil.pop(context);
                    if (onQuit != null) {
                      onQuit();
                    }
                  },
                ),
              ),
              new FlatButton(
                child: new Text(
                  "确定",
                  style: TextStyles.color_2192fc_15,
                ),
                onPressed: () {
                  NavigatorUtil.pop(context);
                  if (onSubmit != null) {
                    onSubmit();
                  }
                },
              )
            ],
          ),
          onWillPop: () async {
            if (willPop && barrierDismissible) {
              onQuit();
            }
            return Future.value(willPop);
          }),
    );
  }

  static Color fromHex({String code, int opacity}) {
    /* var str = code.substring(1, 7);
    var bigint = int.parse(str, radix: 16);
    final r = (bigint >> 16) & 255;
    final g = (bigint >> 8) & 255;
    final b = bigint & 255;
    int a = opacity ?? 255;
    return new Color(r: r, b: b, g: g, a: a);*/
  }

  static String getOrderState(int status) {
    //1待付款 2待确认 3申诉 4 已取消 5已完成6 待发货 7 待收货 8已收货
      if(status ==1){
        return '待付款';
      }else  if(status ==2){
        return '待确认';
      }else  if(status ==3){
        return '申诉';
      }else  if(status ==4){
        return '已取消';
      }else  if(status ==5){
        return '已完成';
      }else  if(status ==6){
        return '待发货';
      }else  if(status ==7){
        return '待收货';
      }else  if(status ==8){
        return '已收货';
      }


  }
}
