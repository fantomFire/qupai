import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/pages/mine/entity/wallet_bean.dart';
import 'package:qupai/pages/mine/entity/wallet_list_bean.dart';
import 'package:qupai/pages/mine/my_wallet/wallet_wcash_page.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/widgets/appbars.dart';

import '../../../urls.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  String balance = "";

  @override
  void initState() {
    super.initState();
    getWalletList();
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
              child: Column(
                children: <Widget>[
                  AppBars.witheTitleNoLine(context, '我的钱包'),
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    child: TextView("余额",
                        style: TextStyle(fontSize: 17, color: Colors.white)),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 21, bottom: 59),
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "¥ ",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        TextSpan(
                            text: balance,
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                      ]))),
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
                      setState(() {});
                      print('点击了充值');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 43,
                      child: TextView(
                        "充值",
                        style: TextStyle(
                            fontSize: 15, color: BaseColor.color_333333),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return WalletWCashPage(
                          money: double.parse(balance),
                        );
                      }));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 43,
                      child: TextView(
                        "提现",
                        style: TextStyle(
                            fontSize: 15, color: BaseColor.color_333333),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Line(color: BaseColor.color_f7f7f7, height: 10),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: walletList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return getWalletItem(index);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  //明细item
  Widget getWalletItem(index) {
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
                  TextView(getTitle(walletList[index]),
                      style: TextStyle(
                          fontSize: ScreenUtil().getSp(15),
                          color: BaseColor.color_333333)),
                  TextView(getContent(walletList[index]),
                      style: TextStyle(
                          fontSize: ScreenUtil().getSp(15),
                          color: BaseColor.color_2BA245)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 11, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextView(walletList[index].creattime,
                      style: TextStyle(
                          fontSize: ScreenUtil().getSp(11),
                          color: BaseColor.color_999999)),
                  TextView(getBanlance(walletList[index]),
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

  String getTitle(WalletBean walletBean) {
    if (walletBean.is_status == 1) {
      return "充值";
    } else if (walletBean.is_status == 3) {
      return "提现";
    } else if (walletBean.is_status == 2) {
      return "手续费";
    }
  }

  String getContent(WalletBean walletBean) {
    if (walletBean.is_status == 1) {
      return "+ ${walletBean.money}";
    } else if (walletBean.is_status == 3) {
      return "- ${walletBean.tx_money}";
    } else if (walletBean.is_status == 2) {
      return "- ${walletBean.commission}";
    }
  }

  String getBanlance(WalletBean walletBean) {
    if (walletBean.is_status == 1) {
      return "余额 ${walletBean.cz_balance}";
    } else if (walletBean.is_status == 3) {
      return "余额 ${walletBean.tx_balance}";
    } else if (walletBean.is_status == 2) {
      return "余额 ${walletBean.com_balance}";
    }
  }

  List<WalletBean> walletList = List();

  void getWalletList() async {
    HttpResponse response = await HttpUtil.send(
        context, "post", Urls.getWalletList, {"user_id": UiUtils.getUserId()},
        initState: true);

    if (response.result) {
      walletList.clear();
      if (response.datas != null && response.datas.length > 0) {
        WalletListBean listBean = WalletListBean.fromJson(response.datas);
        for (int i = 0; i < listBean.jl.length; i++) {
          WalletBean item = listBean.jl[i];
          walletList.add(item);
        }
        balance = listBean?.balance;
      } else {
        ToastUtil.toast(response.message);
      }
      setState(() {});
    }
  }
}
