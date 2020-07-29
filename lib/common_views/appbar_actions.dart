
/**
 * 顶部AppBar的封装
 */

import 'package:flutter/material.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';
import 'appbar_color.dart';
import 'customview.dart';

///顶部AppBar的封装
class MyAppBarActions {
  static MyAppBarActions _instance;

  static MyAppBarActions getInstance() {
    if (_instance == null) {
      _instance = MyAppBarActions();
    }
    return _instance;
  }

  Widget getSecondaryTopAppBar(BuildContext context, String title) {
    return AppBarColor(
      child: Column(
        children: <Widget>[
          Container(color: BaseColor.color_ffffff, height: MediaQuery.of(context).padding.top),
          Container(
            constraints: BoxConstraints(minHeight: 44),
            alignment: Alignment.centerLeft,
            color: BaseColor.color_ffffff,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    NavigatorUtil.pop(context);
                  },
                  child: Container(width: 44, height: 44, child: Image.asset(UiUtils.getImgPath('icon_back'), width: 10, height: 18)),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 44),
                    alignment: Alignment.center,
                    child: TextView(title,style: TextStyle(fontSize: 17,color: BaseColor.color_333333,fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 0.5, color:BaseColor.color_lineColor)
        ],
      ),
    );
  }

  Widget getSecondaryRightTopAppBar(BuildContext context, String title, String rightText, dynamic rightClick) {
    return Column(
      children: <Widget>[
        Container(
          color: BaseColor.color_ffffff,
          height: MediaQuery.of(context).padding.top,
        ),
        Container(
          height: 44,
          alignment: Alignment.centerLeft,
          color: BaseColor.color_ffffff,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  NavigatorUtil.pop(context);
                },
                child: Container(width: 44, height: 44, child: Image.asset(UiUtils.getImgPath('icon_back'), width: 10, height: 18)),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: TextView(
                    title,
                    style: TextStyles.color_333333_18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: rightClick,
                  child: TextView(
                    rightText,
                    style: TextStyles.color_f99a1d_17,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 0.5,
          color: BaseColor.color_dddddd,
        )
      ],
    );
  }
}
