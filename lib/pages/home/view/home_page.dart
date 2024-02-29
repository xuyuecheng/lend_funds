import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahayak_cash/pages/common/marquee_widget.dart';
import 'package:sahayak_cash/pages/common/privacy_agreement.dart';
import 'package:sahayak_cash/pages/home/controller/home_controller.dart';
import 'package:sahayak_cash/pages/product/product_confirm_page.dart';
import 'package:sahayak_cash/pages/webview/webview.dart';
import 'package:sahayak_cash/utils/const/translate.dart';
import 'package:sahayak_cash/utils/network/dio_config.dart';
import 'package:sahayak_cash/utils/toast/toast_utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var refreshController = RefreshController(initialRefresh: false);
  bool _switchSelected = true;
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
            if (vc.forms.isNotEmpty) {
              return Scaffold(
                body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                  // reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 45.h,
                      ),
                      Container(
                          child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset(
                            "assets/home/home_info_background.png",
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            left: 7.5.w,
                            top: 46.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Maximum loan amount",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.normal)),
                                Text("₹ 200,000",
                                    style: TextStyle(
                                        fontSize: 45.sp,
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 11.h,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/home/home_maximum_loan_term_icon.png",
                                          width: 18.w,
                                          height: 18.w,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Maximum loan term",
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color:
                                                        const Color(0xFFFFFFFF),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Text("360 days",
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color:
                                                        const Color(0xFFFFFFFF),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 19.w,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/home/home_loan_interest_icon.png",
                                          width: 18.w,
                                          height: 18.w,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Loan interest",
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color:
                                                        const Color(0xFFFFFFFF),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Text("0.05% per day",
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color:
                                                        const Color(0xFFFFFFFF),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              bottom: 37.h,
                              child: Container(
                                width: 260.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF000000),
                                    borderRadius: BorderRadius.circular(5.w)),
                                child: TextButton(
                                  onPressed: () async {
                                    _requestAllPermission();
                                  },
                                  child: Text("Apply Now",
                                      style: TextStyle(
                                          fontSize: 25.sp,
                                          color: const Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.w700)),
                                ),
                              )),
                          Positioned(bottom: 10.h, child: PrivacyAgreement()),
                        ],
                      )),
                      SizedBox(
                        height: 30.h,
                      ),
                      Center(
                        child: Text("Loan Process",
                            style: TextStyle(
                                fontSize: 25.sp,
                                color: const Color(0xFF1A1A1A),
                                fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Image.asset(
                              "assets/home/home_id_card_icon.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                          Expanded(
                            child: Image.asset(
                              "assets/home/home_application_form_icon.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                          Expanded(
                            child: Image.asset(
                              "assets/home/home_loan_amount_icon.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                          Expanded(
                            child: Image.asset(
                              "assets/home/home_get_loan_icon.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Image.asset(
                        "assets/home/home_choose_us_icon.png",
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
              );
            }
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Product List",
                    style: TextStyle(
                        fontSize: 17.5.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                  ),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    MarqueeWidget(),
                    Expanded(
                        child: SmartRefresher(
                            controller: refreshController,
                            enablePullDown: true,
                            enablePullUp: false,
                            header: MaterialClassicHeader(),
                            footer: ClassicFooter(
                              loadingText: "loading",
                              failedText: "failed",
                              noDataText: "noData",
                              canLoadingText: "",
                              idleText: "idle",
                            ),
                            onRefresh: () async {
                              await HomeController.to.getProductList();
                              refreshController.refreshCompleted();
                              refreshController.loadComplete();
                            },
                            onLoading: () async {},
                            child: vc.productList.isNotEmpty
                                ? ListView.separated(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.h, horizontal: 7.5.h),
                                    shrinkWrap: true,
                                    itemCount: vc.productList.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final item =
                                          HomeController.to.productList[index];
                                      String id = item.containsKey("idxQEzsQ")
                                          ? item["idxQEzsQ"]
                                          : "";
                                      String name =
                                          item.containsKey("nameyJEzwD")
                                              ? item["nameyJEzwD"]
                                              : "loan";
                                      String icon =
                                          item.containsKey("iconKzUZic")
                                              ? item["iconKzUZic"]
                                              : "iconKzUZic";
                                      dynamic amount =
                                          item.containsKey("amountVmVZsg")
                                              ? item["amountVmVZsg"]
                                              : "amountVmVZsg";
                                      dynamic serviceAmount = item.containsKey(
                                              "serviceAmountyNv9UA")
                                          ? item["serviceAmountyNv9UA"]
                                          : "0";
                                      dynamic term =
                                          item.containsKey("termvXWr1o")
                                              ? item["termvXWr1o"]
                                              : "0";
                                      dynamic dayRate =
                                          item.containsKey("dayRatepSGZ9K")
                                              ? item["dayRatepSGZ9K"]
                                              : 1;
                                      print("dayRate:${dayRate.toString()}");
                                      dynamic interest =
                                          amount * dayRate * term;
                                      print("IMAGE_URL:" +
                                          "${DioConfig.IMAGE_URL}$icon");
                                      if (index == 0) {
                                        return Column(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                    width: 1.sw,
                                                    height: 68.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        7.5.w),
                                                                topRight: Radius
                                                                    .circular(
                                                                        7.5.w)),
                                                        color:
                                                            Color(0xff00A651)),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Text("Credit(INR)",
                                                            style: TextStyle(
                                                                fontSize: 20.sp,
                                                                color: const Color(
                                                                    0xFFFFFFFF),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        Text(
                                                            "₹ ${amount.toString()}",
                                                            style: TextStyle(
                                                                fontSize: 45.sp,
                                                                color: const Color(
                                                                    0xFFFFFFFF),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                      ],
                                                    )),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5.w,
                                                        right: 5.w,
                                                        top: 10.h,
                                                        bottom: 10.h),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      7.5.w),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      7.5.w)),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "Loan tenure",
                                                                    style: TextStyle(
                                                                        fontSize: 15
                                                                            .sp,
                                                                        color: const Color(
                                                                            0xFF161616),
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                                SizedBox(
                                                                  height: 7.h,
                                                                ),
                                                                Text(
                                                                    "${term.toString()} (DAYS)",
                                                                    style: TextStyle(
                                                                        fontSize: 15
                                                                            .sp,
                                                                        color: const Color(
                                                                            0xFF161616),
                                                                        fontWeight:
                                                                            FontWeight.w500))
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 45.w,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text("Interest",
                                                                    style: TextStyle(
                                                                        fontSize: 15
                                                                            .sp,
                                                                        color: const Color(
                                                                            0xFF161616),
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                                SizedBox(
                                                                  height: 7.h,
                                                                ),
                                                                Text(
                                                                    "${dayRate * 100}% /Day",
                                                                    style: TextStyle(
                                                                        fontSize: 15
                                                                            .sp,
                                                                        color: const Color(
                                                                            0xFF161616),
                                                                        fontWeight:
                                                                            FontWeight.w500))
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        Positioned(
                                                            bottom: 0,
                                                            right: 5.w,
                                                            child: Container(
                                                              width: 19.w,
                                                              height: 19.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xff00A651),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            9.5.w)),
                                                              ),
                                                            ))
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ],
                                        );
                                      }
                                      return GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          item["hadSelect"] =
                                              !item["hadSelect"];
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 16.5.w,
                                              right: 10.w,
                                              top: 8.5.h,
                                              bottom: 8.5.h),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7.5.w),
                                              color: Color(0xffffffff)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 27.5.w,
                                                        height: 27.5.w,
                                                        decoration:
                                                            new BoxDecoration(
                                                          //
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          0)),
                                                        ),
                                                        child: Image.network(
                                                            "${DioConfig.IMAGE_URL}$icon",
                                                            width: 60,
                                                            height: 60),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(name,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  color: const Color(
                                                                      0xFF161616),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          // Text("Loan within 30 mins",
                                                          //     style: TextStyle(
                                                          //         fontSize: 7.5.sp,
                                                          //         color: const Color(0xFF929292),
                                                          //         fontWeight: FontWeight.w500)),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 14.5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Credit(INR)",
                                                          style: TextStyle(
                                                              fontSize: 12.5.sp,
                                                              color: const Color(
                                                                  0xFF161616),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      Text(
                                                          "₹ ${amount.toString()}",
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: const Color(
                                                                  0xFF161616),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 30.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Loan tenure",
                                                          style: TextStyle(
                                                              fontSize: 12.5.sp,
                                                              color: const Color(
                                                                  0xFF161616),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      Text(
                                                          "${term.toString()} (DAYS)",
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: const Color(
                                                                  0xFF161616),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 30.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Interest",
                                                          style: TextStyle(
                                                              fontSize: 12.5.sp,
                                                              color: const Color(
                                                                  0xFF161616),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      Text(
                                                          "${dayRate * 100}% /Day",
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: const Color(
                                                                  0xFF161616),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Loan within 30 mins",
                                                      style: TextStyle(
                                                          fontSize: 12.5.sp,
                                                          color: const Color(
                                                              0xFF000000),
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                  (item["hadSelect"] == true)
                                                      ? Container(
                                                          width: 19.w,
                                                          height: 19.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xff00A651),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        9.5.w)),
                                                          ),
                                                        )
                                                      : Container(
                                                          width: 19.w,
                                                          height: 19.w,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Color(
                                                                      0xffffffff),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius.circular(
                                                                        9.5.w),
                                                                  ),
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          0xffB6B4B4),
                                                                      width:
                                                                          1.w)),
                                                        )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height: 15.h,
                                      );
                                    },
                                  )
                                : Column(
                                    children: [
                                      SizedBox(
                                        height: 50.h,
                                      ),
                                      Image.asset(
                                          'assets/product/product_list_empty.png',
                                          width: 274.w,
                                          height: 274.w),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Text("You have no products to borrow yet",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: const Color(0xFFA7A7A7),
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      PrivacyAgreement()
                                    ],
                                  )))
                  ],
                ),
                backgroundColor: Color(0xffF5F4F2),
                bottomNavigationBar: vc.productList.isNotEmpty
                    ? Container(
                        height: 171,
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            RichText(
                                // textAlign: TextAlign.center,
                                text: TextSpan(
                              // style: TextStyle(height: 2),
                              children: [
                                WidgetSpan(
                                  // alignment: PlaceholderAlignment.middle,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      setState(() {
                                        _switchSelected = !_switchSelected;
                                      });
                                    },
                                    child: Image.asset(
                                        _switchSelected
                                            ? "assets/login/login_select_icon.png"
                                            : "assets/login/login_noselect_icon.png",
                                        width: 18.w,
                                        height: 18.w),
                                  ),
                                ),
                                TextSpan(
                                  text: '  I have read and agreed to the ',
                                  style: TextStyle(
                                      color: const Color(0xFF000000),
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text: '《Loan Agreement》',
                                  style: TextStyle(
                                      color: const Color(0xFF059226),
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // debugPrint("1");
                                      Get.to(() => WebView(
                                            title: Translate.loanAgreement,
                                            url: AppConfig.loanAgreement,
                                          ));
                                    },
                                ),
                              ],
                            )),
                            SizedBox(height: 15),
                            Container(
                              width: 265.w,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF00A651),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextButton(
                                onPressed: () {
                                  if (_switchSelected == false) {
                                    CZLoading.toast(
                                        "Please tick the box to confirm, thanks");
                                    return;
                                  }
                                  List<String> productIds = [];
                                  for (Map item
                                      in HomeController.to.productList) {
                                    if (item["hadSelect"] == true) {
                                      String id = item.containsKey("idxQEzsQ")
                                          ? item["idxQEzsQ"]
                                          : "idxQEzsQ";
                                      productIds.add(id);
                                    }
                                  }
                                  debugPrint("productIds:$productIds");
                                  getTrialData(productIds: productIds);
                                },
                                child: Text("APPLY",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: const Color(0xFFffffff),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            SizedBox(height: 25),
                            PrivacyAgreement(),
                          ],
                        ),
                      )
                    : SizedBox.shrink());
          },
        ));
  }

  //
  getTrialData({required List productIds}) async {
    CZLoading.loading();
    final response = await HomeController.to.requestTrialData(productIds);
    CZLoading.dismiss();
    if (response["statusE8iqlh"] == 0) {
      List<dynamic>? item =
          response.containsKey("modelU8mV9A") ? response["modelU8mV9A"] : null;
      print("item:${item.toString()}");
      if (item != null && item.length > 0) {
        var result = await Get.to(() => ProductConfirmPage(
              itemList: item,
              productIds: productIds,
            ));
      }
    }
  }

  void _requestAllPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sms,
      Permission.camera,
      Permission.location,
    ].request();

    if (PermissionStatus.granted == statuses[Permission.sms] &&
        PermissionStatus.granted == statuses[Permission.camera]) {
      _getDevModel();
      CZLoading.loading();
      await HomeController().requestIncompleteForm();
      CZLoading.dismiss();
    } else {
      if (PermissionStatus.permanentlyDenied == statuses[Permission.sms] ||
          PermissionStatus.permanentlyDenied == statuses[Permission.camera]) {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text(
                    'You need to fully grant permissions to continue'),
                content: const Text(
                    'Please go to Settings to turn on the permissions'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text('Deny',
                        style: TextStyle(color: const Color(0xFF000000))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('OK',
                        style: TextStyle(color: const Color(0xFF000000))),
                    onPressed: () {
                      Navigator.pop(context);
                      //
                      openAppSettings();
                    },
                  ),
                ],
              );
            });
      }
    }
  }

  _getDevModel() async {
    final response = await HomeController().requestDevModel();
    if (response["statusE8iqlh"] == 0) {
      List<dynamic> list = response["listNPJAeA"];
      debugPrint("list111222:$list");
      list.forEach((element) {
        switch (element) {
          case "DEVICE":
            HomeController().requestDeviceInfo();
            break;
          case "APP":
            HomeController().requestApp();
            break;
          case "SMS":
            HomeController().requestSms();
            break;
          case "CONTACT":
            // getContactsList(context);
            break;
          case "PHOTO":
            // getPhoto(context);
            break;
        }
      });
    }
  }
}
