import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/common/privacy_agreement.dart';
import 'package:lend_funds/pages/repay/repay_upi_page.dart';
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
          padding: EdgeInsets.only(
              left: 7.5.w, right: 7.5.w, top: 12.h, bottom: 12.h),
          child: Column(
            children: [
              Text(
                "Repayment amount",
                style: TextStyle(
                    fontSize: 22.5.sp,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "₹ ${loanAmount.toString()}",
                style: TextStyle(
                    fontSize: 50.sp,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
                  decoration: BoxDecoration(
                      color: const Color(0xFFffffff),
                      borderRadius: BorderRadius.circular(5.w)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delayed date:",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFF999999),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "${expiryTime.toString()}",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFF292929),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
                decoration: BoxDecoration(
                    color: const Color(0xFFffffff),
                    borderRadius: BorderRadius.circular(5.w)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Extend time:",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xFF999999),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${delayTerm.toString()} DAY",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xFF292929),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
                decoration: BoxDecoration(
                    color: const Color(0xFFffffff),
                    borderRadius: BorderRadius.circular(5.w)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recording delay(max.10000):",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xFF999999),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${delayTimes.toString()} Time",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xFF292929),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Text(
                "This loan is provided by a third-party company Sahayak Cash",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFF9B9B9B),
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 50.h,
                width: 1.sw,
                decoration: BoxDecoration(
                    color: const Color(0xFF00A651),
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
        bottomNavigationBar: Container(
          height: 46,
          child: Column(
            children: [
              SizedBox(height: 10),
              PrivacyAgreement(),
            ],
          ),
        ));
  }
}
