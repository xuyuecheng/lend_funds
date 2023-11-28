// import 'package:financial_app/pages/credit/views/credit.dart';
// import 'package:financial_app/pages/mine/views/mine.dart';
// import 'package:financial_app/pages/mine/views/mine_message_main.dart';
// import 'package:financial_app/pages/webview/webview_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/expection_pages/unknown_route.dart';
import 'package:lend_funds/pages/login/view/login_page.dart';
import 'package:lend_funds/pages/login/view/validate_code_page.dart';
import 'package:lend_funds/pages/main/views/main.dart';
import 'package:lend_funds/pages/main/views/splash.dart';
import 'package:lend_funds/pages/order/view/order_page.dart';
import 'package:lend_funds/pages/webview/webview_utils.dart';

// import '../../pages/credit/views/credit_alive_error.dart';
// import '../../pages/credit/views/credit_base_info.dart';
// import '../../pages/credit/views/credit_contacts.dart';
// import '../../pages/credit/views/credit_ktp.dart';
// import '../../pages/credit/views/credit_loan_verify.dart';
// import '../../pages/credit/views/credit_quota_assessment.dart';
// import '../../pages/credit/views/credit_repayment_plan.dart';
// import '../../pages/expection_pages/unknown_route.dart';
// import '../../pages/home/views/home.dart';
// import '../../pages/login/views/login.dart';
// import '../../pages/login/views/login_code.dart';
// import '../../pages/main/views/main.dart';
// import '../../pages/mine/views/mine_about_us.dart';
// import '../../pages/mine/views/mine_bank.dart';
// import '../../pages/mine/views/mine_faq.dart';
// import '../../pages/mine/views/mine_order.dart';
// import '../../pages/mine/views/mine_setting.dart';
// import '../../pages/repay/views/repay.dart';
// import '../../pages/repay/views/repay_order_detail.dart';
// import '../../pages/repay/views/repay_plan.dart';

class CZRouteConfig {
  //Main
  static const main = '/';
  static const splash = '/splash';
  //Home
  static const home = '/home';
  static const credit = '/home/credit';
  static const creditBaseInfo = '/home/credit/baseInfo';
  static const ktp = '/home/credit/ktp';
  static const contacts = '/home/credit/contacts';
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
    // GetPage(name: home, page: () => const CZHomePage()),
    // GetPage(name: mine, page: () => const CZMinePage()),
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: loginCode, page: () => const ValidateCodePage()),
    // GetPage(name: credit, page: () => const CZCreditPage()),
    // GetPage(name: creditBaseInfo, page: () => const CZCreditBaseInfoPage()),
    // GetPage(name: ktp, page: () => const CZKtpPage()),
    // GetPage(name: contacts, page: () => const CZContactsPage()),
    // GetPage(name: aliveError, page: () => const CZAliveErrorPage()),
    // GetPage(name: quotaAssessment, page: () => const CZQuotaAssessmentPage()),
    // GetPage(name: loanVerify, page: () => const CZCreditLoanVerifyPage()),
    // GetPage(
    //     name: repaymentPlant, page: () => const CZCreditRepaymentPlanPage()),
    // GetPage(name: mineBank, page: () => const BankPage()),
    // GetPage(name: mineOrder, page: () => const OrderPage()),
    // GetPage(name: mineMessage, page: () => const MineMessageMain()),
    // GetPage(name: mineFaq, page: () => const FaqPage()),
    // GetPage(name: mineAboutUs, page: () => const AboutUsPage()),
    // GetPage(name: mineSetting, page: () => const SettingPage()),
    GetPage(name: order, page: () => const OrderPage()),
    // GetPage(name: repayPlan, page: () => const CZRepayPlanPage()),
    // GetPage(name: repayDetail, page: () => const CZRepayOrderDetailPage()),
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
