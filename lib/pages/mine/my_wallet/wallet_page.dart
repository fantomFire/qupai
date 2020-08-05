import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/rich_text_parser.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/pages/mine/my_wallet/wallet_list.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/widgets/appbars.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  PageController _pageController;
  int isSelect = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: BaseColor.color_ffffff_pagege,
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffD63432), Color(0xffFE8564)]),
              ),
              child:  Column(
                children: <Widget>[
                  AppBars.witheTitleNoLine(context, '我的钱包'),

                  Container(
                    margin: EdgeInsets.only(top:32),
                    child: TextView("余额",style: TextStyle(fontSize: 17,color: Colors.white)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:21,bottom: 59),
                    child: Text.rich(TextSpan(
                      children: [
                        TextSpan(text:"¥ ",style: TextStyle(fontSize: 16,color: Colors.white)),
                        TextSpan(text:"8799.00",style: TextStyle(fontSize: 30,color: Colors.white)),
                      ]
                    ))
                  ),
                ],
              ),
            ),


            //钱包积分
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _pageController.jumpToPage(0);
                      setState(() {
                        isSelect = 0;
                      });
                      print('点击了充值');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 43,
                      child: TextView(
                        "充值",
                        style: TextStyle(
                            fontWeight: isSelect == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 15,
                            color: isSelect == 0
                                ? BaseColor.color_FF0000
                                : BaseColor.color_333333),
                      ),
                    ),
                  ),
                  Container(
                    height: 43,
                    width: 0.5,
                    color: BaseColor.color_E6E6E6,
                  ),
                  GestureDetector(
                    onTap: () {
                      _pageController.jumpToPage(1);
                      print('点击了提现');
                      setState(() {
                        isSelect = 1;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 43,
                      child: TextView(
                        "提现",
                        style: TextStyle(
                            fontWeight: isSelect == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 15,
                            color: isSelect == 1
                                ? BaseColor.color_FF0000
                                : BaseColor.color_333333),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Line(color: BaseColor.color_f7f7f7, height: 10),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {

                },
                children: getPages(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  List<Widget> getPages() {
    return [
      WalletList(
        status: 0,
      ),
      WalletList(
        status: 1,
      ),
    ];
  }
}
