import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sahayak_cash/pages/common/privacy_agreement.dart';
import 'package:sahayak_cash/pages/credit/view/widget/dict_sheet.dart';
import 'package:sahayak_cash/utils/base/base_view_model.dart';
import 'package:sahayak_cash/utils/entity/syscode_entity.dart';
import 'package:sahayak_cash/utils/network/dio_config.dart';
import 'package:sahayak_cash/utils/network/dio_request.dart';
import 'package:sahayak_cash/utils/service/TelAndSmsService.dart';
import 'package:sahayak_cash/utils/toast/toast_utils.dart';
import 'package:sahayak_cash/utils/vm/app_model.dart';
import 'package:sahayak_cash/utils/vm/repo_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as myBottomSheet;

class RepayUpiPage extends HookWidget {
  final dynamic amount;
  final dynamic id;
  final dynamic type;

  RepayUpiPage({Key? key, this.amount, this.id, this.type}) : super(key: key);

  var upiState;
  @override
  Widget build(BuildContext context) {
    upiState = useState(SysCodeEntity("", "UPI", "", "", false, null));
    return Scaffold(
        backgroundColor: Color(0xffEFF0F3),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              }),
          title: Text(
            "Repayment Mode",
            style: TextStyle(
                fontSize: 17.5.sp,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: 7.5.w, right: 7.5.w, top: 12.h, bottom: 12.h),
          child: Column(
            children: [
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                    color: const Color(0xFFffffff),
                    borderRadius: BorderRadius.circular(5.w)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      "Repayment amount",
                      style: TextStyle(
                          fontSize: 22.5.sp,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "₹ ${amount.toString()}",
                      style: TextStyle(
                          fontSize: 50.sp,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                        width: 1.sw,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFffffff),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Choose your payment mode",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: const Color(0xFF999999),
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 11.5.h,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                getUpi(context, id);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 8.5.h),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF1F1F1),
                                    borderRadius: BorderRadius.circular(5.w)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Please Choose",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: const Color(0xFF161616),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 3.5.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.5.w),
                                          color: Color(0xff00A651)),
                                      child: Text(
                                        "${upiState.value.name}",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: const Color(0xFFffffff),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 14.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 51.h,
              ),
              Text(
                "This Loan Is Provided By A Third-Party Company Sahayak Cash",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFF9B9B9B),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 46,
          child: Column(
            children: [
              SizedBox(height: 10),
              PrivacyAgreement(),
            ],
          ),
        ));
  }

  _myUpiSelect(BuildContext context, SysCodeEntity sysCodeEntity) {
    upiState.value = sysCodeEntity;
    _myUpiUrlSelect(context, sysCodeEntity);
  }

  _myUpiUrlSelect(BuildContext context, SysCodeEntity sysCodeEntity) {
    upiState.value = sysCodeEntity;
    Map<String, dynamic> params = {
      "modelU8mV9A": {
        "orderIdN1N7lN": id,
        "repayMethodFujhvV": sysCodeEntity.repayMethod,
        "methodCoderBLztN": sysCodeEntity.methodCode,
        "repayTypeWdc4g6": type
      }
    };
    getUpiUrl(context, params);
  }

  getUpi(BuildContext mContext, String id) async {
    CZLoading.loading();
    dynamic model = await mContext.read(upiProvider).getUpiRequest(id);
    List<dynamic>? methods =
        model.containsKey("methods") ? model["methods"] : null;
    CZLoading.dismiss();
    List<SysCodeEntity> sysCodeEntityList = [];
    if (methods != null && methods.isNotEmpty) {
      sysCodeEntityList = methods
          .map<SysCodeEntity>((value) => SysCodeEntity.fromJson(value))
          .toList();
    }
    //
    await myBottomSheet.showCupertinoModalBottomSheet(
      context: mContext,
      builder: (mContext) => SupervisionDictSheet(
        sysCodes: sysCodeEntityList,
        onSelect: (sysCodeEntityList) =>
            {_myUpiSelect(mContext, sysCodeEntityList.first)},
      ),
    );
  }

  getUpiUrl(BuildContext mContext, Map<String, dynamic> params) async {
    CZLoading.loading();
    dynamic model =
        await mContext.read(upiUrlProvider).getUpiUrlRequest(params);
    CZLoading.dismiss();
    dynamic repayCode =
        model.containsKey("repayCodes0suow") ? model["repayCodes0suow"] : null;
    print("repayCode:$repayCode");
    TelAndSmsService service = getIt<TelAndSmsService>();
    service.openUrl(repayCode);
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

  getUpiRequest(String id) async {
    final response = await HttpRequest.request(InterfaceConfig.upi, params: {
      "modelU8mV9A": {"orderIdN1N7lN": id}
    });
    return response["modelU8mV9A"];
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
  getUpiUrlRequest(Map<String, dynamic> params) async {
    final response =
        await HttpRequest.request(InterfaceConfig.upi_url, params: params);
    return response["modelU8mV9A"];
  }
}
