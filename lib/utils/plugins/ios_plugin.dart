import 'dart:io';

import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CZDeviceUtils {
  //自己封装的方法
  static const platform = MethodChannel("com.rupee.rain/device");
  static Map _deviceInfo = {};
  static getCZDeviceInfo() async {
    if (_deviceInfo.keys.isNotEmpty) {
      return _deviceInfo;
    }
    _deviceInfo = await platform.invokeMethod("getDeviceInfo");
    return _deviceInfo;
  }

  static jumpContacts() {
    platform.invokeMethod("jumpContacts");
  }

}

class CZPackageUtils {
 static PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

 static getPackageInfo() async {
    if (_packageInfo.appName.contains('Unknown')) {
      _packageInfo = await PackageInfo.fromPlatform();
    }
    return _packageInfo;
  }


}