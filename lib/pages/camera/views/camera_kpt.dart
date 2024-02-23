import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahayak_cash/pages/camera/views/widget/camera_permission_dialog.dart';
import 'package:sahayak_cash/utils/toast/toast_utils.dart';
import 'package:permission_handler/permission_handler.dart';

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
      body: Column(
        children: <Widget>[
          Expanded(
            child: _cameraPreviewWidget(),
          ),
          _captureControlRowWidget(),
        ],
      ),
    );
  }

  ///
  Widget _captureControlRowWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, //
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
            iconSize: 40.w,
            icon: Icon(Icons.clear_rounded),
            color: Color(0xff00A651),
            onPressed: () {
              Navigator.pop(context, null);
            },
          ),
          IconButton(
            iconSize: 40.w,
            icon: Icon(Icons.camera_alt),
            color: Color(0xff00A651),
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

  ///
  Widget _cameraPreviewWidget() {
    if (!controller.value.isInitialized) {
      return SizedBox.shrink();
    } else {
      return CameraPreview(controller);
    }
  }

  Future<void> onTakePictureButtonPressed() async {
    Navigator.pop(context, await controller.takePicture());
  }

  void cameraPermissionDialog() {
    CZDialogUtil.show(CameraPermissionDialog(confirmBlock: () {
      CZDialogUtil.dismiss();
      openAppSettings();
    }, cancelBlock: () {
      CZDialogUtil.dismiss();
    }));
  }
}
