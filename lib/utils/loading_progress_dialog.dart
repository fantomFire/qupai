import 'dart:async';

import 'package:flutter/material.dart';

import 'navigator_util.dart';

class LoadingProgress {
  static bool _isShow = false;
  static bool _barrierDismissible;
  static bool _onWillPop;
  static Widget _widget;

  static LoadingProgress get instance => _getInstance();
  static LoadingProgress _instance;

  LoadingProgress._internal();

  static LoadingProgress getInstance({bool barrierDismissible: false, bool onWillPop: false, Widget widget}) {
    _barrierDismissible = barrierDismissible;
    _onWillPop = onWillPop;
    _widget = widget;
    return LoadingProgress.instance;
  }

  static LoadingProgress _getInstance() {
    if (_instance == null) {
      _instance = new LoadingProgress._internal();
    }
    return _instance;
  }

  void show(BuildContext context, [bool initState = false]) {
    if (initState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _show(context);
      });
    } else {
      _show(context);
    }
  }

  void _show(BuildContext context) {
    if (!_isShow) {
      _isShow = true;
      showDialog(
        barrierDismissible: _barrierDismissible,
        context: context,
        builder: (_) => WillPopScope(
            child: Center(
              child: _widget ?? CircularProgressIndicator(),
            ),
            onWillPop: () async {
              if (_barrierDismissible && _onWillPop && _isShow) {
                _isShow = false;
              }
              return Future.value(_onWillPop);
            }),
      );
    }
  }

  void hide(BuildContext context) {
    if (_isShow) {
      _isShow = false;
      NavigatorUtil.pop(context);
    }
  }
}
