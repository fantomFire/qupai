import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/widgets/WZTextField.dart';

class NLoginPage extends StatefulWidget {
  NLoginPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<NLoginPage> {
  String phone;
  String pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(UiUtils.getImgPath("loginbg")),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //logo
              Container(
                height: ScreenUtil().getAdapterSize(250),
                child: Image(
                  image: AssetImage(UiUtils.getImgPath("qupai")),
                  fit: BoxFit.contain,
                  width: ScreenUtil().getAdapterSize(67),
                  height: ScreenUtil().getAdapterSize(88),
                ),
              ),
              Container(
                width: ScreenUtil().getAdapterSize(267),
                child: WZTextField(
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  hintText: "手机号",
                  // labelText: "手机号",
                  icon: Icon(
                    Icons.phone_android,
                    size: ScreenUtil().getAdapterSize(20),
                  ),
                  onChanged: (value) {
                    phone = value;
                  },
                  errorText: "手机号不能为空",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, ScreenUtil().getAdapterSize(20),
                    0, ScreenUtil().getAdapterSize(57)),
                width: ScreenUtil().getAdapterSize(267),
                child: WZTextField(
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  hintText: "密码",
                  icon: Icon(
                    Icons.lock,
                    size: ScreenUtil().getAdapterSize(20),
                  ),
                  onChanged: (value) {
                    pwd = value;
                  },
                  // errorText: "密码不能为空",
                ),
              ),
              Container(
                  height: ScreenUtil().getAdapterSize(40),
                  width: ScreenUtil().getAdapterSize(280),
                  child: FlatButton(
                    color: Color(0xffC60000),
                    colorBrightness: Brightness.dark,
                    child: Container(
                      child: Center(
                        child: Text("登录",
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: ScreenUtil().getAdapterSize(18))),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () async {

                      //当前测试专用
                      SpUtil.putString("user_id", "1");

                      NavigatorUtil.pushNamed(context, "/main_page");
                    },
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(0, ScreenUtil().getAdapterSize(20),
                    0, ScreenUtil().getAdapterSize(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      child: Text("立即注册",
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: ScreenUtil().getAdapterSize(12))),
                      onTap: () {
                        NavigatorUtil.pushNamed(context, "/register");
                      },
                      highlightColor: Colors.transparent,
                    ),
                    Text("   |   "),
                    InkWell(
                      child: Text("忘记密码?",
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: ScreenUtil().getAdapterSize(12))),
                      onTap: () {
                        NavigatorUtil.pushNamed(context, "/forget");
                      },
                      highlightColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
              Center(
                child: Text("短信验证登录",
                    style: TextStyle(
                        color: Color(0xffC60000),
                        fontSize: ScreenUtil().getAdapterSize(12))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
