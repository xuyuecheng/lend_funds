import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignatureDialog extends StatefulWidget {
  final Function() confirmBlock;
  const SignatureDialog({Key? key, required this.confirmBlock})
      : super(key: key);

  @override
  State<SignatureDialog> createState() => _SignatureDialogState();
}

class _SignatureDialogState extends State<SignatureDialog> {
  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7.5.w),
          width: 1.sw,
          decoration: BoxDecoration(color: const Color(0xFFffffff)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.5.h,
              ),
              Center(
                child: Text("Signature",
                    style: TextStyle(
                        fontSize: 22.5.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w700)),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text("Please write down your name",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 10.5.h,
              ),
              Container(
                width: 1.sw,
                height: 147.h,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    border: Border.all(color: Color(0xff707070), width: 0.5)),
                child: Container(),
              ),
              SizedBox(
                height: 18.h,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 165.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                          color: const Color(0xFF82CEA9),
                          borderRadius: BorderRadius.circular(5.w)),
                      child: TextButton(
                        onPressed: () {
                          // confirmBlock();
                        },
                        child: Text("Clear",
                            style: TextStyle(
                                fontSize: 17.5.sp,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Container(
                      width: 165.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                          color: const Color(0xFF00A651),
                          borderRadius: BorderRadius.circular(5.w)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          widget.confirmBlock();
                        },
                        child: Text("Confirm",
                            style: TextStyle(
                                fontSize: 17.5.sp,
                                color: const Color(0xFFffffff),
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        )
      ],
    );
  }
}
