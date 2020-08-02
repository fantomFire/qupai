import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class WZChatTextField extends StatefulWidget {
  String hintText;
  Widget button;
  bool obscureText;
  Object onChanged;
  Object onEditingComplete;
  int maxLines;
  double suffixIconWidth;
  double suffixIconHeight;
  bool isDense;
  TextAlign textAlign;
  Object onTap;
  TextEditingController controller;
  TextInputType keyboardType;
  Object onSubmitted;

  WZChatTextField(
      {Key key,
      this.onEditingComplete,
      this.controller = null,
      this.maxLines = 1,
      this.hintText,
      this.onChanged,
      this.button,
      this.suffixIconWidth,
      this.suffixIconHeight,
      this.isDense = false,
      this.textAlign,
      this.onTap,
      this.obscureText = false,
      this.keyboardType,
      this.onSubmitted})
      : super(key: key);

  @override
  _WZChatTextFieldState createState() => _WZChatTextFieldState();
}

class _WZChatTextFieldState extends State<WZChatTextField> {
  double _screenWidth() {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplete,
      obscureText: widget.obscureText,
      style: TextStyle(fontSize: ScreenUtil().getAdapterSize(13)),
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign == null ? TextAlign.start : widget.textAlign,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: ScreenUtil().getAdapterSize(8),
              horizontal: ScreenUtil().getAdapterSize(10)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          isDense: widget.isDense,
       /*   prefixIconConstraints:
              BoxConstraints(maxWidth: ScreenUtil().getAdapterSize(10)),
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
          ),*/
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: ScreenUtil().getAdapterSize(12),
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.grey),
          // ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          // focusColor: Color(0xffC60000),
          fillColor: Theme.of(context).backgroundColor,
          filled: true),
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onSubmitted: widget.onSubmitted,
    );
  }
}
