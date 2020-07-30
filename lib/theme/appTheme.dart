import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getAppTheme(bool isDarkMode) {
    return ThemeData(
        platform: TargetPlatform.iOS, // 该属性可使页面右划返回
        backgroundColor: isDarkMode ? Colors.grey[700] : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: isDarkMode ? Colors.grey[900] : Color(0xffFAF7FA),
        // // Tab指示器颜色
        // indicatorColor: isDarkMode ? Colors.yellow : Colors.yellow,
        // iconTheme: IconThemeData(
        //   color: isDarkMode ? Colors.white : Colors.black,
        // ),
        // bottomAppBarTheme: BottomAppBarTheme(
        //   color: isDarkMode ? Colors.black : Colors.white,
        // ),
        appBarTheme: AppBarTheme(
          color: isDarkMode ? Colors.black : Colors.white,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
          textTheme: TextTheme(
            title: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          iconTheme: IconThemeData(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ));
  }
}
// class ThemeData(
//       errorColor: isDarkMode ? Colours.dark_red : Colours.red,
//       brightness: isDarkMode ? Brightness.dark : Brightness.light,
//       primaryColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
//       accentColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
//       // Tab指示器颜色
//       indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
//       // 页面背景色
//       scaffoldBackgroundColor: isDarkMode ? Colours.dark_bg_color : Colors.white,
//       // 主要用于Material背景色
//       canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
//       // 文字选择色（输入框复制粘贴菜单）
//       textSelectionColor: Colours.app_main.withAlpha(70),
//       textSelectionHandleColor: Colours.app_main,
//       textTheme: TextTheme(
//         // TextField输入文字颜色
//         subhead: isDarkMode ? TextStyles.textDark : TextStyles.text,
//         // Text默认文字样式
//         body1: isDarkMode ? TextStyles.textDark : TextStyles.text,
//         // 这里用于小文字样式
//         subtitle: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
//       ),
//       appBarTheme: AppBarTheme(
//         elevation: 0.0,
//         color: isDarkMode ? Colours.dark_bg_color : Colors.white,
//         brightness: isDarkMode ? Brightness.dark : Brightness.light,
//       ),
//       dividerTheme: DividerThemeData(
//         color: isDarkMode ? Colours.dark_line : Colours.line,
//         space: 0.6,
//         thickness: 0.6
//       )
//     );
