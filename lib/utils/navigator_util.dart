import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtil {
  static Future<T> pushNamed<T extends Object>(BuildContext context, String routeName, {Object arguments}) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T> pushReplacementNamed<T extends Object, TO extends Object>(BuildContext context, String routeName, {TO result, Object arguments}) {
    return Navigator.of(context).pushReplacementNamed<T, TO>(routeName, arguments: arguments, result: result);
  }

  static void popUntil(BuildContext context, String name) {
    if (context != null) {
      Navigator.popUntil(context, ModalRoute.withName(name));
    }
  }

  static Future<T> pushNamedAndRemoveUntil<T extends Object>(BuildContext context, String name, String untilName, { Object arguments}) {
    return Navigator.pushNamedAndRemoveUntil(context, name, ModalRoute.withName(name),arguments: arguments);
  }

  static void pop<T extends Object>(BuildContext context, [T result]) {
    if (context != null) {
       Navigator.of(context).pop<T>(result);
    }

  }
}
