import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lend_funds/pages/repay/repay_upi_page.dart';
import 'package:lend_funds/utils/base/base_view_model.dart';
import 'package:lend_funds/utils/entity/syscode_entity.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/theme/screen_utils.dart';
import 'package:lend_funds/utils/time/time_utils.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';
import 'package:lend_funds/utils/vm/app_model.dart';
import 'package:lend_funds/utils/vm/repo_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RepayRolloverPage extends HookWidget {
  final dynamic model;
  final dynamic id;
  final dynamic type;

  RepayRolloverPage({Key? key, this.model, this.id, this.type})
      : super(key: key);

  var rolloverState;
  @override
  Widget build(BuildContext context) {
    dynamic delayAmount =
        model.containsKey("delayAmount") ? model["delayAmount"] : null;
    dynamic expiryTime =
        model.containsKey("expiryTime") ? model["expiryTime"] : null;
    dynamic loanAmount =
        model.containsKey("loanAmount") ? model["loanAmount"] : null;
    expiryTime =
        "${CZTimeUtils.formatDateTime(expiryTime, format: "yyyy-MM-dd HH:mm:ss")}";
    dynamic delayTerm =
        model.containsKey("delayTerm") ? model["delayTerm"] : null;
    dynamic delayTimes =
        model.containsKey("delayTimes") ? model["delayTimes"] : null;
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

  myUpiSelect(BuildContext context, SysCodeEntity sysCodeEntity) {
    rolloverState.value = sysCodeEntity;
    myUpiUrlSelect(context, sysCodeEntity);
  }

  myUpiUrlSelect(BuildContext context, SysCodeEntity sysCodeEntity) {
    rolloverState.value = sysCodeEntity;
    Map<String, dynamic> params = {
      "model": {
        "orderId": id,
        "repayMethod": sysCodeEntity.repayMethod,
        "methodCode": sysCodeEntity.methodCode,
        "repayType": type
      }
    };
    _getUpiUrl(context, params);
  }

  _getUpiUrl(BuildContext mContext, Map<String, dynamic> params) async {
    CZLoading.loading();
    dynamic model = await mContext.read(upiUrlProvider).getUpiUrl(params);
    CZLoading.dismiss();
    dynamic repayCode =
        model.containsKey("repayCode") ? model["repayCode"] : null;
    print("repayCode:$repayCode");
    final Uri _url = Uri.parse(repayCode);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

final upiProvider = ChangeNotifierProvider.autoDispose(
    (ref) => UpiModel(ref.watch(appProvider))..init());

class UpiModel extends BaseModel {
  AppModel appModel;

  UpiModel(this.appModel);

  init() async {
    notifyListeners();
  }

  getUpi(String id) async {
    final response = await HttpRequest.request(InterfaceConfig.upi, params: {
      "model": {"orderId": id}
    });
    return response.model;
  }
}

final upiUrlProvider = ChangeNotifierProvider.autoDispose(
    (ref) => UpiUrlModel(ref.watch(appProvider))..init());

class UpiUrlModel extends BaseModel {
  AppModel appModel;

  UpiUrlModel(this.appModel);

  init() async {
    notifyListeners();
  }

//{"model": {"orderId": id,"repayMethod": id,"methodCode": id,"repayType": id}}
  getUpiUrl(Map<String, dynamic> params) async {
    final response =
        await HttpRequest.request(InterfaceConfig.upi_url, params: params);
    return response.model;
  }
}
