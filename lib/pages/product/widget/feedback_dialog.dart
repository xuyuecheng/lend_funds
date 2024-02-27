import 'package:flutter/material.dart';

class FeedbackDialog extends StatefulWidget {
  final Function(String) confirmBlock;
  const FeedbackDialog({Key? key, required this.confirmBlock})
      : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  var textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
        ),
        Container(
          width: 262,
          decoration: BoxDecoration(
              color: const Color(0xFFffffff),
              borderRadius: BorderRadius.circular(7.5)),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text("Feed back",
                  style: TextStyle(
                      fontSize: 17.5,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                width: 228,
                height: 96,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(2.5),
                    border: Border.all(color: Color(0xff707070), width: 0.5)),
                child: TextFormField(
                    minLines: 1,
                    maxLines: 20,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        fontSize: 15,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                      //
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      //
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    controller: textEditingController),
              ),
              SizedBox(
                height: 15,
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
                    widget.confirmBlock(textEditingController.text);
                  },
                  child: Text("Submit",
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
