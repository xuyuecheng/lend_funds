import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lend_funds/pages/common/privacy_agreement.dart';
import 'package:lend_funds/pages/feedback/feedback_list_page.dart';
import 'package:lend_funds/pages/repay/repay_page.dart';
import 'package:lend_funds/utils/base/base_view_model.dart';
import 'package:lend_funds/utils/eventbus/eventbus.dart';
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
    //listen event
    EventBus().on(EventBus.refreshOrderList, (arg) async {
      //all update
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
        backgroundColor: Color(0xffEFF0F3),
        body: Column(
          children: [
            model.data.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            debugPrint("onTap");
                            EventBus().emit(EventBus.changeToHomeTab, null);
                          },
                          child: Image.asset(
                            "assets/order/order_another_one_icon.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  )
                : SizedBox.shrink(),
            Expanded(
                child: SmartRefresher(
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 7.5.w, vertical: 15.w),
                      itemCount: model.data.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = model.data[index];
                        dynamic id = item.containsKey("id") ? item["id"] : "";
                        dynamic term = item.containsKey("termvXWr1o")
                            ? item["termvXWr1o"]
                            : "120";
                        dynamic product = item.containsKey("productI8T9N3")
                            ? item["productI8T9N3"]
                            : null;
                        dynamic amount = item.containsKey("amountVmVZsg")
                            ? item["amountVmVZsg"]
                            : null;
                        dynamic created = item.containsKey("createdfouYQX")
                            ? item["createdfouYQX"]
                            : null;
                        dynamic statusName = item.containsKey("statusName")
                            ? item["statusName"]
                            : null;
                        dynamic statusColor = item.containsKey("statusColor")
                            ? item["statusColor"]
                            : null;
                        dynamic mStatus = item.containsKey("statusE8iqlh")
                            ? item["statusE8iqlh"]
                            : null;
                        dynamic name;
                        dynamic icon;
                        if (product != null) {
                          name = product.containsKey("nameyJEzwD")
                              ? product["nameyJEzwD"]
                              : null;
                          icon = product.containsKey("iconKzUZic")
                              ? product["iconKzUZic"]
                              : null;
                        }
                        print("IMAGE_URL:" + "${DioConfig.IMAGE_URL}$icon");
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            if (mStatus == "LOAN_SUCCESS") {
                              getPlan(context, id);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 11.5.w,
                                right: 11.5.w,
                                top: 11.5.h,
                                bottom: 11.5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.w),
                                color: Color(0xffffffff)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                            "${DioConfig.IMAGE_URL}$icon",
                                            width: 27.w,
                                            height: 27.w),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text("${name.toString()}",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    Text(statusName,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Color(
                                                _getColorFromHex(statusColor)),
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                SizedBox(height: 11.5.h),
                                Container(
                                  height: 0.5.h,
                                  color: Color(0xffC5C3C3),
                                ),
                                SizedBox(height: 11.5.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Loanamount:",
                                        style: TextStyle(
                                            fontSize: 11.5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                    Text("₹ ${amount.toString()}",
                                        style: TextStyle(
                                            fontSize: 11.5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                SizedBox(height: 11.5.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Loan Period(Days):",
                                        style: TextStyle(
                                            fontSize: 11.5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                    Text("${term.toString()}",
                                        style: TextStyle(
                                            fontSize: 11.5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                SizedBox(height: 11.5.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Loan date:",
                                        style: TextStyle(
                                            fontSize: 11.5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                        "${CZTimeUtils.formatDateTime(created, format: "yyyy-MM-dd HH:mm:ss")}",
                                        style: TextStyle(
                                            fontSize: 11.5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                SizedBox(height: 11.5.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Loan notenumber:",
                                        style: TextStyle(
                                            fontSize: 11.5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                    Text(id,
                                        style: TextStyle(
                                            fontSize: 11.5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                (mStatus == "LOAN_SUCCESS")
                                    ? Column(
                                        children: [
                                          // SizedBox(height: 11.5.h),
                                          GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            onTap: () {
                                              Get.to(() => FeedbackListPage(
                                                    thirdOrderId: id,
                                                  ));
                                            },
                                            child: Image.asset(
                                              "assets/order/order_list_feedback_icon.png",
                                              width: 181,
                                              height: 43,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        ],
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 15.h,
                        );
                      },
                    )
                  : Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Positioned(
                          top: 100.h,
                          child: Image.asset(
                              'assets/order/order_list_empty.png',
                              width: 227.w,
                              height: 223.w),
                        ),
                        Positioned(
                          bottom: 25.h,
                          child: PrivacyAgreement(),
                        ),
                      ],
                    ),
            ))
          ],
        ),
        bottomNavigationBar: model.data.isNotEmpty
            ? Container(
                height: 46,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    PrivacyAgreement(),
                  ],
                ),
              )
            : SizedBox.shrink(),
      );
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
        "queryBQDz08": {
          "statusE8iqlh": status,
          "pageNowNjald": this.page,
          "pageSizeUTP2dN": 10
        }
      };
    } else {
      params = {
        "queryBQDz08": {"pageNowNjald": this.page, "pageSizeUTP2dN": 10}
      };
    }

    final response =
        await HttpRequest.request(InterfaceConfig.order_list, params: params);
    List<dynamic> contents = response["pageLosuN4"].containsKey("contentCxb7jm")
        ? response["pageLosuN4"]["contentCxb7jm"]
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
  if (response["statusE8iqlh"] == 0) {
    //
    Get.to(() => RepayPage(
          model: response["modelU8mV9A"],
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
      "modelU8mV9A": {"orderIdN1N7lN": orderId}
    });
    return response;
  }
}
