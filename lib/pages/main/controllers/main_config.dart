import 'package:easy_refresh/easy_refresh.dart';
// import 'package:financial_app/pages/main/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lend_funds/pages/home/view/home_page.dart';
import 'package:lend_funds/pages/mine/view/mine_page.dart';
import 'package:lend_funds/pages/order/view/order_page.dart';

import '../../../utils/theme/app_theme.dart';
import '../../../utils/theme/screen_utils.dart';
import '../../../utils/toast/toast_utils.dart';
// import '../../home/views/home.dart';
// import '../../mine/views/mine.dart';
// import '../../repay/views/repay.dart';

class CZBottomBarItem extends BottomNavigationBarItem {
  CZBottomBarItem(String iconName, String title)
      : super(
          label: title,
          icon: Image.asset("assets/tabbar/tab_${iconName}_normal.png",
              width: 25),
          activeIcon: Image.asset("assets/tabbar/tab_${iconName}_selected.png",
              width: 25),
        );
}

class CZMainConfig {
  static List<Widget> pages = [
    const HomePage(),
    const OrderPage(),
    const MinePage(),
  ];

  static List<CZBottomBarItem> items = [
    CZBottomBarItem("home", ""),
    CZBottomBarItem("order", ""),
    CZBottomBarItem("mine", ""),
  ];

  static CZBeforeRunAppConfig() async {
    await ScreenUtil.ensureScreenSize();
    await GetStorage.init('lend_funds');
    WidgetsFlutterBinding.ensureInitialized();
  }

  static init(BuildContext ctx) {
    // Get.put(MainController());
    CZScreenUtils.init(ctx);
    CZToastConfig.setEasyLoading();
    CZAppThemeConfig.setupDevice();

    // 全局设置
    EasyRefresh.defaultHeaderBuilder = () => ClassicHeader();
    EasyRefresh.defaultFooterBuilder = () => ClassicFooter();
  }
}
