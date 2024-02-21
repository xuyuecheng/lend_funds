import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lend_funds/pages/common/privacy_agreement.dart';
import 'package:lend_funds/pages/feedback/feedback_list_page.dart';
import 'package:lend_funds/pages/repay/repay_rollover_page.dart';
import 'package:lend_funds/pages/repay/repay_upi_page.dart';
import 'package:lend_funds/utils/base/base_view_model.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/time/time_utils.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';

class RepayPage extends StatefulWidget {
  final dynamic model;
  const RepayPage({Key? key, this.model}) : super(key: key);

  @override
  State<RepayPage> createState() => _RepayPageState();
}

class _RepayPageState extends State<RepayPage> {
  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, watch, __) {
      print("model：${widget.model}");
      dynamic loanAmount = widget.model.containsKey("loanAmountfBtogO")
          ? widget.model["loanAmountfBtogO"]
          : null;
      dynamic orderId = widget.model.containsKey("orderIdN1N7lN")
          ? widget.model["orderIdN1N7lN"]
          : null;
      dynamic bankCard = widget.model.containsKey("bankAccounttaar2N")
          ? widget.model["bankAccounttaar2N"]
          : null;
      dynamic expiryTime = widget.model.containsKey("expiryTimegE1p5H")
          ? widget.model["expiryTimegE1p5H"]
          : null;
      dynamic adminAmount = widget.model.containsKey("adminAmountlSq4P1")
          ? widget.model["adminAmountlSq4P1"]
          : null;
      dynamic phone = widget.model.containsKey("phonedD1cuP")
          ? widget.model["phonedD1cuP"]
          : null;
      dynamic loanTerm = widget.model.containsKey("loanTermvVw2io")
          ? widget.model["loanTermvVw2io"]
          : null;
      dynamic interestAmount = widget.model.containsKey("interestAmountGMh3bF")
          ? widget.model["interestAmountGMh3bF"]
          : null;
      dynamic overdueDays = widget.model.containsKey("overdueDaysTbFmj3")
          ? widget.model["overdueDaysTbFmj3"]
          : null;
      return Scaffold(
          backgroundColor: Color(0xffEFF0F3),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  Get.back();
                }),
            title: Text(
              "Order Details",
              style: TextStyle(
                  fontSize: 17.5.sp,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 7.5.w, right: 7.5.w, top: 12.h, bottom: 12.h),
            child: Column(
              children: [
                Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                      color: const Color(0xFFffffff),
                      borderRadius: BorderRadius.circular(5.w)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Repayment amount",
                            style: TextStyle(
                                fontSize: 22.5.sp,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              //
                              Get.to(() => FeedbackListPage(
                                    thirdOrderId: orderId,
                                  ));
                            },
                            child: Image.asset(
                                "assets/order/order_detail_feedback_icon.png",
                                width: 26.w,
                                height: 26.w),
                          ),
                        ],
                      ),
                      Text(
                        "₹ ${loanAmount.toString()}",
                        style: TextStyle(
                            fontSize: 41.sp,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: const Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(5.w)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Loan note number: ",
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    orderId.toString(),
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF9F9F9F),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Phone number:",
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    phone,
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF9F9F9F),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Bank cardnumber:",
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    bankCard.toString(),
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF9F9F9F),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Loan Period(Days):",
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    loanTerm.toString(),
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF9F9F9F),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "End date:",
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '${CZTimeUtils.formatDateTime(expiryTime ?? 0, format: "yyyy-MM-dd HH:mm:ss")}',
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF9F9F9F),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Interest:",
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "₹ ${interestAmount.toString()}",
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF9F9F9F),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total service charge:",
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "₹ ${adminAmount.toString()}",
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF9F9F9F),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 12.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "This Loan Is Provided By A Third-Party Company Sahayak Cash",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF9B9B9B),
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 160.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: const Color(0xFF00A651),
                          borderRadius: BorderRadius.circular(5.w)),
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => RepayUpiPage(
                              amount: loanAmount.toString(),
                              id: orderId,
                              type: "IMMEDIATE"));
                        },
                        child: Text("Repayment",
                            style: TextStyle(
                                fontSize: 17.5.sp,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Container(
                      width: 160.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(5.w)),
                      child: TextButton(
                        onPressed: () {
                          getRolloverPlan(context, orderId);
                        },
                        child: Text("Rollover",
                            style: TextStyle(
                                fontSize: 17.5.sp,
                                color: const Color(0xFF00A651),
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 46,
            child: Column(
              children: [
                SizedBox(height: 10),
                PrivacyAgreement(),
              ],
            ),
          ));
    });
  }
}

getRolloverPlan(BuildContext context, String orderId) async {
  CZLoading.loading();
  final response =
      await context.read(rolloverPlanProvider(orderId)).loadPlanData();
  CZLoading.dismiss();
  if (response["statusE8iqlh"] == 0) {
    // dynamic delayAmount = response.model.containsKey("delayAmount") ? response.model["delayAmount"] : null;
    Get.to(() => RepayRolloverPage(
        model: response["modelU8mV9A"], id: orderId, type: "DELAY"));
  }
}

final rolloverPlanProvider = ChangeNotifierProvider.autoDispose
    .family((ref, orderId) => RolloverPlanModel(orderId.toString()));

class RolloverPlanModel extends BaseModel {
  final String orderId;

  RolloverPlanModel(this.orderId);

  loadPlanData() async {
    final response =
        await HttpRequest.request(InterfaceConfig.rollover_plan, params: {
      "modelU8mV9A": {"orderIdN1N7lN": orderId}
    });
    return response;
  }
}
