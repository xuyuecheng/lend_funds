import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  ConstraintId container0 = ConstraintId('container0');
  ConstraintId container1 = ConstraintId('container1');

  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My loan',
          style: TextStyle(
              fontSize: 17.5.sp,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: ConstraintLayout(width: 1.sw, height: matchParent, children: [
        Container(
          color: Colors.red,
          width: 1.sw - 20.w,
        ).applyConstraint(
            id: container0,
            topLeftTo: parent.topMargin(100.w).leftMargin(10.w),
            topRightTo: parent.topMargin(100.w).rightMargin(10.w),
            height: 200.h),
        Container(
          color: Colors.green,
          width: 1.sw - 20.w,
        ).applyConstraint(
          id: container1,
          left: container0.left,
          right: container0.right,
          top: container0.bottom,
          height: 200.h,
        )
      ]),
      backgroundColor: Colors.white,
    );
  }
}
