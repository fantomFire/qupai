import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'entity/appstoreinfo.dart';


class NativeUtils {
  static const MethodChannel _channel = const MethodChannel('com.ty.ty_mall/native');

  //安装新版apk安装包
  static Future<String> installApk(String filePath, String appId) async {
    return await _channel.invokeMethod("installApk", {"filePath": filePath, "appId": appId});
  }

  //通过url打开AppStore
//  static Future<String> gotoAppStore(String urlString) async {
//    return await _channel.invokeMethod('gotoAppStore', {'urlString': urlString});
//  }

  //检测appstore版本号
  static Future<String> getAppStoreVersion() async {
    Dio _dio = Dio();
    _dio.options.sendTimeout = 20000;
    _dio.options.connectTimeout = 20000;
    _dio.options.receiveTimeout = 20000;
    try {
      Response response = await _dio.get("http://itunes.apple.com/cn/lookup?id=1517571920");
      if (response.statusCode == 200) {
        if (response.data != null) {
          AppStoreInfo asi = AppStoreInfo.fromJson(json.decode(response.data));
          if (asi.results != null && asi.results.length != 0) {
            return asi.results[0].version;
          }
        }
      }
    } catch (e) {}
    return "";
  }

  static Future<String> setBadge(int badgeCount) async {
    return await _channel.invokeMethod("setBadge", {"badgeCount": badgeCount});
  }

  static Future<String> clearBadge() async {
    return await _channel.invokeMethod("clearBadge");
  }
  //版本比较
  static bool compareVersion(String currentVersion, String newVersion) {
    if (currentVersion == null || newVersion == null || currentVersion == "" || newVersion == "") {
      return true;
    } else {
      List<String> currStrs = currentVersion.split(".");
      List<String> newStrs = newVersion.split(".");
      List<String> currVersions = null;
      List<String> newVersions = null;
      if (currStrs.length > newStrs.length) {
        newVersions = List<String>();
        for (int i = 0; i < newVersions.length; i++) {
          if (i < newStrs.length) {
            newVersions[i] = newStrs[i];
          } else {
            newVersions[i] = "0";
          }
        }
        currVersions = currStrs;
      } else if (currStrs.length < newStrs.length) {
        currVersions = List<String>();
        for (int i = 0; i < newStrs.length; i++) {
          if (i < currStrs.length) {
            currVersions[i] = currStrs[i];
          } else {
            currVersions[i] = "0";
          }
        }
        newVersions = newStrs;
      } else {
        currVersions = currStrs;
        newVersions = newStrs;
      }
      for (int i = 0; i < currVersions.length; i++) {
        if (currVersions[i] == "" || newVersions[i] == "") {
          return true;
        }
        if (int.parse(currVersions[i]) < int.parse(newVersions[i])) {
          return true;
        } else if (int.parse(currVersions[i]) == int.parse(newVersions[i])) {
          continue;
        } else {
          return false;
        }
      }
      return false;
    }
  }
}
