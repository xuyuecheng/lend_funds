import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/utils/route/route_config.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              }),
          title: Text(
            'personal information',
            style: TextStyle(
                fontSize: 17.5.sp,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          // padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color(0xffF1F2F2),
                height: 15.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.h),
                    Container(
                      width: 345.w,
                      height: 50.h,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF003C6A),
                            borderRadius: BorderRadius.circular(5.w)),
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(CZRouteConfig.workInforma);
                          },
                          child: Text("Next step",
                              style: TextStyle(
                                  fontSize: 17.5.sp,
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                    SizedBox(height: 52.h),
                  ],
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
