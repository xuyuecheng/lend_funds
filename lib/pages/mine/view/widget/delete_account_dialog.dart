import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccountDialog extends StatelessWidget {
  final Function() confirmBlock;
  final Function() cancelBlock;
  const DeleteAccountDialog(
      {Key? key, required this.confirmBlock, required this.cancelBlock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 288.w,
          decoration: BoxDecoration(
              color: Colors.transparent,
              // borderRadius: BorderRadius.circular(15.w),
              image: DecorationImage(
                  image: AssetImage(
                      'assets/mine/mine_delete_account_background.png'),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              SizedBox(
                height: 8.w,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.5.w),
                child: Text(
                    "After deleting your account, all your information on Sahayak Cash will be deleted and you will no longer be able to use our services. If you want to continue using it, you must re-register.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // height: 2,
                        fontSize: 12.5.sp,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.normal)),
              ),
              SizedBox(
                height: 30.w,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 128.w,
                      decoration: BoxDecoration(
                          color: const Color(0xFF00A651),
                          borderRadius: BorderRadius.circular(5.w)),
                      child: TextButton(
                        onPressed: () {
                          confirmBlock();
                        },
                        child: Text("Confirm",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Container(
                      width: 128.w,
                      decoration: BoxDecoration(
                          color: const Color(0xFFDBF6E9),
                          borderRadius: BorderRadius.circular(5.w)),
                      child: TextButton(
                        onPressed: () {
                          cancelBlock();
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color(0xFF00A651),
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 11.5.w,
              ),
            ],
          ),
        )
      ],
    );
  }
}
