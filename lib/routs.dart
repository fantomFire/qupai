import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:qupai/login/n_forget_psd_page.dart';
import 'package:qupai/pages/custom/chat.dart';
import 'package:qupai/pages/home/auction_details.dart';
import 'package:qupai/pages/home/auction_session.dart';
import 'package:qupai/pages/home/demonstration_session.dart';
import 'package:qupai/pages/home/ensure_order.dart';
import 'login/n_login_page.dart';
import 'login/n_register_page.dart';
import 'pages/mainPage.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => NLoginPage(), // 登录界面
    '/register': (BuildContext context) => NRegisterPage(), // 注册界面
    '/forget': (BuildContext context) => NForgetPsdPage(), // 忘记密码界面
    '/tochat': (BuildContext context) => ChatPage(), // 聊天界面

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
    '/demonstrationSession': (context) => DemonstrationSessionPage(),
    '/ensureOrder': (context) => EnsureOrder(),
  };
}
