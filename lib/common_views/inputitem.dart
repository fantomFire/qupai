import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qupai/values/baseColor.dart';

import 'customview.dart';

class InputItem extends StatelessWidget {
  final String title;
  final dynamic onclick;
  final String hintText;
  final bool must;
  final TextEditingController controller;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final double titleWidth;
  final TextAlign inputTextAlign;
  final EdgeInsetsGeometry margin;
  final bool noBottomLine;
  final EdgeInsetsGeometry lineMargin;
  final double fontSize;
  final bool inputEnable;
  final bool obscureText;
  final bool inputBorder ;
  const InputItem(
      {Key key,
      this.title,
      this.onclick,
      this.controller,
      this.hintText,
      this.must: true,
      this.textInputType,
      this.inputFormatters,
      this.titleWidth,
      this.inputTextAlign: TextAlign.right,
      this.margin,
      this.noBottomLine:false,
      this.lineMargin,
        this.obscureText:false,
      this.fontSize: 14,
      this.inputEnable: true, this.inputBorder:false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Column(
        children: <Widget>[
          Container(
            margin: margin,
            constraints: BoxConstraints(minHeight: 44),
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
                          style: TextStyle(fontSize: fontSize, color: BaseColor.color_333333),
                        ),
                        padding: EdgeInsets.only(left: 15),
                      ),
                   /*   must
                          ? Container(
                              child: Image.asset(
                                UiUtils.getImgPath('img_must'),
                                width: 7,
                                height: 7,
                              ),
                              padding: EdgeInsets.only(top: 10),
                              alignment: Alignment.topCenter,
                            )
                          : Container(),*/
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: MyTextField(
                      controller: controller,
                      keyboardType: textInputType,
                      inputFormatters: inputFormatters,
                      decoration: InputDecoration(
                          hintText: hintText, border: inputBorder?null:InputBorder.none, hintStyle: TextStyle(fontSize: fontSize, color: BaseColor.color_999999)),
                      obscureText: obscureText,
                      style: TextStyle(fontSize: fontSize, color: BaseColor.color_333333),
                      textAlign: inputTextAlign,
                      enabled: inputEnable,
                    ),
                  ),
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
