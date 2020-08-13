import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/widgets/RoundCheckBox.dart';
import 'package:qupai/widgets/WZTextField.dart';

import '../urls.dart';

class NRegisterPage extends StatefulWidget {
  NRegisterPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<NRegisterPage> {
  bool isButtonEnable = true; //获取验证码按钮状态  是否可点击
  String buttonText = '获取验证码'; //初始文本
  String phone;
  String inviteCode ;
  String smsCode;
  String pwd ;
  int count = 60; //初始倒计时时间
  Timer timer; //倒计时的计时器
  bool check = false;//阅读协议选择状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());

        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(UiUtils.getImgPath("loginbg")),
              fit: BoxFit.fill,
            ),
          ),
          child:SingleChildScrollView(
            child:  Center(
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
                    margin: EdgeInsets.fromLTRB(
                        0, 0, 0, ScreenUtil().getAdapterSize(20)),
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
                        inviteCode = value;
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
                      },
                      errorText: "密码不能为空",
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
                            child: Text("注册",
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: ScreenUtil().getAdapterSize(18))),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          toRegister();


                        },
                      )),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RoundCheckBox(
                          value: check,
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
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                                TextSpan(
                                    text: "《隐私政策》",
                                    style: TextStyle(
                                      color: Color(0xffC60000),
                                      fontSize: ScreenUtil().getAdapterSize(10),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                              ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
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

  void _buttonClickListen()async {
    if(phone==null||phone.length!=11){
      ToastUtil.toast("请输入正确的手机号码");
      return ;
    }
    if(!UiUtils.checkPhone(phone)){
      ToastUtil.toast("请输入正确的手机号码");
      return ;
    }
    HttpResponse response = await HttpUtil.send(context, "post", Urls.getYZM, {
      "user_phone":phone,
    });
    if(response.result){
      ToastUtil.toast("验证码发送成功");
    }


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

  void toRegister()async {
    if(phone==null||phone.length!=11){
      ToastUtil.toast("请输入正确的手机号码");
      return ;
    }
    if(!UiUtils.checkPhone(phone)){
      ToastUtil.toast("请输入正确的手机号码");
      return ;
    }
    if(smsCode==null){
      ToastUtil.toast("请输入验证码");
      return ;
    }

    if(pwd==null){
      ToastUtil.toast("请输入密码");
      return ;
    }
    if(pwd.length<8){

      ToastUtil.toast("请输入至少8位密码");
      return ;
    }
    if(!check){
      ToastUtil.toast("注册用户需同意用户协议，隐私策略");
      return ;
    }

    HttpResponse response = await HttpUtil.send(context, "post", Urls.Register, {
      "user_phone":phone,
      "user_password":pwd,
      "invite":inviteCode,
      "user_code":smsCode,
    });
    if(response.result){
     ToastUtil.toast("注册成功");
     NavigatorUtil.pop(context);
    }




  }
}
