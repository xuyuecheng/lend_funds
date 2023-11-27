import 'package:flutter/material.dart';

import 'package:easy_refresh/easy_refresh.dart';

class CZEasyRefreshConfig {
  static ClassicHeader header = const ClassicHeader(
    clamping: true,
    position: IndicatorPosition.locator,
    mainAxisAlignment: MainAxisAlignment.end,
    dragText: '1Pull to refresh',
    armedText: '1Release ready',
    readyText: '1Refreshing...',
    processingText: '1Refreshing...',
    processedText: '1Succeeded',
    noMoreText: '1No more',
    failedText: '1Failed',
    messageText: '1Last updated at %T',
  );

  static ClassicFooter footer = const ClassicFooter(
    position: IndicatorPosition.locator,
    dragText: '1Pull to load',
    armedText: '1Release ready',
    readyText: '1Loading...',
    processingText: '1Loading...',
    processedText: '1Succeeded',
    noMoreText: '1No more',
    failedText: '1Failed',
    messageText: '1Last updated at %T',
  );

}