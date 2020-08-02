import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/utils/cacahe_manager.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/imageutil.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';

import '../../urls.dart';
import 'entity/user_info.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                    margin: EdgeInsets.only(top: 40, right: 13, left: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          child: GestureDetector(
                            onTap: () {
                              NavigatorUtil.pushNamed(context, "/setting_page");
                            },
                            child: Image.asset(UiUtils.getImgPath("set")),
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
                  Container(
                    margin: EdgeInsets.only(top: 30, right: 15, left: 17),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            NavigatorUtil.pushNamed(
                              context,
                              "/user_info",
                            ).then((v) {
                              getUserInfo();
                            });
                          },
                          child: ClipOval(
                              child: ImageLoadUtil(
                            url: Urls.imageTest,
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                          )),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.only(left: 12),
                            child: Column(
                              //  mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    TextView(
                                      '小艾同学',
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
                                              "运营中心 ",
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
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: TextView(
                                          userInfoBean?.user_phone,
                                          style: TextStyles.color_ffffff_14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          TextView("邀请码 K098ZY",
                                              style:
                                                  TextStyles.color_ffffff_13),
                                          GestureDetector(
                                            onTap: () {
                                              ToastUtil.toast("已复制该邀请码");
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
                                  userInfoBean?.surplus.toString(),
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
                                  userInfoBean?.bonus.toString(),
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
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 10),
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(30)),
                clipBehavior: Clip.antiAlias,
                child: ImageLoadUtil(
                  url: Urls.imageTest,
                  fit: BoxFit.fill,
                  height: 60,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 37,
                      child: TextView(
                        '我的订单',
                        style: TextStyles.color_333333_16_b,
                      ),
                    ),
                    Line(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                UiUtils.getImgPath('buy_order'),
                                width: 23,
                                height: 23,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 13),
                                child: TextView('我的买单'),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                UiUtils.getImgPath('buy_order'),
                                width: 23,
                                height: 23,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 13),
                                child: TextView('我的卖单'),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                UiUtils.getImgPath('buy_order'),
                                width: 23,
                                height: 23,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 13),
                                child: TextView('实物订单'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            mainItemWidget("appointment", "我的预约", () {
              NavigatorUtil.pushNamed(context, "/mine_appointment");
            }),
            mainItemWidget("getmoney", "我的业绩", () {
              NavigatorUtil.pushNamed(context, "/mine_getMoney");
            }),
            mainItemWidget("team", "我的推荐", () {
              NavigatorUtil.pushNamed(context, "/mine_team");
            }),
            mainItemWidget("certification", "实名认证", () {
              if (userInfoBean?.user_card_status == '0') {
                NavigatorUtil.pushNamed(context, "/mine_certification")
                    .then((v) {
                  if (v != null) {
                    getUserInfo();
                  }
                });
              } else if (userInfoBean?.user_card_status == '1') {
                ToastUtil.toast("实名认证审核中");
              } else if (userInfoBean?.user_card_status == '2') {
                NavigatorUtil.pushNamed(context, "/mine_certification_succ");
              } else {
                NavigatorUtil.pushNamed(context, "/mine_certification_fail");
              }
            }),
            mainItemWidget("cardimg", "银行卡管理", () {
              NavigatorUtil.pushNamed(context, "/mine_card_manager");
            }),
            mainItemWidget("my_alipay", "支付宝管理", () {
              NavigatorUtil.pushNamed(context, "/add_zhifubao");
            }),
            mainItemWidget("share", "邀请好友", () {
              NavigatorUtil.pushNamed(context, "/invite_friend");
            }),
          ],
        ),
      ),
    );
  }

  Widget mainItemWidget(String imgPath, String title, dynamic onTap) {
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
        ),
      ],
    );
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
