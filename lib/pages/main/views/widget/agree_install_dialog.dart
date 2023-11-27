import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/utils/const/translate.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/route/route_config.dart';

class AgreeInstallDialog extends StatelessWidget {
  final Function() agreeBlock;
  final Function() rejectBlock;
  const AgreeInstallDialog(
      {Key? key, required this.agreeBlock, required this.rejectBlock})
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
              borderRadius: BorderRadius.circular(15.w),
              image: DecorationImage(
                  image: AssetImage('assets/login/install_pop_background.png'),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              SizedBox(
                height: 28.w,
              ),
              Text("Thanks for installing\n Lend Funds",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 27.5.sp,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 68.w,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.5.w),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(height: 2), //设置行间距
                      children: [
                        TextSpan(
                          text:
                              'Lend Funds attaches great importance to the protection of user privacy and personal information. Please read all the requirements of the',
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                            text: '《Privacy Policy》',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xFFFF0000),
                                fontWeight: FontWeight.w500),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(CZRouteConfig.webView, parameters: {
                                  'title': Translate.privacyStatement,
                                  'url': AppConfig.privacyStatementURL,
                                });
                              }),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                            text: '《Conditions and Terms Agreement》',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xFFFF0000),
                                fontWeight: FontWeight.w500),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(CZRouteConfig.webView, parameters: {
                                  'title': Translate.termsAgreement,
                                  'url': AppConfig.termsAgreement,
                                });
                              }),
                        TextSpan(
                          text:
                              '. Once you read and accept all terms, you can start using our services.',
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 31.5.w,
              ),
              Container(
                width: 210.w,
                decoration: BoxDecoration(
                    color: const Color(0xFF003C6A),
                    borderRadius: BorderRadius.circular(10.w)),
                child: TextButton(
                  onPressed: () {
                    agreeBlock();
                  },
                  child: Text("Agree",
                      style: TextStyle(
                          fontSize: 26.sp,
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.normal)),
                ),
              ),
              SizedBox(
                height: 10.5.w,
              ),
              TextButton(
                onPressed: () {
                  rejectBlock();
                },
                child: Text("Reject",
                    style: TextStyle(
                        fontSize: 26.sp,
                        color: const Color(0xFFCECECE),
                        fontWeight: FontWeight.normal)),
              ),
              SizedBox(
                height: 18.w,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
