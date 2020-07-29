import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';



class RefreshViewCustom extends StatefulWidget {
  final EasyRefreshController controller;
  final dynamic onRefresh;
  final dynamic onLoadMore;
  final dynamic childItem;
  final bool firstRefresh;
  final List lists;
  final int pageSize;

  const RefreshViewCustom({
    Key key,
    this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.firstRefresh: true,
    this.childItem,
    this.lists,
    this.pageSize: 10,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RefreshViewCustomState();
  }
}

class RefreshViewCustomState extends State<RefreshViewCustom> {
  EasyRefreshController _easyRefreshController = EasyRefreshController();
  bool _firstRefresh = true;
  bool _failState = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _easyRefreshController = widget.controller;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _failState
        ? Container(
            color: BaseColor.color_ffffff,
            constraints: BoxConstraints.expand(),
            child: Column(
              children: <Widget>[
//                Container(
//                  margin: EdgeInsets.only(top: 100, bottom: 30),
//                  child: Image.asset(
//                    UiUtils.getImgPath('img_failview'),
//                  ),
//                ),
                GestureDetector(
                  onTap: () {
                    _easyRefreshController.callRefresh();
                  },
                  child: Container(
                    width: 120,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid, color: BaseColor.color_999999, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    child: TextView("重新加载", style:TextStyles.color_999999_14),
                  ),
                ),
              ],
            ),
          )
        : EasyRefresh.custom(
            controller: _easyRefreshController,
            firstRefresh: widget.firstRefresh,
            enableControlFinishLoad: true,
            emptyWidget: _firstRefresh == true
                ? null
                : widget.lists.length != 0
                    ? null
                    : Container(
                        child: Column(
                          children: <Widget>[
//                            Container(
//                              margin: EdgeInsets.only(top: 100, bottom: 30),
//                              child: Image.asset(
//                                UiUtils.getImgPath('img_emptyview'),
//                              ),
//                            ),
                            Text(
                              "什么也没有！",
                              style: TextStyles.color_999999_14,
                            ),
                          ],
                        ),
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
                  childCount: widget.lists.length,
                ),
              ),
            ],
            onRefresh: () async {
              _firstRefresh = false;
           /*  TotalListResponse result = await widget.onRefresh();
              widget.lists.clear();
              if (result != null && result.list.length != 0) {
                widget.lists.addAll(result.list);
                _easyRefreshController.resetLoadState();
                if (result.list == null || widget.lists.length == result.total) {
                  _easyRefreshController.finishLoad(noMore: true);
                }
                _easyRefreshController.finishRefresh();
              }*/
              setState(() {});
            },
            onLoad: widget.onLoadMore == null
                ? null
                : () async {
                   /* TotalListResponse result = await widget.onLoadMore();
                    if (result != null && result.list.length != 0) {
                      setState(() {
                        widget.lists.addAll(result.list);
                        if (result.list == null || widget.lists.length == result.total) {
                          _easyRefreshController.finishLoad(noMore: true);
                        } else {
                          _easyRefreshController.finishLoad(noMore: false);
                        }
                      });
                    }*/
                  });
  }
}
