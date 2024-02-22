import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/camera/views/camera_kpt.dart';
import 'package:lend_funds/pages/common/marquee_widget.dart';
import 'package:lend_funds/pages/common/privacy_agreement.dart';
import 'package:lend_funds/pages/common/retention_dialog.dart';
import 'package:lend_funds/pages/credit/controller/ocr_controller.dart';
import 'package:lend_funds/pages/credit/view/ocr_detail_page.dart';
import 'package:lend_funds/pages/home/controller/home_controller.dart';
import 'package:lend_funds/utils/image/ImageCompressUtil.dart';
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

  bool isUploadAadhaarCardStep =
      true; //默认是true，是否是上传Aadhaar Card的步骤，上传完adhaar Card后开始上传pan card

  @override
  void initState() {
    super.initState();
    //...
    Get.put(OcrController());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _backEvent();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
              color: Colors.black,
              onPressed: () {
                _backEvent();
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
        body: Column(
          children: [
            MarqueeWidget(),
            Expanded(
                child: SingleChildScrollView(
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 11.h,
                        ),
                        Image.asset(
                          "assets/credit/progress_ekyc.png",
                          fit: BoxFit.fill,
                        ),
                        (isUploadAadhaarCardStep)
                            ? Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      Text(
                                          "Please upload the front of your Aadhaar Card",
                                          style: TextStyle(
                                              fontSize: 12.5.sp,
                                              color: const Color(0xFF000000),
                                              fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Center(
                                          child: GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          _navigateFrontCameraPage(context);
                                        },
                                        child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        6.5.w)),
                                            width: 193,
                                            height: 128,
                                            child: resultFront != null
                                                ? Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    children: [
                                                      Image.file(
                                                        File(resultFront!),
                                                        width: 193,
                                                        height: 128,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      (loadFront != null)
                                                          ? Positioned(
                                                              child:
                                                                  Image.asset(
                                                                "assets/credit/ocr_right_flag.png",
                                                                width: 64,
                                                                height: 64,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            )
                                                          : Image.asset(
                                                              "assets/credit/image_upload_failed.png",
                                                              width: 64,
                                                              height: 64,
                                                              fit: BoxFit.fill,
                                                            ),
                                                    ],
                                                  )
                                                : Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "assets/credit/aadhear_front_backg.png",
                                                        width: 193,
                                                        height: 128,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ],
                                                  )),
                                      )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      Text(
                                          "Please upload the back of your Aadhaar Card",
                                          style: TextStyle(
                                              fontSize: 12.5.sp,
                                              color: const Color(0xFF000000),
                                              fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Center(
                                          child: GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          _navigateBackCameraPage(context);
                                        },
                                        child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        6.5.w)),
                                            width: 193,
                                            height: 128,
                                            child: resultBack != null
                                                ? Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    children: [
                                                      Image.file(
                                                        File(resultBack!),
                                                        width: 193,
                                                        height: 128,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      (loadBack != null)
                                                          ? Positioned(
                                                              child:
                                                                  Image.asset(
                                                                "assets/credit/ocr_right_flag.png",
                                                                width: 64,
                                                                height: 64,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            )
                                                          : Image.asset(
                                                              "assets/credit/image_upload_failed.png",
                                                              width: 193,
                                                              height: 128,
                                                              fit: BoxFit.fill,
                                                            ),
                                                    ],
                                                  )
                                                : Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "assets/credit/aadhear_back_backg.png",
                                                        width: 193,
                                                        height: 128,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ],
                                                  )),
                                      )),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  Text(
                                      "Please upload the front of your PAN Card",
                                      style: TextStyle(
                                          fontSize: 12.5.sp,
                                          color: const Color(0xFF000000),
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Center(
                                      child: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            _navigatePanCameraPage(context);
                                          },
                                          child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.5.w)),
                                              width: 193,
                                              height: 128,
                                              child: resultPan != null
                                                  ? Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      children: [
                                                        Image.file(
                                                          File(resultPan!),
                                                          width: 193,
                                                          height: 128,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        (loadPan != null)
                                                            ? Positioned(
                                                                child:
                                                                    Image.asset(
                                                                  "assets/credit/ocr_right_flag.png",
                                                                  width: 64,
                                                                  height: 64,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              )
                                                            : Image.asset(
                                                                "assets/credit/image_upload_failed.png",
                                                                width: 64,
                                                                height: 64,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                      ],
                                                    )
                                                  : Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          "assets/credit/pan_front_backg.png",
                                                          width: 193,
                                                          height: 128,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ],
                                                    )))),
                                ],
                              ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          width: 345.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: const Color(0xFF00A651),
                              borderRadius: BorderRadius.circular(5.w)),
                          child: TextButton(
                            onPressed: () {
                              _navigateOcrDetailPage();
                            },
                            child: Text("Next",
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        PrivacyAgreement(),
                      ],
                    ))),
          ],
        ),
        backgroundColor: Color(0xffF5F4F2),
      ),
    );
  }

  _backEvent() {
    if (isUploadAadhaarCardStep) {
      CZDialogUtil.show(RetentionDialog());
    } else {
      setState(() {
        isUploadAadhaarCardStep = true;
        resultPan = null;
        loadPan = null;
      });
    }
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
      CZLoading.loading();
      await OcrController.to.uploadFile(resultFront ?? "").then((value) {
        CZLoading.dismiss();
        if (value["statusE8iqlh"] == 0) {
          loadFront = value['modelU8mV9A']["ossUrl"];
          debugPrint("loadFront:${loadFront}");
        }
      });
      if (loadFront != null && loadFront!.length > 0) {
        CZLoading.loading();
        Map response = await OcrController.to.ocrIdentifyFront(loadFront ?? "");
        if (response["statusE8iqlh"] == 0) {
          idCard = response["modelU8mV9A"].containsKey("idCardLpsFQr")
              ? response["modelU8mV9A"]["idCardLpsFQr"]
              : null;
          realName = response["modelU8mV9A"].containsKey("userNameeRu4G3")
              ? response["modelU8mV9A"]["userNameeRu4G3"]
              : null;
          birthDay = response["modelU8mV9A"].containsKey("birthDayclwqbz")
              ? response["modelU8mV9A"]["birthDayclwqbz"]
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
          CZLoading.toast(response["msgEsmut7"]);
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
      CZLoading.loading();
      await OcrController.to.uploadFile(resultBack ?? "").then((value) {
        CZLoading.dismiss();
        if (value["statusE8iqlh"] == 0) {
          loadBack = value['modelU8mV9A']["ossUrl"];
          debugPrint("loadBack:${loadBack}");
        }
      });
      if (loadBack != null && loadBack!.length > 0) {
        CZLoading.loading();
        Map response = await OcrController.to.ocrIdentifyBack(loadBack ?? "");
        if (response["statusE8iqlh"] == 0) {
          CZLoading.dismiss();
          setState(() {});
        } else {
          loadBack = null;
          // resultBack = null;
          CZLoading.dismiss();
          CZLoading.toast(response["msgEsmut7"]);
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
      CZLoading.loading();
      await OcrController.to.uploadFile(resultPan ?? "").then((value) {
        CZLoading.dismiss();
        if (value["statusE8iqlh"] == 0) {
          loadPan = value['modelU8mV9A']["ossUrl"];
          debugPrint("loadPan:${loadPan}");
        }
      });
      if (loadPan != null && loadPan!.length > 0) {
        CZLoading.loading();
        Map response = await OcrController.to.ocrIdentifyPan(loadPan ?? "");
        if (response["statusE8iqlh"] == 0) {
          taxRegNumber =
              response["modelU8mV9A"].containsKey("taxRegNumberXgH70W")
                  ? response["modelU8mV9A"]["taxRegNumberXgH70W"]
                  : null;
          realName = response["modelU8mV9A"].containsKey("userNameeRu4G3")
              ? response["modelU8mV9A"]["userNameeRu4G3"]
              : null;
          birthDay = response["modelU8mV9A"].containsKey("birthDayclwqbz")
              ? response["modelU8mV9A"]["birthDayclwqbz"]
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
          CZLoading.toast(response["msgEsmut7"]);
          setState(() {});
        }
      }
    }
  }

  Future<XFile> testCompressAndGetFile(String path, String targetPath) async {
    ImageCompressUtil imageCompressUtil = ImageCompressUtil();
    return imageCompressUtil.imageCompressAndGetFile(File(path));
  }

  _navigateOcrDetailPage() async {
    if (isUploadAadhaarCardStep == true) {
      if (loadFront == null || loadFront!.isEmpty) {
        CZLoading.toast("please upload The AadhaarFront");
        return;
      }
      if (loadBack == null || loadBack!.isEmpty) {
        CZLoading.toast("please upload The AadhaarBack");
        return;
      }
      setState(() {
        isUploadAadhaarCardStep = false;
      });
      return;
    } else {
      if (loadFront == null || loadFront!.isEmpty) {
        CZLoading.toast("please upload The AadhaarFront");
        return;
      }
      if (loadBack == null || loadBack!.isEmpty) {
        CZLoading.toast("please upload The AadhaarBack");
        return;
      }
      if (loadPan == null || loadPan!.isEmpty) {
        CZLoading.toast("please upload The PanCardFront");
        return;
      }
    }

    Map<String, dynamic> params = <String, dynamic>{};
    params["idCardLpsFQr"] = idCard;
    params["userNameeRu4G3"] = realName;
    params["birthDayclwqbz"] = birthDay;
    params["taxRegNumberXgH70W"] = taxRegNumber;
    params["idCardImageFrontRvZMet"] = loadFront;
    params["idCardImageBackexYcGa"] = loadBack;
    params["idCardImagePanRkLgYd"] = loadPan;
    debugPrint("params:$params");
    var result = await Get.to(() => OcrDetailPage(params: params));
    if (result != null && result) {
      CZLoading.loading();
      await HomeController.to.requestIncompleteForm(isOff: true);
      CZLoading.dismiss();
    }
  }
}
