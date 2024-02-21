import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lend_funds/utils/entity/syscode_entity.dart';

class SysCodeWidget extends StatelessWidget {
  final Function()? onConfirm;
  final Function(SysCodeEntity)? onSelect;
  final List<SysCodeEntity>? data;
  final List<SysCodeEntity>? selected;
  final bool showName;

  const SysCodeWidget(
      {Key? key,
      this.onConfirm,
      this.data,
      this.selected,
      this.onSelect,
      this.showName = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 300.h,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 56.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      debugPrint("OK");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.w),
                      child: Text("OK",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.transparent,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Text("Please choose",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.bold)),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      debugPrint("Cancel");
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.w),
                      child: Text("Cancel",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xFFBEBEBE),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 244.h,
              child: ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (context, index) {
                    final sysCode = data?[index];
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        onSelect!(sysCode!);
                        if (onConfirm != null) {
                          onConfirm!();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12.w),
                        child: Text(
                            showName
                                ? sysCode?.name ?? ""
                                : sysCode?.value ?? "",
                            style: TextStyle(
                                fontSize: 17.sp,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.bold)),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
