import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/pages/mine/entity/user_info.dart';
import 'package:qupai/utils/cacahe_manager.dart';
import 'package:qupai/utils/file_select.dart';
import 'package:qupai/utils/file_upload.dart';
import 'package:qupai/utils/imageutil.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';
import 'package:qupai/widgets/appbars.dart';


import '../../urls.dart';

class UserInfoPage extends StatefulWidget {
  final UserInfoBean user;

  @override
  _UserInfoPageState createState() => _UserInfoPageState();

  const UserInfoPage({Key key, this.user}) : super(key: key);
}

class _UserInfoPageState extends State<UserInfoPage> {
  UserInfoBean userInfoBean;

  String user_id;
  String _headimg;
  FileSelect _fileUploadUtil;

  @override
  void initState() {
    super.initState();
   // user_id = CacheManager.instance.getUerInfo().user_id.toString();
    getUserInfo();
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
                              url: '${Urls.imageBase}${userInfoBean?.user_img}',
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
                          userInfoBean?.user_name,
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
                            arguments: {'user_nickname': userInfoBean?.user_nickname})
                        .then((v) {
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
                              userInfoBean?.user_nickname,
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
             /*   GestureDetector(
                  onTap: () {
                    NavigatorUtil.pushNamed(context, "/update_pass");
                  },
                  child: Container(
                    height: 50,
                    color: BaseColor.color_ffffff,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextView(
                          "修改密码",
                          style: TextStyle(
                              fontSize: 16, color: BaseColor.color_333333),
                        ),
                        Image.asset(UiUtils.getImgPath("nextpage"))
                      ],
                    ),
                  ),
                ),
                Line(),*/
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
                            /*   child: TextView(
                              userInfoBean?.address,
                              style: TextStyles.color_999999_16,
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),*/
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
   /* HttpResponse response = await HttpUtil.send(
        context, "post", Urls.UserInfo, {"user_id": UiUtils.getUserId()},
        initState: true);
    if (response.result) {
      if (response.datas != null) {
        userInfoBean = UserInfoBean.fromJson(response.datas);
        setState(() {});
      }
    }*/
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
  /*  HttpResponse httpResponse =
        await FileUpLoadServer.uploadImage(context, Urls.uplaoadPictuer, file);
    if (httpResponse.result) {
      //ToastUtil.toast("上传成功");
      save(httpResponse.datas);

      setState(() {});
    }*/
  }

  void save(String datas) async {
  /*  HttpResponse httpResponse = await HttpUtil.send(context, 'post',
        Urls.savePictuer, {'user_id': UiUtils.getUserId(), 'user_img': datas});

    if (httpResponse.result) {
      //ToastUtil.toast("上传成功");
      getUserInfo();
    }*/
  }
}
