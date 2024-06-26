import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:sahayak_cash/pages/common/model/global_config.dart';

class MarqueeWidget extends StatefulWidget {
  const MarqueeWidget({Key? key}) : super(key: key);

  @override
  State<MarqueeWidget> createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  String finalMessage = "";
  @override
  void initState() {
    super.initState();
    //...
    finalMessage = getMessage();
  }

  String getMessage() {
    String joinMessage = "";
    if (GlobalConfig.message.isNotEmpty) {
      List<String> loanList = ["5000", "10000", "20000", "25000", "30000"];
      for (int index = 0; index < 10; index++) {
        String message = GlobalConfig.message;
        String phoneStr = "******" + randomBit(4);
        int randomIndex = Random().nextInt(5);
        String moneyStr = loanList[randomIndex];
        message = message.replaceAll("#{phone}", phoneStr);
        message = message.replaceAll("#{amount}", moneyStr);
        joinMessage = joinMessage + message + "     ";
      }
    }
    return joinMessage;
  }

  @override
  Widget build(BuildContext context) {
    if (finalMessage.isEmpty) {
      finalMessage = getMessage();
    }
    return Visibility(
        visible: (finalMessage.isNotEmpty),
        child: Column(
          children: [
            Container(
              height: 39,
              color: const Color(0xFF000000),
              child: Row(
                children: [
                  SizedBox(
                    width: 18,
                  ),
                  Image.asset(
                    "assets/credit/scroll_back.png",
                    width: 20,
                    height: 17,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: MarqueeText(
                      text: TextSpan(
                        text: finalMessage,
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFffffff),
                        fontWeight: FontWeight.bold,
                      ),
                      speed: 40,
                    ),
                  ),
                  SizedBox(
                    width: 33,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  randomBit(int len) {
    String scopeF = '0123456789'; //首位
    String scopeC = '0123456789'; //中间
    String result = '';
    for (int i = 0; i < len; i++) {
      if (i == 0) {
        result = scopeF[Random().nextInt(scopeF.length)];
      } else {
        result = result + scopeC[Random().nextInt(scopeC.length)];
      }
    }
    return result;
  }
}
