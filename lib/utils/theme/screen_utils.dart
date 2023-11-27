import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CZScreenUtils {
  static init(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812), //这里传入你蓝湖等上面设计图的大小
    );
  }

  ///顶部导航栏高度= 状态栏高度 + Appbar高度
  static double get topBarHeight {
    return ScreenUtil().statusBarHeight + kToolbarHeight;
  }

  /// 获取 计算后的屏幕高度
  static double get screenHeight {
    return 1.sh;
  }

  /// 获取 计算后的屏幕高度
  static double get screenWidth {
    return 1.sw;
  }

  /// 页面水平内边距
  static pageHorizontalPadding() => 10.w;
}
