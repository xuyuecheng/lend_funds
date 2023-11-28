import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/home/view/widget/home_product_dialog.dart';
import 'package:lend_funds/utils/route/route_config.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        // reverse: true,
        child: ConstraintLayout(
          width: 1.sw,
          height: matchParent,
          children: [
            Text("Lend Funds",
                    style: TextStyle(
                        fontSize: 25.sp,
                        color: const Color(0xFF003C6A),
                        fontWeight: FontWeight.w500))
                .applyConstraint(
                    id: cId('text1'),
                    topLeftTo: parent.topMargin(30.h).leftMargin(15.w)),
            Container(
              width: 1.sw,
              height: 1.5.h,
              color: Color(0xff000000),
            ).applyConstraint(
                id: cId('cont1'), topLeftTo: parent.topMargin(65.h)),
            Text("Welcome！",
                    style: TextStyle(
                        fontSize: 25.sp,
                        color: const Color(0xFF292929),
                        fontWeight: FontWeight.w500))
                .applyConstraint(
                    id: cId('text2'),
                    topLeftTo: parent.topMargin(86.h).leftMargin(15.w)),
            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              height: 154.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 154.w,
                      height: 154.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(26.w)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [Color(0xffF3A135), Color(0xffF5C069)],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.w,
                          ),
                          Image.asset('assets/home/home_loan_amount_icon.png',
                              width: 50.5.w, height: 50.5.w),
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
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(26.w)),
                        color: Color(0xffCFDEEA),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15.w,
                          ),
                          Image.asset('assets/home/home_loan_term_icon.png',
                              width: 40.5.w, height: 40.5.w),
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
            ).applyConstraint(
                id: cId('cont2'), topCenterTo: parent.topMargin(134.h)),
            Container(
              width: 1.sw - 30.w,
              // padding: EdgeInsets.symmetric(horizontal: 15.w),
              height: 120.5.w,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  // borderRadius: BorderRadius.circular(15.w),
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/home/home_credit_loan_backgro.png"),
                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
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
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.normal))
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
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
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.normal))
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
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
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.normal))
                        ],
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text("The loan limit is allocated based on personal credit",
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.normal))
                ],
              ),
            ).applyConstraint(
                id: cId('cont3'), topCenterTo: parent.topMargin(291.5.h)),
            _createRecommend(),
            // _createProducts(),
          ],
        ),
      )),
      backgroundColor: Colors.white,
    );
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
            width: 1.sw - 30.w,
            height: 124.5.h,
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
                      onTap: () {
                        Get.toNamed(CZRouteConfig.uploadPersonalInforma);
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
          Container(
            width: 1.sw - 30.w,
            height: 118.h,
            child: Image.asset(
              'assets/home/home_interest_rate_icon.png',
            ),
          ),
        ],
      ),
    ).applyConstraint(
        id: cId('cont4'), topLeftTo: parent.topMargin(412.h).leftMargin(15.w));
  }

  Widget _createProducts() {
    return Container(
      width: 1.sw - 30.w,
      child: Column(
        children: [
          SizedBox(
            height: 17.5.h,
          ),
          ListView.separated(
            itemCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // final item = vc.payObject["content"][index];
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
                            Image.asset(
                              'assets/lend_funds_logo.png',
                              width: 27.5.w,
                              height: 27.5.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Loan on",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: const Color(0xFF161616),
                                        fontWeight: FontWeight.w500)),
                                Text("Loan within 30 mins",
                                    style: TextStyle(
                                        fontSize: 7.5.sp,
                                        color: const Color(0xFF929292),
                                        fontWeight: FontWeight.w500)),
                              ],
                            )
                          ],
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            CZDialogUtil.show(
                                HomeProductDialog(confirmBlock: () {
                              CZDialogUtil.dismiss();
                            }));
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
                        Expanded(
                            child: Column(
                          children: [
                            Text("Loan amount",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text("₹ 200,000",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500))
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Text("Repayment amount",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text("₹ 200,000",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500))
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Text("loan term",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text("95 days",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500))
                          ],
                        )),
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
                    Text("Daily interest rate from 0.05%",
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
    ).applyConstraint(
        id: cId('cont4'), topLeftTo: parent.topMargin(412.h).leftMargin(15.w));
  }
}
