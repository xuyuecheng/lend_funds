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
    final theme = Theme.of(context);
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
                            Text("₹ ${amount.toString()}",
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
                  padding: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Color.fromRGBO(240, 240, 240, 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              "Choose your payment mode:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text("Please Choose",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13)),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: MaterialButton(
                                  color: Color.fromRGBO(54, 65, 225, 1),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 50),
                                  child: Text("${upiState.value.name}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20)),
                                  onPressed: () {
                                    _getUpi(context, id);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
  }

  myUpiSelect(BuildContext context, SysCodeEntity sysCodeEntity) {
    upiState.value = sysCodeEntity;
    myUpiUrlSelect(context, sysCodeEntity);
  }

  myUpiUrlSelect(BuildContext context, SysCodeEntity sysCodeEntity) {
    upiState.value = sysCodeEntity;
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
    //展示地址第一级
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
    return response["model"];
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
    return response["model"];
  }
}
