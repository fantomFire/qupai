import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/values/baseColor.dart';

class WCashPage extends StatefulWidget {
  @override
  WCashPageState createState() => WCashPageState();
}

class WCashPageState extends State<WCashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("提现")),
      body: Container(
        child: Container(
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
                    Container(
                        width: 200,
                        child: TextField()),
                  ],
                ),
              ),
              Container(
                child: Text(
                  "*提现金额会即使转入您的余额，将会扣除提现金额的10%作为代缴人所得税",
                  style: TextStyle(
                      fontSize: ScreenUtil().getSp(9),
                      color: BaseColor.color_guashouerror),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
