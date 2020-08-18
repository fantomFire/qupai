import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/pages/mine/entity/user_info.dart';
import 'package:qupai/utils/file_select.dart';
import 'package:qupai/utils/file_upload.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/imageutil.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';
import 'package:qupai/widgets/appbars.dart';

import '../../../urls.dart';

class UserInfoPage extends StatefulWidget {
  final UserInfoBean user;

  @override
  _UserInfoPageState createState() => _UserInfoPageState();

  const UserInfoPage({Key key, this.user}) : super(key: key);
}

class _UserInfoPageState extends State<UserInfoPage> {
  UserInfoBean userInfoBean;

  String userId;
  FileSelect _fileUploadUtil;

  @override
  void initState() {
    super.initState();
    if (widget.user == null) {
      getUserInfo();
    } else {
      userInfoBean = widget.user;
    }
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.color_pageBg,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppBars.normalTitle(
            context,
            "个人信息",
          ),
          Container(
            color: BaseColor.color_ffffff,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //   NavigatorUtil.pushNamed(context, "/update_photo");
                    selectImage();
                  },
                  child: Row(
                    children: <Widget>[
                      TextView(
                        "头像",
                        style: TextStyle(fontSize: 16),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          margin: EdgeInsets.only(right: 15),
                          alignment: Alignment.centerRight,
                          child: ClipOval(
                            child: ImageLoadUtil(
                              url: '${Urls.imageBase}${userInfoBean?.user_pic}',
                              width: 60,
                              height: 60,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Line(),
                Container(
                  height: 48,
                  child: Row(
                    children: <Widget>[
                      TextView(
                        "账号",
                        style: TextStyle(
                            fontSize: 16, color: BaseColor.color_333333),
                      ),
                      Expanded(
                          child: Container(
                        child: TextView(
                          "${userInfoBean?.id}",
                          style: TextStyles.color_999999_16,
                          textAlign: TextAlign.right,
                        ),
                      ))
                    ],
                  ),
                ),
                Line(),
                GestureDetector(
                  onTap: () {
                    NavigatorUtil.pushNamed(context, "/update_nickname",
                        arguments: {
                          'user_nickname': userInfoBean?.nickname
                        }).then((v) {
                      if (v != null) {
                        getUserInfo();
                      }
                    });
                  },
                  child: Container(
                    height: 48,
                    color: BaseColor.color_ffffff,
                    child: Row(
                      children: <Widget>[
                        TextView(
                          "昵称",
                          style: TextStyle(
                              fontSize: 16, color: BaseColor.color_333333),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: TextView(
                              userInfoBean?.nickname == null ||
                                      userInfoBean?.nickname == ""
                                  ? "用户 ${userInfoBean?.id}"
                                  : userInfoBean?.nickname,
                              style: TextStyles.color_999999_16,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        Image.asset(UiUtils.getImgPath("nextpage"))
                      ],
                    ),
                  ),
                ),
                Line(),
                GestureDetector(
                  onTap: () {
                    NavigatorUtil.pushNamed(context, "/address_manager");
                  },
                  child: Container(
                    height: 50,
                    color: BaseColor.color_ffffff,
                    child: Row(
                      children: <Widget>[
                        TextView(
                          "收货地址",
                          style: TextStyle(
                              fontSize: 16, color: BaseColor.color_333333),
                        ),
                        Container(
                          color: BaseColor.color_ffffff,
                          width: 40,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                               child: TextView(
                              userInfoBean?.address,
                              style: TextStyles.color_999999_16,
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Image.asset(UiUtils.getImgPath("nextpage"))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void getUserInfo() async {
    userId = SpUtil.getString("user_id");

    HttpResponse response = await HttpUtil.send(
        context, "post", Urls.UserInfo, {"user_id": userId},
        initState: true);
    if (response.result) {
      if (response.datas != null) {
        setState(() {
          userInfoBean = UserInfoBean.fromJson(response.datas);
        });
      }
    }
  }

  void getAddress() async {
    /* HttpResponse response = await HttpUtil.send(
        context, "post", Urls.defaultAddress, {'user_id': user_id},
        initState: true);
    if (response.result) {}*/
  }

  void selectImage() {
    if (_fileUploadUtil == null) {
      _fileUploadUtil = new FileSelect(context);
    }
    _fileUploadUtil.selectPhoto(({file, result}) {
      upload(file, result);
    });
  }

  void upload(File file, result) async {
    HttpResponse httpResponse =
        await FileUpLoadServer.uploadPhoto(context, UiUtils.getUserId(), file);
    if (httpResponse.result) {
      ToastUtil.toast("上传成功");
      setState(() {
        userInfoBean.user_pic = httpResponse.datas.toString();
      });
    }
  }
}
