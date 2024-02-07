import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/main/views/widget/agree_install_dialog.dart';
import 'package:lend_funds/utils/route/route_config.dart';
import 'package:lend_funds/utils/storage/storage_utils.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 271.h),
          Center(
            child: Image.asset('assets/main/main_launch_logo.png',
                width: 237.w, height: 166.w),
          ),
          SizedBox(height: 5.h),
          Center(
            child: Text("Lend Funds",
                style: TextStyle(
                    fontSize: 36.sp,
                    color: const Color(0xFF003C6A),
                    fontWeight: FontWeight.w500)),
          ),
          Center(
            child: Text("Your personal ATM",
                style: TextStyle(
                    fontSize: 20.sp,
                    color: const Color(0xFF003C6A),
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  void _onInit() async {
    bool installProtol = await CZStorage.getAgreeInstall();
    if (installProtol == false) {
      CZDialogUtil.show(AgreeInstallDialog(agreeBlock: () {
        CZDialogUtil.dismiss();
        CZStorage.saveAgreeInstall(true);
        Get.offNamed(CZRouteConfig.initialRouteLogin);
      }, rejectBlock: () {
        CZDialogUtil.dismiss();
        exit(0);
      }));
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
