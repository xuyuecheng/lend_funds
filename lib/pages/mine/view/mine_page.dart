import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/login/view/login_new_page.dart';
import 'package:lend_funds/pages/mine/controller/mine_controller.dart';
import 'package:lend_funds/pages/mine/view/widget/delete_account_dialog.dart';
import 'package:lend_funds/pages/webview/webview.dart';
import 'package:lend_funds/utils/const/translate.dart';
import 'package:lend_funds/utils/eventbus/eventbus.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/storage/storage_utils.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  bool _hasEmailSupport = false;
  @override
  void initState() {
    super.initState();
    //...
    Get.put(MineController());
    canLaunchUrl(Uri(scheme: 'mailto', path: 'smith@example.com'))
        .then((bool result) {
      _hasEmailSupport = result;
    });
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
                    Image.asset('assets/lend_funds_logo.png',
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
                              _makeEmailCall("bcvuwagdak@gmail.com");
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
                                MineController.to.requestDel().then((value) {
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
            // Positioned(
            //     top: 64.h,
            //     left: 16.w,
            //     right: 16.w,
            //     child: Container(
            //       // padding: EdgeInsets.symmetric(horizontal: 16.w),
            //       child: Column(
            //         children: [
            //           Text("Personal Center",
            //               style: TextStyle(
            //                   fontSize: 20.sp,
            //                   color: const Color(0xFFFFFFFF),
            //                   fontWeight: FontWeight.normal)),
            //           SizedBox(
            //             height: 26.h,
            //           ),
            //           Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.all(Radius.circular(15.w)),
            //               color: Colors.white,
            //             ),
            //             padding: EdgeInsets.symmetric(horizontal: 17.5.w),
            //             height: 112.h,
            //             child: Row(
            //               children: [
            //                 Image.asset('assets/lend_funds_logo.png',
            //                     width: 66.w, height: 66.w),
            //                 SizedBox(
            //                   width: 10.w,
            //                 ),
            //                 Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(phone,
            //                         style: TextStyle(
            //                             fontSize: 20.sp,
            //                             color: const Color(0xFF000000),
            //                             fontWeight: FontWeight.normal)),
            //                     Text("Make your credit more valuable",
            //                         style: TextStyle(
            //                             fontSize: 10.sp,
            //                             color: const Color(0xFFAAAAAA),
            //                             fontWeight: FontWeight.normal)),
            //                   ],
            //                 )
            //               ],
            //             ),
            //           ),
            //           SizedBox(
            //             height: 15.h,
            //           ),
            //           Container(
            //             width: 1.sw - 32.w,
            //             decoration: const BoxDecoration(
            //               borderRadius: BorderRadius.all(Radius.circular(15)),
            //               color: Colors.white,
            //             ),
            //             padding: EdgeInsets.all(5.w),
            //             child: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 GestureDetector(
            //                   behavior: HitTestBehavior.opaque,
            //                   onTap: () {
            //                     EventBus()
            //                         .emit(EventBus.changeToOrderTab, null);
            //                   },
            //                   child: MineItem(
            //                     title: "My loan",
            //                     path: "assets/mine/mine_my_load_icon.png",
            //                     color: Color.fromRGBO(226, 233, 255, 1),
            //                     isRequired: true,
            //                     content: "",
            //                     needContent: -1,
            //                   ),
            //                 ),
            //                 GestureDetector(
            //                   behavior: HitTestBehavior.opaque,
            //                   onTap: () {
            //                     _makeEmailCall("bcvuwagdak@gmail.com");
            //                   },
            //                   child: MineItem(
            //                       title: "Customer service",
            //                       path:
            //                           "assets/mine/mine_customer_service_icon.png",
            //                       color: Color.fromRGBO(245, 236, 255, 1),
            //                       isRequired: true,
            //                       content: "",
            //                       needContent: -1),
            //                 ),
            //                 GestureDetector(
            //                   behavior: HitTestBehavior.opaque,
            //                   onTap: () {
            //                     CZDialogUtil.show(
            //                         DeleteAccountDialog(confirmBlock: () {
            //                       CZDialogUtil.dismiss();
            //                       MineController.to.requestDel().then((value) {
            //                         if (value["statusE8iqlh"] == 0) {
            //                           CZStorage.removeUserInfo();
            //                           Get.offAll(() => LoginNewPage());
            //                         }
            //                       });
            //                     }, cancelBlock: () {
            //                       CZDialogUtil.dismiss();
            //                     }));
            //                   },
            //                   child: MineItem(
            //                     title: "Delete account",
            //                     path:
            //                         "assets/mine/mine_delete_account_icon.png",
            //                     color: Color.fromRGBO(226, 233, 255, 1),
            //                     isRequired: true,
            //                     content: "",
            //                     needContent: -1,
            //                     showLine: false,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           SizedBox(
            //             height: 47.h,
            //           ),
            //           GestureDetector(
            //             behavior: HitTestBehavior.translucent,
            //             onTap: () {
            //               CZStorage.removeUserInfo();
            //               Get.offAll(() => LoginNewPage());
            //             },
            //             child: Container(
            //               // height: 50.h,
            //               width: 1.sw,
            //               decoration: BoxDecoration(
            //                   color: const Color(0xFF003C6A),
            //                   borderRadius: BorderRadius.circular(10.w)),
            //               padding: EdgeInsets.symmetric(vertical: 7.5.h),
            //               alignment: Alignment.center,
            //               child: Text("Log out",
            //                   style: TextStyle(
            //                       fontSize: 26.sp,
            //                       color: const Color(0xFFFFFFFF),
            //                       fontWeight: FontWeight.w500)),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ))
          ],
        ));
  }

  Future<void> _makeEmailCall(String emailNumber) async {
    debugPrint("_hasEmailSupport:$_hasEmailSupport");
    if (_hasEmailSupport) {
      final Uri launchUri = Uri(
        scheme: 'mailto',
        path: emailNumber,
      );
      await launchUrl(launchUri);
    } else {}
  }
}
