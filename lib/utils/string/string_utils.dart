import 'package:flutter/material.dart';

class CZStringUtils {
  static String changeMoneyString(dynamic value) {
    if (value is double) {
      value = value.toInt();
    }
    String text = value.toString();
    String separator = '.';
    if (text.isEmpty) {
      return 'Rp0';
    }
    var removeSeparator = text.replaceAll(separator, '');
    var list = removeSeparator.split('');
    for (var i = removeSeparator.length - 3; i > 0; i = i - 3) {
      list.insert(i, separator);
    }
    var endText = list.join('');
    return 'Rp$endText';
  }

  static String showMaskPhoneNumber(dynamic value) {
    String phoneNumber = value.toString();
    int maskLength = 4;
    int firstLength = 2;
    String maskChar = '*';
    // Check if phone number is valid
    if (phoneNumber.isEmpty) {
      return '';
    }
    if (phoneNumber.length < 8) {
      return value;
    }
    String lastFourDigits = phoneNumber.substring(phoneNumber.length - maskLength);
    String first = phoneNumber.substring(0,firstLength);
    String maskedString = '';
    for (int i = 0; i < phoneNumber.length - maskLength - firstLength; i++) {
      maskedString += maskChar;
    }
    first = first + maskedString + lastFourDigits;
    return first;
  }
}