import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CZAppThemeConfig {
  //设置不允许字体放大
  static const double textScaleFactor = 1.0;

  //不允许字体跟随系统变化
  static Widget fixedTextScale(
      {required BuildContext context, required Widget child}) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: textScaleFactor),
        child: child);
  }

  //设置App支持的屏幕方向
  static const List<DeviceOrientation> supportOrientations = [
    DeviceOrientation.portraitUp
  ];

  //runApp 之前调用
  static void setupDevice() {
    //设置屏幕的方向
    SystemChrome.setPreferredOrientations(supportOrientations);
  }

  //[AppBar.title] 和 [AlertDialog.title]）等字体样式
  static const TextStyle titleLarge =
  TextStyle(fontSize: 18.0, color: Colors.white);

  //用于列表中的主要文本（例如，[ListTile.title]）。
  static const TextStyle titleMedium =
  TextStyle(fontSize: 13.0, color: Colors.black);

  // [Material]的默认文本样式。
  static const TextStyle defaultStyle =
  TextStyle(fontSize: 12.0, color: Colors.grey);

  // 用于 [ElevatedButton]、[TextButton] 和 [OutlinedButton] 上的文本。
  static const TextStyle buttonStyle =
  TextStyle(fontSize: 12.0, color: Colors.blue);

  //用于 [showDatePicker] 显示的对话框中的日期。
  static const TextStyle pickerStyle =
  TextStyle(fontSize: 10.0, color: Colors.blue);

  //字体
  static const String fontFamily = '';

  //AppBar标题颜色
  static const Color appBarTitleColor = Colors.white;

  //主题颜色
  static const Color primaryColor =  Color(0xFF32C16B);

  //按钮颜色
  static const Color btnColor =  Color(0xFF14CF87);
  //AppBar背景颜色
  static Color appBarBgColor = primaryColor;

  //Scaffold背景颜色
  static const Color scaffoldBgColor = Colors.white;

  static const Color dialogBgColor = Colors.white;

  //可滚动组件的背景颜色
  static const Color scrollBgColor = Colors.white;

  //页面跳转样式
  static const PageTransitionsTheme pageTransitionsTheme =
  PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
  });

  //ThemeData
  static final ThemeData themeData = ThemeData(
      // useMaterial3: true,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryColor,
      ),
      brightness: Brightness.light,
      pageTransitionsTheme: pageTransitionsTheme,
      fontFamily: fontFamily,
      primaryColor: primaryColor,
      primaryColorLight: Color.fromRGBO(245, 245, 245, 1),
      textTheme: const TextTheme(
        displayMedium: pickerStyle,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        bodyMedium: defaultStyle,
        labelLarge: buttonStyle,
      ),
      scaffoldBackgroundColor: scaffoldBgColor,
      dialogBackgroundColor: dialogBgColor,
      colorScheme: const ColorScheme.light().copyWith(
        primary: Colors.white,
        background: scrollBgColor,
      ),
      //去掉水波纹
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      appBarTheme: AppBarTheme(
          elevation: 1,
          titleTextStyle: titleLarge,
          backgroundColor: appBarBgColor),
      tabBarTheme: const TabBarTheme(
          labelColor: Colors.red,
          labelStyle: TextStyle(fontSize: 20),
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: TextStyle(fontSize: 20),
          indicatorSize: TabBarIndicatorSize.label),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 1,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          showSelectedLabels: true,
          showUnselectedLabels: true),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ))),
      dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      //以下是可选的
      textButtonTheme: const TextButtonThemeData(),
      elevatedButtonTheme: const ElevatedButtonThemeData(),
      outlinedButtonTheme: const OutlinedButtonThemeData());
}