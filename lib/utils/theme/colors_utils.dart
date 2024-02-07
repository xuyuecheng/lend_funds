import 'dart:ui';

class ColorsUtil {
  ///
  /// hex，：0xffffff，
  /// alpha，[0.0, 1.0]
  static Color hexColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0, alpha);
  }

  ///
  /// colorString，：'0x000000'  '0xff000000' '#000000' '#000000'，
  /// alpha，[0.0, 1.0]
  static Color hexStringColor(String colorString, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    String colorStr = colorString;
    // colorString
    if (!colorStr.startsWith('0xff') && colorStr.length == 6) {
      colorStr = '0xff' + colorStr;
    }
    // colorString，如0x000000
    if (colorStr.startsWith('0x') && colorStr.length == 8) {
      colorStr = colorStr.replaceRange(0, 2, '0xff');
    }
    // colorString，如#000000
    if (colorStr.startsWith('#') && colorStr.length == 7) {
      colorStr = colorStr.replaceRange(0, 1, '0xff');
    }
    //
    Color color = Color(int.parse(colorStr));
    int red = color.red;
    int green = color.green;
    int blue = color.blue;
    //
    return Color.fromRGBO(red, green, blue, alpha);
  }
}

class ColorsCommon {
  static Color btnBgGreen = ColorsUtil.hexStringColor("54D1AE");
  static Color lineColor = ColorsUtil.hexStringColor("D4D4D4");
  static Color mainColor = ColorsUtil.hexStringColor("FFAB19");
}
