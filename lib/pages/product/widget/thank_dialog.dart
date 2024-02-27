import 'package:flutter/material.dart';

class ThankDialog extends StatefulWidget {
  final Function() confirmBlock;
  const ThankDialog({Key? key, required this.confirmBlock}) : super(key: key);

  @override
  State<ThankDialog> createState() => _ThankDialogState();
}

class _ThankDialogState extends State<ThankDialog> {
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
          decoration: BoxDecoration(
              color: const Color(0xFFffffff),
              borderRadius: BorderRadius.circular(7.5)),
          child: Column(
            children: [
              SizedBox(
                height: 23.5,
              ),
              Text(
                  "Thank you for your feedback. We have received\nit and immediately made improvements.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 2,
                      fontSize: 11,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 26.5,
              ),
              Container(
                width: 133,
                height: 34,
                decoration: BoxDecoration(
                    color: const Color(0xFF00A651),
                    borderRadius: BorderRadius.circular(5)),
                child: TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    widget.confirmBlock();
                  },
                  child: Text("OK",
                      style: TextStyle(
                          fontSize: 12.5,
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400)),
                ),
              ),
              SizedBox(
                height: 10.5,
              ),
            ],
          ),
        )
      ],
    );
  }
}
