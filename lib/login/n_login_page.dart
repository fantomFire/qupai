import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/permission_init_upgrade.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/widgets/WZTextField.dart';

import '../urls.dart';
import 'entity/login_entity.dart';

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
  void initState() {
    super.initState();
    _init();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
         FocusScope.of(context).requestFocus(FocusNode());
        },
        child:SingleChildScrollView(
          child:  Container(
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
                          FocusScope.of(context).requestFocus(FocusNode());
                          _login();
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
        ),
      ),
    );
  }

  void _login() async{
    if (phone.length == 0) {
      ToastUtil.toast("请输入手机号码");
      return;
    }
    if(!UiUtils.checkPhone(phone)){
      ToastUtil.toast("请输入正确的手机号码");
      return ;
    }
    if (pwd.length== 0) {
      ToastUtil.toast("请输入密码");
      return;
    }

    HttpResponse response = await HttpUtil.send(context, "post", Urls.Login, {
      "user_phone":phone,
      "user_password":pwd,
    });
    if(response.result){
      ToastUtil.toast("登录成功");
      LoginEntity loginEntity = LoginEntity.fromJson(response.datas);
      loginSuccess(loginEntity);
      NavigatorUtil.pushReplacementNamed(context, "/main_page");
    }

  }

  Future loginSuccess(LoginEntity loginEntity) async{
    SpUtil.putString("user_id", loginEntity.user_id.toString());
    SpUtil.putObject('user', loginEntity);
    if(loginEntity.user_token!=null&&loginEntity.user_token.length>0){
      SpUtil.putString("token", loginEntity.user_token);
    }
  }

  Future<void> _init() async {

    await InitAndUpgrade.checkPermission();
    String user_id =  SpUtil.getString("user_id");

    if(user_id.isNotEmpty==true){
    //  LoginEntity entity = SpUtil.getObj('user',(v) => LoginEntity.fromJson(v));
      NavigatorUtil.pushReplacementNamed(context, "/main_page");

    }
  }


}
