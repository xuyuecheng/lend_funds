import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraPermissionDialog extends StatelessWidget {
  final Function() confirmBlock;
  final Function() cancelBlock;
  const CameraPermissionDialog(
      {Key? key, required this.confirmBlock, required this.cancelBlock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 345.w,
          decoration: BoxDecoration(
              color: Colors.transparent,
              // borderRadius: BorderRadius.circular(15.w),
              image: DecorationImage(
                  image: AssetImage(
                      'assets/mine/mine_delete_account_background.png'),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              SizedBox(
                height: 8.w,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.5.w),
                child: Text(
                    "Please go to Settings app to enable camera access.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 2,
                        fontSize: 14.5.sp,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.normal)),
              ),
              SizedBox(
                height: 74.w,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 154.w,
                      decoration: BoxDecoration(
                          color: const Color(0xFF003C6A),
                          borderRadius: BorderRadius.circular(5.w)),
                      child: TextButton(
                        onPressed: () {
                          confirmBlock();
                        },
                        child: Text("Confirm",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Container(
                      width: 154.w,
                      decoration: BoxDecoration(
                          color: const Color(0xFFCFDEEA),
                          borderRadius: BorderRadius.circular(5.w)),
                      child: TextButton(
                        onPressed: () {
                          cancelBlock();
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: const Color(0xFF003C6A),
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 11.5.w,
              ),
            ],
          ),
        )
      ],
    );
  }
}
