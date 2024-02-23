import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sahayak_cash/pages/login/view/login_new_page.dart';
import 'package:sahayak_cash/pages/mine/controller/mine_controller.dart';
import 'package:sahayak_cash/pages/mine/view/widget/delete_account_dialog.dart';
import 'package:sahayak_cash/pages/webview/webview.dart';
import 'package:sahayak_cash/utils/const/translate.dart';
import 'package:sahayak_cash/utils/eventbus/eventbus.dart';
import 'package:sahayak_cash/utils/network/dio_config.dart';
import 'package:sahayak_cash/utils/service/TelAndSmsService.dart';
import 'package:sahayak_cash/utils/storage/storage_utils.dart';
import 'package:sahayak_cash/utils/toast/toast_utils.dart';

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
    Get.put(MineController());
  }

  @override
  Widget build(BuildContext context) {
    var userInfo = CZStorage.getUserInfo();
    var phone = "Halo";
    if (userInfo != null) {
      if (kDebugMode) {
        print("getUserInfo:${userInfo.toString()}");
      }

      var user = userInfo.containsKey("accountUnDcbi")
          ? userInfo["accountUnDcbi"]
          : null;
      if (user != null) {
        phone = user.containsKey("phone") ? user["phone"] : "Halo";
      }
    }
    return Scaffold(
        backgroundColor: Color(0xFFF4F5F7),
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
                top: 28.h,
                left: 7.5.w,
                right: 7.5.w,
                child: Column(
                  children: [
                    Image.asset('assets/mine/mine_photo_icon.png',
                        width: 57.w, height: 57.w),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(phone,
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: const Color(0xFF0A0A0A),
                            fontWeight: FontWeight.normal)),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text("Make your credit more valuable",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF0A0A0A),
                            fontWeight: FontWeight.normal)),
                    SizedBox(
                      height: 25.h,
                    ),
                    Container(
                      width: 1.sw,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(7.5.w)),
                      // alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              EventBus().emit(EventBus.changeToOrderTab, null);
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 17.h,
                                ),
                                Image.asset('assets/mine/mine_my_load_icon.png',
                                    width: 24.w, height: 17.w),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text("My Loan",
                                    style: TextStyle(
                                        fontSize: 7.5.sp,
                                        color: const Color(0xFF5F5F5F),
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Get.to(() => WebView(
                                    title: Translate.termsAgreement,
                                    url: AppConfig.termsAgreement,
                                  ));
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 17.h,
                                ),
                                Image.asset(
                                    'assets/mine/mine_security_protocol_icon.png',
                                    width: 24.w,
                                    height: 17.w),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text("Conditions Terms",
                                    style: TextStyle(
                                        fontSize: 7.5.sp,
                                        color: const Color(0xFF5F5F5F),
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              _emailCall("bcvuwagdak@gmail.com");
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 17.h,
                                ),
                                Image.asset(
                                    'assets/mine/mine_customer_service_icon.png',
                                    width: 24.w,
                                    height: 17.w),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text("Customer service",
                                    style: TextStyle(
                                        fontSize: 7.5.sp,
                                        color: const Color(0xFF5F5F5F),
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Get.to(() => WebView(
                                    title: Translate.privacyStatement,
                                    url: AppConfig.privacyStatementURL,
                                  ));
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 17.h,
                                ),
                                Image.asset(
                                    'assets/mine/mine_privacy_agreement_icon.png',
                                    width: 24.w,
                                    height: 17.w),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text("Privacy Agreement",
                                    style: TextStyle(
                                        fontSize: 7.5.sp,
                                        color: const Color(0xFF5F5F5F),
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              CZDialogUtil.show(
                                  DeleteAccountDialog(confirmBlock: () {
                                CZDialogUtil.dismiss();
                                MineController.to
                                    .requestDelAccount()
                                    .then((value) {
                                  if (value["statusE8iqlh"] == 0) {
                                    CZStorage.removeUserInfo();
                                    Get.offAll(() => LoginNewPage());
                                  }
                                });
                              }, cancelBlock: () {
                                CZDialogUtil.dismiss();
                              }));
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 17.h,
                                ),
                                Image.asset(
                                    'assets/mine/mine_delete_account_icon.png',
                                    width: 24.w,
                                    height: 17.w),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text("Delete Account",
                                    style: TextStyle(
                                        fontSize: 7.5.sp,
                                        color: const Color(0xFF5F5F5F),
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {},
                      child: Image.asset(
                        "assets/mine/mine_ad_background.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                )),
            Positioned(
              bottom: 20.h,
              left: 47.w,
              right: 47.w,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  CZStorage.removeUserInfo();
                  Get.offAll(() => LoginNewPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFF00A651),
                      borderRadius: BorderRadius.circular(5.w)),
                  padding: EdgeInsets.symmetric(vertical: 10.5.h),
                  alignment: Alignment.center,
                  child: Text("Log out",
                      style: TextStyle(
                          fontSize: 21.5.sp,
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> _emailCall(String emailNumber) async {
    TelAndSmsService service = getIt<TelAndSmsService>();
    service.sendEmail(emailNumber);
  }
}
