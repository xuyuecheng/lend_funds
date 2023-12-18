// import 'package:financial_app/pages/credit/views/credit.dart';
// import 'package:financial_app/pages/mine/views/mine.dart';
// import 'package:financial_app/pages/mine/views/mine_message_main.dart';
// import 'package:financial_app/pages/webview/webview_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/expection_pages/unknown_route.dart';
import 'package:lend_funds/pages/home/view/home_page.dart';
import 'package:lend_funds/pages/login/view/login_page.dart';
import 'package:lend_funds/pages/login/view/validate_code_page.dart';
import 'package:lend_funds/pages/main/views/main.dart';
import 'package:lend_funds/pages/main/views/splash.dart';
import 'package:lend_funds/pages/order/view/order_page.dart';
import 'package:lend_funds/pages/webview/webview_utils.dart';

class CZRouteConfig {
  //Main
  static const main = '/';
  static const splash = '/splash';
  //Home
  static const home = '/home';
  // static const livenessDetection = '/home/credit/livenessDetection';

  //order
  static const order = '/order';

  //Mine
  static const mine = '/mine';

  //login
  static const login = '/login';
  static const loginCode = '/login/code';

  //Unknown
  static const unknown = '/unknown';

  //web
  static const webView = '/webView';

  static const String initialRoute = main;
  static const String initialRouteLogin = login;
  static const String initialRouteSplash = splash;

  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const Splash()),
    GetPage(name: main, page: () => const MainPage()),
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: loginCode, page: () => const ValidateCodePage()),
    // GetPage(name: livenessDetection, page: () => const AlivePage()),
    GetPage(name: order, page: () => const OrderPage()),
    GetPage(
        name: webView,
        page: () => CZWebView(
              title: "123",
            )),
  ];

  static final GetPage onUnknownRoute =
      GetPage(name: unknown, page: () => const CZUnknownRoutePage());

  static RouteFactory generateRoute = (RouteSettings settings) {};
}
