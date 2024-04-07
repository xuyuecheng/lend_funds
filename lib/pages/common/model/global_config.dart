// import 'package:portal_zp_mobile/src/network/api_urls.dart';
// import 'package:portal_zp_mobile/src/network/http_manager.dart';

import 'package:sahayak_cash/utils/network/dio_config.dart';
import 'package:sahayak_cash/utils/network/dio_request.dart';

class GlobalConfig {
  static String message = "";
  static bool enableFiveStar = false;

  static Future scrollMessageRequest() async {
    Map<String, dynamic> result = await HttpRequest.request(
        InterfaceConfig.scrollMessage,
        params: {"displayLocgUgoAN": "FORM_TOP"});
    if (result["statusE8iqlh"] == 0) {
      List<dynamic>? list = result["listNPJAeA"];
      if (list != null || list!.isNotEmpty) {
        Map map = list[0];
        message = map["contentCxb7jm"] ?? "";
      }
    }
    return message;
  }

  static Future appContactInfoRequest() async {
    Map<String, dynamic> result = await HttpRequest.request(
      InterfaceConfig.appContact_info,
      method: "get",
      params: null,
    );
    if (result["statusE8iqlh"] == 0) {
      Map<dynamic, dynamic> map = result["modelU8mV9A"];
      if (map["enableFiveStar"]) {
        enableFiveStar = map["enableFiveStar"];
        // debugPrint("enableFiveStar111:${enableFiveStar}");
      }
    }
  }
}
