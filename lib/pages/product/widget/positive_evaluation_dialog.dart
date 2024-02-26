import 'package:flutter/material.dart';
import 'package:sahayak_cash/pages/common/custom_star_rating.dart';

class PositiveEvaluationDialog extends StatefulWidget {
  const PositiveEvaluationDialog({Key? key}) : super(key: key);

  @override
  State<PositiveEvaluationDialog> createState() =>
      _PositiveEvaluationDialogState();
}

class _PositiveEvaluationDialogState extends State<PositiveEvaluationDialog> {
  var starValue = 5; //默认5星
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
          height: 285,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                    "assets/product/positive_evaluation_background.png")),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "assets/product/positive_evaluation_good.png",
                width: 130,
                height: 130,
                fit: BoxFit.fill,
              ),
              RatingBar(
                width: 30,
                height: 28,
                padding: 19,
                value: starValue.toDouble(),
                onValueChangedCallBack: (value) {
                  starValue = value.toInt();
                },
              ),
              SizedBox(
                height: 23,
              ),
              Text(
                  "Thank you for your choice. We look forward to\nreceiving a 5-star rating from you.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 13,
              ),
              Container(
                  alignment: Alignment.center,
                  width: 133,
                  height: 34,
                  decoration: BoxDecoration(
                      color: const Color(0xFF00A651),
                      borderRadius: BorderRadius.circular(5)),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      debugPrint("starValue:$starValue");
                    },
                    child: Text("ok",
                        style: TextStyle(
                            fontSize: 17.5,
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400)),
                  )),
              SizedBox(
                height: 23,
              ),
            ],
          ),
        )
      ],
    );
  }
}
