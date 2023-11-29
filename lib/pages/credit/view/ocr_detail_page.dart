import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/credit/view/widget/credit_choose_info_widget.dart';
import 'package:lend_funds/pages/credit/view/widget/credit_input_info_widget.dart';
import 'package:lend_funds/utils/route/route_config.dart';

class OcrDetailPage extends StatefulWidget {
  const OcrDetailPage({Key? key}) : super(key: key);

  @override
  State<OcrDetailPage> createState() => _OcrDetailPageState();
}

class _OcrDetailPageState extends State<OcrDetailPage> {
  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              }),
          title: Text(
            'Ocr Detail',
            style: TextStyle(
                fontSize: 17.5.sp,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          // padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color(0xffF1F2F2),
                height: 15.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.5.h),
                    CreditInputInfoWidget(),
                    CreditInputInfoWidget(),
                    CreditChooseInfoWidget(tapBlock: () {
                      debugPrint("12");
                      showDefaultYearPicker(context);
                    }),
                    CreditInputInfoWidget(),
                    SizedBox(height: 12.h),
                    Container(
                      width: 345.w,
                      height: 50.h,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF003C6A),
                            borderRadius: BorderRadius.circular(5.w)),
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(CZRouteConfig.personalInforma);
                          },
                          child: Text("Next step",
                              style: TextStyle(
                                  fontSize: 17.5.sp,
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                    SizedBox(height: 52.h),
                  ],
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  void showDefaultYearPicker(BuildContext context) async {
    //设置默认显示的日期为当前
    DateTime initialDate = DateTime.now();
    final DateTime? dateTime = await showDatePicker(
      context: context,
      //定义控件打开时默认选择日期
      initialDate: initialDate,
      //定义控件最早可以选择的日期
      firstDate: DateTime(1900, 1),
      //定义控件最晚可以选择的日期
      lastDate: initialDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.blue,
          ),
          child: child!,
        );
      },
    );
    if (dateTime != null && dateTime != initialDate) {
      debugPrint("${dateTime.year}-${dateTime.month}-${dateTime.day}");
    }
  }
}
