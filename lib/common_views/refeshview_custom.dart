import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';
class RefreshViewCustom extends StatefulWidget {
  final EasyRefreshController controller;
  final dynamic onRefresh;
  final dynamic onLoadMore;
  final bool firstRefresh;
  final bool failState;
  final bool noMore;
  final dynamic reRefresh;
  final int childCount;
  final dynamic childItem;

  const RefreshViewCustom(
    this.controller, {
    Key key,
    this.onRefresh,
    this.onLoadMore,
    this.firstRefresh: true,
    this.failState: false,
    this.reRefresh,
    this.noMore: false,
    this.childCount,
    this.childItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RefreshViewCustomState();
  }
}

class RefreshViewCustomState extends State<RefreshViewCustom> {
  bool _firstRefresh = true;

  @override
  Widget build(BuildContext context) {
    return widget.failState
        ? Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 100, bottom: 30),
                  child: Image.asset(
                    UiUtils.getImgPath('img_failview'),
                    width: 112,
                    height: 136,
                  ),
                ),
                Text(
                  "数据加载失败",
                  style: TextStyles.color_666666_14,
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    onPressed: widget.reRefresh,
                    color: BaseColor.color_f99a1d,
                    child: Text(
                      "重新加载",
                      style: TextStyles.color_ffffff_16,
                    ),
                  ),
                ),
              ],
            ),
          )
        : EasyRefresh.custom(
            controller: widget.controller,
            firstRefresh: widget.firstRefresh,
            enableControlFinishLoad: true,
            emptyWidget: _firstRefresh == true
                ? null
                : widget.childCount != 0
                    ? null
                    : Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 100, bottom: 30),
                            child: Text(
                              "～～空空如也～～",
                              style: TextStyles.color_666666_14,
                            ),
                          ),
                          Image.asset(
                            UiUtils.getImgPath('img_emptyview'),
                            width: 93,
                            height: 83,
                          ),
                        ],
                      ),
            header: ClassicalHeader(
              refreshText: "下拉刷新",
              refreshReadyText: "松手刷新",
              refreshingText: "正在刷新",
              refreshedText: "刷新完成",
              infoText: "刷新于 %T",
              bgColor: BaseColor.color_ffffff,
              textColor: BaseColor.color_333333,
            ),
            footer: ClassicalFooter(
              loadText: "上拉加载",
              loadReadyText: "松手加载",
              loadingText: "正在加载",
              loadedText: "加载完成",
              infoText: "加载于 %T",
              noMoreText: "没有更多数据",
              bgColor: BaseColor.color_ffffff,
              textColor: BaseColor.color_333333,
              enableInfiniteLoad: false,
            ),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return widget.childItem(context, index);
                  },
                  childCount: widget.childCount,
                ),
              ),
            ],
            onRefresh: () async {
              _firstRefresh = false;
              await widget.onRefresh();
              widget.controller.resetLoadState();
            },
            onLoad: widget.onLoadMore == null
                ? null
                : () async {
                    await widget.onLoadMore();
                    widget.controller.finishLoad(noMore: widget.noMore);
                  });
  }
}
