import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/common_views/appbar_color.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';
class AppBars {
  static Widget tabTitle(BuildContext context, String title) {
    return AppBarColor(
      dark: true,
      child: Column(
        children: <Widget>[
          Container(height: MediaQuery.of(context).padding.top, color: BaseColor.color_ffffff),
          Container(
            height: 44,
            alignment: Alignment.center,
            color: BaseColor.color_ffffff,
            child: TextView(title,style: TextStyles.color_333333_20),
          ),
          Line(),
        ],
      ),
    );
  }

  static Widget tabTitleWithRightImage(BuildContext context, String title, String icon, dynamic rightClick) {
    return AppBarColor(
      child: Column(
        children: <Widget>[
          Container(color: BaseColor.color_ffffff, height: MediaQuery.of(context).padding.top),
          Container(
            constraints: BoxConstraints(minHeight: 44),
            color: BaseColor.color_ffffff,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  right: 10,
                  child: GestureDetector(
                    onTap: rightClick,
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 44,
                        height: 44,
                        child: Image.asset(UiUtils.getImgPath(icon), width: 10, height: 18)),
                  ),
                ),
                Center(
                  child: TextView(title,style: TextStyles.color_333333_20),
                ),
              ],
            ),
          ),
          Container(height: 0.5, color: BaseColor.color_E6E6E6)
        ],
      ),
    );
  }

  static Widget normalTitle(BuildContext context, String title) {
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
                    child: TextView(title, style:TextStyles.color_333333_20),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 0.5, color: BaseColor.color_E6E6E6)
        ],
      ),
    );
  }

  static Widget normalTitleWithRightButton(BuildContext context, String title, String rightText, dynamic rightClick) {
    return AppBarColor(
      child: Column(
        children: <Widget>[
          Container(color: BaseColor.color_ffffff, height: MediaQuery.of(context).padding.top),
          Container(
            constraints: BoxConstraints(minHeight: 44),
            color: BaseColor.color_ffffff,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        NavigatorUtil.pop(context);
                      },
                      child: Container(width: 44, height: 44, child: Image.asset(UiUtils.getImgPath('icon_back'), width: 10, height: 18)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: BaseColor.color_3E7FFF,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      margin: EdgeInsets.only(right: 5),
                      child: GestureDetector(
                        onTap: rightClick,
                        child: TextView(
                          rightText,
                          style: TextStyles.color_ffffff_14,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[TextView(title, style:TextStyles.color_333333_20)],
                ),
              ],
            ),
          ),
          Container(height: 0.5, color: BaseColor.color_E6E6E6)
        ],
      ),
    );
  }

  static Widget normalTitleWithClick(BuildContext context, String title, String icon, dynamic leftClick, dynamic rightClick) {
    return AppBarColor(
      child: Column(
        children: <Widget>[
          Container(color: BaseColor.color_ffffff, height: MediaQuery.of(context).padding.top),
          Container(
            constraints: BoxConstraints(minHeight: 44),
            color: BaseColor.color_ffffff,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: leftClick,
                      child: Container(width: 44, height: 44, child: Image.asset(UiUtils.getImgPath('icon_back'), width: 10, height: 18)),
                    ),
                    GestureDetector(
                      onTap: rightClick,
                      child: Container(
                          width: 70,
                          height: 44,
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Image.asset(UiUtils.getImgPath(icon), width: 20, height: 20, fit: BoxFit.contain),
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[TextView(title,style: TextStyles.color_333333_20)],
                ),
              ],
            ),
          ),
          Container(height: 0.5, color: BaseColor.color_E6E6E6)
        ],
      ),
    );
  }

  static Widget normalTitleWithRightImage(BuildContext context, String title, String icon, dynamic rightClick) {
    return AppBarColor(
      child: Column(
        children: <Widget>[
          Container(color: BaseColor.color_ffffff, height: MediaQuery.of(context).padding.top),
          Container(
            constraints: BoxConstraints(minHeight: 44),
            color: BaseColor.color_ffffff,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        NavigatorUtil.pop(context);
                      },
                      child: Container(width: 44, height: 44, child: Image.asset(UiUtils.getImgPath('icon_back'), width: 10, height: 18)),
                    ),
                    GestureDetector(
                      onTap: rightClick,
                      child: Container(
                          width: 70,
                          height: 44,
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Image.asset(UiUtils.getImgPath(icon), width: 20, height: 20, fit: BoxFit.contain),
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[TextView(title,style: TextStyles.color_333333_20)],
                ),
              ],
            ),
          ),
          Container(height: 0.5, color: BaseColor.color_E6E6E6)
        ],
      ),
    );
  }

  static Widget normalTitleWithLeftImage(BuildContext context, String title, dynamic liftClick) {
    return AppBarColor(
      child: Column(
        children: <Widget>[
          Container(color: BaseColor.color_ffffff, height: MediaQuery.of(context).padding.top),
          Container(
            constraints: BoxConstraints(minHeight: 44),
            color: BaseColor.color_ffffff,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: liftClick,
                  child: Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      width: 44,
                      height: 44,
                      child: Image.asset(UiUtils.getImgPath('icon_back'), width: 22, height: 25)),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextView(title,style: TextStyles.color_333333_20),
                )
              ],
            ),
          ),
          Container(height: 0.5, color: BaseColor.color_E6E6E6)
        ],
      ),
    );
  }
}
