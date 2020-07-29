import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart'as gs;
import 'package:oktoast/oktoast.dart';
import 'package:qupai/pages/mainPage.dart';
import 'package:qupai/routs.dart';
import 'package:qupai/utils/bloc/bloc_provider.dart';
import 'package:qupai/utils/bloc/dart_bloc.dart';
import 'common_views/maxscaletextwidget.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
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
            theme: new ThemeData(
              platform: defaultTargetPlatform == TargetPlatform.iOS
                  ? TargetPlatform.iOS
                  : TargetPlatform.android,
            ),
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
        statusBarColor: Colors.white,
      ));
    }
  });
}