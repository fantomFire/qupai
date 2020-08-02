import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qupai/widgets/appbars.dart';
import 'package:qupai/widgets/show_content.dart';
class CompanyPage extends StatefulWidget {
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16,right: 16,top: 10),
              child: Card(
                margin: EdgeInsets.only(left: 5,right: 5),
                child: Column(
                  children: <Widget>[
                    ShowContent(
                      title: '商户名',
                      content: '小艾',
                    ),
                    ShowContent(
                      title: '真实姓名',
                      content: '小艾',
                    ),

                    ShowContent(
                      title: '手机',
                      content: '18192600365',
                    ),
                  ],
                ),
              ),

            ),

              ],
            ),
          )

        ],
      ),
    );
  }
}
