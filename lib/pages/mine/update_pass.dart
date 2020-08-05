import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/inputitem.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';
import 'package:qupai/widgets/appbars.dart';


import '../../urls.dart';

class UpdatePass extends StatefulWidget {
  @override
  _UpdatePassState createState() => _UpdatePassState();
}

class _UpdatePassState extends State<UpdatePass> {
  TextEditingController oldController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController conformController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Focus.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: BaseColor.color_ffffff,
        body: Column(
          children: <Widget>[
           AppBars.normalTitle(context, "修改密码"),
         /*   Container(
              margin: EdgeInsets.only(left: 16,right: 16),
              constraints: BoxConstraints(minHeight: 44),
              color: BaseColor.color_ffffff,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 44,

                    child: Row(
                      children: <Widget>[
                        Container(
                          child: TextView(
                            "22222",
                            style: TextStyle(fontSize: 12, color: BaseColor.color_333333),
                          ),
                          padding: EdgeInsets.only(left: 15),
                        ),
                        *//*   must
                          ? Container(
                              child: Image.asset(
                                UiUtils.getImgPath('img_must'),
                                width: 7,
                                height: 7,
                              ),
                              padding: EdgeInsets.only(top: 10),
                              alignment: Alignment.topCenter,
                            )
                          : Container(),*//*
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: MyTextField(
                        controller: oldController,

                      ),
                    ),
                  ),
                ],
              ),
            ),*/
            InputItem(
              title: "旧密码",
              titleWidth: 80,
              inputTextAlign: TextAlign.left,
              controller: oldController,
              hintText: "请输入旧密码",
              fontSize: 14,
              obscureText: true,
      inputBorder: true,
            ),
            InputItem(
              title: "新密码",
              titleWidth: 80,
              inputTextAlign: TextAlign.left,
              controller: newController,
              hintText: "请输入新密码",
              obscureText: true,
              inputBorder: true,
            ),
            InputItem(
              title: "确认密码",
              titleWidth: 80,
              inputTextAlign: TextAlign.left,
              controller: conformController,
              hintText: "请再次输入新密码",
              obscureText: true,
              inputBorder: true,
            ),
            GestureDetector(
              onTap: () {
                Focus.of(context).requestFocus(FocusNode());
                _update();
              },
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 45, top: 80, right: 45),
                  decoration: BoxDecoration(
                   color: BaseColor.color_C60000,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  constraints: BoxConstraints.expand(width: 280, height: 40),
                  child: Text(
                    "确定",
                    style: TextStyles.color_withe_18,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _update() async {
    if (oldController.text.trim().length == 0) {
      ToastUtil.toast("请输入旧密码");
      return;
    }
    if (newController.text.trim().length < 6) {
      ToastUtil.toast("密码长度不能小于6");
      return;
    }

    if (conformController.text.trim().length == 0) {
      ToastUtil.toast("请再次输入新密码");
      return;
    }
    if (newController.text.trim() != conformController.text.trim()) {
      ToastUtil.toast("再次输入密码不一致");
      return;
    }
  /*  String user_id = CacheManager.instance.getUerInfo().user_id.toString();
    HttpResponse response = await HttpUtil.send(
      context,
      "post",
      Urls.updatePass,
      {
        'user_id': user_id,
        'old_password': oldController.text.trim().toString(),
        'new_password': newController.text.trim().toString(),
        'confirm_password': conformController.text.trim().toString(),
      },
    );
    if (response.result) {

      ToastUtil.toast("密码修改成功");
      NavigatorUtil.pop(context);

    }*/
  }
}
