import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qupai/utils/toast_util.dart';
import '../urls.dart';
import 'CommonUtil.dart';
import 'http_util.dart';

class FileUpLoadServer {
  static Dio _dio;

  // 上传二维码
  static Future<HttpResponse> uploadzhifi(BuildContext context, File file,
      {bool showDialog: true, bool initState: false}) async {
    if (file != null && file.lengthSync() != 0) {
      if (!CommonUtil.checkImageType(file)) {
        ToastUtil.toast("图片格式错误");
        return HttpResponse(false);
      } else {
        HttpUtil.showLoadingProgress(context, showDialog, initState);
        if (_dio == null) {
          _dio = Dio();
          _dio.options.baseUrl = Urls.base;
          _dio.options.connectTimeout = 10000;
          _dio.options.receiveTimeout = 20000;
          HttpUtil.addInterceptor(_dio);
        }
        try {
          FormData formData = new FormData.fromMap({
            "image": await MultipartFile.fromFile(
              file.path,
              filename: file.path.substring(file.path.lastIndexOf("/") + 1),
            ),
          });
          Response response =
              await _dio.post(Urls.addAliPictuer, data: formData);
          if (response.statusCode == 200) {
            var datas = json.decode(response.data);
            String code = datas['code'];
            if (code != null && code == '200') {
              HttpUtil.hideLoadingProgress(context, showDialog);
              return HttpResponse(true, code, datas["message"], datas["data"]);
            }
          } else {
            HttpUtil.hideLoadingProgress(context, showDialog);
            ToastUtil.toast("网络错误！");
            return HttpResponse(false);
          }
        } on DioError catch (e) {
          HttpUtil.hideLoadingProgress(context, showDialog);
          if (e != null &&
              (e.type == DioErrorType.CONNECT_TIMEOUT ||
                  e.type == DioErrorType.RECEIVE_TIMEOUT ||
                  e.type == DioErrorType.SEND_TIMEOUT)) {
            ToastUtil.toast('网络连接超时');
          } else {
            ToastUtil.toast("网络连接错误，请检查网络！");
          }
          return HttpResponse(false);
        } catch (e) {
          HttpUtil.hideLoadingProgress(context, showDialog);
          ToastUtil.toast("网络错误！");
          return HttpResponse(false);
        }
      }
    } else {
      ToastUtil.toast("上传图片错误，请重试！");
    }
  }

  //上传头像
  static Future<HttpResponse> uploadPhoto(
      BuildContext context, String user_id, File file,
      {bool showDialog: true, bool initState: false}) async {
    if (file != null && file.lengthSync() != 0) {
      if (!CommonUtil.checkImageType(file)) {
        ToastUtil.toast("图片格式错误");
        return HttpResponse(false);
      } else {
        HttpUtil.showLoadingProgress(context, showDialog, initState);
        if (_dio == null) {
          _dio = Dio();
          _dio.options.baseUrl = Urls.base;
          _dio.options.connectTimeout = 10000;
          _dio.options.receiveTimeout = 20000;
          HttpUtil.addInterceptor(_dio);
        }
        try {
          FormData formData = new FormData.fromMap({
            "image": await MultipartFile.fromFile(
              file.path,
              filename: file.path.substring(file.path.lastIndexOf("/") + 1),
            ),
            'user_id': user_id,
          });
          Response response =
              await _dio.post(Urls.setUserPhoto, data: formData);
          if (response.statusCode == 200) {
            var datas = json.decode(response.data);
            num code = datas['code'];
            if (code != null && code == 200) {
              HttpUtil.hideLoadingProgress(context, showDialog);
              return HttpResponse(true, code, datas["message"], datas["data"]);
            }
          } else {
            HttpUtil.hideLoadingProgress(context, showDialog);
            ToastUtil.toast("网络错误！");
            return HttpResponse(false);
          }
        } on DioError catch (e) {
          HttpUtil.hideLoadingProgress(context, showDialog);
          if (e != null &&
              (e.type == DioErrorType.CONNECT_TIMEOUT ||
                  e.type == DioErrorType.RECEIVE_TIMEOUT ||
                  e.type == DioErrorType.SEND_TIMEOUT)) {
            ToastUtil.toast('网络连接超时');
          } else {
            ToastUtil.toast("网络连接错误，请检查网络！");
          }
          return HttpResponse(false);
        } catch (e) {
          HttpUtil.hideLoadingProgress(context, showDialog);
          ToastUtil.toast("网络错误！");
          return HttpResponse(false);
        }
      }
    } else {
      ToastUtil.toast("上传图片错误，请重试！");
    }
  }

