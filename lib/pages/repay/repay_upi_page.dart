import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lend_funds/pages/credit/view/widget/dict_sheet.dart';
import 'package:lend_funds/utils/base/base_view_model.dart';
import 'package:lend_funds/utils/entity/syscode_entity.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/theme/screen_utils.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';
import 'package:lend_funds/utils/vm/app_model.dart';
import 'package:lend_funds/utils/vm/repo_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as myBottomSheet;
import 'package:url_launcher/url_launcher.dart';

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
      backgroundColor: Color(0xffF1F2F3),
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
                    "₹ ${amount.toString()}",
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
                width: CZScreenUtils.screenWidth - 30.w,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                    color: const Color(0xFFffffff),
                    borderRadius: BorderRadius.circular(5.w)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7.5.h,
                    ),
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
                        _getUpi(context, id);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 8.5.h),
                        decoration: BoxDecoration(
                            color: const Color(0xFFF1F1F1),
                            borderRadius: BorderRadius.circular(5.w)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                borderRadius: BorderRadius.circular(4.5.w),
                                border: Border.all(
                                  color: Color(0xff003C6A),
                                  width: 1.w,
                                ),
                              ),
                              child: Text(
                                "${upiState.value.name}",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: const Color(0xFF003C6A),
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                  ],
                )),
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
    upiState.value = sysCodeEntity;
    myUpiUrlSelect(context, sysCodeEntity);
  }

  myUpiUrlSelect(BuildContext context, SysCodeEntity sysCodeEntity) {
    upiState.value = sysCodeEntity;
    Map<String, dynamic> params = {
      "modelU8mV9A": {
        "orderIdN1N7lN": id,
        "repayMethodFujhvV": sysCodeEntity.repayMethod,
        "methodCoderBLztN": sysCodeEntity.methodCode,
        "repayTypeWdc4g6": type
      }
    };
    _getUpiUrl(context, params);
  }

  _getUpi(BuildContext mContext, String id) async {
    CZLoading.loading();
    dynamic model = await mContext.read(upiProvider).getUpi(id);
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
            {myUpiSelect(mContext, sysCodeEntityList.first)},
      ),
    );
  }

  _getUpiUrl(BuildContext mContext, Map<String, dynamic> params) async {
    CZLoading.loading();
    dynamic model = await mContext.read(upiUrlProvider).getUpiUrl(params);
    CZLoading.dismiss();
    dynamic repayCode =
        model.containsKey("repayCodes0suow") ? model["repayCodes0suow"] : null;
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
  getUpiUrl(Map<String, dynamic> params) async {
    final response =
        await HttpRequest.request(InterfaceConfig.upi_url, params: params);
    return response["modelU8mV9A"];
  }
}
