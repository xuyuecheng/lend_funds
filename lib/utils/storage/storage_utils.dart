import 'package:get_storage/get_storage.dart';

class CZStorage {
  static const String userInfoKey = 'UserInfo';
  static const String agreeInstallKey = "agreeInstallKey"; //
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
}
