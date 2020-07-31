import 'package:flutter/cupertino.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';

class ShowContent extends StatelessWidget {
  final String title;
  final String content;
  final double fontSize;
  final double lineHeight;
  final double itemHeight;
  final Color lineColor;
  final EdgeInsetsGeometry lineMargin;
  final TextAlign textAlign;
  final double titleWidth;
  final dynamic onTap;
  final bool hasRightImage;
  final Color titleColor;
  final Color contentColor;
  final bool hasBottomLine;

  const ShowContent(
      {Key key,
      this.title: "",
      this.content: "",
      this.fontSize: 14,
      this.lineHeight: 1,
      this.lineColor: BaseColor.color_f1f1f1,
      this.lineMargin,
      this.textAlign: TextAlign.right,
      this.titleWidth,
      this.itemHeight: 40,
      this.onTap,
      this.hasRightImage: false,
      this.titleColor: BaseColor.color_999999,
      this.contentColor: BaseColor.color_999999,
      this.hasBottomLine:true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 12, right: 12),
          height: itemHeight,
          child: Row(
            children: <Widget>[
              Container(
                width: titleWidth,
                child: TextView(
                  title,
                  style: TextStyle(color: titleColor, fontSize: fontSize),
                ),
                margin: EdgeInsets.only(right: 20),
              ),
              Expanded(
                child: TextView(
                  content,
                  textAlign: textAlign,
                  style: TextStyle(color: contentColor, fontSize: fontSize),
                ),
              ),
              hasRightImage
                  ? GestureDetector(
                      onTap: onTap,
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(6),
                        child: Image.asset(
                          UiUtils.getImgPath("add_file"),
                          width: 12,
                          height: 12,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        hasBottomLine?Container(
          height: lineHeight,
          color: lineColor,
          margin: lineMargin,
        ):Container(),
      ],
    );
  }
}
