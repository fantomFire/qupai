import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:qupai/pages/home/auction_details.dart';
import 'package:qupai/pages/home/auction_session.dart';
import 'login/login_page.dart';
import 'pages/mainPage.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => LoginPage(), // 登录界面

    "/main_page": (BuildContext context) => MainPage(),
    '/auctionSession': (BuildContext context) {
      Map<String, Object> arguments = ModalRoute.of(context).settings.arguments;
      return arguments == null
          ? AuctionSessionPage()
          : AuctionSessionPage(
        status: arguments['status'],
      );
    },
    '/auctionDetails': (BuildContext context) {
      Map<String, Object> arguments = ModalRoute.of(context).settings.arguments;
      return arguments == null
          ? AuctionDetailsPage()
          : AuctionDetailsPage(
        status: arguments['status'],
      );
    },
  };
}
