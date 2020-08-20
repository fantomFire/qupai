import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/model/other_bean.dart';
import 'package:qupai/pages/mine/entity/user_info.dart';
import 'package:qupai/urls.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';

class WalletCZPage extends StatefulWidget {
  @override
  WalletCZPageState createState() => WalletCZPageState();
}

class WalletCZPageState extends State<WalletCZPage> {
  String czMoney = "0";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "充值",
        style: TextStyle(fontSize: 18),
      )),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 185,
              margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
              padding: EdgeInsets.fromLTRB(15, 20, 10, 15),
              decoration: new BoxDecoration(
                //背景
                color: Colors.white,
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //设置四周边框
//                border: new Border.all(width: 1, color: Colors.red),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("输入金额（元）",
                        style: TextStyle(
                            fontSize: ScreenUtil().getSp(17),
                            fontWeight: FontWeight.normal)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 36, bottom: 24),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          '¥',
                          style: TextStyle(fontSize: 25),
                        ),
                        Expanded(
                          child: Container(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                czMoney = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                height: 60,
                margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
                decoration: new BoxDecoration(
                  //背景
                  color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  //设置四周边框
//                border: new Border.all(width: 1, color: Colors.red),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 11),
                      alignment: Alignment.centerLeft,
                      child: Image.asset(UiUtils.getImgPath("icon_red_select")),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 11),
                      alignment: Alignment.centerRight,
                      child: Image.asset(UiUtils.getImgPath("icon_cz_zfb")),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: EdgeInsets.fromLTRB(
                        0, 0, 0, ScreenUtil().getAdapterSize(66)),
                    height: ScreenUtil().getAdapterSize(40),
                    width: ScreenUtil().getAdapterSize(280),
                    child: FlatButton(
                      color: Color(0xffC60000),
                      colorBrightness: Brightness.dark,
                      child: Container(
                        child: Center(
                          child: Text("充值",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: ScreenUtil().getAdapterSize(18))),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () async {
                        toChongzhi();
                      },
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //充值
  void toChongzhi() async {
    double num = double.parse(czMoney);

    if (czMoney == "" || num == 0) {
      return ToastUtil.toast("充值金额不能为零");
    }
  }
}
