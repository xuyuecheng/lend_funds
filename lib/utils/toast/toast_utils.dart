

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CZToastConfig {
  static setEasyLoading() {
    EasyLoading.instance

      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..indicatorColor = Colors.white
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 50.0
      ..fontSize = 18.0
      ..backgroundColor = const Color(0xFF7D7D7D)
      ..progressColor = Colors.green
      ..textColor = Colors.white
      ..maskColor = Colors.transparent
      ..userInteractions = true
      ..dismissOnTap = false;
      // ..customAnimation = CustomAnimation();
    //   ..displayDuration = const Duration(milliseconds: 2000)
    //   ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    //   ..loadingStyle = EasyLoadingStyle.dark
    //   ..indicatorSize = 45.0
    //   ..radius = 10.0
    //   // ..backgroundColor = const Color.fromRGBO(136, 214, 185, 1)
    //   // ..maskColor = const Color.fromRGBO(136, 214, 185, 1)
    //   // ..progressColor = const Color.fromRGBO(136, 214, 185, 1)
    //   ..backgroundColor = Colors.transparent
    //   // ..indicatorColor = const Color.fromRGBO(136, 214, 185, 1)
    //   // ..textColor = ColorsCommon.mainColor
    //   ..maskColor = Colors.transparent
    //   ..userInteractions = false
    //   ..maskType = EasyLoadingMaskType.clear
    //   ..dismissOnTap = false;
    // // ..customAnimation = CustomAnimation();
  }

}

class CZLoading {
  static loading({String? status}) {
    EasyLoading.instance
      ..backgroundColor = const Color(0xFF7D7D7D)
      ..contentPadding = const EdgeInsets.all(25)
      ..radius = 8.0;
    EasyLoading.show(status: status);
  }

  static toast(String v) {
    EasyLoading.instance
      ..backgroundColor = const Color(0xFF88D6B9)
      ..radius = 8.0
      ..contentPadding = const EdgeInsets.symmetric(horizontal:25,vertical: 10);
    EasyLoading.showToast(v);
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}

class CZDialogUtil {
  static void show(Widget customView) {
    if (Get.isDialogOpen == true) {
      return;
    }
    Get.dialog(
      customView,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.6),
      barrierDismissible: false,
    );
  }

  static void dismiss() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}