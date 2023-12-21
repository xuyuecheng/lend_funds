import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lend_funds/pages/feedback/feedback_list_page.dart';
import 'package:lend_funds/pages/repay/repay_page.dart';
import 'package:lend_funds/utils/base/base_view_model.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/time/time_utils.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderListPage extends StatefulWidget {
  final String status;
  const OrderListPage({Key? key, this.status = ""}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  var model;
  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);
    return Consumer(builder: (_, watch, __) {
      model = watch(basicFormProvider(widget.status));
      return Scaffold(
          body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: ClassicFooter(
          loadingText: "loading",
          failedText: "failed",
          noDataText: "noData",
          canLoadingText: "",
          idleText: "idle",
        ),
        onRefresh: () async {
          await model.refresh();
          refreshController.refreshCompleted();
          refreshController.loadComplete();
        },
        onLoading: () async {
          final hasData = await model.loadMore();
          if (hasData) {
            refreshController.loadComplete();
          } else {
            refreshController.loadNoData();
          }
        },
        child: model.data.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                itemCount: model.data.length ?? 0,
                itemBuilder: (context, index) {
                  final item = model.data[index];
                  dynamic id = item.containsKey("id") ? item["id"] : "";
                  dynamic term =
                      item.containsKey("term") ? item["term"] : "120";
                  dynamic product =
                      item.containsKey("product") ? item["product"] : null;
                  dynamic amount =
                      item.containsKey("amount") ? item["amount"] : null;
                  dynamic created =
                      item.containsKey("created") ? item["created"] : null;
                  dynamic statusName = item.containsKey("statusName")
                      ? item["statusName"]
                      : null;
                  dynamic statusColor = item.containsKey("statusColor")
                      ? item["statusColor"]
                      : null;
                  dynamic mStatus =
                      item.containsKey("status") ? item["status"] : null;
                  dynamic name;
                  dynamic icon;
                  if (product != null) {
                    name = product.containsKey("name") ? product["name"] : null;
                    icon = product.containsKey("icon") ? product["icon"] : null;
                  }
                  print("IMAGE_URL:" + "${DioConfig.IMAGE_URL}$icon");
                  return Container(
                      margin: EdgeInsets.only(left: 0, top: 15),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        //设置四周圆角 角度
                        borderRadius: (mStatus == "LOAN_SUCCESS")
                            ? BorderRadius.all(Radius.circular(23))
                            : BorderRadius.only(
                                bottomLeft: Radius.circular(23),
                                bottomRight: Radius.circular(23)),
                        // //设置四周边框
                        border: new Border.all(
                            width: 2,
                            color: (mStatus == "LOAN_SUCCESS")
                                ? Color.fromRGBO(54, 65, 225, 1)
                                : Color.fromRGBO(143, 147, 255, 1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (mStatus == "LOAN_SUCCESS")
                              ? Row(children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      child: MaterialButton(
                                        color: Color.fromRGBO(54, 65, 225, 1),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        child: ListTile(
                                          title: Text("Feedback question",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 15)),
                                          trailing: Image.asset(
                                              "assets/lend_funds_logo.png",
                                              width: 40,
                                              height: 40),
                                        ),
                                        onPressed: () {
                                          //跳转到反馈界面
                                          Get.to(() => FeedbackListPage(
                                                thirdOrderId: id,
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                ])
                              : Container(
                                  width: 0,
                                  height: 0,
                                ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              color: Color.fromRGBO(143, 147, 255, 1),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20)),
                                    // color: Color.fromRGBO(218, 220, 255, 1),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Loan amount",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13)),
                                      SizedBox(height: 4.h),
                                      Text(
                                        "₹ ${amount.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      SizedBox(height: 16.h),
                                      Text("Loan period(Days)",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13)),
                                      SizedBox(height: 4.h),
                                      Text("₹ ${term.toString()}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 16.h),
                                      Text("Loan date",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13)),
                                      SizedBox(height: 4.h),
                                      Text(
                                          "${CZTimeUtils.formatDateTime(created, format: "yyyy-MM-dd HH:mm:ss")}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 16.h),
                                      Text("Loan note number",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13)),
                                      SizedBox(height: 4.h),
                                      Text(id,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),

                                // const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                          "${DioConfig.IMAGE_URL}$icon",
                                          width: 30,
                                          height: 30),
                                      SizedBox(height: 8.h),
                                      Text("${name.toString()}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 8.h),
                                      MaterialButton(
                                        // color: Color.fromRGBO(54, 65, 225, 1),
                                        color: Color(
                                            _getColorFromHex(statusColor)),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(statusName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () {
                                          if (mStatus == "LOAN_SUCCESS") {
                                            //跳转到付款方式选择界面
                                            getPlan(context, id);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 15.h,
                  );
                },
              )
            : Center(
                child: Image.asset('assets/order/order_list_empty.png',
                    width: 227.w, height: 223.w),
              ),
      ));
    });
  }

  int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

final basicFormProvider = ChangeNotifierProvider.autoDispose
    .family((ref, status) => BasicFormModel(status.toString()));

class BasicFormModel extends BaseListModel<dynamic> {
  final String status;

  BasicFormModel(this.status);

  loadData() async {
    this.loading = true;
    Map<String, dynamic> params;
    if (status.length > 0) {
      params = {
        "query": {"status": status, "pageNo": this.page, "pageSize": 10}
      };
    } else {
      params = {
        "query": {"pageNo": this.page, "pageSize": 10}
      };
    }

    final response =
        await HttpRequest.request(InterfaceConfig.order_list, params: params);
    List<dynamic> contents = response["page"].containsKey("content")
        ? response["page"]["content"]
        : [];
    if (kDebugMode) {
      log("orderList:${json.encode(contents)}");
    }
    return contents;
  }
}

getPlan(BuildContext context, String orderId) async {
  CZLoading.loading();
  final response = await context.read(planProvider(orderId)).loadPlanData();
  CZLoading.dismiss();
  if (response["status"] == 0) {
    //跳转
    Get.to(() => RepayPage(
          model: response["model"],
        ));
  }
}

final planProvider = ChangeNotifierProvider.autoDispose
    .family((ref, orderId) => PlanModel(orderId.toString()));

class PlanModel extends BaseModel {
  final String orderId;

  PlanModel(this.orderId);

  loadPlanData() async {
    final response =
        await HttpRequest.request(InterfaceConfig.repayment_plan, params: {
      "model": {"orderId": orderId}
    });
    return response;
  }
}
