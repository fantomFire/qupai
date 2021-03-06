import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qupai/common_views/inputitem.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';

import '../../../model/other_bean.dart';
import '../../../urls.dart';
import '../../../values/baseColor.dart';

class IdentificationPage extends StatefulWidget {
  @override
  IdentificationPageState createState() => IdentificationPageState();
}

class IdentificationPageState extends State<IdentificationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cidController = TextEditingController();
  String _name = "";
  String _cid = "";
  bool showRZ = false;

  @override
  void initState() {
    super.initState();
    getRenZheng();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "实名认证",
        style: TextStyle(fontSize: 18),
      )),
      body: Container(
        child: Column(
          children: <Widget>[
            Offstage(
              //false展示出来
              offstage: showRZ,
              child: Container(
                height: 225,
                margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffD63432), Color(0xffFE8564)]),
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  //设置四周边框
//                border: new Border.all(width: 1, color: Colors.red),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 74,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "证件类型",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              UiUtils.getImgPath("icon_renzheng"),
                              width: 59,
                              height: 59,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 20),
                              child: Text(
                                "身份证",
                                style: TextStyle(
                                    color: BaseColor.color_eeeeee,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Line(),
                    Container(
                      height: 74,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "姓名",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 20),
                              child: Text(
                                _name,
                                style: TextStyle(
                                    color: BaseColor.color_eeeeee,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Line(),
                    Container(
                      height: 74,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "证件号码",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 20),
                              child: Text(
                                _cid,
                                style: TextStyle(
                                    color: BaseColor.color_eeeeee,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Offstage(
              offstage: !showRZ,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          InputItem(
                            title: "真实姓名",
                            titleWidth: ScreenUtil().getAdapterSize(80),
                            inputTextAlign: TextAlign.left,
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
                          Line(),
                          InputItem(
                            title: "身份证号",
                            titleWidth: ScreenUtil().getAdapterSize(80),
                            inputTextAlign: TextAlign.left,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp("[0-9x]")),
                            ],
                            hintText: "请输入身份证号",
                            fontSize: ScreenUtil().getSp(15),
                            controller: cidController,
                            obscureText: false,
                            inputBorder: false,
                            noBottomLine: true,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            0,
                            ScreenUtil().getAdapterSize(138),
                            0,
                            ScreenUtil().getAdapterSize(66)),
                        height: ScreenUtil().getAdapterSize(40),
                        width: ScreenUtil().getAdapterSize(280),
                        child: FlatButton(
                          color: Color(0xffC60000),
                          colorBrightness: Brightness.dark,
                          child: Container(
                            child: Center(
                              child: Text("提交",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize:
                                          ScreenUtil().getAdapterSize(18))),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () async {
                            toRenZheng();
                          },
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void toRenZheng() async {
    if (nameController.text.trim().length == 0) {
      ToastUtil.toast("请输入姓名");
      return;
    }
    if (cidController.text.trim().length == 0) {
      ToastUtil.toast("请输入身份证");
      return;
    }
    if (!UiUtils.checkIdCard(cidController.text.trim())) {
      ToastUtil.toast("请输入正确的身份证");
      return;
    }
    HttpResponse httpResponse =
        await HttpUtil.send(context, 'post', Urls.toRenZheng, {
      'user_id': UiUtils.getUserId(),
      'name': nameController.text.toString().trim(),
      'cid': cidController.text.toString().trim(),
    });
    if (httpResponse.result) {
      ToastUtil.toast("提交成功");
      setState(() {});
    }
    Navigator.pop(context, true);
  }

  void checkRenZheng() async {
    HttpResponse httpResponse = await HttpUtil.send(
        context, 'post', Urls.checkRenZheng, {'user_id': UiUtils.getUserId()});
    if (httpResponse.code == 400 || httpResponse.message == "实名认证已认证") {
      setState(() {});
    }
  }

  void getRenZheng() async {
    HttpResponse httpResponse = await HttpUtil.send(
        context, 'post', Urls.getRenZheng, {'user_id': UiUtils.getUserId()},
        initState: true);
    if (httpResponse.result) {
      if (httpResponse.datas != null && httpResponse.datas.length > 0) {
        OtherBean bean = OtherBean.fromJson(httpResponse.datas);
        _name = bean.name;
        _cid = bean.cid;
        showRZ = false;
      } else {
        showRZ = true;
      }
      setState(() {});
    }
  }
}
