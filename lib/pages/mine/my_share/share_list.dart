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

class ShareList extends StatefulWidget {
  final int status;

  const ShareList({Key key, this.status}) : super(key: key);

  @override
  _ShareListState createState() => _ShareListState(status);
}

class _ShareListState extends State<ShareList>
    with AutomaticKeepAliveClientMixin {
  bool isFail = false;
  int userId;
  EasyRefreshController _easyRefreshController = EasyRefreshController();

  bool _hasNoMore = true;
  int curPage = 1;

  final int status;

  _ShareListState(this.status);

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
            if (status == 0) {
              return _createIncomeDetail(index);
            }
            return _createPayDetail(index);
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

  //支出item
  Widget _createPayDetail(index) {
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
                  TextView("提现",
                      style: TextStyle(
                          fontSize: ScreenUtil().getSp(15),
                          color: BaseColor.color_333333)),
                  TextView("-150",
                      style: TextStyle(
                          fontSize: ScreenUtil().getSp(15),
                          color: BaseColor.color_FF0000)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 11, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextView("2020-08-03 15:00:00",
                      style: TextStyle(
                          fontSize: ScreenUtil().getSp(11),
                          color: BaseColor.color_999999)),
                  TextView("已提现至钱包",
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

  //收入item
  Widget _createIncomeDetail(index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: BaseColor.color_ffffff,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(right: 8, bottom: 16),
                    child: ClipOval(
                      child: ImageLoadUtil(
                        width: 37,
                        height: 37,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  TextView("小艾同学",
                                      style: TextStyle(
                                          fontSize: ScreenUtil().getSp(12),
                                          color: BaseColor.color_333333)),
                                  Container(
                                    margin: EdgeInsets.only(left: 13),
                                    child: TextView("初级会员",
                                        style: TextStyle(
                                            fontSize: ScreenUtil().getSp(6),
                                            color: BaseColor.color_333333)),
                                  ),
                                ],
                              ),
                              TextView("+150",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().getSp(15),
                                      color: BaseColor.color_2BA245)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextView("13812345678",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().getSp(11),
                                      color: BaseColor.color_999999)),
                              TextView("2020-08-03 15:00:00",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().getSp(11),
                                      color: BaseColor.color_999999)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Line(
              color: BaseColor.color_lineColor,
            )
          ],
        ),
      ),
    );
  }
}
