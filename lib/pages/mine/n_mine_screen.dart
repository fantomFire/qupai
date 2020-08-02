import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/utils/cacahe_manager.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/utils/imageutil.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';

import '../../urls.dart';
import 'entity/user_info.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  int userId;
  UserInfoBean userInfoBean;

  @override
  void initState() {
    super.initState();
    userId = CacheManager.instance.getUerInfo()?.user_id;
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                  height: 225,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xffD63432), Color(0xffFE8564)]),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 36, right: 16, left: 16),
                    //消息和设置
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          child: GestureDetector(
                            onTap: () {
                              NavigatorUtil.pushNamed(context, "/setting_page");
                            },
                            child: Image.asset(UiUtils.getImgPath("icon_msg")),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: GestureDetector(
                            onTap: () {
                              NavigatorUtil.pushNamed(context, "/setting_page");
                            },
                            child: Image.asset(UiUtils.getImgPath("set")),
                          ),
                        )
                      ],
                    ),
                  ),
                  //头像
                  Container(
                    margin: EdgeInsets.only(top: 28, right: 13, left: 13),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: ClipOval(
                            child: ImageLoadUtil(
                              url: '${Urls.imageBase}${userInfoBean?.user_img}',
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Column(
                              //  mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                //名字...
                                Row(
                                  children: <Widget>[
                                    TextView(
                                      "小艾同学",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: BaseColor.color_ffffff),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        NavigatorUtil.pushNamed(
                                            context, "/mine_leve");
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 18,
                                        padding: EdgeInsets.only(right: 10),
                                        margin: EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            color: BaseColor.color_817c94),
                                        //身份标记
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(right: 4),
                                              alignment: Alignment.center,
                                              width: 17,
                                              height: 17,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      BaseColor.color_F8D986),
                                              child: Image.asset(
                                                  UiUtils.getImgPath("star")),
                                            ),
                                            TextView(
                                              "运营中心",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      BaseColor.color_ffffff),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.bottomRight,
                                        child: Image.asset(
                                            UiUtils.getImgPath("nextpage")),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 7,
                                ),
                                //电话...
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: TextView(
                                          "13812345678",
                                          style: TextStyles.color_ffffff_14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          TextView("邀请码 ${'K9527'}",
                                              style:
                                                  TextStyles.color_ffffff_13),
                                          GestureDetector(
                                            onTap: () {
                                              if (userInfoBean != null) {
                                                Clipboard.setData(ClipboardData(
                                                    text: userInfoBean
                                                        ?.user_invitation_code
                                                        .toString()));
                                                ToastUtil.toast("已复制该邀请码");
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 13,
                                              width: 27,
                                              padding: EdgeInsets.only(
                                                  left: 2, right: 2),
                                              margin: EdgeInsets.only(left: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(6)),
                                                  color: Color(0x55ffffff)),
                                              child: TextView(
                                                "复制",
                                                style:
                                                    TextStyles.color_ffffff_9,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Line(
                      left: 15,
                      right: 15,
                      height: 0.2,
                    ),
                  ),
                  //钱包积分
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            NavigatorUtil.pushNamed(context, "/my_wallet");
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 12),
                                child: TextView(
                                  "8799.00",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: BaseColor.color_ffffff),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: TextView(
                                  "我的钱包",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: BaseColor.color_DDDDD),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 35,
                          width: 0.5,
                          color: BaseColor.color_E6E6E6,
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigatorUtil.pushNamed(context, "/mine_getMoney");
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 12),
                                child: TextView(
                                  "8799",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: BaseColor.color_ffffff),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: TextView(
                                  "我的积分",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: BaseColor.color_DDDDD),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //广告图
            Container(
              margin: EdgeInsets.fromLTRB(16, 15, 16, 0),
              height: 60,
              decoration: new BoxDecoration(
                //背景
                color: Colors.white,
                //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                //设置四周边框
                border: new Border.all(width: 1, color: Colors.red),
              ),
            ),
            //我的订单
            Container(
              margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
              decoration: new BoxDecoration(
                //背景
                color: Colors.white,
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //设置四周边框
//                border: new Border.all(width: 1, color: Colors.red),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(11),
                    alignment: Alignment.centerLeft,
                    child: Text("我的订单",
                        style: TextStyle(
                            fontSize: ScreenUtil().getSp(16),
                            fontWeight: FontWeight.bold)),
                  ),
                  Line(),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 14),
                    //三个订单菜单
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            NavigatorUtil.pushNamed(context, "/buy_order");
                          },
                          child: Container(
                            color: BaseColor.color_ffffff,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(top: 12),
                                    width: 23,
                                    height: 23,
                                    child: Image.asset(
                                        UiUtils.getImgPath("icon_mrdd"))),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: TextView(
                                    "我的买单",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: BaseColor.color_333333),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigatorUtil.pushNamed(context, "/mine_getMoney");
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 12),
                                  width: 23,
                                  height: 23,
                                  child: Image.asset(
                                      UiUtils.getImgPath("icon_mcdd"))),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: TextView(
                                  "我的卖单",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: BaseColor.color_333333),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigatorUtil.pushNamed(context, "/mine_getMoney");
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 12),
                                  width: 23,
                                  height: 23,
                                  child: Image.asset(
                                      UiUtils.getImgPath("icon_swdd"))),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: TextView(
                                  "实物订单",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: BaseColor.color_333333),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //菜单栏
            Container(
              margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
              decoration: new BoxDecoration(
                //背景
                color: Colors.white,
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //设置四周边框
//                border: new Border.all(width: 1, color: Colors.red),
              ),
              child: Column(
                children: <Widget>[
                  mainItemWidget("icon_fxjl", "分享奖励", true, () {
                    NavigatorUtil.pushNamed(context, "/mine_appointment");
                  }),
                  mainItemWidget("icon_smrz", "实名认证", true, () {}),
                  mainItemWidget("icon_skm", "收款码", true, () {}),
                  mainItemWidget("icon_yhzn", "用户指南", true, () {}),
                  mainItemWidget("icon_fxts", "风险提示", false, () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainItemWidget(
      String imgPath, String title, bool showLine, dynamic onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  UiUtils.getImgPath(imgPath),
                  width: 22,
                  height: 22,
                  fit: BoxFit.fill,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    child: TextView(
                      title,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Image.asset(UiUtils.getImgPath("nextpage"))
              ],
            ),
          ),
        ),
        Line(
          left: 16,
          right: 16,
          color: getLineColor(showLine),
        ),
      ],
    );
  }

  Color getLineColor(bool showLine) {
    if (showLine) {
      return BaseColor.color_lineColor;
    }
    return Colors.transparent;
  }

  void getUserInfo() async {
    HttpResponse response = await HttpUtil.send(
        context, "post", Urls.UserInfo, {"user_id": userId},
        initState: true);
    if (response.result) {
      if (response.datas != null) {
        // userInfoBean = UserInfoBean.fromJson(response.datas);
        setState(() {});
      }
    }
  }
}