  // 上传图片
  static Future<HttpResponse> uploadImage(
      BuildContext context, String user_id, File file,
      {bool showDialog: true, bool initState: false}) async {
    if (file != null && file.lengthSync() != 0) {
      if (!CommonUtil.checkImageType(file)) {
        ToastUtil.toast("图片格式错误");
        return HttpResponse(false);
      } else {
        HttpUtil.showLoadingProgress(context, showDialog, initState);
        if (_dio == null) {
          _dio = Dio();
          _dio.options.baseUrl = Urls.base;
          _dio.options.connectTimeout = 10000;
          _dio.options.receiveTimeout = 20000;
          HttpUtil.addInterceptor(_dio);
        }
        try {
          FormData formData = new FormData.fromMap({
            "image": await MultipartFile.fromFile(
              file.path,
              filename: file.path.substring(file.path.lastIndexOf("/") + 1),
            ),
            'user_id': user_id,
          });
          Response response = await _dio.post(Urls.uploadPhoto, data: formData);
          if (response.statusCode == 200) {
            var datas = json.decode(response.data);
            String code = datas['code'];
            if (code != null && code == '200') {
              HttpUtil.hideLoadingProgress(context, showDialog);
              return HttpResponse(true, code, datas["message"], datas["data"]);
            }
          } else {
            HttpUtil.hideLoadingProgress(context, showDialog);
            ToastUtil.toast("网络错误！");
            return HttpResponse(false);
          }
        } on DioError catch (e) {
          HttpUtil.hideLoadingProgress(context, showDialog);
          if (e != null &&
              (e.type == DioErrorType.CONNECT_TIMEOUT ||
                  e.type == DioErrorType.RECEIVE_TIMEOUT ||
                  e.type == DioErrorType.SEND_TIMEOUT)) {
            ToastUtil.toast('网络连接超时');
          } else {
            ToastUtil.toast("网络连接错误，请检查网络！");
          }
          return HttpResponse(false);
        } catch (e) {
          HttpUtil.hideLoadingProgress(context, showDialog);
          ToastUtil.toast("网络错误！");
          return HttpResponse(false);
        }
      }
    } else {
      ToastUtil.toast("上传图片错误，请重试！");
    }
  }

  static Future<HttpResponse> sendImage(
      BuildContext context, String user_id, String cs_id, File file,
      {bool showDialog: true, bool initState: false}) async {
    if (file != null && file.lengthSync() != 0) {
      if (!CommonUtil.checkImageType(file)) {
        ToastUtil.toast("图片格式错误");
        return HttpResponse(false);
      } else {
        HttpUtil.showLoadingProgress(context, showDialog, initState);
        if (_dio == null) {
          _dio = Dio();
          _dio.options.baseUrl = Urls.base;
          _dio.options.connectTimeout = 10000;
          _dio.options.receiveTimeout = 20000;
          HttpUtil.addInterceptor(_dio);
        }
        try {
          FormData formData = new FormData.fromMap({
            "image": await MultipartFile.fromFile(
              file.path,
              filename: file.path.substring(file.path.lastIndexOf("/") + 1),
            ),
            'cs_id': cs_id,
            'user_id': user_id,
            'chat_type': '2',
            'sender': '2'
          });
          Response response = await _dio.post(Urls.sendImage, data: formData);
          if (response.statusCode == 200) {
            var datas = json.decode(response.data);
            String code = datas['code'];
            if (code != null && code == '200') {
              HttpUtil.hideLoadingProgress(context, showDialog);
              return HttpResponse(true, code, datas["message"], datas["data"]);
            }
          } else {
            HttpUtil.hideLoadingProgress(context, showDialog);
            ToastUtil.toast("网络错误！");
            return HttpResponse(false);
          }
        } on DioError catch (e) {
          HttpUtil.hideLoadingProgress(context, showDialog);
          if (e != null &&
              (e.type == DioErrorType.CONNECT_TIMEOUT ||
                  e.type == DioErrorType.RECEIVE_TIMEOUT ||
                  e.type == DioErrorType.SEND_TIMEOUT)) {
            ToastUtil.toast('网络连接超时');
          } else {
            ToastUtil.toast("网络连接错误，请检查网络！");
          }
          return HttpResponse(false);
        } catch (e) {
          HttpUtil.hideLoadingProgress(context, showDialog);
          ToastUtil.toast("网络错误！");
          return HttpResponse(false);
        }
      }
    } else {
      ToastUtil.toast("上传图片错误，请重试！");
    }
  }

  //上传视频
  static Future<HttpResponse> uploadvideo(
    BuildContext context,
    File file, {
    bool showDialog: true,
    bool initState: false,
  }) async {
    HttpUtil.showLoadingProgress(context, showDialog, initState);
    if (_dio == null) {
      _dio = Dio();
      _dio.options.baseUrl = Urls.base;
      _dio.options.connectTimeout = 10000;
      _dio.options.receiveTimeout = 20000;
      HttpUtil.addInterceptor(_dio);
    }
    try {
      FormData formData = new FormData.fromMap({
        "video": await MultipartFile.fromFile(
          file.path,
          filename: file.path.substring(file.path.lastIndexOf("/") + 1),
        ),
      });
      Response response = await _dio.post(
        Urls.uploadPhoto,
        data: formData,
      );
      if (response.statusCode == 200) {
        HttpUtil.hideLoadingProgress(context, showDialog);
        return HttpResponse(true, response.data["data"]);
      } else {
        HttpUtil.hideLoadingProgress(context, showDialog);
        ToastUtil.toast("网络错误！");
        return HttpResponse(false);
      }
    } on DioError catch (e) {
      HttpUtil.hideLoadingProgress(context, showDialog);
      if (e != null &&
          (e.type == DioErrorType.CONNECT_TIMEOUT ||
              e.type == DioErrorType.RECEIVE_TIMEOUT ||
              e.type == DioErrorType.SEND_TIMEOUT)) {
        ToastUtil.toast('网络连接超时');
      } else {
        ToastUtil.toast("网络连接错误，请检查网络！");
      }
      return HttpResponse(false);
    } catch (e) {
      HttpUtil.hideLoadingProgress(context, showDialog);
      ToastUtil.toast("网络错误！");
      return HttpResponse(false);
    }
  }
}
