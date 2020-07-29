import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qupai/utils/CommonUtil.dart';
import 'package:qupai/values/baseColor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {



  @override
  void initState() {
    super.initState();
    CommonUtil.initCache(context);



  }

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: BaseColor.color_ffffff);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              "趣拍",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),

        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;


  @override
  void dispose() {
    super.dispose();
  }

}
