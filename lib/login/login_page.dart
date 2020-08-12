import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/utils/cacahe_manager.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/permission_init_upgrade.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';

import '../urls.dart';
import 'entity/login_entity.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _passwordMask = true;

  @override
  void initState() {
    super.initState();
    _init();
  }
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    }
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(


                children: <Widget>[
                  /*  Container(
                color: BaseColor.color_itembg,
                height: MediaQuery.of(context).padding.top,
              ),*/
                  Container(
                    height: 243,
                    child: Image.asset(
                      UiUtils.getImgPath("login_bg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 44,
                    margin: EdgeInsets.only(top: 40, left: 50, right: 50),
                    child: MyTextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: BaseColor.color_999999)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: BaseColor.color_999999)),
                        prefixIcon: Image.asset(
                            UiUtils.getImgPath("login_iphone_icon"),width: 15,height: 21,),
                        hintText: "手机号",
                        contentPadding: EdgeInsets.only(top: 8),
                        hintStyle: TextStyles.color_999999_15,

                      ),
                      autofocus: false,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40, left: 50, right: 50),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          height: 44,
                          child: MyTextField(
                            controller: passController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.grey,
                            obscureText: _passwordMask,
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              _login();
                            },
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(16)
                            ],

                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: BaseColor.color_999999)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: BaseColor.color_999999)),
                              contentPadding: EdgeInsets.only(top: 8),
                              hintText: '请输入密码',
                              hintStyle: TextStyles.color_999999_15,
                              prefixIcon: Image.asset(
                                  UiUtils.getImgPath("login_password"),width: 15,height: 21,),
                            ),
                            autofocus: false,
                          ),
                        )),
                        IconButton(
                          icon: _getHideIcon(),
                          onPressed: () {
                            setState(() {
                              _passwordMask = !_passwordMask;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                 GestureDetector(
                   onTap: () {
                     _login();
                   },
                   child:  Container(
                       alignment: Alignment.center,
                       margin: EdgeInsets.only(left: 45, top: 80, right: 45),
                       decoration: BoxDecoration(
                         gradient: LinearGradient(colors: [BaseColor.color_d68,BaseColor.color_e3b579]),
                         borderRadius: BorderRadius.all(Radius.circular(20)),
                       ),
                       constraints:
                       BoxConstraints.expand(width: 280, height: 40),
                       child: Text(
                         "登录",style: TextStyles.color_withe_18,
                       )),
                 ),
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(left: 15, top: 30, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            NavigatorUtil.pushNamed(context, "/quick_regist");
                          },
                          child: TextView("立即注册",style: TextStyles.color_999999_14,),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          color: BaseColor.color_999999,
                          width: 1,
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigatorUtil.pushNamed(context, "/forgot_pass");
                          },
                          child: TextView("忘记密码",style: TextStyles.color_999999_14,),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 190,
                left: 130,
                child: Image.asset(
                  UiUtils.getImgPath("tianyunmall"),
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getHideIcon() {
    if (_passwordMask) {
      return Image.asset(
        UiUtils.getImgPath('login_icon_pwd_hide'),
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        UiUtils.getImgPath('login_icon_pwd_show'),
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      );
    }
  }

  void _login() async{

    SpUtil.clear();

 NavigatorUtil.pushReplacementNamed(context, "/main_page");
      if (phoneController.text.length == 0) {
      ToastUtil.toast("请输入手机号码");
      return;
    }

    if (passController.text.length== 0) {
      ToastUtil.toast("请输入密码");
      return;
    }

   HttpResponse response = await HttpUtil.send(context, "post", Urls.Login, {
      "username":phoneController.text.trim().toString(),
      "password":passController.text.trim().toString(),
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
    CacheManager.instance.setUserInfo(loginEntity);
      if(loginEntity.user_token!=null&&loginEntity.user_token.length>0){
        SpUtil.putString("token", loginEntity.user_token);
        CacheManager.instance.setCookie(loginEntity.user_token);
      }
  }

  Future<void> _init() async {

    await InitAndUpgrade.checkPermission();
   String user_id =  SpUtil.getString("user_id");

    if(user_id!=null&&user_id.length>0){
      LoginEntity entity = SpUtil.getObj('user',(v) => LoginEntity.fromJson(v));
      CacheManager.instance.setUserInfo(entity) ;
      CacheManager.instance.setCookie(entity.user_token);
      NavigatorUtil.pushReplacementNamed(context, "/main_page");

    }
  }



}
