import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/common/privacy_agreement.dart';
import 'package:lend_funds/pages/home/controller/home_controller.dart';
import 'package:lend_funds/pages/home/view/widget/home_product_dialog.dart';
import 'package:lend_funds/pages/order/view/order_page.dart';
import 'package:lend_funds/utils/eventbus/eventbus.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';
import 'package:permission_handler/permission_handler.dart';
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
                padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                // reverse: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45.h,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text("Hello user",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            width: 3.w,
                          ),
                          Image.asset(
                            "assets/home/home_welcome_icon.png",
                            width: 20.w,
                            height: 20.w,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 19.h,
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
                                                  fontWeight: FontWeight.w500)),
                                          Text("360 days",
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.w500)),
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
                                                  fontWeight: FontWeight.w500)),
                                          Text("0.05% per day",
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.w500)),
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
                                  requestAllPermission();
                                },
                                child: Text("Apply Now",
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w700)),
                              ),
                            ))
                      ],
                    )),
                    SizedBox(
                      height: 11.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/home/choose_cash_left.png",
                          width: 49.w,
                          height: 6.h,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text("Reasons to choose Cash Home",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF464646),
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          width: 5.w,
                        ),
                        Image.asset(
                          "assets/home/choose_cash_right.png",
                          width: 49.w,
                          height: 6.h,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 11.w,
                        ),
                        Image.asset(
                          "assets/home/high_quota_icon.png",
                          width: 39.w,
                          height: 39.w,
                        ),
                        SizedBox(
                          width: 7.5.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("High quota",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF464646),
                                    fontWeight: FontWeight.w700)),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                                "The maximum amount is 10,000~100,000 rupees, and there is no charge if the credit line is not used",
                                style: TextStyle(
                                    fontSize: 6.sp,
                                    color: const Color(0xFFBEBEBE),
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        SizedBox(
                          width: 11.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 11.w,
                        ),
                        Image.asset(
                          "assets/home/approval_fast_icon.png",
                          width: 39.w,
                          height: 39.w,
                        ),
                        SizedBox(
                          width: 7.5.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Approval fast",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF464646),
                                    fontWeight: FontWeight.w700)),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                                "Online application, automatic approval, arrive within 24 hours",
                                style: TextStyle(
                                    fontSize: 6.sp,
                                    color: const Color(0xFFBEBEBE),
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        SizedBox(
                          width: 11.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 47.h,
                    ),
                    Center(
                      child: PrivacyAgreement(),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 15.w),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Welcome！",
                    //           style: TextStyle(
                    //               fontSize: 25.sp,
                    //               color: const Color(0xFF292929),
                    //               fontWeight: FontWeight.w500)),
                    //       SizedBox(
                    //         height: 13.h,
                    //       ),
                    //       Container(
                    //         height: 154.w,
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Container(
                    //                 width: 154.w,
                    //                 height: 154.w,
                    //                 padding:
                    //                     EdgeInsets.symmetric(horizontal: 10.w),
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.all(
                    //                       Radius.circular(26.w)),
                    //                   gradient: LinearGradient(
                    //                     begin: Alignment.topLeft,
                    //                     end: Alignment.bottomLeft,
                    //                     colors: [
                    //                       Color(0xffF3A135),
                    //                       Color(0xffF5C069)
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 child: Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     SizedBox(
                    //                       height: 10.w,
                    //                     ),
                    //                     Image.asset(
                    //                         'assets/home/home_loan_amount_icon.png',
                    //                         width: 50.5.w,
                    //                         height: 50.5.w),
                    //                     SizedBox(
                    //                       height: 22.5.w,
                    //                     ),
                    //                     Text("Maximum loan amount",
                    //                         style: TextStyle(
                    //                             fontSize: 11.sp,
                    //                             color: const Color(0xFF000000),
                    //                             fontWeight: FontWeight.w500)),
                    //                     Text("₹ 500,000",
                    //                         style: TextStyle(
                    //                             fontSize: 25.sp,
                    //                             color: const Color(0xFF000000),
                    //                             fontWeight: FontWeight.w500)),
                    //                   ],
                    //                 )),
                    //             Container(
                    //                 width: 154.w,
                    //                 height: 154.w,
                    //                 padding:
                    //                     EdgeInsets.symmetric(horizontal: 10.w),
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.all(
                    //                       Radius.circular(26.w)),
                    //                   color: Color(0xffCFDEEA),
                    //                 ),
                    //                 child: Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     SizedBox(
                    //                       height: 15.w,
                    //                     ),
                    //                     Image.asset(
                    //                         'assets/home/home_loan_term_icon.png',
                    //                         width: 40.5.w,
                    //                         height: 40.5.w),
                    //                     SizedBox(
                    //                       height: 27.5.w,
                    //                     ),
                    //                     Text("Maximum loan term",
                    //                         style: TextStyle(
                    //                             fontSize: 11.sp,
                    //                             color: const Color(0xFF000000),
                    //                             fontWeight: FontWeight.w500)),
                    //                     Text("360 days",
                    //                         style: TextStyle(
                    //                             fontSize: 25.sp,
                    //                             color: const Color(0xFF000000),
                    //                             fontWeight: FontWeight.w500)),
                    //                   ],
                    //                 )),
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 12.h,
                    //       ),
                    //       Container(
                    //         child: Stack(
                    //           alignment: AlignmentDirectional.center,
                    //           children: [
                    //             Image.asset(
                    //                 'assets/home/home_credit_loan_backgro.png',
                    //                 fit: BoxFit.fill),
                    //             Positioned(
                    //               top: 20.h,
                    //               left: 0,
                    //               right: 0,
                    //               child: Row(
                    //                 children: [
                    //                   Expanded(
                    //                       child: Column(
                    //                     children: [
                    //                       Image.asset(
                    //                         'assets/home/home_credit_loans.png',
                    //                         width: 40.5.w,
                    //                         height: 40.5.w,
                    //                       ),
                    //                       SizedBox(
                    //                         height: 6.5.h,
                    //                       ),
                    //                       Text("Credit Loans",
                    //                           style: TextStyle(
                    //                               fontSize: 12.5.sp,
                    //                               color:
                    //                                   const Color(0xFF000000),
                    //                               fontWeight:
                    //                                   FontWeight.normal))
                    //                     ],
                    //                   )),
                    //                   Expanded(
                    //                       child: Column(
                    //                     children: [
                    //                       Image.asset(
                    //                         'assets/home/home_automatic_review.png',
                    //                         width: 40.5.w,
                    //                         height: 40.5.w,
                    //                       ),
                    //                       SizedBox(
                    //                         height: 6.5.h,
                    //                       ),
                    //                       Text("Automatic review",
                    //                           style: TextStyle(
                    //                               fontSize: 12.5.sp,
                    //                               color:
                    //                                   const Color(0xFF000000),
                    //                               fontWeight:
                    //                                   FontWeight.normal))
                    //                     ],
                    //                   )),
                    //                   Expanded(
                    //                       child: Column(
                    //                     children: [
                    //                       Image.asset(
                    //                         'assets/home/home_safe_reliable.png',
                    //                         width: 40.5.w,
                    //                         height: 40.5.w,
                    //                       ),
                    //                       SizedBox(
                    //                         height: 6.5.h,
                    //                       ),
                    //                       Text("Safe and reliable",
                    //                           style: TextStyle(
                    //                               fontSize: 12.5.sp,
                    //                               color:
                    //                                   const Color(0xFF000000),
                    //                               fontWeight:
                    //                                   FontWeight.normal))
                    //                     ],
                    //                   )),
                    //                 ],
                    //               ),
                    //             ),
                    //             Positioned(
                    //                 // left: 0,
                    //                 // right: 0,
                    //                 bottom: 12.h,
                    //                 child: Text(
                    //                     "The loan limit is allocated based on personal credit",
                    //                     style: TextStyle(
                    //                         fontSize: 11.sp,
                    //                         color: const Color(0xFFFFFFFF),
                    //                         fontWeight: FontWeight.normal)))
                    //           ],
                    //         ),
                    //       ),
                    //       vc.forms.isNotEmpty
                    //           ? _createRecommend()
                    //           : _createProducts()
                    //     ],
                    //   ),
                    // ),
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
              String id = item.containsKey("idxQEzsQ") ? item["idxQEzsQ"] : "";
              String name =
                  item.containsKey("nameyJEzwD") ? item["nameyJEzwD"] : "loan";
              String icon = item.containsKey("iconKzUZic")
                  ? item["iconKzUZic"]
                  : "iconKzUZic";
              dynamic amount = item.containsKey("amountVmVZsg")
                  ? item["amountVmVZsg"]
                  : "amountVmVZsg";
              dynamic serviceAmount = item.containsKey("serviceAmountyNv9UA")
                  ? item["serviceAmountyNv9UA"]
                  : "0";
              dynamic term =
                  item.containsKey("termvXWr1o") ? item["termvXWr1o"] : "0";
              dynamic dayRate =
                  item.containsKey("dayRatepSGZ9K") ? item["dayRatepSGZ9K"] : 1;
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
                                //
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

  //
  _getTrialData({required List productIds}) async {
    CZLoading.loading();
    final response = await HomeController.to.requestTrialData(productIds);
    CZLoading.dismiss();
    if (response["statusE8iqlh"] == 0) {
      List<dynamic>? item =
          response.containsKey("modelU8mV9A") ? response["modelU8mV9A"] : null;
      print("item:${item.toString()}");
      if (item != null && item.length > 0) {
        CZDialogUtil.show(HomeProductDialog(
            itemList: item,
            confirmBlock: () async {
              CZLoading.loading();
              final response =
                  await HomeController.to.requestLoanData(productIds);
              CZLoading.dismiss();
              if (response["statusE8iqlh"] == 0) {
                CZDialogUtil.dismiss();
                //
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
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sms,
      Permission.camera,
      Permission.phone,
      Permission.bluetooth,
      // Permission.contacts,
      // Permission.storage
    ].request();

    if (PermissionStatus.granted == statuses[Permission.sms] &&
            PermissionStatus.granted == statuses[Permission.camera] &&
            PermissionStatus.granted == statuses[Permission.phone] &&
            PermissionStatus.granted == statuses[Permission.bluetooth]
        // && PermissionStatus.granted == statuses[Permission.contacts]
        ) {
      getDevModel();
      CZLoading.loading();
      await HomeController().requestIncompleteForm();
      CZLoading.dismiss();
    } else {
      if (PermissionStatus.denied == statuses[Permission.sms] ||
              PermissionStatus.denied == statuses[Permission.camera] ||
              PermissionStatus.denied == statuses[Permission.phone] ||
              PermissionStatus.denied == statuses[Permission.bluetooth]
          // || PermissionStatus.denied == statuses[Permission.contacts]
          ) {
        requestAllPermission();
      }
      if (PermissionStatus.permanentlyDenied == statuses[Permission.sms] ||
              PermissionStatus.permanentlyDenied ==
                  statuses[Permission.camera] ||
              PermissionStatus.permanentlyDenied ==
                  statuses[Permission.phone] ||
              PermissionStatus.permanentlyDenied ==
                  statuses[Permission.bluetooth]
          // || PermissionStatus.permanentlyDenied == statuses[Permission.contacts]
          ) {
        //
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('You need to grant album permissions'),
                content: const Text(
                    'Please go to your phone settings to turn on the corresponding permissions'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text('cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('confirm'),
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

  getDevModel() async {
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
