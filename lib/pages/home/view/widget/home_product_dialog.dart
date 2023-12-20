import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';

class HomeProductDialog extends StatelessWidget {
  final List itemList;
  final Function() confirmBlock;
  const HomeProductDialog(
      {Key? key, required this.confirmBlock, required this.itemList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map itemData = itemList[0];
    dynamic name = itemData.containsKey("name") ? itemData["name"] : null;
    dynamic productId =
        itemData.containsKey("productId") ? itemData["productId"] : null;
    dynamic amount =
        itemData.containsKey("amount") ? itemData["amount"] : "amount";
    dynamic repayAmount = itemData.containsKey("repayAmount")
        ? itemData["repayAmount"]
        : "repayAmount";
    dynamic adminAmount =
        itemData.containsKey("adminAmount") ? itemData["adminAmount"] : "0";
    dynamic actualAmount =
        itemData.containsKey("actualAmount") ? itemData["actualAmount"] : "0";
    dynamic term = itemData.containsKey("term") ? itemData["term"] : "120";
    dynamic interestAmount =
        itemData.containsKey("interestAmount") ? itemData["interestAmount"] : 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
                child: Text(
                    "You have applied for ${itemList.length} loan products",
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
                child: Text("The details of your loan products are as follows",
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
                        Text("Product NO:$productId",
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
                        Text(name,
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w500)),
                        Text("$term",
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
                        Text("Total service charge:",
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
                        Text("₹ ${amount.toString()}",
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w500)),
                        Text("₹ ${adminAmount.toString()}",
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
                        Text("Interest：",
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
                        Text("₹ ${interestAmount.toString()}",
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w500)),
                        Text("₹ ${actualAmount.toString()}",
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
                        Text("Repayment amount：",
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
                        Text("₹ ${repayAmount.toString()}",
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
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        CZDialogUtil.dismiss();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: 150.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: const Color(0xFF003C6A),
                              borderRadius: BorderRadius.circular(5.w)),
                          child: Text("Cancel",
                              style: TextStyle(
                                  fontSize: 22.5.sp,
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w500))),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        confirmBlock();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            color: const Color(0xFF003C6A),
                            borderRadius: BorderRadius.circular(5.w)),
                        child: Text("Confirm",
                            style: TextStyle(
                                fontSize: 22.5.sp,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 21.5.h,
              ),
            ],
          ),
        )
      ],
    );
  }
}
