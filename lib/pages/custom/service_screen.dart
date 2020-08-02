import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicePage extends StatefulWidget {
  ServicePage({Key key}) : super(key: key);

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  Widget _bodyWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().getAdapterSize(80),
                horizontal: ScreenUtil().getAdapterSize(30)),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: InkWell(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          UiUtils.getImgPath("service_online"),
                          width: ScreenUtil().getAdapterSize(60),
                          height: ScreenUtil().getAdapterSize(60),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: ScreenUtil().getAdapterSize(8),
                        ),
                        Text("在线客服")
                      ]),
                  onTap: () {
                    NavigatorUtil.pushNamed(context, "/tochat");
                  },
                )),
                Expanded(
                    child: InkWell(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          UiUtils.getImgPath("call"),
                          width: ScreenUtil().getAdapterSize(60),
                          height: ScreenUtil().getAdapterSize(60),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: ScreenUtil().getAdapterSize(8),
                        ),
                        Text("联系我们")
                      ]),
                  onTap: () async {
                    await showDialog(
                      context: context,
                      barrierDismissible: false, //// user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: Center(
                            child: Text('提示'),
                          ),
                          content: Text(
                            '确定拨打电话：4008258608吗？',
                            style: TextStyle(
                                fontSize: ScreenUtil().getAdapterSize(13)),
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                FlatButton(
                                  child: Text('取消',
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                  onPressed: () {
                                    Navigator.pop(context, "notsure");
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    '确认',
                                    style: TextStyle(color: Color(0xffC60000)),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context, "sure");
                                    launch("tel:18292837296");
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().getAdapterSize(60)),
            alignment: Alignment.centerLeft,
            child: Expanded(
                child: RichText(
              text: TextSpan(
                  text: '*',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: ScreenUtil().getAdapterSize(10)),
                  children: [
                    TextSpan(
                      text: "请在工作时间内咨询或者致电，我们的工作时间为：上午9:00~12:00 下午2:30~5:30。",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: ScreenUtil().getAdapterSize(11)),
                    ),
                  ]),
            )),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        automaticallyImplyLeading: false,
        title: Text("客服"),
        centerTitle: false,
        elevation: 0,
      ),
      body: _bodyWidget(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
