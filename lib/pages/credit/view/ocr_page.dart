import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/camera/views/camera_kpt.dart';
import 'package:lend_funds/pages/credit/controller/ocr_controller.dart';
import 'package:lend_funds/pages/credit/view/widget/credit_take_photo_widget.dart';
import 'package:lend_funds/utils/image/ImageCompressUtil.dart';
import 'package:lend_funds/utils/route/route_config.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';

class OcrPage extends StatefulWidget {
  final String formId;
  final String formName;
  const OcrPage({Key? key, required this.formId, required this.formName})
      : super(key: key);

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  String? resultFront;
  String? loadFront;
  String? resultBack;
  String? loadBack;
  String? resultPan;
  String? loadPan;

  String? idCard;
  String? realName;
  int? birthDay;
  String? taxRegNumber;

  @override
  void initState() {
    super.initState();
    //...
    Get.put(OcrController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            }),
        title: Text(
          widget.formName,
          style: TextStyle(
              fontSize: 17.5.sp,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
              color: Color(0xffCFDEEA),
              child: Row(
                children: [
                  Image.asset('assets/credit/credit_camera_small_icon.png',
                      width: 26.w, height: 21.w),
                  SizedBox(
                    width: 9.w,
                  ),
                  Expanded(
                      child: Text(
                    'For anti-money laundering and anti-fraud review, please upload your true personal information.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 9.5.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.normal),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              'Photograph the original ID card',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 11.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CreditTakePhotoWidget(
                  title: "ID Card Front",
                  takePhotoBlock: () async {
                    _navigateFrontCameraPage(context);
                  },
                  imgFile: resultFront,
                ),
                CreditTakePhotoWidget(
                  title: "ID Card Back",
                  takePhotoBlock: () async {
                    _navigateBackCameraPage(context);
                  },
                  imgFile: resultBack,
                ),
              ],
            ),
            SizedBox(
              height: 17.h,
            ),
            Text(
              'Take a photo of the original tax card',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 11.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CreditTakePhotoWidget(
                  title: "Pan Card",
                  takePhotoBlock: () {
                    _navigatePanCameraPage(context);
                  },
                  imgFile: resultPan,
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              width: 345.w,
              height: 50.h,
              decoration: BoxDecoration(
                  color: const Color(0xFF003C6A),
                  borderRadius: BorderRadius.circular(5.w)),
              child: TextButton(
                onPressed: () {
                  Get.toNamed(CZRouteConfig.ocrDetail);
                },
                child: Text("Next step",
                    style: TextStyle(
                        fontSize: 17.5.sp,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w500)),
              ),
            ),
            SizedBox(
              height: 18.5.h,
            ),
            RichText(
                // textAlign: TextAlign.center,
                text: TextSpan(
              style: TextStyle(height: 2),
              children: [
                WidgetSpan(
                  // alignment: PlaceholderAlignment.middle,
                  child: Image.asset('assets/credit/credit_security.png',
                      width: 7.6.w, height: 8.9.w, fit: BoxFit.fill),
                ),
                TextSpan(
                  text:
                      ' Your information is only for loan review purposes, we will keep it strictly confidential and will not disclose it to any third-party platform.',
                  style: TextStyle(
                      color: const Color(0xFF000000F),
                      fontSize: 7.5.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  _navigateFrontCameraPage(BuildContext context) async {
    XFile? imageFile = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraKpt()),
    );
    if (imageFile != null) {
      resultFront = imageFile.path;
      debugPrint("resultFront:${resultFront}");
      if (resultFront == null || resultFront?.length == 0) {
        return;
      }
      resultFront =
          (await testCompressAndGetFile(resultFront ?? "", resultFront ?? ""))
              .path;
      CZLoading.loading(status: '');
      await OcrController.to.uploadFile(resultFront ?? "").then((value) {
        CZLoading.dismiss();
        loadFront = value;
        debugPrint("loadFront:${loadFront}");
      });
      if (loadFront != null && loadFront!.length > 0) {
        CZLoading.loading(status: '');
        Map response = await OcrController.to.ocrIdentifyFront(loadFront ?? "");
        if (response["status"] == 0) {
          idCard = response["model"].containsKey("idCard")
              ? response["model"]["idCard"]
              : null;
          realName = response["model"].containsKey("realName")
              ? response["model"]["realName"]
              : null;
          birthDay = response["model"].containsKey("birthDay")
              ? response["model"]["birthDay"]
              : null;
          if (idCard == null || realName == null || birthDay == null) {
            loadFront = null;
            resultFront = null;
            CZLoading.toast(
                "The photo is incorrect or unclear and cannot be recognized");
          }
          CZLoading.dismiss();
          setState(() {});
        } else {
          loadFront = null;
          // resultFront = null;
          CZLoading.dismiss();
          CZLoading.toast(response["message"]);
          setState(() {});
        }
      }
    }
  }

  _navigateBackCameraPage(BuildContext context) async {
    XFile? imageFile = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraKpt()),
    );
    if (imageFile != null) {
      resultBack = imageFile.path;
      debugPrint("resultFront:${resultBack}");
      if (resultBack == null || resultBack?.length == 0) {
        return;
      }
      resultBack =
          (await testCompressAndGetFile(resultBack ?? "", resultBack ?? ""))
              .path;
      CZLoading.loading(status: '');
      await OcrController.to.uploadFile(resultBack ?? "").then((value) {
        CZLoading.dismiss();
        loadBack = value;
        debugPrint("loadBack:${loadBack}");
      });
      if (loadBack != null && loadBack!.length > 0) {
        CZLoading.loading(status: '');
        Map response = await OcrController.to.ocrIdentifyBack(loadBack ?? "");
        if (response["status"] == 0) {
          CZLoading.dismiss();
          setState(() {});
        } else {
          loadBack = null;
          // resultBack = null;
          CZLoading.dismiss();
          CZLoading.toast(response["message"]);
          setState(() {});
        }
      }
    }
  }

  _navigatePanCameraPage(BuildContext context) async {
    XFile? imageFile = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraKpt()),
    );
    if (imageFile != null) {
      resultPan = imageFile.path;
      debugPrint("resultPan:${resultPan}");
      if (resultPan == null || resultPan?.length == 0) {
        return;
      }
      resultPan =
          (await testCompressAndGetFile(resultPan ?? "", resultPan ?? "")).path;
      CZLoading.loading(status: '');
      await OcrController.to.uploadFile(resultPan ?? "").then((value) {
        CZLoading.dismiss();
        loadPan = value;
        debugPrint("loadPan:${loadPan}");
      });
      if (loadPan != null && loadPan!.length > 0) {
        CZLoading.loading(status: '');
        Map response = await OcrController.to.ocrIdentifyFront(loadPan ?? "");
        if (response["status"] == 0) {
          taxRegNumber = response["model"].containsKey("taxRegNumber")
              ? response["model"]["taxRegNumber"]
              : null;
          realName = response["model"].containsKey("realName")
              ? response["model"]["realName"]
              : null;
          birthDay = response["model"].containsKey("birthDay")
              ? response["model"]["birthDay"]
              : null;
          if (taxRegNumber == null || realName == null || birthDay == null) {
            loadPan = null;
            resultPan = null;
            CZLoading.toast(
                "The photo is incorrect or unclear and cannot be recognized");
          }
          CZLoading.dismiss();
          setState(() {});
        } else {
          loadPan = null;
          // resultPan = null;
          CZLoading.dismiss();
          CZLoading.toast(response["message"]);
          setState(() {});
        }
      }
    }
  }

  Future<XFile> testCompressAndGetFile(String path, String targetPath) async {
    ImageCompressUtil imageCompressUtil = ImageCompressUtil();
    return imageCompressUtil.imageCompressAndGetFile(File(path));
  }
}
