import 'package:flutter/material.dart';
// import 'package:portal_zp_mobile/src/common/app_constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppModel with ChangeNotifier {
  // String phone = "";
  // String auth = "";
  // bool sign;
  //
  // bool isLogin() {
  //   if (this.phone != null &&
  //       this.phone.length > 0 &&
  //       this.auth != null &&
  //       this.auth.length > 0) {
  //     print("phone:" + phone);
  //     print("auth:" + auth);
  //     return true;
  //   }
  //   return false;
  // }
  //
  // setPhone(String phone) async {
  //   this.phone = phone;
  //   final preferences = await SharedPreferences.getInstance();
  //   preferences.setString(AppConstant.SP_PHONE, phone);
  //   preferences.commit();
  // }

  // setAuth(String auth) async {
  //   this.auth = auth;
  //   final preferences = await SharedPreferences.getInstance();
  //   preferences.setString(AppConstant.SP_AUTH, auth);
  //   preferences.commit();
  // }
  //
  // setSign(bool sign) async {
  //   this.sign = sign;
  //   final preferences = await SharedPreferences.getInstance();
  //   preferences.setBool(AppConstant.SP_SIGN, sign);
  //   preferences.commit();
  // }
  //
  // clear() async {
  //   this.phone = "";
  //   final preferences = await SharedPreferences.getInstance();
  //   preferences.setString(AppConstant.SP_PHONE, "");
  //   preferences.commit();
  // }
  //
  // init() async {
  //   final preferences = await SharedPreferences.getInstance();
  //   if (phone == null || phone.length == 0) {
  //     phone = preferences.getString(AppConstant.SP_PHONE);
  //   }
  //   if (auth == null || auth.length == 0) {
  //     auth = preferences.getString(AppConstant.SP_AUTH);
  //   }
  //   if (sign == null) {
  //     sign = preferences.getBool(AppConstant.SP_SIGN);
  //   }
  // }
}
