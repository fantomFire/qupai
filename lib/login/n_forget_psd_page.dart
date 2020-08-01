import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/widgets/RoundCheckBox.dart';
import 'package:qupai/widgets/WZTextField.dart';

class NForgetPsdPage extends StatefulWidget {
  NForgetPsdPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ForgetPsdPageState();
  }
}

class _ForgetPsdPageState extends State<NForgetPsdPage> {
  bool isButtonEnable = true; //获取验证码按钮状态  是否可点击
  String buttonText = '获取验证码'; //初始文本
  String phone;
  String smsCode;
  String pwd;

  int count = 60; //初始倒计时时间
  Timer timer; //倒计时的计时器

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("忘记密码",style: TextStyle(fontSize: ScreenUtil().getSp(18)),),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, ScreenUtil().getAdapterSize(10), 0, 0),
        padding: EdgeInsets.only(left: ScreenUtil().getAdapterSize(16)),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: WZTextField(
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  hintText: "请输入手机号",
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
                child: WZTextField(
                  hintText: "请输入验证码",
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  icon: Icon(
                    Icons.verified_user,
                    size: ScreenUtil().getAdapterSize(20),
                  ),
                  button: Container(
                    constraints: BoxConstraints(),
                    margin: EdgeInsets.all(ScreenUtil().getAdapterSize(5)),
                    child: FlatButton(
                      color: Color(0xffC60000),
                      colorBrightness: Brightness.dark,
                      child: Container(
                        child: Center(
                          child: Text(
                            '$buttonText',
                            style: TextStyle(fontSize: ScreenUtil().getSp(11)),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.white,
                      onPressed: () {
                        _buttonClickListen();
                      },
                    ),
                  ),
                  suffixIconWidth: ScreenUtil().getHeight(100),
                  suffixIconHeight: ScreenUtil().getHeight(40),
                  onChanged: (value) {
                    smsCode = value;
                  },
                ),
              ),
              Container(
                child: WZTextField(
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  hintText: "请输入密码",
                  icon: Icon(
                    Icons.lock,
                    size: ScreenUtil().getAdapterSize(20),
                  ),
                  onChanged: (value) {
                    pwd = value;
                  },
                  errorText: "密码不能为空",
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(
                    0, ScreenUtil().getAdapterSize(20), 0, ScreenUtil().getAdapterSize(198)),
                child: Text("密码必须8-16位的数字、字母组合",style: TextStyle(fontSize: ScreenUtil().getSp(10),color: Color(0xffBBBBBB)),),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(
                      0, 0, 0, ScreenUtil().getAdapterSize(66)),
                  height: ScreenUtil().getAdapterSize(40),
                  width: ScreenUtil().getAdapterSize(280),
                  child: FlatButton(
                    color: Color(0xffC60000),
                    colorBrightness: Brightness.dark,
                    child: Container(
                      child: Center(
                        child: Text("完成",
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
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel(); //销毁计时器
    timer = null;
    super.dispose();
  }

  void _buttonClickListen() {
    setState(() async {
      //当按钮可点击时
      if (isButtonEnable) {
        isButtonEnable = false; //按钮状态标记
        _initTimer();
        return null; //返回null按钮禁止点击
      } else {
        //当按钮不可点击时
        return null; //返回null按钮禁止点击
      }
    });
  }

  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          isButtonEnable = true; //按钮可点击
          count = 60; //重置时间
          buttonText = '获取验证码'; //重置按钮文本
        } else {
          buttonText = '重发($count)'; //更新文本内容
        }
      });
    });
  }
}
