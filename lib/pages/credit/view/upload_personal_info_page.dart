import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/camera/views/camera_kpt.dart';
import 'package:lend_funds/pages/credit/controller/ocr_controller.dart';
import 'package:lend_funds/pages/credit/view/widget/credit_take_photo_widget.dart';
import 'package:lend_funds/utils/route/route_config.dart';

class UploadPersonalInforPage extends StatefulWidget {
  final String formId;
  final String formName;
  const UploadPersonalInforPage(
      {Key? key, required this.formId, required this.formName})
      : super(key: key);

  @override
  State<UploadPersonalInforPage> createState() =>
      _UploadPersonalInforPageState();
}

class _UploadPersonalInforPageState extends State<UploadPersonalInforPage> {
  XFile? _frontImageFile;
  XFile? _backImageFile;
  @override
  void initState() {
    super.initState();
    //...
    Get.put(OcrController());
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
          widget.formName,
          style: TextStyle(
              fontSize: 17.5.sp,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
              color: Color(0xffCFDEEA),
              child: Row(
                children: [
                  Image.asset('assets/credit/credit_camera_small_icon.png',
                      width: 26.w, height: 21.w),
                  SizedBox(
                    width: 9.w,
                  ),
                  Expanded(
                      child: Text(
                    'For anti-money laundering and anti-fraud review, please upload your true personal information.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 9.5.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.normal),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              'Photograph the original ID card',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 11.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CreditTakePhotoWidget(
                  title: "ID Card Front",
                  takePhotoBlock: () async {
                    XFile? imageFile = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CameraKpt()),
                    );
                    if (imageFile != null) {
                      // RequestUtil.addDot(RbiConfig.firstOcrImage);
                      OcrController.to.setIdCardFrontImage(imageFile);
                      // debugPrint("_frontImageFile--path:${imageFile.path}");
                      // setState(() {
                      //   _frontImageFile = imageFile;
                      // });
                    }
                  },
                  imgFile: _frontImageFile,
                ),
                CreditTakePhotoWidget(
                  title: "ID Card Back",
                  takePhotoBlock: () async {
                    XFile? imageFile = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CameraKpt()),
                    );
                    if (imageFile != null) {
                      // RequestUtil.addDot(RbiConfig.firstOcrImage);
                      // CZCreditKtpController.to.setIdCardFrontImage(imageFile);
                      debugPrint("_backImageFile--path:${imageFile.path}");
                      setState(() {
                        _backImageFile = imageFile;
                      });
                    }
                  },
                  imgFile: _backImageFile,
                ),
              ],
            ),
            SizedBox(
              height: 17.h,
            ),
            Text(
              'Take a photo of the original tax card',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 11.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CreditTakePhotoWidget(
                  title: "Pan Card",
                  takePhotoBlock: () {},
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              width: 345.w,
              height: 50.h,
              decoration: BoxDecoration(
                  color: const Color(0xFF003C6A),
                  borderRadius: BorderRadius.circular(5.w)),
              child: TextButton(
                onPressed: () {
                  Get.toNamed(CZRouteConfig.ocrDetail);
                },
                child: Text("Next step",
                    style: TextStyle(
                        fontSize: 17.5.sp,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w500)),
              ),
            ),
            SizedBox(
              height: 18.5.h,
            ),
            RichText(
                // textAlign: TextAlign.center,
                text: TextSpan(
              style: TextStyle(height: 2),
              children: [
                WidgetSpan(
                  // alignment: PlaceholderAlignment.middle,
                  child: Image.asset('assets/credit/credit_security.png',
                      width: 7.6.w, height: 8.9.w, fit: BoxFit.fill),
                ),
                TextSpan(
                  text:
                      ' Your information is only for loan review purposes, we will keep it strictly confidential and will not disclose it to any third-party platform.',
                  style: TextStyle(
                      color: const Color(0xFF000000F),
                      fontSize: 7.5.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
