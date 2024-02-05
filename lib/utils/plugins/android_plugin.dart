import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FinancialPlugin {
  static MethodChannel platform =
      const MethodChannel("lend_funds_plugin"); //__xor__
  var gaid = "";
  var aid = "";
  Future<String> getGoogleGaId() async {
    try {
      if (gaid.isEmpty) {
        gaid = await platform.invokeMethod('getGoogleGaId');
      }
      return gaid;
    } on PlatformException catch (e) {
      return 'Error: $e';
    }
  }

  Future<String> getAndroidId() async {
    try {
      if (aid.isEmpty) {
        aid = await platform.invokeMethod('getAnId');
      }
      return aid;
    } on PlatformException catch (e) {
      return 'Error: $e';
    }
  }

  static Future<String> getGoogleToken() async {
    try {
      String? token = await platform.invokeMethod('firebaseToken');
      return token ?? "";
    } on PlatformException catch (e) {
      return 'Error: $e';
    }
  }

  static Future<String> getGoogleInstanceId() async {
    try {
      String InstanceId = await platform.invokeMethod('googleInstanceId');
      return InstanceId;
    } on PlatformException catch (e) {
      return 'Error: $e';
    }
  }

  static Future<dynamic> getInstallReferrer() async {
    try {
      var param = await platform.invokeMethod('installReferrer');
      return param;
    } on PlatformException catch (e) {
      return 'Error: $e';
    }
  }

  Future<Map> liveness() async {
    final result = await platform.invokeMethod('liveness'); //活体
    if (kDebugMode) {
      print("invokeMethod.liveness:${result.toString()}");
      //{status: 0, livenessId: eb7d7444-5c97-465b-aa43-b255554913a0}
    }
    return result;
  }

  Future initLiveness(String key, String value, String appName) async {
    try {
      await platform.invokeMethod('initLiveness',
          {"key": key, "value": value, "appName": appName}); //活体
    } on PlatformException catch (e) {
      return 'Error: $e';
    }
  }

  Future requestAllPermission() async {
    try {
      return await platform
          .invokeMethod('requestAllPermission'); //请求各种权限 返回true|false
    } catch (e) {
      return false;
    }
  }

  Future requestPermission() async {
    try {
      return await platform
          .invokeMethod('requestPermissions'); //请求各种权限 返回true|false
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> getDeviceInfo() async {
    final result = await platform.invokeMethod('getDeviceInfo'); //上报的设备信息
    // if (kDebugMode) {
    //   log("getDeviceInfo123456:${result.toString()}");
    // }
    return result;
  }

  Future<dynamic> getAppList() async {
    final result = await platform.invokeMethod('getAppList'); //已安装的app列表
    if (kDebugMode) {
      print("getAppList:${result.toString()}");
    }
    return result;
  }

  Future<List> getSmsList() async {
    final result = await platform.invokeMethod('getSmsList'); //短信列表
    return result;
  }

  getContacts() async {
    await platform.invokeMethod('getContacts');
  }
}
