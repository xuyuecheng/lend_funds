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
import 'package:lend_funds/utils/eventbus/eventbus.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/theme/screen_utils.dart';
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
  late RefreshController refreshController;

  @override
  void dispose() {
    //...
    EventBus().off(EventBus.refreshOrderList);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //...
    //监听事件
    EventBus().on(EventBus.refreshOrderList, (arg) async {
      //全部的才会刷新
      if (widget.status == "") {
        await model.refresh();
        refreshController.refreshCompleted();
        refreshController.loadComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    refreshController = RefreshController(initialRefresh: true);
    return Consumer(builder: (_, watch, __) {
      model = watch(basicFormProvider(widget.status));
      return Scaffold(
          backgroundColor: Color(0xffF1F2F3),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
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
                        name = product.containsKey("name")
                            ? product["name"]
                            : null;
                        icon = product.containsKey("icon")
                            ? product["icon"]
                            : null;
                      }
                      print("IMAGE_URL:" + "${DioConfig.IMAGE_URL}$icon");
                      return Row(
                        children: [
                          Container(
                            width: 88.w,
                            height: 200.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.sp),
                                  bottomLeft: Radius.circular(5.sp)),
                              color: Color(0xff003C6A),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network("${DioConfig.IMAGE_URL}$icon",
                                        width: 39.w, height: 39.w),
                                    SizedBox(height: 5.h),
                                    Text("${name.toString()}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12.5.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                Visibility(
                                    visible: mStatus == "LOAN_SUCCESS",
                                    child: Positioned(
                                      left: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          //跳转到反馈界面
                                          Get.to(() => FeedbackListPage(
                                                thirdOrderId: id,
                                              ));
                                        },
                                        child: Image.asset(
                                            "assets/order/order_list_feedback_icon.png",
                                            width: 50.w,
                                            height: 50.w),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              height: 200.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.sp),
                                    bottomRight: Radius.circular(5.sp)),
                                color: Color(0xffffffff),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Loan amount:",
                                              style: TextStyle(
                                                  fontSize: 11.5.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text("₹ ${amount.toString()}",
                                              style: TextStyle(
                                                  fontSize: 11.5.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Loan period(Days):",
                                              style: TextStyle(
                                                  fontSize: 11.5.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text("${term.toString()}",
                                              style: TextStyle(
                                                  fontSize: 11.5.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Loan date:",
                                              style: TextStyle(
                                                  fontSize: 11.5.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              "${CZTimeUtils.formatDateTime(created, format: "yyyy-MM-dd HH:mm:ss")}",
                                              style: TextStyle(
                                                  fontSize: 11.5.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Loan note number:",
                                              style: TextStyle(
                                                  fontSize: 11.5.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(
                                            child: Text(id,
                                                style: TextStyle(
                                                    fontSize: 11.5.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      if (mStatus == "LOAN_SUCCESS") {
                                        //跳转到付款方式选择界面
                                        getPlan(context, id);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 13.w),
                                      width: CZScreenUtils.screenWidth,
                                      // height: 35.h,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(
                                                _getColorFromHex(statusColor)),
                                            borderRadius:
                                                BorderRadius.circular(5.w)),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 7.h),
                                        alignment: Alignment.center,
                                        child: Text(statusName,
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                color: const Color(0xFFFFFFFF),
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
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
