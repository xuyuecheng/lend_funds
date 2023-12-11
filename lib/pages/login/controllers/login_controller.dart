import 'package:get/get.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();
  String? phoneStr;
  bool isHaveLoginPage = false;

  Future sendPhoneCode({Map<String, dynamic>? params}) async {
    CZLoading.loading();
    try {
      Map<String, dynamic> result = await HttpRequest.request(
        InterfaceConfig.phoneCode,
        params: params,
      );
      CZLoading.dismiss();
      if (result['status'] == 0) {
        //成功
        return result;
      } else {
        return Future.error(result['message']);
      }
    } catch (e) {
      CZLoading.dismiss();
      CZLoading.toast(e.toString());
      return Future.error(e);
    }
  }

  Future requestUserLogin({Map<String, dynamic>? params}) async {
    CZLoading.loading();
    try {
      Map<String, dynamic> result = await HttpRequest.request(
        InterfaceConfig.userLogin,
        params: params,
      );
      CZLoading.dismiss();
      if (result['status'] == 0) {
        //成功
        return result;
      } else {
        CZLoading.dismiss();
        return Future.error('e');
      }
    } catch (e) {
      CZLoading.dismiss();
      CZLoading.toast(e.toString());
      return Future.error(e);
    }
  }
}
