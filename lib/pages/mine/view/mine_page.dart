import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/login/view/login_page.dart';
import 'package:lend_funds/pages/mine/view/widget/custom_mine_item.dart';
import 'package:lend_funds/pages/mine/view/widget/delete_account_dialog.dart';
import 'package:lend_funds/utils/storage/storage_utils.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F7),
      body: SingleChildScrollView(
        child: ConstraintLayout(
          width: 1.sw,
          height: matchParent,
          children: [
            Container(
                    color: Colors.transparent,
                    child: Image.asset(
                      'assets/mine/mine_background.png',
                      width: 1.sw,
                      height: 203.h,
                      fit: BoxFit.fill,
                    ))
                .applyConstraint(
                    id: cId('cont2'), width: 1.sw, topLeftTo: parent),
            Text("Personal Center",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.normal))
                .applyConstraint(
                    id: cId('text1'),
                    topCenterTo: cId('cont2').topMargin(64.h)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.w)),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 17.5.w),
              child: Row(
                children: [
                  Image.asset('assets/lend_funds_logo.png',
                      width: 66.w, height: 66.w),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("156****258",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.normal)),
                      Text("Make your credit more valuable",
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: const Color(0xFFAAAAAA),
                              fontWeight: FontWeight.normal)),
                    ],
                  )
                ],
              ),
            ).applyConstraint(
                id: cId('cont3'),
                width: 1.sw - 32.w,
                height: 112.h,
                topCenterTo: cId('cont2').topMargin(118.h)),
            Container(
              width: 1.sw - 32.w,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(5.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      debugPrint("111");
                      // Get.toNamed(CZRouteConfig.mineBank);
                    },
                    child: MineItem(
                      title: "My loan",
                      path: "assets/mine/mine_my_load_icon.png",
                      color: Color.fromRGBO(226, 233, 255, 1),
                      isRequired: true,
                      content: "",
                      needContent: -1,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // Get.toNamed(CZRouteConfig.mineOrder);
                    },
                    child: MineItem(
                        title: "Security protocol",
                        path: "assets/mine/mine_security_protocol_icon.png",
                        color: Color.fromRGBO(255, 241, 229, 1),
                        isRequired: true,
                        content: "",
                        needContent: -1),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // Get.toNamed(CZRouteConfig.mineFaq);
                    },
                    child: MineItem(
                        title: "About us",
                        path: "assets/mine/mine_about_us_icon.png",
                        color: Color.fromRGBO(245, 236, 255, 1),
                        isRequired: true,
                        content: "",
                        needContent: -1),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // //隐私协议
                      // Get.toNamed(CZRouteConfig.webView, parameters: {
                      //   'title': Translate.privacyStatement,
                      //   'url': AppConfig.privacyStatementURL,
                      // });
                    },
                    child: MineItem(
                        title: "Customer service",
                        path: "assets/mine/mine_customer_service_icon.png",
                        color: Color.fromRGBO(245, 236, 255, 1),
                        isRequired: true,
                        content: "",
                        needContent: -1),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      CZDialogUtil.show(DeleteAccountDialog(confirmBlock: () {
                        CZDialogUtil.dismiss();
                      }, cancelBlock: () {
                        CZDialogUtil.dismiss();
                      }));
                    },
                    child: MineItem(
                        title: "Delete account",
                        path: "assets/mine/mine_delete_account_icon.png",
                        color: Color.fromRGBO(226, 233, 255, 1),
                        isRequired: true,
                        content: "",
                        needContent: -1),
                  ),
                ],
              ),
            ).applyConstraint(
                id: cId('cont4'),
                width: 1.sw - 32.w,
                topCenterTo: cId('cont2').topMargin(245.h)),
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                  color: const Color(0xFF003C6A),
                  borderRadius: BorderRadius.circular(10.w)),
              child: TextButton(
                onPressed: () {
                  CZStorage.removeUserInfo();
                  Get.offAll(() => LoginPage());
                },
                child: Text("Log in",
                    style: TextStyle(
                        fontSize: 26.sp,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w500)),
              ),
            ).applyConstraint(
                id: cId('cont5'),
                width: 1.sw - 32.w,
                topCenterTo: cId('cont2').topMargin(554.h)),
          ],
        ),
      ),
    );
  }
}
