import 'package:flutter/material.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';

import 'customview.dart';

class SelectItem extends StatelessWidget {
  final String title;
  final dynamic onclick;
  final String hintText;
  final bool must;
  final TextEditingController controller;
  final EdgeInsetsGeometry margin;
  final double titleWidth;
  final TextAlign inputTextAlign;
  final bool noBottomLine;
  final EdgeInsetsGeometry lineMargin;
  final double fontSize;
  final Widget rightWidget;
  final Color titleTextColor;

  const SelectItem(
      {Key key,
      this.title,
      this.onclick,
      this.controller,
      this.hintText,
      this.must: true,
      this.margin,
      this.titleWidth,
      this.inputTextAlign: TextAlign.right,
      this.noBottomLine: true,
      this.lineMargin,
      this.fontSize: 16,
      this.rightWidget,
      this.titleTextColor: BaseColor.color_333333})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(minHeight: 44),
            margin: margin,
            color: BaseColor.color_ffffff,
            child: Row(
              children: <Widget>[
                Container(
                  height: 44,
                  width: titleWidth,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: TextView(
                          title,
                          style: TextStyle(fontSize: fontSize, color: titleTextColor),
                        ),
                        padding: EdgeInsets.only(left: 15),
                      ),
                      must
                          ? Container(
                              child: Image.asset(
                                UiUtils.getImgPath('img_must'),
                                width: 7,
                                height: 7,
                              ),
                              padding: EdgeInsets.only(top: 10),
                              alignment: Alignment.topCenter,
                            )
                          : Container(),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: MyTextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: hintText, border: InputBorder.none, hintStyle: TextStyle(fontSize: fontSize, color: BaseColor.color_999999)),
                      style: TextStyle(fontSize: fontSize, color: BaseColor.color_333333),
                      textAlign: inputTextAlign,
                      maxLines: null,
                      enabled: false,
                    ),
                  ),
                ),
                Container(
                  child: rightWidget == null
                      ? Image.asset(
                          UiUtils.getImgPath('nextpage'),
                          width: 8,
                          height: 14,
                        )
                      : rightWidget,
                  padding: EdgeInsets.only(right: 15, left: 15),
                ),
              ],
            ),
          ),
          Offstage(
            offstage: noBottomLine,
            child: Container(
              margin: lineMargin,
              height: 0.5,
              color: BaseColor.color_dddddd,
            ),
          ),
        ],
      ),
    );
  }
}
