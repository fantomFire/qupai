import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarColor extends StatelessWidget {
  final Widget child;
  final bool dark;

  const AppBarColor({Key key, this.dark: true, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      child: child,
    );
  }
}
