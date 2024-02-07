import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
enum VerificationBoxItemType {
  //
  underline,
  //
  box,
}

class CZVerificationBox extends StatefulWidget {
  //
  final int count;
  //
  final double itemWidth;
  //
  final double itemHeight;
  //
  final ValueChanged? onSubmitted;
  // ，[VerificationBoxItemType]
  final VerificationBoxItemType type;
  //
  final Decoration? decoration;
  //
  final double borderWidth;
  //
  final Color? borderColor;
  //
  final Color? focusBorderColor;
  // [VerificationBoxItemType.box]
  final double borderRadius;
  //
  final TextStyle? textStyle;
  //
  final bool unfocus;
  //
  final bool autoFocus;
  //
  final bool showCursor;
  //
  final Color? cursorColor;
  //
  final double cursorWidth;
  //
  final double cursorIndent;
  //
  final double cursorEndIndent;

  const CZVerificationBox(
      {super.key,
      this.count = 6,
      this.itemWidth = 45,
      this.itemHeight = 45,
      this.onSubmitted,
      this.type = VerificationBoxItemType.box,
      this.decoration,
      this.borderWidth = 1.0,
      this.borderRadius = 5.0,
      this.textStyle,
      this.focusBorderColor,
      this.borderColor,
      this.unfocus = true,
      this.autoFocus = true,
      this.showCursor = false,
      this.cursorWidth = 2,
      this.cursorColor,
      this.cursorIndent = 10,
      this.cursorEndIndent = 10});

  @override
  State<StatefulWidget> createState() => _CZVerificationBox();
}

class _CZVerificationBox extends State<CZVerificationBox> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  final List _contentList = [];

  @override
  void initState() {
    List.generate(widget.count, (index) {
      _contentList.add('');
    });
    _controller = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(widget.count, (index) {
              return Container(
                width: widget.itemWidth,
                height: widget.itemHeight,
                child: CZVerificationBoxItem(
                  data: _contentList[index],
                  textStyle: widget.textStyle,
                  type: widget.type,
                  decoration: widget.decoration,
                  borderRadius: widget.borderRadius,
                  borderWidth: widget.borderWidth,
                  borderColor: (_controller.text.length == index
                          ? widget.focusBorderColor
                          : widget.borderColor) ??
                      widget.borderColor,
                  showCursor:
                      widget.showCursor && _controller.text.length == index,
                  cursorColor: widget.cursorColor,
                  cursorWidth: widget.cursorWidth,
                  cursorIndent: widget.cursorIndent,
                  cursorEndIndent: widget.cursorEndIndent,
                ),
              );
            }),
          )),
          _buildTextField(),
        ],
      ),
    );
  }

  /// TextField
  _buildTextField() {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
      cursorWidth: 0,
      autofocus: widget.autoFocus,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(widget.count),
      ],
      maxLength: widget.count,
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required int? maxLength,
        required bool isFocused,
      }) {
        return const Text('');
      },
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.transparent),
      onChanged: _onValueChange,
    );
  }

  _onValueChange(value) {
    for (int i = 0; i < widget.count; i++) {
      if (i < value.length) {
        _contentList[i] = value.substring(i, i + 1);
      } else {
        _contentList[i] = '';
      }
    }
    setState(() {});

    if (value.length == widget.count) {
      if (widget.unfocus) {
        _focusNode.unfocus();
      }
      if (widget.onSubmitted != null) {
        widget.onSubmitted!(value);
      }
    }
  }
}

///
class CZVerificationBoxItem extends StatelessWidget {
  final String data;
  final VerificationBoxItemType type;
  final double borderWidth;
  final Color? borderColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final Decoration? decoration;
  //
  final bool showCursor;
  //
  final Color? cursorColor;
  //
  final double cursorWidth;
  //
  final double cursorIndent;
  //
  final double cursorEndIndent;
  const CZVerificationBoxItem(
      {super.key,
      this.data = '',
      this.textStyle,
      this.type = VerificationBoxItemType.box,
      this.decoration,
      this.borderRadius = 5.0,
      this.borderWidth = 2.0,
      this.borderColor,
      this.showCursor = false,
      this.cursorColor,
      this.cursorWidth = 2,
      this.cursorIndent = 5,
      this.cursorEndIndent = 5});

  @override
  Widget build(BuildContext context) {
    var borderColor = this.borderColor ?? Theme.of(context).dividerColor;
    var text = _buildText();
    var widget;
    if (type == VerificationBoxItemType.box) {
      widget = _buildBoxDecoration(text, borderColor);
    } else {
      widget = _buildUnderlineDecoration(text, borderColor);
    }

    return Stack(
      children: <Widget>[
        widget,
        showCursor
            ? Positioned.fill(
                child: CZVerificationBoxCursor(
                color: cursorColor ??
                    Theme.of(context).textSelectionTheme.cursorColor,
                width: cursorWidth,
                indent: cursorIndent,
                endIndent: cursorEndIndent,
              ))
            : Container()
      ],
    );
  }

  ///
  _buildBoxDecoration(Widget child, Color borderColor) {
    return Container(
      alignment: Alignment.center,
      decoration: decoration ??
          BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: borderColor, width: borderWidth)),
      child: child,
    );
  }

  ///
  _buildUnderlineDecoration(Widget child, Color borderColor) {
    return Container(
      alignment: Alignment.center,
      decoration: UnderlineTabIndicator(
          borderSide: BorderSide(width: borderWidth, color: borderColor)),
      child: child,
    );
  }

  ///
  _buildText() {
    return Text(
      '$data',
      style: textStyle,
    );
  }
}

/// des:
class CZVerificationBoxCursor extends StatefulWidget {
  //
  final Color? color;
  //
  final double width;
  //
  final double indent;
  //
  final double endIndent;
  CZVerificationBoxCursor(
      {this.color,
      required this.width,
      required this.indent,
      required this.endIndent});

  @override
  State<StatefulWidget> createState() => _CZVerificationBoxCursor();
}

class _CZVerificationBoxCursor extends State<CZVerificationBoxCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: VerticalDivider(
        thickness: widget.width,
        color: widget.color,
        indent: widget.indent,
        endIndent: widget.endIndent,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
