import 'package:get_storage/get_storage.dart';

class CZStorage {
  static const String userInfoKey = 'UserInfo';
  static const String agreePrivateProtocolKey = 'AgreePrivateProtocol';
  static const String date = 'date';
  static const String appUpdateVersion = 'AppUpdateVersion';
  static const String firstTimeLaunch = "FirstTimeLaunch";
  static const String permissionDate = 'permissionDate';
  static const String agreeInstallKey = "agreeInstallKey"; //同意安装协议
  static final GetStorage storageBox = GetStorage('lend_funds');

  static read(String key) {
    return storageBox.read(key);
  }

  static write(String key, dynamic value) async {
    storageBox.write(key, value);
  }

  static remove(String key) {
    if (storageBox.hasData(key)) {
      storageBox.remove(key);
    }
  }

  static saveDate(dynamic value) {
    write(date, value);
  }

  static getDate(dynamic value) {
    return value == read(date);
  }

  static savePermissionDate(dynamic value) {
    write(permissionDate, value);
  }

  static getPermissionDate(dynamic value) {
    return value == read(permissionDate);
  }

  static saveAgreeInstall(bool value) {
    write(agreeInstallKey, value);
  }

  static bool getAgreeInstall() {
    if (storageBox.hasData(agreeInstallKey)) {
      return read(agreeInstallKey);
    }
    return false;
  }

  static saveUserInfo(dynamic value) {
    write(userInfoKey, value);
  }

  static dynamic getUserInfo() {
    return read(userInfoKey);
  }

  static removeUserInfo() {
    remove(userInfoKey);
  }

  static saveAgreePrivateProtocol(bool value) {
    write(agreePrivateProtocolKey, value);
  }

  static bool getAgreePrivateProtocol() {
    if (storageBox.hasData(agreePrivateProtocolKey)) {
      return read(agreePrivateProtocolKey);
    }
    return false;
  }

  static saveAppUpdateVersion(dynamic value) {
    write(appUpdateVersion, value);
  }

  static dynamic getAppUpdateVersion() {
    return read(appUpdateVersion);
  }

  static saveFirstTimeLaunch(dynamic value) {
    write(firstTimeLaunch, value);
  }

  static dynamic getFirstTimeLaunch() {
    return read(firstTimeLaunch);
  }

  static removeFirstTimeLaunch() {
    remove(firstTimeLaunch);
  }
}
