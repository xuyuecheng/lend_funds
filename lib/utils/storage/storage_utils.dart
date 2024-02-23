import 'package:get_storage/get_storage.dart';

class CZStorage {
  static const String userInfoKey = 'UserInfo';
  static const String agreePermissionKey = "agreePermissionKey"; //
  static final GetStorage storageBox = GetStorage('sahayak_cash');

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

  static saveAgreePermission(bool value) {
    write(agreePermissionKey, value);
  }

  static bool getAgreePermission() {
    if (storageBox.hasData(agreePermissionKey)) {
      return read(agreePermissionKey);
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
