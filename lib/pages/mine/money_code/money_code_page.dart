import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/utils/file_select.dart';
import 'package:qupai/utils/file_upload.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/values/textstyles.dart';

class MoneyCodePage extends StatefulWidget {
  @override
  _MoneyCodePageState createState() => _MoneyCodePageState();
}

class _MoneyCodePageState extends State<MoneyCodePage> {
  int isSelect = 0;
  FileSelect _fileUploadUtil;
  bool hasSelect = false;
  String imgPath = "";
  File picFile;

  String status;
  String name;
  String account;
  String bankopen;
  String bankbranch;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "收款码设置",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            body: Column(
              children: <Widget>[
                Container(
                  color: BaseColor.color_ffffff_pagege,
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 10),
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelect = 0;
                              status = "3";
                            });
                          },
                          child: Container(
                              height: 45,
                              decoration: new BoxDecoration(
                                //背景
                                color: Colors.white,
                                //设置四周边框
                                border: new Border.all(
                                    width: 1,
                                    color: isSelect == 0
                                        ? BaseColor.color_C60000
                                        : Colors.white),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          left:
                                              ScreenUtil().getAdapterSize(20)),
                                      child: Row(
                                        children: <Widget>[
                                          Image(
                                            alignment: Alignment.topRight,
                                            image: AssetImage(
                                                UiUtils.getImgPath(
                                                    "icon_pay_zhifubao")),
                                            width:
                                                ScreenUtil().getAdapterSize(18),
                                            height:
                                                ScreenUtil().getAdapterSize(18),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: ScreenUtil()
                                                    .getAdapterSize(8)),
                                            child: TextView(
                                              "支付宝",
                                              style: TextStyle(
                                                  fontWeight: isSelect == 0
                                                      ? FontWeight.normal
                                                      : FontWeight.normal,
                                                  fontSize: 15,
                                                  color: isSelect == 0
                                                      ? BaseColor.color_333333
                                                      : BaseColor.color_333333),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Offstage(
                                    offstage: isSelect == 0 ? false : true,
                                    child: Image(
                                      alignment: Alignment.topRight,
                                      image: AssetImage(UiUtils.getImgPath(
                                          "icon_pay_checked")),
                                      width: ScreenUtil().getAdapterSize(20),
                                      height: ScreenUtil().getAdapterSize(20),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelect = 1;
                              status = "1";
                            });
                          },
                          child: Container(
                              height: 45,
                              decoration: new BoxDecoration(
                                //背景
                                color: Colors.white,
                                //设置四周边框
                                border: new Border.all(
                                    width: 1,
                                    color: isSelect == 1
                                        ? BaseColor.color_C60000
                                        : Colors.white),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          left:
                                              ScreenUtil().getAdapterSize(20)),
                                      child: Row(
                                        children: <Widget>[
                                          Image(
                                            alignment: Alignment.topRight,
                                            image: AssetImage(
                                                UiUtils.getImgPath(
                                                    "icon_pay_weixin")),
                                            width:
                                                ScreenUtil().getAdapterSize(18),
                                            height:
                                                ScreenUtil().getAdapterSize(18),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: ScreenUtil()
                                                    .getAdapterSize(8)),
                                            child: TextView(
                                              "  微信",
                                              style: TextStyle(
                                                  fontWeight: isSelect == 1
                                                      ? FontWeight.normal
                                                      : FontWeight.normal,
                                                  fontSize: 15,
                                                  color: isSelect == 1
                                                      ? BaseColor.color_333333
                                                      : BaseColor.color_333333),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Offstage(
                                    offstage: isSelect == 1 ? false : true,
                                    child: Image(
                                      alignment: Alignment.topRight,
                                      image: AssetImage(UiUtils.getImgPath(
                                          "icon_pay_checked")),
                                      width: ScreenUtil().getAdapterSize(20),
                                      height: ScreenUtil().getAdapterSize(20),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelect = 2;
                              status = "2";
                            });
                          },
                          child: Container(
                              height: 45,
                              decoration: new BoxDecoration(
                                //背景
                                color: Colors.white,
                                //设置四周边框
                                border: new Border.all(
                                    width: 1,
                                    color: isSelect == 2
                                        ? BaseColor.color_C60000
                                        : Colors.white),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          left:
                                              ScreenUtil().getAdapterSize(20)),
                                      child: Row(
                                        children: <Widget>[
                                          Image(
                                            alignment: Alignment.topRight,
                                            image: AssetImage(
                                                UiUtils.getImgPath(
                                                    "icon_pay_yinhangka")),
                                            width:
                                                ScreenUtil().getAdapterSize(18),
                                            height:
                                                ScreenUtil().getAdapterSize(18),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: ScreenUtil()
                                                    .getAdapterSize(8)),
                                            child: TextView(
                                              "银行卡",
                                              style: TextStyle(
                                                  fontWeight: isSelect == 2
                                                      ? FontWeight.normal
                                                      : FontWeight.normal,
                                                  fontSize: 15,
                                                  color: isSelect == 2
                                                      ? BaseColor.color_333333
                                                      : BaseColor.color_333333),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Offstage(
                                    offstage: isSelect == 2 ? false : true,
                                    child: Image(
                                      alignment: Alignment.topRight,
                                      image: AssetImage(UiUtils.getImgPath(
                                          "icon_pay_checked")),
                                      width: ScreenUtil().getAdapterSize(20),
                                      height: ScreenUtil().getAdapterSize(20),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    //背景
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    //设置四周边框
//                border: new Border.all(width: 1, color: Colors.red),
                  ),
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
                  padding: EdgeInsets.all(12),
                  height: isSelect == 2 ? 360 : 260,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text("收款码",
                                  style:
                                      TextStyle(color: BaseColor.color_999999)),
                            ),
                            Offstage(
                                offstage: hasSelect ? true : false,
                                child: GestureDetector(
                                  onTap: () {
                                    selectImage();
                                  },
                                  child: //上传二维码
                                      Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().getAdapterSize(50)),
                                    color: BaseColor.color_eeeeee,
                                    width: ScreenUtil().getAdapterSize(138),
                                    height: ScreenUtil().getAdapterSize(138),
                                    alignment: Alignment.center,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Image(
                                            image: AssetImage(
                                                UiUtils.getImgPath("icon_add")),
                                            fit: BoxFit.contain,
                                            width:
                                                ScreenUtil().getAdapterSize(30),
                                            height:
                                                ScreenUtil().getAdapterSize(30),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: ScreenUtil()
                                                      .getAdapterSize(14)),
                                              child: Text(
                                                "上传收款码",
                                                style: TextStyle(
                                                    color:
                                                        BaseColor.color_999999,
                                                    fontSize: 11),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            Offstage(
                              offstage: hasSelect ? false : true,
                              child: GestureDetector(
                                  onTap: () {
                                    selectImage();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().getAdapterSize(50)),
                                    color: BaseColor.color_eeeeee,
                                    width: ScreenUtil().getAdapterSize(138),
                                    height: ScreenUtil().getAdapterSize(138),
                                    alignment: Alignment.center,
                                    child: Image.file(File(imgPath)),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text("收款人",
                                style:
                                    TextStyle(color: BaseColor.color_999999)),
                            Expanded(
                              child: TextField(
                                textAlign: TextAlign.end,
                                decoration: InputDecoration.collapsed(
                                    hintText: " 请输入姓名",
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: BaseColor.color_333333)),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: BaseColor.color_333333),
                                onChanged: (value) {
                                  name = value;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(getTitle(),
                                style:
                                    TextStyle(color: BaseColor.color_999999)),
                            Expanded(
                              child: TextField(
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[a-zA-Z0-9._@-]")),
                                ],
                                textAlign: TextAlign.end,
                                decoration: InputDecoration.collapsed(
                                    hintText: getHint(),
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: BaseColor.color_333333)),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: BaseColor.color_333333),
                                onChanged: (value) {
                                  account = value;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Offstage(
                        offstage: isSelect == 2 ? false : true,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Text("开户银行",
                                  style:
                                      TextStyle(color: BaseColor.color_999999)),
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "请输入开户银行",
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: BaseColor.color_333333)),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: BaseColor.color_333333),
                                  onChanged: (value) {
                                    bankopen = value;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: isSelect == 2 ? false : true,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Text("开户支行",
                                  style:
                                      TextStyle(color: BaseColor.color_999999)),
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "请输入开户支行",
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: BaseColor.color_333333)),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: BaseColor.color_333333),
                                  onChanged: (value) {
                                    bankbranch = value;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 59, 16, 0),
                  child: Text(
                    "风险提示：转拍属于C2C交易，资金不经过平台，平台不会自动扣款，需要您手动自行转账给对方，对方才能收到款项。",
                    style:
                        TextStyle(fontSize: 10, color: BaseColor.color_C60000),
                    strutStyle: StrutStyle(
                        forceStrutHeight: true,
                        height: textLineHeight,
                        leading: leading),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    upload(picFile);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 45, top: 50, right: 45),
                      decoration: BoxDecoration(
                        color: BaseColor.color_C60000,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      constraints:
                          BoxConstraints.expand(width: 280, height: 40),
                      child: Text(
                        "确定",
                        style: TextStyles.color_withe_18,
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  final double textLineHeight = 1;
  final double leading = 1;

  String getTitle() {
    if (isSelect == 0) {
      return "账号";
    } else if (isSelect == 1) {
      return "账号";
    } else if (isSelect == 2) {
      return "账号";
    }
    return "";
  }

  String getHint() {
    if (isSelect == 0) {
      return "请输入支付宝账号";
    } else if (isSelect == 1) {
      return "请输入微信号";
    } else if (isSelect == 2) {
      return "请输入银行卡号";
    }
    return "";
  }

  void selectImage() {
    if (_fileUploadUtil == null) {
      _fileUploadUtil = new FileSelect(context);
    }
    _fileUploadUtil.selectPhoto(({file, result}) {
      hasSelect = true;

      setState(() {
        picFile = file;
        imgPath = file.path;
        Fluttertoast.showToast(
          msg: imgPath,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      });
    });
  }

  void upload(File file) async {
    HttpResponse httpResponse = await FileUpLoadServer.uploadCodePic(context,
        file, UiUtils.getUserId(), status, name, account, bankopen, bankbranch);
    if (httpResponse.result) {
      ToastUtil.toast("上传成功");
      setState(() {});
      Navigator.pop(context, true);
    }
  }
}
