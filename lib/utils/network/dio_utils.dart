import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as Encrypt;
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../plugins/android_plugin.dart';
import '../plugins/ios_plugin.dart';
import '../storage/storage_utils.dart';
import 'dio_config.dart';

class DioUtils {
  static getPlatform() {
    if (Platform.isIOS) {
      return 'IOS';
    } else {
      return 'Android';
    }
  }

  static getToken() async {
    PackageInfo packageInfo = await CZPackageUtils.getPackageInfo();
    String gaid = '';
    String aid = '';
    if (Platform.isIOS) {
      // Map deviceInfo = await CZDeviceUtils.getCZDeviceInfo();
      // gaid = deviceInfo['GAID'];
      // aid = deviceInfo['AID'];
      gaid = await CZDeviceUtils().getIdfa();
      if (kDebugMode) {
        print("gaid:$gaid");
      }
      aid = await CZDeviceUtils().getIdfv();
    } else {
      gaid = await FinancialPlugin().getGoogleGaId();
      if (kDebugMode) {
        print("getGoogleGaId:$gaid");
      }
      aid = await FinancialPlugin().getAndroidId();
    }

    Map<String, dynamic> tokenHeaders = {
      'RV': packageInfo.packageName,
      'VERSION': packageInfo.version,
      'GAID': gaid,
      'AID': aid,
    };
    if (kDebugMode) {
      // log("请求头tokenHeaders:$tokenHeaders");
    }
    dynamic user = CZStorage.getUserInfo();
    if (user != null) {
      tokenHeaders['Auth'] = user['user']['token'];
    }
    if (kDebugMode) {
      log("请求头tokenHeaders:$tokenHeaders");
    }
    var tokenStr = json.encode(tokenHeaders);
    var encryptToken = await _aesEncrypt(tokenStr);
    return '${AppConfig.appId}${encryptToken}';
  }

  static getEncryptParams(Map<dynamic, dynamic> params) async {
    var paramsStr = json.encode(params);
    var encryptParams = await _aesEncrypt(paramsStr);
    return encryptParams;
  }

  static Future responseDecrypt(String raw) async {
    if (raw.contains("\"")) {
      raw = raw.replaceAll("\"", "");
    }
    var result = await _aesDecrypt(raw);
    var resultParams = json.decode(result);
    return resultParams;
  }

  static Future _aesEncrypt(String raw) async {
    final key = Encrypt.Key.fromUtf8(AppConfig.AESKey);
    final iv = Encrypt.IV.fromLength(0);
    final encrypter =
        Encrypt.Encrypter(Encrypt.AES(key, mode: Encrypt.AESMode.ecb));
    final encrypted = encrypter.encrypt(raw, iv: iv);
    return encrypted.base16.toUpperCase();
  }

  static Future _aesDecrypt(String encrypt) async {
    try {
      final key = Encrypt.Key.fromUtf8(AppConfig.AESKey);
      final iv = Encrypt.IV.fromLength(0);
      final encrypter =
          Encrypt.Encrypter(Encrypt.AES(key, mode: Encrypt.AESMode.ecb));
      final decrypted =
          encrypter.decrypt(Encrypt.Encrypted.fromBase16(encrypt), iv: iv);
      return decrypted;
    } catch (e) {
      return encrypt;
    }
  }

  static String md5Crypto(String str) {
    var bytes = utf8.encode(str);
    final dig = md5.convert(bytes);
    var keyStr = dig.toString();
    return keyStr.toLowerCase();
  }
}
