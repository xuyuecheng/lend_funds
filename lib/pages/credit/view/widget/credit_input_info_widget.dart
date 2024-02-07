import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditInputInfoWidget extends HookWidget {
  final TextEditingController? inputController;
  final FocusNode? focusNode;
  final String name;
  final String? hint;
  final bool require;
  final int numberSize;
  const CreditInputInfoWidget({
    Key? key,
    this.inputController,
    this.focusNode,
    required this.name,
    this.hint,
    this.require = false,
    this.numberSize = 100,
  }) : super(key: key);

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
              keyboardType: require ? TextInputType.number : TextInputType.text,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(numberSize) //
              ],
              style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w500),
              // controller: _phoneController,
              decoration: InputDecoration(
                hintText: hint ?? "Please enter $name",
                hintStyle: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
                //
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                //
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

class CreditInputTitleWidget extends StatelessWidget {
  final String? name;

  const CreditInputTitleWidget({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name ?? "",
            style: TextStyle(
                fontSize: 25,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w600)),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
