import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/login/controllers/login_controller.dart';
import 'package:lend_funds/utils/route/route_config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();
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
        body: SingleChildScrollView(
          // reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 93.h,
              ),
              Center(
                child: Image.asset('assets/login/lend_funds_logo.png',
                    width: 143.w, height: 100.w),
              ),
              SizedBox(
                height: 13.5.h,
              ),
              Center(
                child: Text("Please sign in",
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: const Color(0xFF00BF9C),
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                height: 66.h,
              ),
              Center(
                child: Text("Your phone number",
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: const Color(0xFF003C6A),
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                height: 27.h,
              ),
              Container(
                width: 1.sw,
                height: 47.h,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Text("  +91-",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w500)),
                    Expanded(
                        child: TextFormField(
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: "",
                        hintStyle: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                        // 未获得焦点下划线设为透明色
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        //获得焦点下划线设为透明色
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                width: 1.sw,
                height: 1.5.h,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Container(
                  color: const Color(0xFF003C6A),
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
                      LoginController.to.phoneStr = _phoneController.text;
                      Get.toNamed(CZRouteConfig.loginCode);
                      return;
                      LoginController.to.sendPhoneCode(params: {
                        'phone': _phoneController.text,
                        "phoneCode": "+91"
                      }).then((value) {
                        Get.toNamed(CZRouteConfig.loginCode);
                      }).catchError((e) {});
                    },
                    child: Text("Next step",
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
}
