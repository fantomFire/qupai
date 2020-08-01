import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class WZTextField extends StatefulWidget {
  String hintText;
  String errorText;
  String labelText;
  Widget icon;
  String areacode;
  Widget button;
  bool obscureText;
  Object onChanged;
  Object onEditingComplete;
  int maxLines;
  double iconWidth;
  double iconHeight;
  double suffixIconWidth;
  double suffixIconHeight;
  bool isDense;
  bool readOnly;
  TextAlign textAlign;
  Object onTap;
  TextEditingController controller;
  TextInputType keyboardType;

  WZTextField(
      {Key key,
      this.onEditingComplete,
      this.controller = null,
      this.maxLines = 1,
      this.hintText,
      this.labelText,
      this.errorText,
      this.areacode,
      this.onChanged,
      this.icon,
      this.button,
      this.iconWidth,
      this.iconHeight,
      this.suffixIconWidth,
      this.suffixIconHeight,
      this.isDense = false,
      this.readOnly = false,
      this.textAlign,
      this.onTap,
      this.obscureText = false,
      this.keyboardType})
      : super(key: key);

  @override
  _WZTextFieldState createState() => _WZTextFieldState();
}

class _WZTextFieldState extends State<WZTextField> {
  double _screenWidth() {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: new ThemeData(
          primaryColor: Color(0xffC60000),
        ),
        child: TextFormField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          onEditingComplete: widget.onEditingComplete,
          obscureText: widget.obscureText,
          readOnly: widget.readOnly,
          style: TextStyle(fontSize: ScreenUtil().getAdapterSize(15)),
          keyboardType: widget.keyboardType,
          // enableInteractiveSelection: false,
          textAlign:
              widget.textAlign == null ? TextAlign.start : widget.textAlign,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            // border: InputBorder.none,
            isDense: widget.isDense,
            prefixIcon: Row(children: <Widget>[
              widget.icon == null ? Text('') : widget.icon
            ]),
            prefixIconConstraints: BoxConstraints(
              maxWidth: widget.iconWidth == null
                  ? ScreenUtil().getAdapterSize(30)
                  : widget.iconWidth,
              maxHeight: widget.iconHeight == null
                  ? ScreenUtil().getAdapterSize(20)
                  : widget.iconHeight,
            ),
            prefixStyle: TextStyle(
              color: Color(0xffC60000),
            ),
            suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  widget.button == null ? Text('') : widget.button
                ]),
            suffixIconConstraints: BoxConstraints(
              maxWidth: widget.suffixIconWidth == null
                  ? ScreenUtil().getAdapterSize(0)
                  : widget.suffixIconWidth,
              maxHeight: widget.suffixIconHeight == null
                  ? ScreenUtil().getAdapterSize(0)
                  : widget.suffixIconHeight,
            ),
            labelText: widget.labelText,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: ScreenUtil().getAdapterSize(12),
            ),
            // 文字提醒
//             errorText: widget.errorText,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.3),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC60000), width: 0.3),
            ),
          ),
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          validator: (v) {
            return v.trim().isNotEmpty ? null : widget.errorText;
          },
        ));
  }
}
