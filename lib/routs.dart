import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qupai/pages/custom/chat.dart';
import 'package:qupai/pages/home/auction_details.dart';
import 'package:qupai/pages/home/auction_session.dart';
import 'package:qupai/pages/home/demonstration_session.dart';
import 'package:qupai/pages/home/ensure_order.dart';
import 'package:qupai/pages/mine/buy_order/order_detail.dart';
import 'package:qupai/pages/mine/buy_order/order_wait_pay.dart';
import 'package:qupai/pages/mine/money_code/money_code_page.dart';
import 'package:qupai/pages/mine/my_share/share_page.dart';
import 'package:qupai/pages/mine/my_share/wcash_page.dart';
import 'package:qupai/pages/mine/my_wallet/wallet_page.dart';
import 'package:qupai/pages/mine/physical_order/physical_detail.dart';
import 'package:qupai/pages/mine/physical_order/physical_screen.dart';
import 'package:qupai/pages/mine/ren_zheng/identification_page.dart';
import 'package:qupai/pages/mine/sell_order/order_sell_screen.dart';
import 'package:qupai/pages/mine/sell_order/sell_detail.dart';
import 'package:qupai/pages/mine/setting/seting_page.dart';
import 'package:qupai/pages/mine/setting/update_pass.dart';
import 'package:qupai/pages/mine/user_guide/uguide_detail_page.dart';
import 'package:qupai/pages/mine/user_guide/uguide_page.dart';
import 'package:qupai/pages/mine/user_guide/urisk_page.dart';
import 'pages/login/n_forget_psd_page.dart';
import 'pages/login/n_login_page.dart';
import 'pages/login/n_register_page.dart';
import 'pages/mainPage.dart';
import 'pages/mine/buy_order/order_screen.dart';
import 'pages/mine/my_info/add_address.dart';
import 'pages/mine/my_info/address_manager.dart';
import 'pages/mine/my_info/update_nickname.dart';
import 'pages/mine/my_info/user_info.dart';

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
              id: arguments['id'], status: arguments['status']);
    },
    '/demonstrationSession': (context) => DemonstrationSessionPage(),
    '/ensureOrder': (context) => EnsureOrder(),
    '/buy_order': (context) => OrderScreen(),
    '/order_detail': (BuildContext context) {
      Map<String, Object> arguments = ModalRoute.of(context).settings.arguments;
      return arguments == null
          ? OrderDetail()
          : OrderDetail(
              id: arguments['id'],
        orderStatus:arguments['orderStatus'],
            );
    },
    "/order_wait": (BuildContext context) {
      Map<String, Object> arguments = ModalRoute.of(context).settings.arguments;
      return arguments == null
          ? OrderWaitPay()
          : OrderWaitPay(
        id: arguments['id'],
        orderStatus:arguments['orderStatus'],
      );
    },


    "/sell_detail": (BuildContext context) {
      Map<String, Object> arguments = ModalRoute.of(context).settings.arguments;
      return arguments == null
          ? SellDetail()
          : SellDetail(
              id: arguments['id'],
            );
    },
    "/physical_detail": (context) => PhysicalDetail(),
    '/sell_order': (context) => OrderSell(),
    '/physical_order': (context) => PhysicalScreen(),
    "/setting_page": (context) => SettingPage(),
    '/user_info': (BuildContext context) {
      Map<String, Object> arguments = ModalRoute.of(context).settings.arguments;
      return arguments == null
          ? UserInfoPage()
          : UserInfoPage(
              user: arguments['user'],
            );
    },
    "/update_nickname": (BuildContext context) {
      Map<String, Object> arguments = ModalRoute.of(context).settings.arguments;
      return arguments == null
          ? UpdateNickname()
          : UpdateNickname(
              user_nickname: arguments['user_nickname'],
            );
    },
    "/address_manager": (BuildContext context) => AddressManager(),
    "/add_address": (BuildContext context) {
      Map<String, Object> arguments = ModalRoute.of(context).settings.arguments;
      return arguments == null
          ? AddAddress()
          : AddAddress(
              addressData: arguments['addressData'],
            );
    },
    "/update_pass": (BuildContext context) => UpdatePass(),
    "/my_wallet": (context) => WalletPage(),
    "/my_share": (context) => SharePage(),
    //实名认证
    "/to_identifilcation": (context) => IdentificationPage(),
    //用户指南
    "/to_user_guide": (context) => UGuidePage(),
    //用户指南
    "/to_user_risk": (context) => URiskPage(),
    "/to_money_code": (context) => MoneyCodePage(),
  };
}
