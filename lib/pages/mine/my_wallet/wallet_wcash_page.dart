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

class WalletWCashPage extends StatefulWidget {
  final double money;

  const WalletWCashPage({Key key, this.money}) : super(key: key);

  @override
  WalletWCashPageState createState() => WalletWCashPageState();
}

class WalletWCashPageState extends State<WalletWCashPage> {
  String txMoney = "0";
  UserInfoBean userInfoBean = UserInfoBean();

  @override
  void initState() {
    super.initState();
    userInfoBean.zfb_account = "";
    userInfoBean.zfb_name = "";
    getTXhl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "提现",
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
                          child: Container(child: TextField(
                            onChanged: (value) {
                              txMoney = value;
                            },
                          )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "*额外扣除${txhl}%手续费",
                      style: TextStyle(
                          fontSize: ScreenUtil().getSp(9),
                          color: BaseColor.color_guashouerror),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                NavigatorUtil.pushNamed<UserInfoBean>(context, "/add_zfb")
                    .then((UserInfoBean result) {
                  if (result != null) {
                    userInfoBean.zfb_name = result.zfb_name;
                    userInfoBean.zfb_account = result.zfb_account;
                  }
                });
              },
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
                      child: Image.asset(UiUtils.getImgPath("icon_pay_zfb")),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                userInfoBean.zfb_name,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3, left: 15),
                              child: Text(
                                userInfoBean.zfb_account,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: BaseColor.color_999999),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 11),
                      alignment: Alignment.centerRight,
                      child: Image.asset(UiUtils.getImgPath("nextpage")),
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
                          child: Text("提现",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: ScreenUtil().getAdapterSize(18))),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () async {
                        toTx();
                      },
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  num txhl = 0;

  void getTXhl() async {
    HttpResponse response = await HttpUtil.send(
        context, "post", Urls.getZRyehl, {"user_id": UiUtils.getUserId()},
        initState: true);

    if (response.result) {
      if (response.datas != null && response.datas.length > 0) {
        OtherBean otherBean = OtherBean.fromJson(response.datas);
        txhl = otherBean.yetxl;
      } else {
        ToastUtil.toast(response.message);
      }
      setState(() {});
    }
  }

  void toTx() async {
    double num = double.parse(txMoney);
    if (num > widget.money) {
      return ToastUtil.toast("提现金额不能超过总余额");
    }

    if (txMoney == "" || num == 0) {
      return ToastUtil.toast("提现金额不能为零");
    }

    HttpResponse response = await HttpUtil.send(
        context,
        "post",
        Urls.toZRye,
        {
          "user_id": UiUtils.getUserId(),
          "money": txMoney,
          "txl": txhl.toString()
        },
        initState: true);

    if (response.result) {
      if (response.datas != null && response.datas.length > 0) {
        OtherBean otherBean = OtherBean.fromJson(response.datas);
        txhl = otherBean.yetxl;
      } else {
        ToastUtil.toast(response.message);
        NavigatorUtil.pop(context);
      }
      setState(() {});
    }
  }
}
