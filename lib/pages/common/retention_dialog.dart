import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RetentionDialog extends StatefulWidget {
  final Function()? confirmBlock;
  const RetentionDialog({Key? key, this.confirmBlock}) : super(key: key);

  @override
  State<RetentionDialog> createState() => _RetentionDialogState();
}

class _RetentionDialogState extends State<RetentionDialog> {
  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 262,
          height: 262,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/credit/retention_back.png")),
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                  top: 36,
                  child: Image.asset(
                    "assets/credit/retention_background_icon.png",
                    width: 173,
                    height: 179,
                    fit: BoxFit.fill,
                  )),
              Positioned(
                top: 17.5,
                child: Text("One Step to get your Money\nUp to ₹ 20,000",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17.5.sp,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w400)),
              ),
              Positioned(
                  left: 10,
                  bottom: 15,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/credit/retention_quit_background_icon.png",
                      width: 115,
                      height: 35,
                      fit: BoxFit.fill,
                    ),
                  )),
              Positioned(
                  right: 10,
                  bottom: 15,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                      if (widget.confirmBlock != null) {
                        widget.confirmBlock!();
                      }
                    },
                    child: Image.asset(
                      "assets/credit/retention_continue_background_icon.png",
                      width: 115,
                      height: 35,
                      fit: BoxFit.fill,
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
