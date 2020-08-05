import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/common_views/refeshview_custom.dart';
import 'package:qupai/urls.dart';
import 'package:qupai/utils/imageutil.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';

class WalletList extends StatefulWidget {
  final int status;

  const WalletList({Key key, this.status}) : super(key: key);

  @override
  _WalletListState createState() => _WalletListState();
}

class _WalletListState extends State<WalletList>
    with AutomaticKeepAliveClientMixin {
  bool isFail = false;
  int userId;
  EasyRefreshController _easyRefreshController = EasyRefreshController();

  bool _hasNoMore = true;
  int curPage = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: 5),
        constraints: BoxConstraints.expand(),
        child: RefreshViewCustom(
          _easyRefreshController,
          failState: isFail,
          noMore: _hasNoMore,
          reRefresh: () {
            setState(() {
              isFail = false;
            });
          },
          childCount: 5,
          childItem: (context, index) {
            return _createIncomeDetail(index);
          },
          onRefresh: () async {
            curPage = 1;
          },
          onLoadMore: () {
            curPage++;
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  //明细item
  Widget _createIncomeDetail(index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: BaseColor.color_ffffff,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextView("充值",
                      style: TextStyle(
                          fontSize: ScreenUtil().getSp(15),
                          color: BaseColor.color_333333)),
                  TextView(
                    "+150",
                      style: TextStyle(
                          fontSize: ScreenUtil().getSp(15),
                          color: BaseColor.color_2BA245)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 11, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextView(
                    "2020-08-03 15:00:00",
                      style: TextStyle(
                          fontSize: ScreenUtil().getSp(11),
                          color: BaseColor.color_999999)),
                  TextView(
                    "余额 800.30",
                      style: TextStyle(
                          fontSize: ScreenUtil().getSp(11),
                          color: BaseColor.color_999999)),
                ],
              ),
            ),
            Line(color: BaseColor.color_lineColor),
          ],
        ),
      ),
    );
  }
}
