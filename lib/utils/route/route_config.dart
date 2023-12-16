// import 'package:financial_app/pages/credit/views/credit.dart';
// import 'package:financial_app/pages/mine/views/mine.dart';
// import 'package:financial_app/pages/mine/views/mine_message_main.dart';
// import 'package:financial_app/pages/webview/webview_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/credit/view/bank_page.dart';
import 'package:lend_funds/pages/credit/view/contact_page.dart';
import 'package:lend_funds/pages/credit/view/liveness_detection_page.dart';
import 'package:lend_funds/pages/credit/view/personal_info_page.dart';
import 'package:lend_funds/pages/credit/view/work_information_page.dart';
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
  static const personalInforma = '/home/personalInforma';
  static const workInforma = '/home/workInforma';
  static const creditBaseInfo = '/home/credit/baseInfo';
  static const ktp = '/home/credit/ktp';
  static const contacts = '/home/credit/contacts';
  static const bank = '/home/credit/bank';
  static const livenessDetection = '/home/credit/livenessDetection';
  static const aliveError = '/home/credit/alive/error';
  static const quotaAssessment = '/home/credit/quotaAssessment';
  static const loanVerify = '/home/credit/loanVerify';
  static const repaymentPlant = '/home/credit/loanVerify/repaymentPlant';

  //order
  static const order = '/order';
  static const repayPlan = '/repay/plan';
  static const repayDetail = '/repay/plan/detail';

  //Mine
  static const mine = '/mine';
  static const mineBank = '/mine/bank';
  static const mineAboutUs = '/mine/aboutUs';
  static const mineFaq = '/mine/faq';
  static const mineSetting = '/mine/setting';
  static const mineOrder = '/mine/order';
  static const mineMessage = '/mine/message';

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
    GetPage(name: personalInforma, page: () => const PersonalInfoPage()),
    GetPage(name: workInforma, page: () => const WorkInformationPage()),
    GetPage(name: contacts, page: () => const ContactPage()),
    GetPage(name: bank, page: () => const BankPage()),
    GetPage(name: livenessDetection, page: () => const LivenessDetectionPage()),
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
