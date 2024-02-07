import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CZAppThemeConfig {
  //
  static const double textScaleFactor = 1.0;

  //
  static Widget fixedTextScale(
      {required BuildContext context, required Widget child}) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: textScaleFactor),
        child: child);
  }

  //
  static const List<DeviceOrientation> supportOrientations = [
    DeviceOrientation.portraitUp
  ];

  //runApp
  static void setupDevice() {
    //
    SystemChrome.setPreferredOrientations(supportOrientations);
  }

  //[AppBar.title]  [AlertDialog.title]）
  static const TextStyle titleLarge =
      TextStyle(fontSize: 18.0, color: Colors.white);

  //（，[ListTile.title]）。
  static const TextStyle titleMedium =
      TextStyle(fontSize: 13.0, color: Colors.black);

  // [Material]
  static const TextStyle defaultStyle =
      TextStyle(fontSize: 12.0, color: Colors.grey);

  //  [ElevatedButton]、[TextButton]  [OutlinedButton] 。
  static const TextStyle buttonStyle =
      TextStyle(fontSize: 12.0, color: Colors.blue);

  // [showDatePicker] 。
  static const TextStyle pickerStyle =
      TextStyle(fontSize: 10.0, color: Colors.blue);

  //
  static const String fontFamily = '';

  //AppBar
  static const Color appBarTitleColor = Colors.white;

  //
  static const Color primaryColor = Color(0xFF32C16B);

  //
  static const Color btnColor = Color(0xFF14CF87);
  //AppBar
  static Color appBarBgColor = primaryColor;

  //Scaffold
  static const Color scaffoldBgColor = Colors.white;

  static const Color dialogBgColor = Colors.white;

  //
  static const Color scrollBgColor = Colors.white;

  //
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
      //
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
      //
      textButtonTheme: const TextButtonThemeData(),
      elevatedButtonTheme: const ElevatedButtonThemeData(),
      outlinedButtonTheme: const OutlinedButtonThemeData());
}
