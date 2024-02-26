import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sahayak_cash/pages/login/controllers/login_controller.dart';
import 'package:sahayak_cash/pages/webview/webview.dart';
import 'package:sahayak_cash/utils/const/translate.dart';
import 'package:sahayak_cash/utils/network/dio_config.dart';
import 'package:sahayak_cash/utils/route/route_config.dart';
import 'package:sahayak_cash/utils/storage/storage_utils.dart';
import 'package:sahayak_cash/utils/toast/toast_utils.dart';

class LoginNewPage extends StatefulWidget {
  const LoginNewPage({Key? key}) : super(key: key);

  @override
  State<LoginNewPage> createState() => _LoginNewPageState();
}

class _LoginNewPageState extends State<LoginNewPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  bool _switchSelected = true;
  Timer? _timer;
  var _countdownTime = 0;

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    //...
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //...
    Get.put(LoginController());
    _phoneController.addListener(() {
      debugPrint(_phoneController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 96.w,
              left: 7.w,
              right: 7.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sahayak Cash",
                    style: TextStyle(
                        fontSize: 25.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 7.h),
                  Text(
                    "Make your credit more valuable",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xFFB8B8B8),
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 34.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.w, vertical: 0.h),
                    width: 1.sw,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(5.w),
                        border: Border.all(color: Colors.black, width: 0.5.w)),
                    // alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Image.asset('assets/login/login_phone_icon.png',
                            width: 17.w, height: 25.w),
                        SizedBox(width: 9.h),
                        Expanded(
                            child: TextFormField(
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w400),
                          keyboardType: TextInputType.number,
                          controller: _phoneController,
                          decoration: InputDecoration(
                            hintText: "Phone number",
                            hintStyle: TextStyle(
                                fontSize: 13.5.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                            //
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            //
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 13.w, vertical: 0.h),
                        width: 1.sw,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(5.w),
                            border:
                                Border.all(color: Colors.black, width: 0.5.w)),
                        // alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset('assets/login/login_code_icon.png',
                                width: 17.w, height: 25.w),
                            SizedBox(width: 9.h),
                            Expanded(
                                child: TextFormField(
                              style: TextStyle(
                                  fontSize: 13.5.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w400),
                              keyboardType: TextInputType.number,
                              controller: _codeController,
                              decoration: InputDecoration(
                                hintText: "Verification code",
                                hintStyle: TextStyle(
                                    fontSize: 13.5.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                                //
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                //
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ))
                          ],
                        ),
                      )),
                      SizedBox(width: 8.h),
                      Container(
                          width: 81.5.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(5.w),
                              border: Border.all(
                                  color: Colors.black, width: 0.5.w)),
                          alignment: Alignment.center,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              if (_phoneController.text.isEmpty) {
                                CZLoading.toast("please input phone");
                                return;
                              }
                              FocusScope.of(context).unfocus();
                              LoginController.to.sendPhoneCodeRequest(params: {
                                "modelU8mV9A": {
                                  'phonedD1cuP': _phoneController.text,
                                  "countryCodesA4GLm": "+91"
                                }
                              }).then((value) {
                                if (value["statusE8iqlh"] == 0) {
                                  _btnPress();
                                }
                              }).catchError((e) {});
                            },
                            child: Text(
                              _handleCodeAutoSizeText(),
                              style: TextStyle(
                                  fontSize: 19.5.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(height: 30.h),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (_phoneController.text.length == 0) {
                        CZLoading.toast("please input phone");
                        return;
                      }
                      if (_codeController.text.length == 0) {
                        CZLoading.toast("please input code");
                        return;
                      }
                      if (_switchSelected == false) {
                        CZLoading.toast("Please read the agreement");
                        return;
                      }
                      _sendSubmitted(_codeController.text);
                    },
                    child: Container(
                      width: 1.sw,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF00A651),
                            borderRadius: BorderRadius.circular(5.w)),
                        padding: EdgeInsets.symmetric(vertical: 9.5.h),
                        alignment: Alignment.center,
                        child: Text("Log In",
                            style: TextStyle(
                                fontSize: 25.sp,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 19.w,
              left: 7.w,
              right: 7.w,
              child: RichText(
                  // textAlign: TextAlign.center,
                  text: TextSpan(
                style: TextStyle(height: 2),
                children: [
                  WidgetSpan(
                    // alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          _switchSelected = !_switchSelected;
                        });
                      },
                      child: Image.asset(
                          _switchSelected
                              ? "assets/login/login_select_icon.png"
                              : "assets/login/login_noselect_icon.png",
                          width: 15.w,
                          height: 15.w),
                    ),
                  ),
                  TextSpan(
                    text: '  I have read and agreed',
                    style: TextStyle(
                        color: const Color(0xFF000000),
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: '${"《Sahayak Cash's privacy agreement》"}',
                    style: TextStyle(
                        color: const Color(0xFF059226),
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        debugPrint("1");
                        Get.to(() => WebView(
                              title: Translate.privacyStatement,
                              url: AppConfig.privacyStatementURL,
                            ));
                      },
                  ),
                  TextSpan(
                    text: ' & ',
                    style: TextStyle(
                        color: const Color(0xFF000000),
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: '《conditions and terms》',
                    style: TextStyle(
                        color: const Color(0xFF059226),
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        debugPrint("2");
                        Get.to(() => WebView(
                              title: Translate.termsAgreement,
                              url: AppConfig.termsAgreement,
                            ));
                      },
                  ),
                  TextSpan(
                    text:
                        ' The agreement is highlighted, click to view, the agreement is checked by default, and you can click to cancel the check',
                    style: TextStyle(
                        color: const Color(0xFF000000),
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  _sendCode() {
    //
    startCountdown();
  }

  _btnPress() {
    if (_countdownTime == 0) {
      _sendCode();
    }
  }

  String _handleCodeAutoSizeText() {
    if (_countdownTime > 0) {
      return '${_countdownTime}s';
    } else {
      return 'OTP';
    }
  }

  call(timer) {
    if (_countdownTime < 1) {
      if (_timer != null) {
        _timer?.cancel();
        _timer = null;
      }
    } else {
      setState(() {
        _countdownTime -= 1;
      });
    }
  }

  //
  startCountdown() {
    //
    _countdownTime = 60;
    _timer ??= Timer.periodic(const Duration(seconds: 1), call);
  }

  void _sendSubmitted(value) {
    debugPrint("value111:$value");
    LoginController.to.requestUserLogin(params: {
      'phonedD1cuP': _phoneController.text,
      'otpYsMR7y': value,
      "countryCodesA4GLm": "+91"
    }).then((value) {
      if (value["statusE8iqlh"] == 0) {
        CZStorage.saveUserInfo(value);
        Get.offAllNamed(CZRouteConfig.main);
      }
    }, onError: (err) {});
  }
}
