import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    final theme = Theme.of(context);
    return Consumer(builder: (_, watch, __) {
      print("model：${widget.model}");
      dynamic loanAmount = widget.model.containsKey("loanAmount")
          ? widget.model["loanAmount"]
          : null;
      dynamic orderId =
          widget.model.containsKey("orderId") ? widget.model["orderId"] : null;
      dynamic bankCard = widget.model.containsKey("bankCard")
          ? widget.model["bankCard"]
          : null;
      dynamic expiryTime = widget.model.containsKey("expiryTime")
          ? widget.model["expiryTime"]
          : null;
      dynamic adminAmount = widget.model.containsKey("adminAmount")
          ? widget.model["adminAmount"]
          : null;
      dynamic phone =
          widget.model.containsKey("phone") ? widget.model["phone"] : null;
      dynamic loanTerm = widget.model.containsKey("loanTerm")
          ? widget.model["loanTerm"]
          : null;
      dynamic interestAmount = widget.model.containsKey("interestAmount")
          ? widget.model["interestAmount"]
          : null;
      dynamic overdueDays = widget.model.containsKey("overdueDays")
          ? widget.model["overdueDays"]
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
            "Lend Funds",
            style: TextStyle(
                fontSize: 17.5.sp,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              color: Color.fromRGBO(240, 240, 240, 1),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: MaterialButton(
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: ListTile(
                              leading: Image.asset("assets/lend_funds_logo.png",
                                  width: 30, height: 30),
                              title: Text("Small Credit",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 25)),
                              trailing: Image.asset(
                                  "assets/lend_funds_logo.png",
                                  width: 30,
                                  height: 30)),
                          onPressed: () async {
                            //跳转到反馈界面
                            Get.to(() => FeedbackListPage(
                                  thirdOrderId: orderId,
                                ));
                          },
                        ),
                      ),
                    ),
                  ),
                  Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: MaterialButton(
                          color: Color.fromRGBO(54, 65, 225, 1),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Text("Repayment amount",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                              Text("₹ ${loanAmount.toString()}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ]),
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    // decoration: const BoxDecoration(
                    //   borderRadius: const BorderRadius.only(
                    //       bottomLeft: Radius.circular(20),
                    //       bottomRight: Radius.circular(20)),
                    // ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Loan note number",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                orderId.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text("Bank card number",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(bankCard.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text("End date",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                  "${CZTimeUtils.formatDateTime(expiryTime ?? 0, format: "yyyy-MM-dd HH:mm:ss")}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text("Total service charge",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(adminAmount.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Phone number",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                phone,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text("Term(Days)",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(loanTerm.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text("Interest",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(interestAmount.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text("Overdue Days",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text("${overdueDays.toString()}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: MaterialButton(
                          color: Color.fromRGBO(34, 210, 137, 1),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20))),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text("Full Repayment",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 17)),
                          onPressed: () {
                            Get.to(() => RepayUpiPage(
                                amount: loanAmount.toString(),
                                id: orderId,
                                type: "IMMEDIATE"));
                            // AppRouter.navigate(context, AppRoute.upi_repay, params: {"amount" : loanAmount.toString(), "id" : orderId, "type" : "IMMEDIATE"}, finishSelf: false);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: MaterialButton(
                          color: Color.fromRGBO(54, 65, 225, 1),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20))),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text("Rollover",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 17)),
                          onPressed: () {
                            getRolloverPlan(context, orderId);
                          },
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ]),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "*This loan is provided by a third-party company\nSmall Credit",
            textAlign: TextAlign.center,
            style: theme.textTheme.caption,
          ),
        ),
      );
    });
  }
}

getRolloverPlan(BuildContext context, String orderId) async {
  CZLoading.loading();
  final response =
      await context.read(rolloverPlanProvider(orderId)).loadPlanData();
  CZLoading.dismiss();
  if (response["status"] == 0) {
    // dynamic delayAmount = response.model.containsKey("delayAmount") ? response.model["delayAmount"] : null;
    Get.to(() => RepayRolloverPage(
        model: response["model"], id: orderId, type: "DELAY"));
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
      "model": {"orderId": orderId}
    });
    return response;
  }
}
