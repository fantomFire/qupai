import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/model/other_bean.dart';
import 'package:qupai/urls.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';

class WCashPage extends StatefulWidget {
  final double money;

  const WCashPage({Key key, this.money}) : super(key: key);

  @override
  WCashPageState createState() => WCashPageState();
}

class WCashPageState extends State<WCashPage> {
  String txMoney = "0";

  @override
  void initState() {
    super.initState();
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
                    child: Text(
                      "*提现金额会即使转入您的余额，将会扣除提现金额的${txhl}%作为代缴人所得税",
                      style: TextStyle(
                          fontSize: ScreenUtil().getSp(9),
                          color: BaseColor.color_guashouerror),
                    ),
                  )
                ],
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

    if (txMoney == ""||num == 0) {
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
