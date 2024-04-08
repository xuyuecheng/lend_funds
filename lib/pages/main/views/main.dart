// import 'package:financial_app/pages/mine/controllers/mine_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahayak_cash/pages/home/controller/home_controller.dart';
import 'package:sahayak_cash/utils/eventbus/eventbus.dart';

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
  int _currentIndex = 0;
  late BottomNavigationBar navigationBar;
  PageController _pageController = PageController();
  @override
  void initState() {
    // MainController.to.requestUpload();
    // MainController.to.getAuthLicense();
    super.initState();
    //listen event
    EventBus().on(EventBus.changeToOrderTab, (arg) {
      // setState(() {
      //   _currentIndex = 1;
      //   _refresh(1);
      //   debugPrint("_currentIndex:$_currentIndex");
      // });
      _currentIndex = 1;
      _pageController.jumpToPage(1);
      debugPrint("_currentIndex:$_currentIndex");
    });
    EventBus().on(EventBus.changeToHomeTab, (arg) {
      // setState(() {
      //   _currentIndex = 0;
      //   _refresh(0);
      //   debugPrint("_currentIndex:$_currentIndex");
      // });
      _currentIndex = 0;
      _pageController.jumpToPage(0);
      debugPrint("_currentIndex:$_currentIndex");
    });
  }

  @override
  void dispose() {
    //...
    EventBus().off(EventBus.changeToOrderTab);
    EventBus().off(EventBus.changeToHomeTab);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    navigationBar = BottomNavigationBar(
      currentIndex: _currentIndex,
      items: CZMainConfig.items,
      type: BottomNavigationBarType.fixed,
      unselectedFontSize: 10.sp,
      selectedFontSize: 10.sp,
      selectedItemColor: const Color(0xFF008773),
      unselectedItemColor: const Color(0xFFCCCCCC),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        setState(() {
          //   _currentIndex = index;
          //   _refresh(index);
          //   debugPrint("_currentIndex:$_currentIndex");
          _currentIndex = index;
          _pageController.jumpToPage(index);
          debugPrint("_currentIndex:$_currentIndex");
        });
      },
    );
    return Scaffold(
      // body: IndexedStack(
      //   index: _currentIndex,
      //   children: CZMainConfig.pages,
      // ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: CZMainConfig.pages.length,
        itemBuilder: (context, index) => CZMainConfig.pages[index],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: navigationBar,
    );
  }

  _refresh(int index) {
    switch (index) {
      case 0:
        {
          HomeController.to.getIncompleteForm();
          HomeController.to.getProductList();
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
