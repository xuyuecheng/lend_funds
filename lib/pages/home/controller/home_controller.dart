import 'package:get/get.dart';
import 'package:lend_funds/pages/credit/view/ocr_page.dart';
import 'package:lend_funds/pages/credit/view/work_information_page.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';

class HomeController extends GetxController with StateMixin<Map> {
  static HomeController get to => Get.find();
  List forms = [];
  @override
  void onReady() {
    getIncompleteForm();
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
            if (isOff) {
              Get.off(() => WorkInformationPage());
            } else {
              Get.to(() => WorkInformationPage());
            }
            // _getBasicForm(context, formId);
          } else if (formType.trim() == "ALIVE") {
            // await AppRouter.navigate(context, AppRoute.form_alive,
            //     params: {"formId": formId, "formName": formName}, finishSelf: true);
          }
        }
      }
    }
    return result;
  }
}