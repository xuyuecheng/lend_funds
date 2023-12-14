import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../utils/network/dio_config.dart';
import '../../../utils/network/dio_request.dart';
import '../../../utils/toast/toast_utils.dart';

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
    if (result['status'] == 0) {
      return result['model']["ossUrl"];
    } else {
      return null;
    }
  }

  Future ocrIdentifyFront(String url) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.ocr,
      params: {
        "model": {"url": url, "cardType": "FRONT"}
      },
    );
    if (result['status'] == 0) {
      return result;
    } else {
      return null;
    }
  }

  Future ocrIdentifyBack(String url) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.ocr,
      params: {
        "model": {"url": url, "cardType": "BACK"}
      },
    );
    if (result['status'] == 0) {
      return result;
    } else {
      return null;
    }
  }

  Future ocrIdentifyPan(String url) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.ocr,
      params: {
        "model": {"url": url, "cardType": "PAN"}
      },
    );
    if (result['status'] == 0) {
      return result;
    } else {
      return null;
    }
  }

  Future submitKtpInfo({Map<String, dynamic>? params}) async {
    CZLoading.loading(status: '');
    try {
      dynamic result = await HttpRequest.request(
        InterfaceConfig.submitOcrInfo,
        params: params,
      );
      if (kDebugMode) {
        print("HttpRequest.submitOcrInfo.params:${params.toString()}");
        print("HttpRequest.submitOcrInfo:${result.toString()}");
      }
      CZLoading.dismiss();
      if (result['status'] == 0) {
        // CZCreditMixinController.to.requestNextPage(step: 1);
        return result;
      } else {
        return Future.error('e');
      }
    } catch (e) {
      CZLoading.dismiss();
      CZLoading.toast(e.toString());
      return Future.error(e);
    }
  }
}
