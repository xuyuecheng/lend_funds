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

  Future ocrIdentifyFront(String url) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.ocr,
      params: {
        "model": {"url": url, "cardType": "FRONT"}
      },
    );
    return result;
  }

  Future ocrIdentifyBack(String url) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.ocr,
      params: {
        "model": {"url": url, "cardType": "BACK"}
      },
    );
    return result;
  }

  Future ocrIdentifyPan(String url) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.ocr,
      params: {
        "model": {"url": url, "cardType": "PAN"}
      },
    );
    return result;
  }

  Future submitOcrInfo({Map<String, dynamic>? params}) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.submitOcrInfo,
      params: params,
    );
    return result;
  }
}
