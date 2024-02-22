import 'package:get/get.dart';

import '../../../utils/network/dio_config.dart';
import '../../../utils/network/dio_request.dart';

class OcrController extends GetxController {
  static OcrController get to => Get.find();
  // String? resultFront;
  // String? loadFront;
  // String? resultBack;
  // String? loadBack;
  // String? resultPan;
  // String? loadPan;
  //
  // String? idCard;
  // String? realName;
  // int? birthDay;
  // String? taxRegNumber;

  Future uploadFile(String filePath) async {
    dynamic result =
        await HttpRequest.uploadFile(InterfaceConfig.uploadFile, filePath);
    return result;
  }

  Future ocrIdentifyFrontRequest(String url) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.ocr,
      params: {
        "modelU8mV9A": {"urlB5K9pj": url, "cardTypeSIKoLx": "FRONT"}
      },
    );
    return result;
  }

  Future ocrIdentifyBackRequest(String url) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.ocr,
      params: {
        "modelU8mV9A": {"urlB5K9pj": url, "cardTypeSIKoLx": "BACK"}
      },
    );
    return result;
  }

  Future ocrIdentifyPanRequest(String url) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.ocr,
      params: {
        "modelU8mV9A": {"urlB5K9pj": url, "cardTypeSIKoLx": "PAN"}
      },
    );
    return result;
  }

  Future submitOcrInfoRequest({Map<String, dynamic>? params}) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.submitOcrInfo,
      params: params,
    );
    return result;
  }
}
