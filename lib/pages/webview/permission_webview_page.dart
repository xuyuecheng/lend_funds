import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sahayak_cash/utils/route/route_config.dart';
import 'package:sahayak_cash/utils/storage/storage_utils.dart';
import 'package:sahayak_cash/utils/theme/colors_utils.dart';
import 'package:sahayak_cash/utils/toast/toast_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PermissionWebviewPage extends StatefulWidget {
  String title;
  String url;
  PermissionWebviewPage({Key? key, this.title = "", this.url = ""})
      : super(key: key);

  @override
  State<PermissionWebviewPage> createState() => _PermissionWebviewPageState();
}

class _PermissionWebviewPageState extends State<PermissionWebviewPage> {
  late final WebViewController controller;
  bool _isLoading = true;
  bool _switchSelected = false;
  @override
  void initState() {
    super.initState();
    //...
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(onNavigationRequest: (NavigationRequest request) {
        if (mounted) {
          setState(() {
            _isLoading = true; //
          });
        }
        return NavigationDecision.navigate;
      }, onPageFinished: (String url) {
        if (mounted) {
          setState(() {
            _isLoading = false; //页面加载完成，更新状态
          });
        }
      }))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
              color: Colors.black,
              onPressed: () {
                exit(0);
              }),
          title: Text(
            widget.title,
            style: TextStyle(
                fontSize: 17.5.sp,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: _isLoading
            ? Container(
                alignment: Alignment.center,
                child: SpinKitFadingCircle(
                  size: 50,
                  color: ColorsCommon.mainColor,
                ),
              )
            : WebViewWidget(
                controller: controller,
                //
                gestureRecognizers: {
                  Factory(() => VerticalDragGestureRecognizer()), //
                },
              ),
        bottomNavigationBar: Container(
          // height: 175.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.h),
              Row(
                children: [
                  SizedBox(width: 7.5.h),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        _switchSelected = !_switchSelected;
                      });
                    },
                    child: Image.asset(
                        _switchSelected
                            ? "assets/main/main_permission_select.png"
                            : "assets/main/main_permission_unselect.png",
                        width: 24.w,
                        height: 24.w),
                  ),
                  SizedBox(width: 5.h),
                  Text(
                    "Please tick the box to agree and confirm",
                    style: TextStyle(
                        fontSize: 12.5.sp,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: 37.h),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (_switchSelected == false) {
                    CZLoading.toast("Please tick the box to confirm, thanks");
                    return;
                  }
                  CZStorage.saveAgreePermission(true);
                  Get.offNamed(CZRouteConfig.initialRouteLogin);
                },
                child: Container(
                  width: 1.sw,
                  height: 45.h,
                  padding: EdgeInsets.symmetric(horizontal: 47.w),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF00A651),
                        borderRadius: BorderRadius.circular(5.w)),
                    alignment: Alignment.center,
                    child: Text("Next",
                        style: TextStyle(
                            fontSize: 21.5.sp,
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              SizedBox(height: 47.h),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
