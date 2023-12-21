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
    final theme = Theme.of(context);

    dynamic delayAmount =
        model.containsKey("delayAmount") ? model["delayAmount"] : null;
    dynamic expiryTime =
        model.containsKey("expiryTime") ? model["expiryTime"] : null;
    dynamic loanAmount =
        model.containsKey("loanAmount") ? model["loanAmount"] : null;
    // dynamic expiryTime = model.containsKey("expiryTime") ? model["expiryTime"] : null;
    // expiryTime = MyDate.format("yyyy-MM-dd HH:mm:ss", DateTime.fromMillisecondsSinceEpoch(expiryTime)).toString();
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
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                children: [
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
                    decoration: const BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Color.fromRGBO(240, 240, 240, 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Delayed date",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13)),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              "${expiryTime.toString()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text("Extend time",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13)),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text("${delayTerm.toString()}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text("Recording delay(max.10000)",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13)),
                            Text("${delayTimes.toString()}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
        bottomNavigationBar: Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "*This loan is provided by a third-party company\nSmall Credit",
                textAlign: TextAlign.center,
                style: theme.textTheme.caption,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: MaterialButton(
                        color: Color.fromRGBO(54, 65, 225, 1),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                            "Need to repay loan ₹ ${delayAmount.toString()}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Get.to(() => RepayUpiPage(
                              amount: delayAmount.toString(),
                              id: id,
                              type: "DELAY"));
                          // AppRouter.navigate(context, AppRoute.upi_repay, params: {"amount" : delayAmount.toString(), "id" : id, "type" : "DELAY"}, finishSelf: false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
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
