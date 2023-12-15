import 'package:get/get.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/storage/storage_utils.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';

class MineController extends GetxController {
  static MineController get to => Get.find();

  @override
  void onReady() {
    super.onReady();
  }

  Future requestDel() async {
    var userInfo = CZStorage.getUserInfo();
    var phone = "Halo";
    if (userInfo != null) {
      var user = userInfo.containsKey("user") ? userInfo["user"] : null;
      if (user != null) {
        phone = user.containsKey("phone") ? user["phone"] : "Halo";
      }
    }
    CZLoading.loading();
    Map<String, dynamic> result = await HttpRequest.request(
        "${InterfaceConfig.del}/${phone}",
        params: null,
        method: "get");
    CZLoading.dismiss();
    return result;
  }
}
