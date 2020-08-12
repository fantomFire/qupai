import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/model/guide_bean.dart';
import 'package:qupai/model/user_guide_risk.dart';
import 'package:qupai/pages/mine/user_guide/uguide_detail_page.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';

import '../../../urls.dart';

class URiskPage extends StatefulWidget {
  @override
  URiskPageState createState() => URiskPageState();
}

class URiskPageState extends State<URiskPage> {
  @override
  void initState() {
    super.initState();
    getData(true);
  }

  void getData(bool bool) async {
    HttpResponse response = await HttpUtil.send(
        context, "post", Urls.getGuide, {},
        initState: bool);
    if (response.result) {
      UserGuideRiskBean guideRiskBean =
          UserGuideRiskBean.fromJson(response.datas);
      setState(() {
        if (guideRiskBean.risk != null) {
          guidesList = guideRiskBean.risk;
        }
      });
    }
  }

  // 下拉刷新数据
  Future<Null> _refreshData() async {
    getData(true);
  }

  // 数据源
  List<GuideBean> guidesList = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "风险提示",
        style: TextStyle(fontSize: 18),
      )),
      body: Container(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView.separated(
            itemCount: guidesList.length,
            itemBuilder: (BuildContext context, int index) {
              return _listItemWidget(guidesList[index]);
            },
            //分割线构造器
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.grey[300],
                height: ScreenUtil().getAdapterSize(1),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _listItemWidget(data) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UGuideDetailPage(
              guideBean: data,
            );
          }));
        },
        child: Container(
          padding: EdgeInsets.all(ScreenUtil().getAdapterSize(15)),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    //标题
                    Container(
                      margin: EdgeInsets.only(
                          bottom: ScreenUtil().getAdapterSize(2)),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data.title,
                        style: TextStyle(fontSize: ScreenUtil().getSp(14)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //内容
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data.content,
                        style: TextStyle(
                            fontSize: ScreenUtil().getSp(11),
                            color: BaseColor.color_999999),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Image.asset(UiUtils.getImgPath("nextpage"),
                    width: ScreenUtil().getAdapterSize(11),
                    height: ScreenUtil().getAdapterSize(11)),
              )
            ],
          ),
        ));
  }
}
