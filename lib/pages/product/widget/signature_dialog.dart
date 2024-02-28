import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';

class SignatureDialog extends StatefulWidget {
  final Function() confirmBlock;
  final Function() cancelBlock;
  const SignatureDialog(
      {Key? key, required this.confirmBlock, required this.cancelBlock})
      : super(key: key);

  @override
  State<SignatureDialog> createState() => _SignatureDialogState();
}

class _SignatureDialogState extends State<SignatureDialog> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Color(0xff00A651),
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    //...
    _controller.addListener(() => log('Value changed'));
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
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
            child: Stack(
              children: [
                Column(
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
                          border:
                              Border.all(color: Color(0xff707070), width: 0.5)),
                      child: Signature(
                        key: const Key('signature'),
                        controller: _controller,
                        // height: 300,
                        backgroundColor: Colors.white,
                      ),
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
                                setState(() => _controller.clear());
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
                Positioned(
                  right: 4,
                  top: 4,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                      widget.cancelBlock();
                    },
                    child: Image.asset(
                      "assets/product/product_delete.png",
                      width: 18,
                      height: 18,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
