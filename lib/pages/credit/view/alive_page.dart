import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AlivePage extends StatefulWidget {
  final String formId;
  final String formName;
  const AlivePage({Key? key, required this.formId, required this.formName})
      : super(key: key);

  @override
  State<AlivePage> createState() => _AlivePageState();
}

class _AlivePageState extends State<AlivePage> {
  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            }),
        title: Text(
          'Liveness detection',
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
                children: [
                  SizedBox(height: 16.5.h),
                  Text("Please face the camera",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 20.h),
                  Container(
                    width: 345.w,
                    height: 50.h,
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF003C6A),
                          borderRadius: BorderRadius.circular(5.w)),
                      child: TextButton(
                        onPressed: () {
                          // Get.toNamed(CZRouteConfig.contacts);
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
    );
  }
}
