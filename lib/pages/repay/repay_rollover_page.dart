import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/repay/repay_upi_page.dart';
import 'package:lend_funds/utils/theme/screen_utils.dart';
import 'package:lend_funds/utils/time/time_utils.dart';

class RepayRolloverPage extends HookWidget {
  final dynamic model;
  final dynamic id;
  final dynamic type;

  RepayRolloverPage({Key? key, this.model, this.id, this.type})
      : super(key: key);

  var rolloverState;
  @override
  Widget build(BuildContext context) {
    dynamic delayAmount = model.containsKey("delayAmountk18tFe")
        ? model["delayAmountk18tFe"]
        : null;
    dynamic expiryTime = model.containsKey("expiryTimegE1p5H")
        ? model["expiryTimegE1p5H"]
        : null;
    dynamic loanAmount = model.containsKey("loanAmountfBtogO")
        ? model["loanAmountfBtogO"]
        : null;
    expiryTime =
        "${CZTimeUtils.formatDateTime(expiryTime, format: "yyyy-MM-dd HH:mm:ss")}";
    dynamic delayTerm =
        model.containsKey("delayTermUO5Grw") ? model["delayTermUO5Grw"] : null;
    dynamic delayTimes = model.containsKey("delayTimesp1w7Cd")
        ? model["delayTimesp1w7Cd"]
        : null;
    return Scaffold(
      backgroundColor: Color(0xffF1F2F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            }),
        title: Text(
          "Rollover",
          style: TextStyle(
              fontSize: 17.5.sp,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
        child: Column(
          children: [
            Container(
              width: CZScreenUtils.screenWidth - 30.w,
              decoration: BoxDecoration(
                  color: const Color(0xFFffffff),
                  borderRadius: BorderRadius.circular(5.w)),
              child: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    "Repayment amount",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "₹ ${loanAmount.toString()}",
                    style: TextStyle(
                        fontSize: 50.sp,
                        color: const Color(0xFF003C6A),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                    color: const Color(0xFFffffff),
                    borderRadius: BorderRadius.circular(5.w)),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delayed date:",
                            style: TextStyle(
                                fontSize: 12.5.sp,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${expiryTime.toString()}",
                            style: TextStyle(
                                fontSize: 12.5.sp,
                                color: const Color(0xFF9F9F9F),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(vertical: 11.h),
                    ),
                    Container(
                      height: 0.25.h,
                      color: Color(0xffC5C3C3),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Extend time:",
                            style: TextStyle(
                                fontSize: 12.5.sp,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${delayTerm.toString()} DAY",
                            style: TextStyle(
                                fontSize: 12.5.sp,
                                color: const Color(0xFF9F9F9F),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(vertical: 11.h),
                    ),
                    Container(
                      height: 0.25.h,
                      color: Color(0xffC5C3C3),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recording delay(max.10000):",
                            style: TextStyle(
                                fontSize: 12.5.sp,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${delayTimes.toString()} Time",
                            style: TextStyle(
                                fontSize: 12.5.sp,
                                color: const Color(0xFF9F9F9F),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(vertical: 11.h),
                    ),
                  ],
                )),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 50.h,
              width: CZScreenUtils.screenWidth - 30.w,
              decoration: BoxDecoration(
                  color: const Color(0xFF003C6A),
                  borderRadius: BorderRadius.circular(5.w)),
              child: TextButton(
                onPressed: () {
                  Get.to(() => RepayUpiPage(
                      amount: delayAmount.toString(), id: id, type: "DELAY"));
                },
                child: Text("Need to repay loan ₹ ${delayAmount.toString()}",
                    style: TextStyle(
                        fontSize: 17.5.sp,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
        child: Text(
          "This loan is provided by a third-party company Lend Funds",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 10.sp,
              color: const Color(0xFF9B9B9B),
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
