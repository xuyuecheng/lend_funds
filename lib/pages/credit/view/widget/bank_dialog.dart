import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankDialog extends StatelessWidget {
  final List titleList;
  final List contentList;
  final Function() onConfirm;
  const BankDialog(
      {required this.titleList,
      required this.contentList,
      required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 300.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  decoration: new BoxDecoration(
                      //设置四周圆角 角度
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(22.sp),
                          topLeft: Radius.circular(22.sp)),
                      color: Color.fromRGBO(54, 65, 225, 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Confirm that your information has been filled in correctly",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 13.sp)),
                    ],
                  )),
              Container(
                  width: 300.w,
                  padding: EdgeInsets.all(20.sp),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: bankInfoWidget(),
                  )),
              Container(
                width: 300.w,
                child: Row(children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: MaterialButton(
                        color: Color.fromRGBO(235, 236, 252, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.sp))),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(54, 65, 225, 1),
                                fontSize: 15.sp)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: MaterialButton(
                        color: Color.fromRGBO(54, 65, 225, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20.sp))),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Text("CONTINUE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15.sp)),
                        onPressed: () {
                          Navigator.pop(context);
                          onConfirm();
                        },
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ));
  }

  List<Widget> bankInfoWidget() {
    List<Widget> widgetList = [];
    for (int index = 0; index < titleList.length; index++) {
      widgetList.add(Text("${titleList[index]}:${contentList[index]}",
          style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.bold)));
      widgetList.add(SizedBox(
        height: 15.h,
      ));
    }
    return widgetList;
  }
}
