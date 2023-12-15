import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditInputInfoWidget extends HookWidget {
  final TextEditingController? inputController;
  final FocusNode? focusNode;
  final String name;
  const CreditInputInfoWidget(
      {Key? key, this.inputController, this.focusNode, required this.name})
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
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          height: 44.h,
          decoration: BoxDecoration(
              color: Color(0xffF1F2F2),
              borderRadius: BorderRadius.circular(5.w)),
          child: TextFormField(
              style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w500),
              // controller: _phoneController,
              decoration: InputDecoration(
                hintText: "Please enter $name",
                hintStyle: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
                // 未获得焦点下划线设为透明色
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                //获得焦点下划线设为透明色
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              focusNode: focusNode,
              controller: inputController),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}