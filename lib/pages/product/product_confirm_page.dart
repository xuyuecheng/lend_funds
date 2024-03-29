import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:sahayak_cash/pages/common/marquee_widget.dart';
import 'package:sahayak_cash/pages/common/model/global_config.dart';
import 'package:sahayak_cash/pages/common/privacy_agreement.dart';
import 'package:sahayak_cash/pages/home/controller/home_controller.dart';
import 'package:sahayak_cash/pages/product/widget/feedback_dialog.dart';
import 'package:sahayak_cash/pages/product/widget/positive_evaluation_dialog.dart';
import 'package:sahayak_cash/pages/product/widget/signature_dialog.dart';
import 'package:sahayak_cash/pages/product/widget/thank_dialog.dart';
import 'package:sahayak_cash/utils/eventbus/eventbus.dart';
import 'package:sahayak_cash/utils/storage/storage_utils.dart';
import 'package:sahayak_cash/utils/toast/toast_utils.dart';

class ProductConfirmPage extends StatefulWidget {
  final List itemList;
  final List productIds;
  const ProductConfirmPage(
      {Key? key, required this.itemList, required this.productIds})
      : super(key: key);

  @override
  State<ProductConfirmPage> createState() => _ProductConfirmPageState();
}

class _ProductConfirmPageState extends State<ProductConfirmPage> {
  bool _isGoogleTestAccount = false;
  @override
  void initState() {
    super.initState();
    //...
    var userInfo = CZStorage.getUserInfo();
    if (userInfo != null) {
      var googleTestAccount = userInfo.containsKey("googleTestIQzU8A")
          ? userInfo["googleTestIQzU8A"]
          : true;
      _isGoogleTestAccount = googleTestAccount;
      debugPrint("googleTestIQzU8A12345:${_isGoogleTestAccount}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F4F2),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              }),
          title: Text(
            "Product confirm",
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
                child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 7.5.w),
                    child: Column(
                      children: [
                        Container(
                          width: 1.sw,
                          padding: EdgeInsets.only(
                              left: 7.w, right: 7.w, top: 7.h, bottom: 7.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.5.w),
                              color: Color(0xffffffff)),
                          child: Column(
                            children: [
                              Text(
                                  "You have applied for ${widget.itemList.length} loan products",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color(0xFF000000),
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 7.5.h,
                              ),
                              Text(
                                  "The details of your loan products are as follows",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: const Color(0xFF000000),
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Column(
                          children: listWidget(),
                        )
                      ],
                    ))),
          ],
        ),
        bottomNavigationBar: Container(
          height: 120,
          child: Column(
            children: [
              SizedBox(height: 5),
              Container(
                width: 265.w,
                height: 45,
                decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(7.5)),
                child: TextButton(
                  onPressed: () async {
                    CZLoading.loading();
                    final response = await HomeController.to
                        .requestLoanData(widget.productIds);
                    CZLoading.dismiss();
                    if (response["statusE8iqlh"] == 0) {
                      if (_isGoogleTestAccount == false) {
                        //有打开好评弹窗
                        if (GlobalConfig.enableFiveStar) {
                          CZDialogUtil.show(PositiveEvaluationDialog(
                              confirmBlock: (int starValue) {
                            debugPrint("starValue:$starValue");
                            //googleplay、app store
                            if (starValue >= 4) {
                              LaunchReview.launch(
                                androidAppId: 'com.sahayak.loan.cash.android',
                                iOSAppId: "",
                              );
                              gotoOrderListPage();
                            }
                            //填写反馈
                            else {
                              CZDialogUtil.show(FeedbackDialog(
                                confirmBlock: (String text) async {
                                  debugPrint("text111:$text");
                                  CZLoading.loading();
                                  //调用反馈的接口
                                  final response =
                                      await HomeController.to.addFeedback(text);
                                  CZLoading.dismiss();
                                  if (response["statusE8iqlh"] == 0) {
                                    CZDialogUtil.show(ThankDialog(
                                      confirmBlock: () {
                                        gotoOrderListPage();
                                      },
                                    ));
                                  }
                                },
                              ));
                            }
                          }));
                        } else {
                          gotoOrderListPage();
                        }
                      } else {
                        //电子签名
                        CZDialogUtil.show(SignatureDialog(
                          confirmBlock: () {
                            gotoOrderListPage();
                          },
                          cancelBlock: () {
                            gotoOrderListPage();
                          },
                        ));
                      }
                    }
                  },
                  child: Text("Confirm",
                      style: TextStyle(
                          fontSize: 18,
                          color: const Color(0xFFffffff),
                          fontWeight: FontWeight.w500)),
                ),
              ),
              SizedBox(height: 20),
              PrivacyAgreement(),
            ],
          ),
        ));
  }

  void gotoOrderListPage() {
    // Get.off(() => OrderPage(
    //       canReturn: true,
    //     ));
    Get.back();
    EventBus().emit(EventBus.changeToOrderTab, null);
    EventBus().emit(EventBus.refreshAllOrderList, null);
    EventBus().emit(EventBus.selectAllOrder, null);
  }

  List<Widget> listWidget() {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.itemList.length; i++) {
      Map itemData = widget.itemList[i];
      dynamic name =
          itemData.containsKey("nameyJEzwD") ? itemData["nameyJEzwD"] : null;
      dynamic productId = itemData.containsKey("productIdhnCnCj")
          ? itemData["productIdhnCnCj"]
          : null;
      dynamic amount = itemData.containsKey("amountVmVZsg")
          ? itemData["amountVmVZsg"]
          : "amountVmVZsg";
      dynamic repayAmount = itemData.containsKey("repayAmounttzUt0n")
          ? itemData["repayAmounttzUt0n"]
          : "repayAmounttzUt0n";
      dynamic adminAmount = itemData.containsKey("adminAmountlSq4P1")
          ? itemData["adminAmountlSq4P1"]
          : "0";
      dynamic actualAmount = itemData.containsKey("actualAmountpwYZWa")
          ? itemData["actualAmountpwYZWa"]
          : "0";
      dynamic term =
          itemData.containsKey("termvXWr1o") ? itemData["termvXWr1o"] : "120";
      dynamic interestAmount = itemData.containsKey("interestAmountGMh3bF")
          ? itemData["interestAmountGMh3bF"]
          : 1;
      widgets.add(Container(
        width: 1.sw,
        padding:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5.w),
            color: Color(0xffffffff)),
        child: Column(
          children: [
            Row(
              children: [
                Text("Product NO:",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500)),
                SizedBox(width: 5.w),
                Text("$productId",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w700)),
              ],
            ),
            SizedBox(height: 13.h),
            Row(
              children: [
                Text("Product Name:",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500)),
                SizedBox(width: 5.w),
                Text("$name",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w700)),
              ],
            ),
            SizedBox(height: 11.h),
            Container(
              height: 0.5.h,
              color: Color(0xffD9D9D9),
            ),
            SizedBox(height: 11.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Loan amount：",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 5.h),
                    Text("₹ ${amount.toString()}",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFF00A651),
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Total service charge",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 5.h),
                    Text("₹ ${adminAmount.toString()}",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFF00A651),
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 11.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Term(Days)",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 5.h),
                    Text("$term",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFF00A651),
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Amount Received",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 5.h),
                    Text("₹ ${actualAmount.toString()}",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFF00A651),
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 11.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Interest",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 5.h),
                    Text("₹ ${interestAmount.toString()}",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFF00A651),
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Repayment amount",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 5.h),
                    Text("₹ ${repayAmount.toString()}",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFF00A651),
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ));
      widgets.add(SizedBox(height: 15.h));
    }
    return widgets;
  }
}
