import 'package:flutter/material.dart';

typedef OnValueChanged = void Function(double value);

class RatingBar extends StatefulWidget {
  //星星大小
  final double width;
  final double height;
  //星星间距
  final double padding;
  //星星改变事件回调
  final OnValueChanged onValueChangedCallBack;
  //值
  double value;

  // 获取键
  Key? getKey() {
    return key;
  }

  @override
  createState() => RatingBarState();

  RatingBar(
      {this.padding = 0,
      required this.onValueChangedCallBack,
      this.value = 5,
      this.width = 30,
      this.height = 30});
}

class RatingBarState extends State<RatingBar> {
  @override
  Widget build(BuildContext context) {
    return _getClickRatingBar();
  }

  _getClickRatingBar() {
    double width = widget.width;
    double height = widget.height;
    double padding = widget.padding;
    var realValue = widget.value % 5;
    if (widget.value >= 5 && realValue == 0) {
      realValue = 5;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            double value = 1;
            setState(() {
              widget.value = value;
            });
            widget.onValueChangedCallBack(value);
          },
          child: Image.asset(
            realValue >= 1
                ? 'assets/product/tab_star.png'
                : 'assets/product/tab_un_star.png',
            width: width,
            height: height,
          ),
        ),
        Padding(padding: EdgeInsets.only(right: padding)),
        GestureDetector(
          onTap: () {
            double value = 2;
            setState(() {
              widget.value = value;
            });
            if (widget.onValueChangedCallBack != null) {
              widget.onValueChangedCallBack(value);
            }
          },
          child: Image.asset(
            realValue >= 2
                ? 'assets/product/tab_star.png'
                : 'assets/product/tab_un_star.png',
            width: width,
            height: height,
          ),
        ),
        Padding(padding: EdgeInsets.only(right: padding)),
        GestureDetector(
          onTap: () {
            double value = 3;
            setState(() {
              widget.value = value;
            });
            if (widget.onValueChangedCallBack != null) {
              widget.onValueChangedCallBack(value);
            }
          },
          child: Image.asset(
            realValue >= 3
                ? 'assets/product/tab_star.png'
                : 'assets/product/tab_un_star.png',
            width: width,
            height: height,
          ),
        ),
        Padding(padding: EdgeInsets.only(right: padding)),
        GestureDetector(
          onTap: () {
            double value = 4;
            setState(() {
              widget.value = value;
            });
            if (widget.onValueChangedCallBack != null) {
              widget.onValueChangedCallBack(value);
            }
          },
          child: Image.asset(
            realValue >= 4
                ? 'assets/product/tab_star.png'
                : 'assets/product/tab_un_star.png',
            width: width,
            height: height,
          ),
        ),
        Padding(padding: EdgeInsets.only(right: padding)),
        GestureDetector(
          onTap: () {
            double value = 5;
            setState(() {
              widget.value = value;
            });
            if (widget.onValueChangedCallBack != null) {
              widget.onValueChangedCallBack(value);
            }
          },
          child: Image.asset(
            realValue >= 5
                ? 'assets/product/tab_star.png'
                : 'assets/product/tab_un_star.png',
            width: width,
            height: height,
          ),
        ),
      ],
    );
  }
}
