import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sahayak_cash/pages/webview/webview.dart';
import 'package:sahayak_cash/utils/const/translate.dart';
import 'package:sahayak_cash/utils/network/dio_config.dart';

class PrivacyAgreement extends StatelessWidget {
  const PrivacyAgreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.to(() => WebView(
              title: Translate.privacyStatement,
              url: AppConfig.privacyStatementURL,
            ));
      },
      child: Text("Privacy Policy",
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 12.sp,
              color: const Color(0xFF00A651),
              fontWeight: FontWeight.normal)),
    );
  }
}
