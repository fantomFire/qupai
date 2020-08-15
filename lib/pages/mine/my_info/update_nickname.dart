import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/widgets/appbars.dart';

import '../../../urls.dart';

class UpdateNickname extends StatefulWidget {
  final String user_nickname;

  @override
  _UpdateNicknameState createState() => _UpdateNicknameState();

  const UpdateNickname({Key key, this.user_nickname}) : super(key: key);
}

class _UpdateNicknameState extends State<UpdateNickname> {
  TextEditingController nickNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user_nickname != null) {
      nickNameController.text = widget.user_nickname;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.color_pageBg,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            AppBars.normalTitleWithRightButton(context, "修改昵称", "完成", () {
              saveNickname();
            }),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: MyTextField(
                controller: nickNameController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: BaseColor.color_dddddd)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: BaseColor.color_dddddd)),
                  hintText: "请输入昵称",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveNickname() async {
    if (nickNameController.text.trim().length == 0) {
      ToastUtil.toast("请输入昵称");
      return;
    }
    HttpResponse httpResponse =
        await HttpUtil.send(context, 'post', Urls.setNickName, {
      'user_id': UiUtils.getUserId(),
      'nickname': nickNameController.text.trim().toString()
    });
    if (httpResponse.result) {
      ToastUtil.toast("修改成功");
      setState(() {});
    }
    Navigator.pop(context, true);
  }
}
