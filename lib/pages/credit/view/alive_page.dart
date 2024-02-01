import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/main.dart';
import 'package:lend_funds/pages/camera/views/widget/camera_permission_dialog.dart';
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: _cameraPreviewWidget(),
          ),
          _captureControlRowWidget(),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  ///相机工具栏
  Widget _captureControlRowWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, //均匀放置
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
            iconSize: 40.w,
            icon: Icon(Icons.clear_rounded),
            color: Colors.transparent,
            onPressed: () {
              // Navigator.pop(context, null);
            },
          ),
          IconButton(
            iconSize: 40.w,
            icon: Icon(Icons.camera_alt),
            color: Colors.blue,
            onPressed: controller.value.isInitialized &&
                    !controller.value.isRecordingVideo
                ? onTakePictureButtonPressed
                : null,
          ),
          IconButton(
            iconSize: 40.w,
            icon: Icon(Icons.verified_outlined),
            color: Colors.transparent,
            onPressed: () {},
          )
        ],
      ),
    );
  }

  ///预览窗口
  Widget _cameraPreviewWidget() {
    if (!controller.value.isInitialized) {
      return SizedBox.shrink();
    } else {
      return CameraPreview(controller);
    }
  }

  Future<void> onTakePictureButtonPressed() async {
    XFile imageFile = await controller.takePicture();
    if (imageFile.path.length > 0) {
      String imagePath = imageFile.path;
      imagePath = (await testCompressAndGetFile(imagePath, imagePath)).path;
      File file = new File(imagePath);
      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      CZLoading.loading();
      var response = await aliveIdentify(base64Image);
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

  Future<XFile> testCompressAndGetFile(String path, String targetPath) async {
    ImageCompressUtil imageCompressUtil = ImageCompressUtil();
    return imageCompressUtil.imageCompressAndGetFile(File(path));
  }

  Future aliveIdentify(String faceInfo) async {
    Map<String, dynamic> result =
        await HttpRequest.request(InterfaceConfig.alive, params: {
      "model": {"faceInfo": faceInfo, "livenessType": "ACC_H5"}
    });
    return result;
  }
}
