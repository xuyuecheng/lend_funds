import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/webview/permission_webview_page.dart';
import 'package:lend_funds/utils/const/translate.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/route/route_config.dart';
import 'package:lend_funds/utils/storage/storage_utils.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 168.h),
          Center(
            child: Image.asset('assets/main/main_launch_logo.png',
                width: 142.w, height: 134.w),
          ),
          SizedBox(height: 22.h),
          Center(
            child: Text("Sahayak Cash",
                style: TextStyle(
                    fontSize: 30.sp,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w700)),
          ),
          SizedBox(height: 30.h),
          Center(
            child: Text("A lending app used by more than 10,000 people",
                style: TextStyle(
                    fontSize: 12.5.sp,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  void _onInit() async {
    bool installProtol = await CZStorage.getAgreePermission();
    if (installProtol == false) {
      Get.off(() => PermissionWebviewPage(
            title: Translate.permission,
            url: AppConfig.privacyStatementURL,
          ));
    } else {
      //
      if (CZStorage.getUserInfo() != null) {
        Get.offNamed(CZRouteConfig.initialRoute);
      } else {
        Get.offNamed(CZRouteConfig.initialRouteLogin);
      }
    }
  }
}
