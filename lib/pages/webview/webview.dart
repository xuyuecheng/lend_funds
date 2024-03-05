import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/theme/colors_utils.dart';

class WebView extends StatefulWidget {
  String title;
  String url;
  WebView({Key? key, this.title = "", this.url = ""}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> with AutomaticKeepAliveClientMixin {
  late final WebViewController controller;
  bool _isLoading = true;

  @override
  void initState() {
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
          widget.title,
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
