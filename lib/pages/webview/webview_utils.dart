import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/theme/colors_utils.dart';

class CZWebView extends StatefulWidget {
  String? title;
  CZWebView({Key? key, this.title}) : super(key: key);

  @override
  State<CZWebView> createState() => _CZWebViewState();
}

class _CZWebViewState extends State<CZWebView>
    with AutomaticKeepAliveClientMixin {
  late final WebViewController controller;
  bool _isLoading = true;
  late String title;
  late String url;

  @override
  void initState() {
    title = Get.parameters['title'] ?? '';
    url = Get.parameters['url'] ?? '';
    controller = WebViewController()
      // ..setJavaScriptMode(JavaScriptMode.unrestricted)
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
      ..loadRequest(Uri.parse(url));
    super.initState();
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
          title,
          style: TextStyle(
              fontSize: 17.5.sp,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(245, 245, 245, 245),
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
