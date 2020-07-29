import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';

import '../urls.dart';
import 'CommonUtil.dart';
import 'http_util.dart';



class InitAndUpgrade {
  static Future<Map<Permission, PermissionStatus> > checkPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.camera,
      Permission.phone,
      Permission.photos,
      Permission.storage,
    ].request();
    return statuses ;
  /*  List<PermissionGroup> permissionGroup = [];
    PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
    if (status != PermissionStatus.granted) {
      permissionGroup.add(PermissionGroup.location);
    }
    status = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (status != PermissionStatus.granted) {
      permissionGroup.add(PermissionGroup.camera);
    }
    status = await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);
    if (status != PermissionStatus.granted) {
      permissionGroup.add(PermissionGroup.phone);
    }
    status = await PermissionHandler().checkPermissionStatus(PermissionGroup.photos);
    if (status != PermissionStatus.granted) {
      permissionGroup.add(PermissionGroup.photos);
    }
    status = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    if (status != PermissionStatus.granted) {
      permissionGroup.add(PermissionGroup.storage);
    }
    if (permissionGroup.length != 0) {
      await PermissionHandler().requestPermissions(permissionGroup);
    }*/
  }

 /* static Future checkAndroidVersion(BuildContext context, dynamic result) async {
    NewVersion _newVersion = NewVersion();
    await PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
      _newVersion.currVersion = packageInfo.version;
      HttpResponse httpResponse = await HttpUtil.send(context, "get", Urls.version, null, showLoading: false);
      if (httpResponse.result) {
        if (httpResponse.datas == null) {
          _newVersion.version = "0.0.0";
        } else {
          _newVersion.version = httpResponse.datas["version"];
          _newVersion.forcedUpgrade = httpResponse.datas["forcedUpgrade"];
          _newVersion.apkLength = httpResponse.datas["apkLength"];
        }
      *//*  if (CommonUtil.compareVersion(packageInfo.version, _newVersion.version) && _newVersion.apkLength > 0) {
          result(_newVersion..next = 'upgrade');
        } else {
          result(_newVersion..next = 'start');
        }*//*
      } else {
        result(_newVersion..next = 'error');
      }
    });
  }*/

}

class NewVersion {
  bool forcedUpgrade; // 是否强制更新
  String version;
  var apkLength;
  String next;
  String currVersion;
}
