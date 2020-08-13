import 'dart:async';
import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/urls.dart';
import 'package:qupai/urls.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/widgets/WZTextField.dart';

import '../urls.dart';

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
        title: Text(
          "忘记密码",
          style: TextStyle(fontSize: ScreenUtil().getSp(18)),
        ),
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
                  noLine: true,
                  titleText: "手机号    ",
                  iconWidth: 80,
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  hintText: "请输入手机号",
                  // labelText: "手机号",
                  onChanged: (value) {
                    phone = value;
                  },
                  errorText: "手机号不能为空",
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 80),
                child: Line(),
              ),
              Container(
                child: WZTextField(
                  noLine: true,
                  titleText: "验证码    ",
                  iconWidth: 80,
                  hintText: "请输入验证码",
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  button: Container(
                    constraints: BoxConstraints(),
                    child: FlatButton(
                      child: Container(
                        child: Center(
                          child: Text(
                            '$buttonText',
                            style: TextStyle(
                                color: BaseColor.color_C60000,
                                fontSize: ScreenUtil().getSp(12)),
                          ),
                        ),
                      ),
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
                margin: EdgeInsets.only(left: 80),
                child: Line(),
              ),
              Container(
                child: WZTextField(
                  noLine: true,
                  titleText: "设置密码  ",
                  iconWidth: 80,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  hintText: "请输入密码",
                  onChanged: (value) {
                    pwd = value;
                  },
                  errorText: "密码不能为空",
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 80),
                child: Line(),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(0, ScreenUtil().getAdapterSize(20),
                    0, ScreenUtil().getAdapterSize(198)),
                child: Text(
                  "密码必须8-16位的数字、字母组合",
                  style: TextStyle(
                      fontSize: ScreenUtil().getSp(10),
                      color: Color(0xffBBBBBB)),
                ),
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
                    onPressed: () async {
                      toReset();
                    },
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

  void _buttonClickListen() async {
    if (phone == null || phone.length != 11) {
      ToastUtil.toast("请输入正确的手机号码");
      return;
    }
    if (!UiUtils.checkPhone(phone)) {
      ToastUtil.toast("请输入正确的手机号码");
      return;
    }

    setState(() async {
      //当按钮可点击时
      if (isButtonEnable) {
        HttpResponse response =
            await HttpUtil.send(context, "post", Urls.getYZM, {
          "user_phone": phone,
        });
        if (response.result) {
          ToastUtil.toast("验证码发送成功");
        }

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

  void toReset() async {
    if (phone == null || phone.length != 11) {
      ToastUtil.toast("请输入正确的手机号码");
      return;
    }
    if (!UiUtils.checkPhone(phone)) {
      ToastUtil.toast("请输入正确的手机号码");
      return;
    }
    if (smsCode == null) {
      ToastUtil.toast("请输入验证码");
      return;
    }

    if (pwd == null) {
      ToastUtil.toast("请输入密码");
      return;
    }
    if (pwd.length < 8) {
      ToastUtil.toast("请输入至少8位密码");
      return;
    }

    HttpResponse response =
        await HttpUtil.send(context, "post", Urls.forgetPsd, {
      "user_phone": phone,
      "user_password": pwd,
      "user_code": smsCode,
    });

    if (response.result) {
      ToastUtil.toast("重置成功");
      NavigatorUtil.pop(context);
    }
  }
}
