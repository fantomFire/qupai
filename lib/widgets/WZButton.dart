import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class WZButton extends StatefulWidget {
  double width;
  double height;
  Object onTap;
  String title;
  Color color;

  WZButton(
      {Key key, this.width, this.height, this.onTap, this.title, this.color})
      : super(key: key);

  @override
  _WZButtonState createState() => _WZButtonState();
}

class _WZButtonState extends State<WZButton> {
  double _screenWidth() {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(ScreenUtil().getAdapterSize(3)),
      ),
      child: FlatButton(
        onPressed: widget.onTap,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            widget.title,
            style: TextStyle(
                color: Colors.white, fontSize: ScreenUtil().getAdapterSize(13)),
          ),
        ),
      ),
    );
  }
}
