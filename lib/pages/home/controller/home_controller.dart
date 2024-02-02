import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/credit/view/alive_page.dart';
import 'package:lend_funds/pages/credit/view/basic_page.dart';
import 'package:lend_funds/pages/credit/view/ocr_page.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/plugins/ios_plugin.dart';

class HomeController extends GetxController with StateMixin<Map> {
  static HomeController get to => Get.find();
  List forms = [];
  List productList = [];
  @override
  void onReady() {
    super.onReady();
  }

  void getIncompleteForm() {
    requestIncompleteForm(isJump: false).then((value) {
      if (value["statusE8iqlh"] == 0) {
        //success
        forms = value['modelU8mV9A']['formsfSvjf4'];
        update();
      }
    });
  }

  void getProductList() {
    requestProductList().then((value) {
      if (value["statusE8iqlh"] == 0) {
        //success
        productList = value["pageLosuN4"].containsKey("contentCxb7jm")
            ? value["pageLosuN4"]["contentCxb7jm"]
            : [];
        if (kDebugMode) {
          log("productList:${json.encode(productList)}");
        }
        update();
      }
    });
  }

  Future requestIncompleteForm({bool isJump = true, bool isOff = false}) async {
    Map<String, dynamic> result = await HttpRequest.request(
      InterfaceConfig.formList,
      params: {
        "modelU8mV9A": {"nodeTypef7sFbO": "NODE1"}
      },
    );
    if (result["statusE8iqlh"] == 0) {
      //success
      if (isJump) {
        ///jump page
        List<dynamic> forms = result["modelU8mV9A"]["formsfSvjf4"];
        if (forms.length > 0) {
          print(forms[0]);
          String formId = forms[0].containsKey("formIdrS92EN")
              ? forms[0]["formIdrS92EN"]
              : "formIdrS92EN";
          String formType = forms[0].containsKey("formTypeh6IHG0")
              ? forms[0]["formTypeh6IHG0"]
              : "formTypeh6IHG0";
          String formName = forms[0].containsKey("formNameQCVJjC")
              ? forms[0]["formNameQCVJjC"]
              : "formNameQCVJjC";
          if (formType.trim() == "OCR") {
            print("navigate.formId:$formId");
            if (isOff) {
              Get.off(() => OcrPage(
                    formId: formId,
                    formName: formName,
                  ));
            } else {
              Get.to(() => OcrPage(
                    formId: formId,
                    formName: formName,
                  ));
            }
          } else if (formType.trim() == "BASIC") {
            await requestBasicForm(formId: formId).then((value) {
              if (value["statusE8iqlh"] == 0) {
                List<dynamic>? forms =
                    value["modelU8mV9A"].containsKey("formsfSvjf4")
                        ? value["modelU8mV9A"]["formsfSvjf4"]
                        : null;
                log("forms567:${json.encode(forms)}");
                if (forms != null && forms.length > 0) {
                  if (isOff) {
                    debugPrint("Get.off(() => BasicPage(");
                    Get.off(
                      () => BasicPage(
                        formId: formId,
                        forms: forms,
                      ),
                      preventDuplicates: false,
                    );
                  } else {
                    Get.to(() => BasicPage(
                          formId: formId,
                          forms: forms,
                        ));
                  }
                }
              }
            });
          } else if (formType.trim() == "ALIVE") {
            if (isOff) {
              Get.off(() => AlivePage(
                    formId: formId,
                    formName: formName,
                  ));
            } else {
              Get.to(() => AlivePage(
                    formId: formId,
                    formName: formName,
                  ));
            }
          }
        } else {
          //返回首页
          Get.back();
        }
      }
    }
    return result;
  }

  Future<Map<String, dynamic>> requestBasicForm(
      {required String formId}) async {
    Map<String, dynamic> result =
        await HttpRequest.request(InterfaceConfig.getOneFormFlow, params: {
      "modelU8mV9A": {"formIdrS92EN": formId, "nodeTypef7sFbO": "NODE1"}
    });
    return result;
  }

  Future<Map<String, dynamic>> requestProductList() async {
    Map<String, dynamic> result = await HttpRequest.request(
        InterfaceConfig.product_list,
        params: {"queryBQDz08": {}});
    return result;
  }

  Future<Map<String, dynamic>> requestTrialData(List productIds) async {
    Map<String, dynamic> result =
        await HttpRequest.request(InterfaceConfig.tria, params: {
      "modelU8mV9A": {"productIdskwFhTC": productIds}
    });
    return result;
  }

  Future<Map<String, dynamic>> requestLoanData(List productIds) async {
    Map<String, dynamic> result =
        await HttpRequest.request(InterfaceConfig.loan, params: {
      "modelU8mV9A": {"productIdskwFhTC": productIds}
    });
    return result;
  }

  Future<Map<String, dynamic>> requestDevModel() async {
    Map<String, dynamic> result =
        await HttpRequest.request(InterfaceConfig.dev_report_situation);
    return result;
  }

  Future<Map<String, dynamic>> requestDeviceInfo() async {
    Map<dynamic, dynamic> deviceInfo = await CZDeviceUtils.getCZDeviceInfo();
    log("deviceInfo111:$deviceInfo");
    Map<String, dynamic> result = await HttpRequest.request(
        InterfaceConfig.report_dev,
        params: deviceInfo);
    log("result33333:$result");
    return result;
  }
}
