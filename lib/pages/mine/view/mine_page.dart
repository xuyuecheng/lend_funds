import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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
        backgroundColor: Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 7.5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 52.h,
              ),
              Center(
                child: Image.asset('assets/mine/mine_photo_icon.png',
                    width: 91.w, height: 91.w),
              ),
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: Text(phone,
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0xFF0A0A0A),
                        fontWeight: FontWeight.w700)),
              ),
              SizedBox(
                height: 7.h,
              ),
              Center(
                child: Text("Sahayak Cash Make your credit more valuable",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color(0xFF0A0A0A),
                        fontWeight: FontWeight.normal)),
              ),
              SizedBox(
                height: 27.h,
              ),
              Text("My Services",
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: const Color(0xFF0A0A0A),
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 13.h,
              ),
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                    // color: const Color(0xFFFF0000),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xffC2FADE),
                        Color(0xffFFFFFF),
                        Color(0xffFFFFFF)
                      ],
                    ),
                    boxShadow: [
                      //卡片阴影
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, 0),
                        blurRadius: 4.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(7.5.w)),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        facebookLogin();
                        return;
                        EventBus().emit(EventBus.changeToOrderTab, null);
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 14.h,
                          ),
                          Image.asset('assets/mine/mine_my_load_icon.png',
                              width: 37.w, height: 26.w),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text("My Loan",
                              style: TextStyle(
                                  fontSize: 11.5.sp,
                                  color: const Color(0xFF5F5F5F),
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 9.5.h,
                          ),
                        ],
                      ),
                    )),
                    SizedBox(
                      width: 40.w,
                    ),
                    Expanded(
                        child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        _emailCall("sahayaknewcash@outlook.com");
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 11.5.h,
                          ),
                          Image.asset(
                              'assets/mine/mine_customer_service_icon.png',
                              width: 30.w,
                              height: 30.w),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text("Customer service",
                              style: TextStyle(
                                  fontSize: 11.5.sp,
                                  color: const Color(0xFF5F5F5F),
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 9.5.h,
                          ),
                        ],
                      ),
                    )),
                    SizedBox(
                      width: 40.w,
                    ),
                    Expanded(
                        child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        CZDialogUtil.show(DeleteAccountDialog(confirmBlock: () {
                          CZDialogUtil.dismiss();
                          MineController.to.requestDelAccount().then((value) {
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
                            height: 11.5.h,
                          ),
                          Image.asset(
                              'assets/mine/mine_delete_account_icon.png',
                              width: 30.w,
                              height: 30.w),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text("Delete Account",
                              style: TextStyle(
                                  fontSize: 11.5.sp,
                                  color: const Color(0xFF5F5F5F),
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 9.5.h,
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 37.h,
              ),
              Text("Information Services",
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: const Color(0xFF0A0A0A),
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Get.to(() => WebView(
                            title: Translate.privacyStatement,
                            url: AppConfig.privacyStatementURL,
                          ));
                    },
                    child: Container(
                      width: 84.w,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFffff),
                          boxShadow: [
                            //卡片阴影
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0, 0),
                              blurRadius: 4.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(7.5.w)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 7.h,
                          ),
                          Image.asset(
                              'assets/mine/mine_privacy_agreement_icon.png',
                              width: 26.w,
                              height: 30.w),
                          SizedBox(
                            height: 10.5.h,
                          ),
                          Text("Privacy\nPolicy",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11.5.sp,
                                  color: const Color(0xFF5F5F5F),
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 12.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Get.to(() => WebView(
                            title: Translate.termsAgreement,
                            url: AppConfig.termsAgreement,
                          ));
                    },
                    child: Container(
                      width: 84.w,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFffff),
                          boxShadow: [
                            //卡片阴影
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0, 0),
                              blurRadius: 4.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(7.5.w)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 7.h,
                          ),
                          Image.asset(
                              'assets/mine/mine_terms_conditions_icon.png',
                              width: 25.w,
                              height: 30.w),
                          SizedBox(
                            height: 10.5.h,
                          ),
                          Text("Terms&\nConditions",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11.5.sp,
                                  color: const Color(0xFF5F5F5F),
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 12.h,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 80.h,
              ),
              Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    CZStorage.removeUserInfo();
                    Get.offAll(() => LoginNewPage());
                  },
                  child: Container(
                    width: 265.w,
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
              SizedBox(
                height: 33.h,
              ),
            ],
          ),
        ));
  }

  Future<void> _emailCall(String emailNumber) async {
    TelAndSmsService service = getIt<TelAndSmsService>();
    service.sendEmail(emailNumber);
  }

  void facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;

      Map<String, dynamic> userData = await FacebookAuth.instance.getUserData();
      print("facebook 获取登录用户信息" + userData.toString());
    } else {
      print("facebook 登录失败");
      print(result.status);
      print(result.message);
    }
  }
}
