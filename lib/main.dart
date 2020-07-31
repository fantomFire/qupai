import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart'as gs;
import 'package:oktoast/oktoast.dart';
import 'package:qupai/pages/mainPage.dart';
import 'package:qupai/routs.dart';
import 'package:qupai/theme/appTheme.dart';
import 'package:qupai/utils/bloc/bloc_provider.dart';
import 'package:qupai/utils/bloc/dart_bloc.dart';
import 'package:qupai/values/baseColor.dart';
import 'common_views/maxscaletextwidget.dart';

//main
void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = BaseColor.color_bg_dialog
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.transparent
    ..textColor = BaseColor.color_333333
    ..indicatorColor = BaseColor.color_3E7FFF
    ..progressColor = BaseColor.color_ffffff
    ..indicatorSize = 60;
  bool isDark =
  WidgetsBinding.instance.window.platformBrightness == Brightness.dark
      ? true
      : false;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(OKToast(
        position: ToastPosition.bottom,
        dismissOtherOnShow: true,
        child: BlocProvider(
          bloc: DartBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '趣拍',
            theme: AppTheme.getAppTheme(isDark),
            darkTheme: AppTheme.getAppTheme(isDark),
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
     /*       theme: new ThemeData(
              platform: defaultTargetPlatform == TargetPlatform.iOS
                  ? TargetPlatform.iOS
                  : TargetPlatform.android,
            ),*/
            home: MainPage(),
            // 国际化支持
            localizationsDelegates: [
              gs.GlobalMaterialLocalizations.delegate,
              gs.GlobalWidgetsLocalizations.delegate,
            ],
            locale: const Locale('zh', 'CH'),
            supportedLocales: [const Locale('zh', 'CH'), const Locale('en', 'US')],
            routes: routes(),
            builder: (ctx, w) {
              return MaxScaleTextWidget(max: 1.0, child: w);
            },
          ),
        )));
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ));
    }
  });
}