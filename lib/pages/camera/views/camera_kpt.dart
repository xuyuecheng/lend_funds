import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';

class CameraKpt extends StatefulWidget {
  const CameraKpt({super.key});

  @override
  _CameraKptState createState() {
    return _CameraKptState();
  }
}

class _CameraKptState extends State<CameraKpt> {
  late CameraController controller;
  GlobalKey iconKey = GlobalKey();

  _initController() {
    controller =
        CameraController(cameras[0], ResolutionPreset.high, enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            debugPrint("CameraAccessDenied");
            break;
          default:
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
    if (!controller.value.isInitialized) {
      return Container(key: iconKey);
    }
    return MaterialApp(
        home: ConstraintLayout(width: 1.sw, height: matchParent, children: [
      CameraPreview(controller).applyConstraint(
        width: 1.sw,
        height: 1.sh,
        topLeftTo: parent,
      ),
      Image.asset(
        'assets/credit/credit_ktp_mask.png',
        height: 448.w,
        width: 250.w,
      ).applyConstraint(
          id: cId("mask"), width: 1.sw, topRightTo: parent.topMargin(120.h)),
      IconButton(
        iconSize: 70.w,
        icon: const Icon(Icons.radio_button_checked_rounded),
        color: Colors.white,
        onPressed:
            controller.value.isInitialized && !controller.value.isRecordingVideo
                ? onTakePictureButtonPressed
                : null,
      ).applyConstraint(width: 1.sw, topCenterTo: cId("mask").topMargin(380.h)),
    ]));
  }

  Future<void> onTakePictureButtonPressed() async {
    Navigator.pop(context, await controller.takePicture());

    // takePicture().then((value) {
    //
    //   if (kDebugMode) {
    //     print("takePicture:${value?.path}");
    //   }
    //   onBackPressed(value!);
    // });
  }

  void onBackPressed(XFile xFile) {
    Navigator.pop(context, xFile);
  }

  Future<XFile?> takePicture() async {
    try {
      return await controller.takePicture();
    } on CameraException catch (e) {
      if (kDebugMode) {
        print("CameraException:$e");
      }
    }
    return null;
  }
}
