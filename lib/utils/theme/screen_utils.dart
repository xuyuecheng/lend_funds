import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CZScreenUtils {
  static init(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812), //
    );
  }

  ///
  static double get topBarHeight {
    return ScreenUtil().statusBarHeight + kToolbarHeight;
  }

  ///
  static double get screenHeight {
    return 1.sh;
  }

  ///
  static double get screenWidth {
    return 1.sw;
  }

  ///
  static pageHorizontalPadding() => 10.w;
}
