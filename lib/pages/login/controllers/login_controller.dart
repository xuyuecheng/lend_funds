import 'package:get/get.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();
  String? phoneStr;
  bool isHaveLoginPage = false;

  Future sendPhoneCodeRequest({Map<String, dynamic>? params}) async {
    CZLoading.loading();
    Map<String, dynamic> result = await HttpRequest.request(
      InterfaceConfig.phoneCode,
      params: params,
    );
    CZLoading.dismiss();
    return result;
  }

  Future requestUserLogin({Map<String, dynamic>? params}) async {
    CZLoading.loading();
    Map<String, dynamic> result = await HttpRequest.request(
      InterfaceConfig.userLogin,
      params: params,
    );
    CZLoading.dismiss();
    return result;
  }
}
