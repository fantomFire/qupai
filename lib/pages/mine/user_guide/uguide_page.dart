import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/pages/mine/user_guide/uguide_detail_page.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';

class UGuidePage extends StatefulWidget {
  @override
  UGuidePageState createState() => UGuidePageState();
}

class UGuidePageState extends State<UGuidePage> {
  // 下拉刷新数据
  Future<Null> _refreshData() async {
    titleItems.addAll(titleItems2);
  }

  // 数据源
  List<String> titleItems = <String>[
    'wifi_tethering wifi_tethering wifi_tethering wifi_tethering wifi_tethering',
    'wifi_lock',
    'widgets',
    'weekend',
    'web',
    '图accessible',
    'ac_unit',
  ];

  List<String> titleItems2 = <String>[
    'keyboard',
    'print',
    'router',
    'pages',
    'zoom_out_map',
    'zoom_out',
    'youtube_searched_for',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "用户指南",
        style: TextStyle(fontSize: 18),
      )),
      body: Container(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView.separated(
            itemCount: titleItems.length,
            itemBuilder: (BuildContext context, int index) {
              return _listItemWidget(titleItems[index], index);
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

  Widget _listItemWidget(data, index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UGuideDetailPage(
              content: titleItems[index],
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
                        data,
                        style: TextStyle(fontSize: ScreenUtil().getSp(14)
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //内容
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data,
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
