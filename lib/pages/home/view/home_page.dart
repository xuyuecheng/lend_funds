import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/home/controller/home_controller.dart';
import 'package:lend_funds/pages/home/view/widget/home_product_dialog.dart';
import 'package:lend_funds/pages/order/view/order_page.dart';
import 'package:lend_funds/utils/eventbus/eventbus.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    //...
    Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: const Key('HomePage'),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction == 1) {
            HomeController.to.getIncompleteForm();
            HomeController.to.getProductList();
          }
        },
        child: GetBuilder<HomeController>(
          builder: (vc) {
            return Scaffold(
              body: SafeArea(
                  child: SingleChildScrollView(
                // reverse: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Text("Lend Funds",
                          style: TextStyle(
                              fontSize: 25.sp,
                              color: const Color(0xFF003C6A),
                              fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      height: 1.5.h,
                      color: Color(0xff000000),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome！",
                              style: TextStyle(
                                  fontSize: 25.sp,
                                  color: const Color(0xFF292929),
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 13.h,
                          ),
                          Container(
                            height: 154.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 154.w,
                                    height: 154.w,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(26.w)),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xffF3A135),
                                          Color(0xffF5C069)
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.w,
                                        ),
                                        Image.asset(
                                            'assets/home/home_loan_amount_icon.png',
                                            width: 50.5.w,
                                            height: 50.5.w),
                                        SizedBox(
                                          height: 22.5.w,
                                        ),
                                        Text("Maximum loan amount",
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: const Color(0xFF000000),
                                                fontWeight: FontWeight.w500)),
                                        Text("₹ 500,000",
                                            style: TextStyle(
                                                fontSize: 25.sp,
                                                color: const Color(0xFF000000),
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    )),
                                Container(
                                    width: 154.w,
                                    height: 154.w,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(26.w)),
                                      color: Color(0xffCFDEEA),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 15.w,
                                        ),
                                        Image.asset(
                                            'assets/home/home_loan_term_icon.png',
                                            width: 40.5.w,
                                            height: 40.5.w),
                                        SizedBox(
                                          height: 27.5.w,
                                        ),
                                        Text("Maximum loan term",
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: const Color(0xFF000000),
                                                fontWeight: FontWeight.w500)),
                                        Text("360 days",
                                            style: TextStyle(
                                                fontSize: 25.sp,
                                                color: const Color(0xFF000000),
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image.asset(
                                    'assets/home/home_credit_loan_backgro.png',
                                    fit: BoxFit.fill),
                                Positioned(
                                  top: 20.h,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/home/home_credit_loans.png',
                                            width: 40.5.w,
                                            height: 40.5.w,
                                          ),
                                          SizedBox(
                                            height: 6.5.h,
                                          ),
                                          Text("Credit Loans",
                                              style: TextStyle(
                                                  fontSize: 12.5.sp,
                                                  color:
                                                      const Color(0xFF000000),
                                                  fontWeight:
                                                      FontWeight.normal))
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/home/home_automatic_review.png',
                                            width: 40.5.w,
                                            height: 40.5.w,
                                          ),
                                          SizedBox(
                                            height: 6.5.h,
                                          ),
                                          Text("Automatic review",
                                              style: TextStyle(
                                                  fontSize: 12.5.sp,
                                                  color:
                                                      const Color(0xFF000000),
                                                  fontWeight:
                                                      FontWeight.normal))
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/home/home_safe_reliable.png',
                                            width: 40.5.w,
                                            height: 40.5.w,
                                          ),
                                          SizedBox(
                                            height: 6.5.h,
                                          ),
                                          Text("Safe and reliable",
                                              style: TextStyle(
                                                  fontSize: 12.5.sp,
                                                  color:
                                                      const Color(0xFF000000),
                                                  fontWeight:
                                                      FontWeight.normal))
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    // left: 0,
                                    // right: 0,
                                    bottom: 12.h,
                                    child: Text(
                                        "The loan limit is allocated based on personal credit",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: const Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.normal)))
                              ],
                            ),
                          ),
                          vc.forms.isNotEmpty
                              ? _createRecommend()
                              : _createProducts()
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              backgroundColor: Colors.white,
            );
          },
        ));
  }

  Widget _createRecommend() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text("Recommended loan",
              style: TextStyle(
                  fontSize: 17.5.sp,
                  color: const Color(0xFF292929),
                  fontWeight: FontWeight.w500)),
          SizedBox(
            height: 10.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.5.w),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xffCFDEEA), Color(0xff003C6A)],
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/home/home_recommend_loan_icon.png',
                  width: 124.5.h,
                  height: 124.5.h,
                ),
                Expanded(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    Text("Loan amount",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500)),
                    Text("₹ 200,000",
                        style: TextStyle(
                            fontSize: 36.sp,
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 6.h,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        requestAllPermission();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.w, vertical: 3.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.w),
                            color: Color(0xff00BF9C)),
                        child: Text("Apply Now->",
                            style: TextStyle(
                                fontSize: 17.5.sp,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text("Interest rate",
              style: TextStyle(
                  fontSize: 17.5.sp,
                  color: const Color(0xFF292929),
                  fontWeight: FontWeight.w500)),
          SizedBox(
            height: 3.h,
          ),
          Image.asset('assets/home/home_interest_rate_icon.png',
              fit: BoxFit.fill),
        ],
      ),
    );
  }

  Widget _createProducts() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 17.5.h,
          ),
          ListView.separated(
            itemCount: HomeController.to.productList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = HomeController.to.productList[index];
              String id = item.containsKey("id") ? item["id"] : "";
              String name = item.containsKey("name") ? item["name"] : "loan";
              String icon = item.containsKey("icon") ? item["icon"] : "icon";
              dynamic amount =
                  item.containsKey("amount") ? item["amount"] : "amount";
              dynamic serviceAmount = item.containsKey("serviceAmount")
                  ? item["serviceAmount"]
                  : "0";
              dynamic term = item.containsKey("term") ? item["term"] : "0";
              dynamic dayRate =
                  item.containsKey("dayRate") ? item["dayRate"] : 1;
              print("dayRate:${dayRate.toString()}");
              dynamic interest = amount * dayRate * term;
              print("IMAGE_URL:" + "${DioConfig.IMAGE_URL}$icon");
              return Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.5.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.5.w),
                    border: Border.all(
                        color: Colors.black,
                        width: 0.5.w,
                        style: BorderStyle.solid)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 27.5.w,
                              height: 27.5.w,
                              decoration: new BoxDecoration(
                                //设置四周圆角 角度
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                              ),
                              child: Image.network(
                                  "${DioConfig.IMAGE_URL}$icon",
                                  width: 60,
                                  height: 60),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: const Color(0xFF161616),
                                        fontWeight: FontWeight.w500)),
                                // Text("Loan within 30 mins",
                                //     style: TextStyle(
                                //         fontSize: 7.5.sp,
                                //         color: const Color(0xFF929292),
                                //         fontWeight: FontWeight.w500)),
                              ],
                            )
                          ],
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            _getTrialData(productIds: [id]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.5.w, vertical: 2.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.w),
                                color: Color(0xff003C6A)),
                            child: Text("Aplicar",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.5.h,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text("Loan amount",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text("₹ ${amount.toString()}",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Column(
                          children: [
                            Text("loan term",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text("${term.toString()} DAYS",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500))
                          ],
                        )
                        // Expanded(
                        //     child: Column(
                        //   children: [
                        //     Text("Loan amount",
                        //         style: TextStyle(
                        //             fontSize: 10.sp,
                        //             color: const Color(0xFF000000),
                        //             fontWeight: FontWeight.w500)),
                        //     SizedBox(
                        //       height: 3.h,
                        //     ),
                        //     Text("₹ ${amount.toString()}",
                        //         style: TextStyle(
                        //             fontSize: 15.sp,
                        //             color: const Color(0xFF000000),
                        //             fontWeight: FontWeight.w500))
                        //   ],
                        // )),
                        // Expanded(
                        //     child: Column(
                        //   children: [
                        //     Text("Repayment amount",
                        //         style: TextStyle(
                        //             fontSize: 10.sp,
                        //             color: const Color(0xFF000000),
                        //             fontWeight: FontWeight.w500)),
                        //     SizedBox(
                        //       height: 3.h,
                        //     ),
                        //     Text("₹ ${repayAmount.toString()}",
                        //         style: TextStyle(
                        //             fontSize: 15.sp,
                        //             color: const Color(0xFF000000),
                        //             fontWeight: FontWeight.w500))
                        //   ],
                        // )),
                        // Expanded(
                        //     child: Column(
                        //   children: [
                        //     Text("loan term",
                        //         style: TextStyle(
                        //             fontSize: 10.sp,
                        //             color: const Color(0xFF000000),
                        //             fontWeight: FontWeight.w500)),
                        //     SizedBox(
                        //       height: 3.h,
                        //     ),
                        //     Text("${term.toString()} DAYS",
                        //         style: TextStyle(
                        //             fontSize: 15.sp,
                        //             color: const Color(0xFF000000),
                        //             fontWeight: FontWeight.w500))
                        //   ],
                        // )),
                      ],
                    ),
                    SizedBox(
                      height: 5.5.h,
                    ),
                    Container(
                      height: 0.5.h,
                      color: Color(0xffC5C3C3),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text("Daily interest rate from ${dayRate * 100}%",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 17.5.h,
              );
            },
          )
        ],
      ),
    );
  }

  //试算
  _getTrialData({required List productIds}) async {
    CZLoading.loading();
    final response = await HomeController.to.requestTrialData(productIds);
    CZLoading.dismiss();
    if (response["status"] == 0) {
      List<dynamic>? item =
          response.containsKey("model") ? response["model"] : null;
      print("item:${item.toString()}");
      if (item != null && item.length > 0) {
        CZDialogUtil.show(HomeProductDialog(
            itemList: item,
            confirmBlock: () async {
              CZLoading.loading();
              final response =
                  await HomeController.to.requestLoanData(productIds);
              CZLoading.dismiss();
              if (response["status"] == 0) {
                CZDialogUtil.dismiss();
                //跳转到订单列表
                Get.to(() => OrderPage(
                      canReturn: true,
                    ));
                EventBus().emit(EventBus.refreshOrderList, null);
              }
            }));
      }
    }
  }

  void requestAllPermission() async {
    // Map<Permission, PermissionStatus> statuses = await [
    //   Permission.sms,
    //   Permission.camera,
    //   Permission.phone,
    // ].request();

    // if (PermissionStatus.granted == statuses[Permission.sms] &&
    //     PermissionStatus.granted == statuses[Permission.camera] &&
    //     PermissionStatus.granted == statuses[Permission.phone]) {
    getDevModel();
    CZLoading.loading();
    await HomeController().requestIncompleteForm();
    CZLoading.dismiss();
    // } else {
    //   if (PermissionStatus.denied == statuses[Permission.sms] ||
    //       PermissionStatus.denied == statuses[Permission.camera] ||
    //       PermissionStatus.denied == statuses[Permission.phone]) {
    //     requestAllPermission(context);
    //   }
    //   if (PermissionStatus.permanentlyDenied == statuses[Permission.sms] ||
    //       PermissionStatus.permanentlyDenied == statuses[Permission.camera] ||
    //       PermissionStatus.permanentlyDenied == statuses[Permission.phone]) {
    //     //跳到设置
    //     showCupertinoDialog(
    //         context: context,
    //         builder: (context) {
    //           return CupertinoAlertDialog(
    //             title: const Text('You need to grant album permissions'),
    //             content: const Text(
    //                 'Please go to your mobile phone to set the permission to open the corresponding album'),
    //             actions: <Widget>[
    //               CupertinoDialogAction(
    //                 child: const Text('cancel'),
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                 },
    //               ),
    //               CupertinoDialogAction(
    //                 child: const Text('confirm'),
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                   // 打开手机上该app权限的页面
    //                   openAppSettings();
    //                 },
    //               ),
    //             ],
    //           );
    //         });
    //   }
    // }
  }

  getDevModel() async {
    final response = await HomeController().requestDevModel();
    if (response["status"] == 0) {
      List<dynamic> list = response["list"];
      debugPrint("list111222:$list");
      list.forEach((element) {
        switch (element) {
          case "DEVICE":
            HomeController().requestDeviceInfo();
            break;
          case "APP":
            //iOS没有权限查看安装的app列表
            // getAppInfo(context);
            break;
          case "SMS":
            //iOS没有权限查看SMS列表
            // getPhoneSms(context);
            break;
        }
      });
    }
  }
}
