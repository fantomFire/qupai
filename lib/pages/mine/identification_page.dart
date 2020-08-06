import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/common_views/inputitem.dart';
import 'package:qupai/common_views/line.dart';

class IdentificationPage extends StatefulWidget {
  @override
  IdentificationPageState createState() => IdentificationPageState();
}

class IdentificationPageState extends State<IdentificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "实名认证",
            style: TextStyle(fontSize: 18),
          )),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  InputItem(
                    title: "真实姓名",
                    titleWidth: ScreenUtil().getAdapterSize(80),
                    inputTextAlign: TextAlign.left,
                    hintText: "请输入真实姓名",
                    fontSize: ScreenUtil().getSp(15),
                    obscureText: true,
                    inputBorder: true,
                    noBottomLine: true,
                  ),
                  Line(),
                  InputItem(
                    title: "身份证号",
                    titleWidth: ScreenUtil().getAdapterSize(80),
                    inputTextAlign: TextAlign.left,
                    hintText: "请输入身份证号",
                    fontSize: ScreenUtil().getSp(15),
                    obscureText: true,
                    inputBorder: true,
                    noBottomLine: true,
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(
                    0, ScreenUtil().getAdapterSize(138), 0, ScreenUtil().getAdapterSize(66)),
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
                  onPressed: () async {},
                )),
          ],
        ),
      ),
    );
  }
}
