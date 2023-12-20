import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/credit/view/alive_page.dart';
import 'package:lend_funds/pages/credit/view/basic_page.dart';
import 'package:lend_funds/pages/credit/view/ocr_page.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';

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
      if (value['status'] == 0) {
        //成功
        forms = value['model']['forms'];
        update();
      }
    });
  }

  void getProductList() {
    requestProductList().then((value) {
      if (value['status'] == 0) {
        //成功
        productList = value["page"].containsKey("content")
            ? value["page"]["content"]
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
        "model": {"nodeType": "NODE1"}
      },
    );
    if (result['status'] == 0) {
      //成功
      if (isJump) {
        ///跳转页面
        List<dynamic> forms = result["model"]["forms"];
        if (forms.length > 0) {
          print(forms[0]);
          String formId =
              forms[0].containsKey("formId") ? forms[0]["formId"] : "formId";
          String formType = forms[0].containsKey("formType")
              ? forms[0]["formType"]
              : "formType";
          String formName = forms[0].containsKey("formName")
              ? forms[0]["formName"]
              : "formName";
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
              if (value["status"] == 0) {
                List<dynamic>? forms = value["model"].containsKey("forms")
                    ? value["model"]["forms"]
                    : null;
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
      "model": {"formId": formId, "nodeType": "NODE1"}
    });
    return result;
  }

  Future<Map<String, dynamic>> requestProductList() async {
    Map<String, dynamic> result = await HttpRequest.request(
        InterfaceConfig.product_list,
        params: {"query": {}});
    return result;
  }

  Future<Map<String, dynamic>> requestTrialData(List productIds) async {
    Map<String, dynamic> result =
        await HttpRequest.request(InterfaceConfig.tria, params: {
      "model": {"productIds": productIds}
    });
    return result;
  }

  Future<Map<String, dynamic>> requestLoanData(List productIds) async {
    Map<String, dynamic> result =
        await HttpRequest.request(InterfaceConfig.loan, params: {
      "model": {"productIds": productIds}
    });
    return result;
  }
}
