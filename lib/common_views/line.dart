import 'package:flutter/material.dart';
import 'package:qupai/values/baseColor.dart';

class Line extends StatelessWidget {
  final Color color;
  final double left;
  final double right;
  final double width;
  final double height;

  const Line({Key key, this.color: BaseColor.color_lineColor, this.left: 0, this.right: 0, this.height: 1, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: left, right: right),
      color: color,
      height: height,
      width: width,
    );
  }
}
