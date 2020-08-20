import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qupai/common_views/inputitem.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/pages/mine/entity/user_info.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';

import '../../../urls.dart';

class AddZfbPage extends StatefulWidget {
  @override
  AddZfbPageState createState() => AddZfbPageState();
}

class AddZfbPageState extends State<AddZfbPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cidController = TextEditingController();
  UserInfoBean userInfoBean = UserInfoBean();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "支付宝设置",
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
                    title: "支付宝账号",
                    titleWidth: ScreenUtil().getAdapterSize(100),
                    inputTextAlign: TextAlign.right,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z@.]")),
                    ],
                    hintText: "请输入支付宝账号",
                    fontSize: ScreenUtil().getSp(15),
                    controller: cidController,
                    obscureText: false,
                    inputBorder: false,
                    noBottomLine: true,
                  ),
                  Line(),
                  InputItem(
                    title: "收款人真实姓名",
                    titleWidth: ScreenUtil().getAdapterSize(120),
                    inputTextAlign: TextAlign.right,
                    textInputType: TextInputType.text,
                    //输入类型
                    hintText: "请输入真实姓名",
                    fontSize: ScreenUtil().getSp(15),
                    controller: nameController,
                    obscureText: false,
                    //是否密码
                    inputBorder: false,
                    //是否隐藏编辑框下划线
                    noBottomLine: true,
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, ScreenUtil().getAdapterSize(138),
                    0, ScreenUtil().getAdapterSize(66)),
                height: ScreenUtil().getAdapterSize(40),
                width: ScreenUtil().getAdapterSize(280),
                child: FlatButton(
                  color: Color(0xffC60000),
                  colorBrightness: Brightness.dark,
                  child: Container(
                    child: Center(
                      child: Text("确认",
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: ScreenUtil().getAdapterSize(18))),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () async {
                    toBack();
                  },
                )),
          ],
        ),
      ),
    );
  }

  void toBack() async {
    if (nameController.text.trim().length == 0) {
      ToastUtil.toast("请输入姓名");
      return;
    }
    if (cidController.text.trim().length == 0) {
      ToastUtil.toast("请输入支付宝账号");
      return;
    }
    userInfoBean.zfb_account = cidController.text.toString().trim();
    userInfoBean.zfb_name = nameController.text.toString().trim();

    Navigator.pop(context, userInfoBean);
  }
}
