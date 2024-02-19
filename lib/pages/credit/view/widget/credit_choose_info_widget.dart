import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditChooseInfoWidget extends StatelessWidget {
  final String name;
  final String text;
  final Function() tapBlock;
  const CreditChooseInfoWidget(
      {Key? key,
      required this.tapBlock,
      required this.name,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: 15.sp,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              tapBlock();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 44.h,
              decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(5.w)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                  ),
                  Image.asset('assets/credit/credit_right_arrow.png',
                      width: 4.1.w, height: 8.2.w, fit: BoxFit.fill),
                ],
              ),
            )),
        SizedBox(height: 12.h),
      ],
    );
  }
}
