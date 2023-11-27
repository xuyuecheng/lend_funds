import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeProductDialog extends StatelessWidget {
  final Function() confirmBlock;
  const HomeProductDialog({Key? key, required this.confirmBlock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 345.w,
            decoration: BoxDecoration(
                color: Colors.transparent,
                // borderRadius: BorderRadius.circular(15.w),
                image: DecorationImage(
                    image: AssetImage(
                        'assets/home/home_product_dialog_background.png'),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                SizedBox(
                  height: 40.5.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text("You have applied for 1 loan products",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.5.sp,
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 10.5.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                      "The details of your loan products are as follows",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.5.sp,
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 59.5.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Product NO:",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                      SizedBox(
                        height: 7.5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Loan products：",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500)),
                          Text("Term (Days):",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Go Rupee",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500)),
                          Text("7 DAY",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                      SizedBox(
                        height: 18.5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Loan amount：",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500)),
                          Text("Daily interest rate:",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("₹ 9000",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500)),
                          Text("0.10%",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                      SizedBox(
                        height: 18.5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("GST：",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500)),
                          Text("Amount Received:",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("₹ 481",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500)),
                          Text("₹ 5848",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                      SizedBox(
                        height: 18.5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total interest and service fee：",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("₹ 2671",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 23.5.h,
                ),
                Container(
                  width: 325.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: const Color(0xFF003C6A),
                      borderRadius: BorderRadius.circular(5.w)),
                  child: TextButton(
                    onPressed: () {
                      confirmBlock();
                    },
                    child: Text("Confirm",
                        style: TextStyle(
                            fontSize: 22.5.sp,
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(
                  height: 21.5.h,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
