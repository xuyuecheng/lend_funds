import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditTakePhotoWidget extends StatelessWidget {
  final int type;
  final Function() takePhotoBlock;
  final String? showFile;
  final String? uploadFile;
  const CreditTakePhotoWidget(
      {Key? key,
      required this.type,
      required this.takePhotoBlock,
      this.showFile,
      this.uploadFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "";
    String take_background_image = "";
    if (type == 1) {
      title = "ID Card Front";
      take_background_image = "assets/credit/aadhear_front_backg.png";
    } else if (type == 2) {
      title = "ID Card Back";
      take_background_image = "assets/credit/aadhear_back_backg.png";
    } else {
      title = "Pan Card";
      take_background_image = "assets/credit/pan_front_backg.png";
    }
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          takePhotoBlock();
        },
        child: Container(
          width: 157.w,
          child: Column(
            children: [
              Container(
                width: 157.w,
                height: 89.w,
                child: (showFile == null || showFile?.length == 0)
                    ? Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset(
                            take_background_image,
                            width: 157.w,
                            height: 89.w,
                            fit: BoxFit.fill,
                          ),
                          Image.asset(
                            'assets/credit/credit_camera_big_icon.png',
                            width: 44.w,
                            height: 38.w,
                            fit: BoxFit.fill,
                          )
                        ],
                      )
                    : Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.file(
                            File(showFile!),
                            height: 89.w,
                            width: 157.w,
                            fit: BoxFit.fill,
                          ),
                          Image.asset(
                            (uploadFile == null || uploadFile?.length == 0)
                                ? 'assets/credit/ocr_error_flag.png'
                                : 'assets/credit/ocr_correct_flag.png',
                            width: 42.w,
                            height: 42.w,
                            fit: BoxFit.fill,
                          )
                        ],
                      ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }
}
