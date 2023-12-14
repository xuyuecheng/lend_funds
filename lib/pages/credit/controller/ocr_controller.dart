import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../utils/image/ImageCompressUtil.dart';
import '../../../utils/network/dio_config.dart';
import '../../../utils/network/dio_request.dart';
import '../../../utils/toast/toast_utils.dart';

class OcrController extends GetxController {
  static OcrController get to => Get.find();

  XFile? idCardFrontImage;
  String? idCardFront;
  bool isError = false;
  dynamic idResult;

  Future<void> setIdCardFrontImage(XFile file) async {
    idCardFrontImage = null;
    idCardFrontImage = await testCompressAndGetFile(file.path, file.path);
    isError = false;
    uploadFile(idCardFrontImage!.path).then((value) {
      idCardFront = value;
      ocrIdentify(value);
    });
  }

  void ocrIdentify(String image) {
    if (kDebugMode) {
      print("image:${image.toString()}");
    }
    isError = false;
    idResult = "";
    ocrRequest(params: {
      "model": {'url': image, 'cardType': 'FRONT'}
    }).then((value) {
      if (kDebugMode) {
        print("ocrIdentify:${value.toString()}");
      }
      idResult = value;
      update();
    });
  }

  Future ocrRequest({Map<String, dynamic>? params}) async {
    CZLoading.loading();
    try {
      dynamic result = await HttpRequest.request(
        InterfaceConfig.ocr,
        params: params,
      );
      if (kDebugMode) {
        print("HttpRequest.ocr:${result.toString()}");
      }

      CZLoading.dismiss();
      if (result['status'] == 0) {
        return result['model'];
      } else {
        // RequestUtil.addDot(RbiConfig.firstOcrError);
        idCardFrontImage = null;
        isError = true;
        update();
        return null;
      }
    } catch (e) {
      CZLoading.dismiss();
      return null;
    }
  }

  Future uploadFile(String filePath) async {
    CZLoading.loading(status: '');
    try {
      dynamic result =
          await HttpRequest.uploadFile(InterfaceConfig.uploadFile, filePath);
      if (kDebugMode) {
        print("HttpRequest.uploadFile:${result.toString()}");
      }
      CZLoading.dismiss();
      if (result['status'] == 0) {
        return result['model']["ossUrl"];
      } else {
        return Future.error('e');
      }
    } catch (e) {
      CZLoading.dismiss();
      CZLoading.toast(e.toString());
      return Future.error(e);
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

  Future<XFile> testCompressAndGetFile(String path, String targetPath) async {
    ImageCompressUtil imageCompressUtil = ImageCompressUtil();
    return imageCompressUtil.imageCompressAndGetFile(File(path));
  }
}
