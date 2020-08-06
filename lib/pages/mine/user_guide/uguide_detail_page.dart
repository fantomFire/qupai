import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';

class UGuideDetailPage extends StatefulWidget {
  final String content;

  UGuideDetailPage({Key key, @required this.content}) : super(key: key);

  @override
  UGuideDetailPageState createState() => UGuideDetailPageState();
}

class UGuideDetailPageState extends State<UGuideDetailPage> {
  final double fontSize = 14;
  final double textLineHeight = 1; /// 文本间距
  final double leading = 0.9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "用户指南",
        style: TextStyle(fontSize: 18),
      )),
      body: Container(
        padding: EdgeInsets.all(ScreenUtil().getAdapterSize(17)),
        child: Transform.translate(
          offset: Offset(0, fontSize * leading / 2),
          child: Text(widget.content,
              strutStyle: StrutStyle(forceStrutHeight: true, height: textLineHeight, leading: leading),
              style: TextStyle()),
        ),
      ),
    );
  }
}
