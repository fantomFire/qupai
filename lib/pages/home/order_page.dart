import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';
import 'package:qupai/widgets/show_content.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int selectIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3.0))),
                    //设置圆角

                    child: Column(
                      children: <Widget>[
                        ShowContent(
                          title: "卖家",
                          content: "小艾",
                        ),
                        ShowContent(
                          title: "订单号",
                          content: "18192600365",
                          contentColor: BaseColor.color_333333,
                          hasRightImage: true,
                          onTap: () {},
                        ),
                        ShowContent(
                          title: "单价",
                          content: "1000",
                        ),
                        ShowContent(
                          title: "数量",
                          content: "1000",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: ShowContent(
                      title: '总计',
                      content: '¥1000',
                      titleColor: BaseColor.color_333333,
                      contentColor: BaseColor.color_C60000,
                      hasBottomLine: false,
                    ),
                  ),
                  Container(
                    height: 44,
                    alignment: Alignment.centerLeft,
                    child: TextView(
                      "选择付款方式",
                      style: TextStyles.color_333333_14,
                    ),
                  ),
                  Card(
                    child: Container(
                      height: 45,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = 1;
                                });
                              },
                              child: Container(
                                height: 45,
                                decoration: selectIndex == 1
                                    ? BoxDecoration(
                                        border: Border.all(
                                            color: BaseColor.color_C60000,
                                            width: 1,
                                            style: BorderStyle.solid))
                                    : BoxDecoration(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                        UiUtils.getImgPath("wechat"),
                                        width: 18,
                                        height: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    TextView(
                                      "支付宝",
                                      style: TextStyles.color_333333_14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = 2;
                                });
                              },
                              child: Container(
                                height: 45,
                                decoration: selectIndex == 2
                                    ? BoxDecoration(
                                        border: Border.all(
                                            color: BaseColor.color_C60000,
                                            width: 1,
                                            style: BorderStyle.solid))
                                    : BoxDecoration(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                        UiUtils.getImgPath("wechat"),
                                        width: 18,
                                        height: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    TextView(
                                      "微信",
                                      style: TextStyles.color_333333_14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = 3;
                                });
                              },
                              child: Container(
                                height: 45,
                                decoration: selectIndex == 3
                                    ? BoxDecoration(
                                        border: Border.all(
                                            color: BaseColor.color_C60000,
                                            width: 1,
                                            style: BorderStyle.solid))
                                    : null,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                        UiUtils.getImgPath("wechat"),
                                        width: 18,
                                        height: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    TextView(
                                      "银行卡",
                                      style: TextStyles.color_333333_14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, bottom: 20, top: 20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextView(
                                '收款码',
                                style: TextStyles.color_999999_14,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                child: Image.asset(
                                  UiUtils.getImgPath('wechat'),
                                  width: 138,
                                  height: 138,
                                  fit: BoxFit.fill,
                                ),
                              )
                            ],
                          ),
                          ShowContent(
                            title: '收款人',
                            content: '小艾',
                            contentColor: BaseColor.color_333333,
                            hasBottomLine: false,
                            hasRightImage: true,
                            onTap: () {},
                          ),
                          ShowContent(
                            title: '微信号',
                            content: '1259867896589',
                            contentColor: BaseColor.color_333333,
                            hasBottomLine: false,
                            hasRightImage: true,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, right: 5),
                    width: double.infinity,
                    child: TextView(
                      "联系电话：1320170569（如付款异常联系商家处理",
                      style: TextStyles.color_333333_12,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 20,
                          alignment: Alignment.center,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: BaseColor.color_C60000,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: TextView(
                            '1',
                            style: TextStyles.color_C60000_11,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: BaseColor.color_C60000,
                        )),
                        Container(
                          width: 20,
                          alignment: Alignment.center,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: BaseColor.color_C60000,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: TextView(
                            '1',
                            style: TextStyles.color_C60000_11,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: BaseColor.color_999999,
                        )),
                        Container(
                          width: 20,
                          alignment: Alignment.center,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: BaseColor.color_999999,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: TextView(
                            '3',
                            style: TextStyles.color_999999_11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: TextView(
                            '步骤一',
                            style: TextStyles.color_999999_14,
                          ),
                        ),
                        Container(
                          child: TextView(
                            '步骤二',
                            style: TextStyles.color_999999_14,
                          ),
                        ),
                        Container(
                          child: TextView(
                            '步骤三',
                            style: TextStyles.color_999999_14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: TextView(
                            '给卖家转账',
                            style: TextStyles.color_999999_14,
                          ),
                        ),
                        Container(
                          child: TextView(
                            '付款后点下一步',
                            style: TextStyles.color_999999_14,
                          ),
                        ),
                        Container(
                          child: TextView(
                            '等待卖家确认',
                            style: TextStyles.color_999999_14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: ScreenUtil().getAdapterSize(50),
        color: Theme.of(context).backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  color: BaseColor.color_bbbb,
                  height: ScreenUtil().getAdapterSize(50),
                  child: Text(
                    "取消订单",
                    style:
                        TextStyle(color: BaseColor.color_ffffff, fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().getAdapterSize(50),
                  color: Color(0xffC60000),
                  child: Text(
                    "立即购买",

                    style: TextStyles.color_ffffff_17,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
