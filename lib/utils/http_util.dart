import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../urls.dart';
import 'cacahe_manager.dart';
import 'loading_progress_dialog.dart';

class HttpUtil {
  static Dio _dio;

  // 执行接口请求
  static Future<HttpResponse> send(BuildContext context, String method, String url, dynamic data,
      {bool showLoading: true, bool initState: false}) async {
    showLoadingProgress(context, showLoading, initState);
    if (_dio == null) {
      _dio = Dio();
      _dio.options.baseUrl = Urls.base;
      _dio.options.sendTimeout = 20000;
      _dio.options.connectTimeout = 20000;
      _dio.options.receiveTimeout = 20000;
     addInterceptor(_dio);
    }
    try {
      Response response;
      switch (method) {
        case "post":
          response = await _dio.post(url, data: data);
          break;
        case "get":
          response = await _dio.get(url, queryParameters: data);
          break;
        case "put":
          response = await _dio.put(url, data: data);
          break;
        case "delete":
          response = await _dio.delete(url, data: data);
          break;
        default:
          hideLoadingProgress(context, showLoading);
          return HttpResponse(false);
      }

      if (response.statusCode == 200) {
       var  datas =  json.decode(response.data);
        int    code = datas['code'];
        if (code != null && code == 200) {
          hideLoadingProgress(context, showLoading);
          return HttpResponse(true, code, datas["message"], datas["data"]);
        }else {
          // 其它失败情况
          if (datas["message"] != null && datas["message"].length != 0) {
            hideLoadingProgress(context, showLoading);
            ToastUtil.toast(datas["message"]);
            return HttpResponse(false, code, datas["message"], datas["data"]);
          } else if (datas["message"] != null && datas["message"].length != 0) {
            hideLoadingProgress(context, showLoading);
            ToastUtil.toast(datas["message"]);
            return HttpResponse(false, code, datas["message"], datas["data"]);
          } else {
            hideLoadingProgress(context, showLoading);
            return HttpResponse(false);
          }
        }
      } else {
        hideLoadingProgress(context, showLoading);
        ToastUtil.toast("网络连接错误，请检查网络！");
        return HttpResponse(false);
      }
    } on DioError catch (e) {
      hideLoadingProgress(context, showLoading);
      if (e != null && (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT || e.type == DioErrorType.SEND_TIMEOUT)) {
        ToastUtil.toast('网络连接超时');
      } else {
        ToastUtil.toast("网络连接错误，请检查网络！");
      }
      return HttpResponse(false);
    } catch (e) {
      hideLoadingProgress(context, showLoading);
      ToastUtil.toast("网络错误！");
      return HttpResponse(false);
    }
  }

  static void addInterceptor(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      if (CacheManager.instance.getCookie() != null && CacheManager.instance.getCookie().length != 0) {
        options.headers["Cookie"] = CacheManager.instance.getCookie();
      } else {
        SharedPreferences sp = await SharedPreferences.getInstance();
        String cookie = sp.getString("token");
        if (cookie != null && cookie.length != 0) {
          options.headers["Cookie"] = cookie;
        }
      }
      return options;
    }, onResponse: (Response response) async {
      /*response.headers.forEach((key, lists) async {
        if (key != null && key.toLowerCase() == "set-cookie") {
          if (lists != null && lists.length != 0) {
            for (int i = 0; i < lists.length; i++) {
              if (lists[i].contains("HttpOnly")) {
                SharedPreferences sp = await SharedPreferences.getInstance();
                CacheManager.instance.setCookie(lists[i]);
                sp.setString("token", lists[i]);
              }
            }
          }
        }
      });*/
      return response;
    }, onError: (DioError e) {
      return e;
    }));
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));
    }


  static String getImageCodeUrl(String type) {
  }

  // token失效后跳转到登录页面
  static Future tokenInvalidate(BuildContext context) async {

    ToastUtil.toast("登录已失效，请重新登录");
  }

  static void showLoadingProgress(BuildContext context, bool showDialog, bool initState) {
    if (showDialog) {
      LoadingProgress.getInstance().show(context, initState);
    }
  }

  static void hideLoadingProgress(BuildContext context, bool showDialog) {
    if (showDialog) {
      LoadingProgress.getInstance().hide(context);
    }
  }
}

class HttpResponse {
  bool result;
  var code;
  var message;
  var datas;

  HttpResponse(this.result, [this.code, this.message, this.datas]);
}
