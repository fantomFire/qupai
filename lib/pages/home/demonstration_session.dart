import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:qupai/widgets/WZVideo.dart';

class DemonstrationSessionPage extends StatefulWidget {

  DemonstrationSessionPage({Key key}) : super(key: key);

  @override
  _DemonstrationSessionPageState createState() =>
      _DemonstrationSessionPageState();
}

class _DemonstrationSessionPageState extends State<DemonstrationSessionPage> {
  ScrollController _scrollController = ScrollController();
  List _swperListData = [];
  Map _data = {"a": 1};
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      _getDeatils();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 下拉刷新数据
  Future<Null> _refreshData() async {
    _getDeatils();
  }

  //获取详情
  _getDeatils() async {
    // NewResp response = await DioUtilNew.getInstance().request(
    //   MethodNew.post,
    //   HttpUrl.instructionsDetailsUrl,
    //   data: {
    //     "instructions_id": widget.arguments["id"].toString(),
    //   },
    // );
    // if (response.code == "200") {
    //   setState(() {
    //     _swperListData = response.data["instructions_course"];
    //     _data = response.data;
    //   });
    // } else {
    //   Fluttertoast.showToast(
    //     msg: response.message,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //   );
    // }
  }

  //轮播图
  Widget _swiperWidget() {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: AspectRatio(
          aspectRatio: 16 / 9, //适配所有终端
          child: WZVideo(
              url: "http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4",looping: true)),
    );
  }

  Widget _contentWidget(data) {
    return Container(
      padding: EdgeInsets.only(
          left: ScreenUtil().getAdapterSize(10),
          right: ScreenUtil().getAdapterSize(10)),
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding:
                EdgeInsets.symmetric(vertical: ScreenUtil().getAdapterSize(5)),
            child: Text(
              "标题",
              style: TextStyle(
                  fontSize: ScreenUtil().getAdapterSize(15),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "内容",
              style: TextStyle(
                  fontSize: ScreenUtil().getAdapterSize(12),
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return RefreshIndicator(
        onRefresh: _refreshData,
        child: _data != null
            ? ListView(
                controller: _scrollController,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        _swiperWidget(),
                        _contentWidget(_data)
                      ],
                    ),
                  ),
                ],
              )
            : SizedBox());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text("演示专场"),
          centerTitle: false,
        ),
        body: _bodyWidget());
  }
}
