import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/widgets/WZTextField.dart';

class NRegisterPage extends StatefulWidget {
  NRegisterPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<NRegisterPage> {
  bool isButtonEnable = true; //按钮状态  是否可点击
  String buttonText = '获取验证码'; //初始文本
  String phone = "";
  String pwd = "";
  String smsCode = "";
  int count = 60; //初始倒计时时间
  Timer timer; //倒计时的计时器
  bool loginType = true;
  bool check = false;

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
                    0, ScreenUtil().getAdapterSize(20)),
                width: ScreenUtil().getAdapterSize(267),
                child: WZTextField(
                  hintText: "验证码",
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  icon: Icon(
                    Icons.sms,
                    size: ScreenUtil().getAdapterSize(20),
                  ),
                  button: Container(
                    constraints: BoxConstraints(
                        maxWidth: ScreenUtil().getAdapterSize(80),
                        maxHeight: ScreenUtil().getAdapterSize(30)),
                    margin: EdgeInsets.all(ScreenUtil().getAdapterSize(5)),
                    child: FlatButton(
                      color: Color(0xffC60000),
                      colorBrightness: Brightness.dark,
                      child: Container(
                        child: Center(
                          child: Text(
                            '$buttonText',
                            style: TextStyle(
                                fontSize: ScreenUtil().getAdapterSize(9)),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.white,
                    ),
                  ),
                  suffixIconWidth: ScreenUtil().getAdapterSize(100),
                  suffixIconHeight: ScreenUtil().getAdapterSize(40),
                  onChanged: (value) {
                    LogUtil.v("验证码:" + value, tag: "摩登");
                    smsCode = value;
                    pwd = "";
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0,
                    0, ScreenUtil().getAdapterSize(20)),
                width: ScreenUtil().getAdapterSize(267),
                child: WZTextField(
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  hintText: "邀请码",
                  icon: Icon(
                    Icons.person_add,
                    size: ScreenUtil().getAdapterSize(20),
                  ),
                  onChanged: (value) {
                    pwd = value;
                    smsCode = "";
                  },
                  errorText: "邀请码不能为空",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, 0, 0, ScreenUtil().getAdapterSize(57)),
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
                    smsCode = "";
                  },
                  errorText: "密码不能为空",
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
                        child: Text("注册",
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: ScreenUtil().getAdapterSize(18))),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () async {},
                  )),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.fromLTRB(0, 0, 0, ScreenUtil().getAdapterSize(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: check,
                      activeColor: Color(0xffC60000),
                      onChanged: (bool val) {
                        // val 是布尔值
                        setState(() {
                          check = val;
                        });
                      },
                    ),
                    RichText(
                      text: TextSpan(
                          text: '我已阅读并接受',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenUtil().getAdapterSize(10)),
                          children: [
                            TextSpan(
                                text: "《用户协议》",
                                style: TextStyle(
                                  color: Color(0xffC60000),
                                  fontSize: ScreenUtil().getAdapterSize(10),
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {}),
                            TextSpan(
                                text: "《隐私政策》",
                                style: TextStyle(
                                  color: Color(0xffC60000),
                                  fontSize: ScreenUtil().getAdapterSize(10),
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {}),
                          ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
