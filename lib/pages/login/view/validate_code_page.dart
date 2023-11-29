import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/login/controllers/login_controller.dart';
import 'package:lend_funds/pages/login/view/widget/custom_verification_box.dart';
import 'package:lend_funds/utils/route/route_config.dart';

class ValidateCodePage extends StatefulWidget {
  const ValidateCodePage({Key? key}) : super(key: key);

  @override
  State<ValidateCodePage> createState() => _ValidateCodePageState();
}

class _ValidateCodePageState extends State<ValidateCodePage> {
  Timer? _timer;
  var _countdownTime = 0;
  @override
  void initState() {
    super.initState();
    //...
    startCountdown();
  }

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
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              }),
          title: Text(
            'Login',
            style: TextStyle(
                fontSize: 17.5.sp,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          // reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 47.h),
              Center(
                child: Image.asset('assets/login/lend_funds_logo.png',
                    width: 143.w, height: 100.w),
              ),
              SizedBox(
                height: 27.5.h,
              ),
              Center(
                child: Text(
                    "Verification code has been sent to ${LoginController.to.phoneStr},\n enter the 6-digit verification code",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.5.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.normal)),
              ),
              SizedBox(
                height: 30.h,
              ),
              _createCodeView(),
              SizedBox(
                height: 13.5.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: _btnPress,
                      child: Text(_handleCodeAutoSizeText(),
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xFF00BF9C),
                              fontWeight: FontWeight.normal)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Container(
                width: 1.sw,
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFF003C6A),
                      borderRadius: BorderRadius.circular(10.w)),
                  child: TextButton(
                    onPressed: () {
                      Get.offAllNamed(CZRouteConfig.home);
                    },
                    child: Text("Login",
                        style: TextStyle(
                            fontSize: 26.sp,
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _createCodeView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: SizedBox(
        height: 40.w,
        child: CZVerificationBox(
          showCursor: true,
          onSubmitted: _sendSubmitted,
          itemHeight: 40.w,
          itemWidth: 40.w,
          borderColor: const Color(0xFF9A9A9A),
          focusBorderColor: const Color(0xFF20A472),
          textStyle: TextStyle(fontSize: 24.sp, color: const Color(0xFF2E2E2E)),
        ),
      ),
    );
  }

  void _sendSubmitted(value) {
    debugPrint("value111:$value");
    // CZLoginController.to.requestUserLogin(
    //     params: {'phone': _phone, 'code': value}).then((value) {
    //   CZStorage.saveUserInfo(value);
    //   Get.offAllNamed(CZRouteConfig.main);
    //   RequestUtil.addDot(AddDotLoginConfig.loginSucess);
    // }, onError: (err) {
    //   RequestUtil.addDot(AddDotLoginConfig.loginError);
    // });
  }

  _sendCode() {
    //开始倒计时
    startCountdown();
    // if (_isSmsCode) {
    //   CZLoginController.to
    //       .sendPhoneCode(params: {'phone': _phone}).then((value) {
    //     if (value['status'] != null && value['status'] == 0) {
    //       //开始倒计时
    //       startCountdown();
    //     }
    //   }).catchError((e) {});
    // } else {
    //   CZLoginController.to
    //       .sendVotpCode(params: {'phone': _phone}).then((value) {
    //     if (value['status'] != null && value['status'] == 0) {
    //       //开始倒计时
    //       startCountdown();
    //     }
    //   }).catchError((e) {});
    // }
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
      return 'Resend';
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

  //倒计时方法
  startCountdown() {
    //倒计时时间
    _countdownTime = 60;
    _timer ??= Timer.periodic(const Duration(seconds: 1), call);
  }
}
