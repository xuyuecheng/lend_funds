import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/plugins/android_plugin.dart';

class MainController extends GetxController {}

class HttpController {
  static Future requestUploadGoogleToken() async {
    if (Platform.isAndroid) {
      String googleToken = await FinancialPlugin.getGoogleToken();
      if (kDebugMode) {
        // print("googleToken:$googleToken");
      }
      if (googleToken.isNotEmpty) {
        Map<String, dynamic> result = await HttpRequest.request(
            InterfaceConfig.report_googleToken,
            params: {"modelU8mV9A": googleToken});
        return result;
      }
    }
  }

  static Future requestUploadGoogleInstanceId() async {
    if (Platform.isAndroid) {
      String googleInstanceId = await FinancialPlugin.getGoogleInstanceId();
      if (kDebugMode) {
        // print("googleInstanceId:$googleInstanceId");
      }
      if (googleInstanceId.isNotEmpty) {
        Map<String, dynamic> result = await HttpRequest.request(
            InterfaceConfig.report_googleInstanceId,
            params: {"modelU8mV9A": googleInstanceId});
        // log("result44444:$result");
        return result;
      }
    }
  }
}
