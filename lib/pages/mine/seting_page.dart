import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/utils/http_util.dart';
import 'package:qupai/utils/native_utils.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';
import 'package:qupai/widgets/appbars.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../urls.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  //SettingBean settingBean ;
  int userId ;
  String _cacheSizeStr ;
  String version;
  String newVersion ;
  @override
  void initState() {
       super.initState();
     //  userId = CacheManager.instance.getUerInfo()?.user_id;
       loadCache();
       getSetting();
       getCurrentVersion();
       getNewVersion();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.color_pageBg,
      body: Container(
        color: BaseColor.color_ffffff,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBars.normalTitle(context, "设置"),
            Line(),
            setItemWidgetClick("修改密码", hasNext: true,onTap: (){
              NavigatorUtil.pushNamed(context, "/update_pass");
            }),
            setItemWidgetClick("消息通知", hasNext: false),


            setItemWidgetClick("清理缓存",
                content: _cacheSizeStr,
                color: TextStyles.color_cc0000_16,
                hasNext: false,
                onTap: () {
              _clearCache();
                }),
            setItemWidgetClick("关于趣拍",
                content: version, hasNext: true, onTap: () {
                  checkVersion();

                }),
            Line(height: 10,),
            GestureDetector(
              onTap: (){
                UiUtils.showTipDialog(context, "是否退出登录？", onSubmit: () {
                  loginOut();
                });
              },
              child: Container(
                height: 50,
                color: BaseColor.color_ffffff,
                alignment: Alignment.center,
                child: TextView("退出登录",style: TextStyles.color_333333_18,),

              ),

            )
          ],
        ),
      ),
    );
  }

  Widget setItemWidgetClick(String title,
      {String content,
      TextStyle color = TextStyles.color_999999_15,
      bool hasNext = true,
      dynamic onTap}) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: TextView(
                      title,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                TextView(
                  content,
                  style: color,
                ),
                hasNext
                    ? Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Image.asset(UiUtils.getImgPath("nextpage")))
                    : Container(),
              ],
            ),
          ),
        ),
        Line(
          left: 16,
          right: 16,
        ),
      ],
    );
  }

  void getSetting() async{

  }

  void loginOut() async{
    SpUtil.clear();
    NavigatorUtil.pushNamedAndRemoveUntil(context, '/login',"");
    }
  ///加载缓存
  Future<Null> loadCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(tempDir);
      /*tempDir.list(followLinks: false,recursive: true).listen((file){
          //打印每个缓存文件的路径
        print(file.path);
      });*/
      setState(() {
        _cacheSizeStr = _renderSize(value);
      });
    } catch (err) {

    }
  }
  /// 递归方式 计算文件的大小
  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        if (children != null)
          for (final FileSystemEntity child in children)
            total += await _getTotalSizeOfFilesInDir(child);
        return total;
      }
      return 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }
  ///格式化文件大小
  _renderSize(double value) {
    if (null == value) {
      return 0;
    }
    List<String> unitArr = List()
      ..add('B')
      ..add('K')
      ..add('M')
      ..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }
  void _clearCache() async {
    //此处展示加载loading
    try {
      Directory tempDir = await getTemporaryDirectory();
      //删除缓存目录
      await delDir(tempDir);
      await loadCache();
      ToastUtil.toast('清除缓存成功');
    } catch (e) {
      print(e);
      ToastUtil.toast('清除缓存失败');
    } finally {
      //此处隐藏加载loading
    }
  }
  ///递归方式删除目录
  Future<Null> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      print(e);
    }
  }

  void checkVersion() async{

    if(Platform.isAndroid){
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      HttpResponse response = await  HttpUtil.send(context, 'post', Urls.version, {},initState: false,showLoading: false);
      if(response.result){
        String  newVersion = response.datas;
        if (newVersion == null) {
          ToastUtil.toast('获取版本信息错误');
        } else if(NativeUtils.compareVersion(packageInfo.version, newVersion)) {
          UiUtils.showVersionDialog(context, "已有新版本${newVersion}, 赶紧去下载吧！",
              title: '版本更新', onSubmit: () {
             //   launch(Urls.updateVersion);
              });
          // launch('http://sysrgood.com/5sq9?from=singlemessage'),
        }
      }

    }else if (Platform.isIOS){
      await PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
        await NativeUtils.getAppStoreVersion().then((version) async {
          if (version != null && version.length != 0 && packageInfo.version != null && packageInfo.version.length != 0) {
            if (NativeUtils.compareVersion(packageInfo.version, version)) {
              final url = "https://itunes.apple.com/cn/app/id1517571920";
              if (await canLaunch(url)) {
                await launch(url, forceSafariVC: false);
              } else {
                throw '打开App Store失败，请前往App Store更新为最新版本！';
              }
            }
          }
        });
      });
    }
  }
  void _quit(bool forcedUpgrade) async {
    if (forcedUpgrade) {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  void getCurrentVersion()async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
     version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
  }

  void getNewVersion() async{
  HttpResponse response = await  HttpUtil.send(context, 'post', Urls.version, {},initState: true,showLoading: false);
  if(response.result){
     newVersion = response.datas;
     setState(() {

     });
  }


  }
}
