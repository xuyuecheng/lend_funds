import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lend_funds/main.dart';
import 'package:lend_funds/pages/camera/views/widget/camera_permission_dialog.dart';
import 'package:lend_funds/pages/common/retention_dialog.dart';
import 'package:lend_funds/pages/home/controller/home_controller.dart';
import 'package:lend_funds/utils/image/ImageCompressUtil.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class AlivePage extends StatefulWidget {
  final String formId;
  final String formName;
  const AlivePage({Key? key, required this.formId, required this.formName})
      : super(key: key);

  @override
  State<AlivePage> createState() => _AlivePageState();
}

class _AlivePageState extends State<AlivePage> {
  late CameraController controller;

  _initController() {
    controller =
        CameraController(cameras[1], ResolutionPreset.high, enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        debugPrint('code:${e.code},description:${e.description}');
        switch (e.code) {
          case 'CameraAccessDenied':
            debugPrint('You have denied camera access.');
            break;
          case 'CameraAccessDeniedWithoutPrompt':
            // iOS only
            cameraPermissionDialog();
            debugPrint('Please go to Settings app to enable camera access.');
            break;
          case 'CameraAccessRestricted':
            // iOS only
            debugPrint('Camera access is restricted.');
            break;
          case 'AudioAccessDenied':
            debugPrint('You have denied audio access.');
            break;
          case 'AudioAccessDeniedWithoutPrompt':
            // iOS only
            debugPrint('Please go to Settings app to enable audio access.');
            break;
          case 'AudioAccessRestricted':
            // iOS only
            debugPrint('Audio access is restricted.');
            break;
          default:
            debugPrint("sdfdsf");
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double cameraWidth = 315;
    double cameraHeight = 397;
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
        body: Stack(
          children: [
            cameraPreviewWidget(),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 13.5),
                  Image.asset(
                    "assets/credit/liveness_detection_backgrou.png",
                    width: cameraWidth,
                    height: cameraHeight,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 20),
                  Text("Please make sure it is done by you",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: const Color(0xFF00A651),
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 21),
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: controller != null &&
                              controller.value.isInitialized &&
                              !controller.value.isRecordingVideo
                          ? _onTakePictureButtonPressed
                          : null,
                      child: Container(
                          alignment: Alignment.center,
                          width: 176.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                              color: const Color(0xFF00A651),
                              borderRadius: BorderRadius.circular(5.w)),
                          child: Image.asset(
                            "assets/credit/liveness_detection_take_photo.png",
                            width: 32.w,
                            height: 28.h,
                          )))
                ],
              ),
            )
          ],
        ),
        backgroundColor: Color(0xffF5F4F2),
      ),
    );
  }

  _backEvent() {
    CZDialogUtil.show(RetentionDialog());
  }

  ///
  // Widget _cameraPreviewWidget() {
  //   if (!controller.value.isInitialized) {
  //     return SizedBox.shrink();
  //   } else {
  //     return CameraPreview(controller);
  //   }
  // }
  ///预览窗口
  Widget cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return Text(
        "",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      //调整child到设置的宽高比
      return CameraPreview(controller);
      // return AspectRatio(
      //   aspectRatio: controller.value.aspectRatio,
      //   child: CameraPreview(controller),
      // );
    }
  }

  Future<void> _onTakePictureButtonPressed() async {
    XFile imageFile = await controller.takePicture();
    if (imageFile.path.length > 0) {
      String imagePath = imageFile.path;
      imagePath = (await _testCompressAndGetFile(imagePath, imagePath)).path;
      File file = new File(imagePath);
      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      CZLoading.loading();
      var response = await _aliveIdentify(base64Image);
      CZLoading.dismiss();
      if (response["statusE8iqlh"] == 0) {
        CZLoading.loading();
        await HomeController.to.requestIncompleteForm(isOff: true);
        CZLoading.dismiss();
      }
    }
  }

  void cameraPermissionDialog() {
    CZDialogUtil.show(CameraPermissionDialog(confirmBlock: () {
      CZDialogUtil.dismiss();
      openAppSettings();
    }, cancelBlock: () {
      CZDialogUtil.dismiss();
    }));
  }

  Future<XFile> _testCompressAndGetFile(String path, String targetPath) async {
    ImageCompressUtil imageCompressUtil = ImageCompressUtil();
    return imageCompressUtil.imageCompressAndGetFile(File(path));
  }

  Future _aliveIdentify(String faceInfo) async {
    Map<String, dynamic> result =
        await HttpRequest.request(InterfaceConfig.alive, params: {
      "modelU8mV9A": {
        "faceInfosYTghz": faceInfo,
        "livenessTypeBB31oo": "ACC_H5"
      }
    });
    return result;
  }
}
