// import 'package:financial_app/pages/mine/controllers/mine_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../home/controllers/home_controller.dart';
// import '../../repay/controllers/repay_controller.dart';
import '../controllers/main_config.dart';
// import '../controllers/main_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // MainController.to.requestUpload();
    // MainController.to.getAuthLicense();
    super.initState();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: CZMainConfig.pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: CZMainConfig.items,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 10.sp,
        selectedFontSize: 10.sp,
        selectedItemColor: const Color(0xFF008773),
        unselectedItemColor: const Color(0xFFCCCCCC),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _refresh(index);
          });
        },
      ),
    );
  }

  _refresh(int index) {
    switch (index) {
      case 0:
        {
          // HomeController.to.refreshData();
        }
        break;
      case 1:
        {
          // debugPrint('Widget CZRepayController is visible');
          // CZRepayController.to.refreshData();
        }
        break;
      case 2:
        {
          // MineController.to.requestHaveNoRead();
        }
        break;
    }
  }
}
