import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'order_list_page.dart';

class OrderPage extends StatefulWidget {
  final int initialIndex;
  final bool canReturn;

  const OrderPage({Key? key, this.initialIndex = 0, this.canReturn = false})
      : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final _pages = const [
    OrderListPage(status: ""),
    OrderListPage(status: "LOAN_SUCCESS"),
    OrderListPage(status: "DUNNING"),
    OrderListPage(status: "FINISH")
  ];
  late TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: (widget.initialIndex));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: widget.canReturn
            ? BackButton(
                color: Colors.black,
                onPressed: () {
                  Get.back();
                })
            : SizedBox.shrink(),
        title: Text(
          "My loan",
          style: TextStyle(
              fontSize: 17.5.sp,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xff00A651),
          labelColor: const Color(0xff00A651),
          unselectedLabelColor: const Color(0xff969696),
          labelStyle: TextStyle(fontSize: 15.sp),
          unselectedLabelStyle: TextStyle(fontSize: 15.sp),
          tabs: const [
            Tab(text: "All"),
            Tab(text: "Success"),
            Tab(text: "Overdue"),
            Tab(text: "Finish")
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: _pages),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
