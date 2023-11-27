import 'dart:async';

// import 'package:lend_funds/pages/main/controllers/main_controller.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/preload.dart';

class RequestUtil {
  static List _waitRequestList = [];
  static Timer? _timer;

  static startTimer() {
    debugPrint("startTimer");
    const duration = Duration(seconds: 10);
    _timer ??= Timer.periodic(duration, (Timer t) {});
  }

  static removeTimer() {
    debugPrint("removeTimer");
    _timer?.cancel();
  }

  static getTimer() {
    return _timer;
  }

  static Future addDotBatchReq() async {
    List tempList = [];
    tempList.addAll(_waitRequestList);
    var paramList = tempList
        .map((e) => {
              "type": e,
            })
        .where((element) {
      String dotNameStr = element["type"];
      // return (isAppointed(dotNameStr: dotNameStr) ||
      //     HttpController.isAppDotEnabled());
      return true;
    }).toList();
    if (paramList.isNotEmpty) {
      try {
        var param = {'dotEventLogList': paramList};
        var result =
            await HttpRequest.request(InterfaceConfig.addBatch, params: param);
        if (result['status'] == 0) {
          _waitRequestList.clear();
        }
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  // static bool isAppointed({required String dotNameStr}) {
  //   bool isAppointed = false;
  //   if (dotNameStr == AddDotLoginConfig.loginStart //第一次打开（卸载后再次打开也发）
  //           ||
  //           dotNameStr == AddDotLoginConfig.loginPhoneFocus //手机号输入框获取焦点
  //           ||
  //           dotNameStr == AddDotLoginConfig.loginPhoneSend //发送短信验证码
  //           ||
  //           dotNameStr ==
  //               AddDotLoginConfig.loginPhoneSucess //发送获取短信成功（服务器返回请求成功）
  //           ||
  //           dotNameStr == RbiConfig.firstIndexClickApply //新客首页点击申请
  //       ) {
  //     isAppointed = true;
  //   }
  //   return isAppointed;
  // }

  static addDot(String param) {
    _waitRequestList.add(param);
    debugPrint("addDot param :$param");
  }

  static Future addDotReq({
    String? type,
  }) async {
    try {
      Map<String?, dynamic> paramso = {
        "type": type,
      };

      Map<String, dynamic>? params =
          paramso.filterNullValue.cast<String, dynamic>();
      var result =
          await HttpRequest.request(InterfaceConfig.rbi, params: params);

      if (result['status'] == 0) {
      } else {}
    } catch (e) {
      return Future.error(e);
    }
  }
}

extension MapUtil<K, V> on Map<K, V> {
  /// 移除null值时的key
  Map<K, V> get filterNullValue {
    removeWhere((key, value) => value == null);
    return this;
  }
}
