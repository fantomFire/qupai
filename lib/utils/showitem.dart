
import 'package:flutter/material.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/values/baseColor.dart';


class ShowItem extends StatelessWidget {
  final String title;
  final String content;
  final double fontSize;
  final double lineHeight;
  final Color lineColor;
  final EdgeInsetsGeometry lineMargin;
  final TextAlign textAlign;
  final double titleWidth;

  const ShowItem(
      {Key key,
      this.title: "",
      this.content: "",
      this.fontSize: 16,
      this.lineHeight: 0.8,
      this.lineColor: BaseColor.color_lineColor,
      this.lineMargin,
      this.textAlign: TextAlign.right,
      this.titleWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: BaseColor.color_ffffff,
          constraints: BoxConstraints(minHeight: 44),
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: <Widget>[
              Container(
                width: titleWidth,
                child: TextView(
                  title,
                  style: TextStyle(color: BaseColor.color_333333, fontSize: fontSize),
                ),
                margin: EdgeInsets.only(right: 20),
              ),
              Expanded(
                child: TextView(
                  content,
                  textAlign: textAlign,
                  style: TextStyle(color: BaseColor.color_666666, fontSize: fontSize),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: lineHeight,
          color: lineColor,
          margin: lineMargin,
        )
      ],
    );
  }
}
