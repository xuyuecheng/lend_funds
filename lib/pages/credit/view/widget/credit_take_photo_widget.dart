import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditTakePhotoWidget extends StatelessWidget {
  final String title;
  final Function() takePhotoBlock;
  const CreditTakePhotoWidget(
      {Key? key, required this.title, required this.takePhotoBlock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Image.asset(
                          'assets/credit/credit_camera_backg_icon.png',
                          width: 157.w,
                          height: 89.w),
                    ),
                    Positioned(
                      left: (157 - 44) / 2,
                      top: (89 - 38) / 2,
                      child: Image.asset(
                          'assets/credit/credit_camera_big_icon.png',
                          width: 44.w,
                          height: 38.w),
                    ),
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
