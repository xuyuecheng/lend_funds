import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/expection_pages/unknown_route.dart';
import 'package:lend_funds/pages/home/view/home_page.dart';
import 'package:lend_funds/pages/login/view/login_new_page.dart';
import 'package:lend_funds/pages/main/views/main.dart';
import 'package:lend_funds/pages/main/views/splash.dart';

class CZRouteConfig {
  //Main
  static const main = '/';
  static const splash = '/splash';
  //Home
  static const home = '/home';

  //login
  static const login = '/login';

  //Unknown
  static const unknown = '/unknown';

  static const String initialRoute = main;
  static const String initialRouteLogin = login;
  static const String initialRouteSplash = splash;

  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const Splash()),
    GetPage(name: main, page: () => const MainPage()),
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: login, page: () => const LoginNewPage()),
  ];

  static final GetPage onUnknownRoute =
      GetPage(name: unknown, page: () => const CZUnknownRoutePage());

  static RouteFactory generateRoute = (RouteSettings settings) {};
}
