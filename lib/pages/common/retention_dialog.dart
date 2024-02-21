import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RetentionDialog extends StatefulWidget {
  final Function()? confirmBlock;
  const RetentionDialog({Key? key, this.confirmBlock}) : super(key: key);

  @override
  State<RetentionDialog> createState() => _RetentionDialogState();
}

class _RetentionDialogState extends State<RetentionDialog> {
  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 9.w),
          width: 262.h,
          decoration: BoxDecoration(
            // color: const Color(0xFF00A651),
            borderRadius: BorderRadius.circular(10.w),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Color(0xff129150), Color(0xff00A651)],
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                  top: 25.h,
                  child: Image.asset(
                    "assets/credit/retention_background_icon.png",
                    width: 173.w,
                    height: 179.w,
                    fit: BoxFit.fill,
                  )),
              Column(
                children: [
                  SizedBox(
                    height: 20.5.h,
                  ),
                  Text(
                      "Now complete the application,\nwithdraw the loan instantly.\n Expires in 10 minutes!",
                      style: TextStyle(
                          fontSize: 12.5.sp,
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 130.5.h,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                      if (widget.confirmBlock != null) {
                        widget.confirmBlock!();
                      }
                    },
                    child: Container(
                      width: 158.5.w,
                      height: 35.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xffCBE6D8),
                              Color(0xffF4FAF7),
                              Color(0xffFFFFFF)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15.h)),
                      child: Text("Continue",
                          style: TextStyle(
                              fontSize: 17.5.sp,
                              color: const Color(0xFF00A651),
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 158.5.w,
                      height: 35.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xffFFFFFF),
                              Color(0xff01A551),
                              Color(0xff01A651)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15.h)),
                      child: Text("Cancel",
                          style: TextStyle(
                              fontSize: 17.5.sp,
                              color: const Color(0xFFffffff),
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  SizedBox(
                    height: 4.5.h,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
