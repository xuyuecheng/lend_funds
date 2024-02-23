import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart' as form;
import 'package:dio/src/multipart_file.dart' as multipart;
import 'package:dio/src/response.dart' as res;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sahayak_cash/pages/login/controllers/login_controller.dart';
import 'package:sahayak_cash/pages/login/view/login_new_page.dart';
import 'package:sahayak_cash/utils/storage/storage_utils.dart';
import 'package:sahayak_cash/utils/toast/toast_utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'dio_config.dart';
import 'dio_utils.dart';

class HttpRequest {
  static final BaseOptions baseOptions = BaseOptions(
    baseUrl: DioConfig.baseURL,
    connectTimeout: DioConfig.timeout,
    receiveTimeout: DioConfig.timeout,
    responseType: ResponseType.plain,
  );
  static final Dio dio = Dio(baseOptions);

  static Future<T> request<T>(String url,
      {String method = "post",
      Map<dynamic, dynamic>? params,
      Interceptor? inter}) async {
    if (kDebugMode) {
      log("request-params:$params");
    }
    // 1.
    Map<String, dynamic> map = await DioUtils.getHeadersMap();
    final options = Options(
      method: method,
      headers: map,
    );
    //
    //
    Interceptor dInter = InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      handler.next(options);
    }, onResponse:
            (res.Response<dynamic> e, ResponseInterceptorHandler handler) {
      handler.next(e);
    }, onError: (DioException e, ErrorInterceptorHandler handler) {
      handler.next(e);
    });
    List<Interceptor> inters = [dInter];

    if (kDebugMode) {
      inters.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 100,
      ));
    }

    //
    if (inter != null) {
      inters.add(inter);
    }

    //
    dio.interceptors.addAll(inters);
    String encryptParams = '';
    if (params != null) {
      // encryptParams = await DioUtils.getEncryptParams(params!);
      encryptParams = json.encode(params);
    }
    // 2.
    try {
      res.Response response =
          await dio.request(url, data: encryptParams, options: options);
      if (response.data is String) {
        var result;
        if (response.data.contains('{')) {
          result = json.decode(response.data);
        } else {
          result = await DioUtils.responseDecrypt(response.data);
        }
        if (kDebugMode) {
          log("return-result:$result");
        }
        if (result != null && result["statusE8iqlh"] != null) {
          if (result["statusE8iqlh"] == 1012) {
            //
            if (LoginController.to.isHaveLoginPage == false) {
              LoginController.to.phoneStr = '';
              CZStorage.removeUserInfo();
              Get.offAll(() => LoginNewPage());
            }
            LoginController.to.isHaveLoginPage = true;
          } else if (result["statusE8iqlh"] != 1012 &&
              result["statusE8iqlh"] != 0) {
            CZLoading.toast(result["msgEsmut7"]);
          }
        }
        return result;
      } else {
        return response.data;
      }
    } on DioException catch (e) {
      CZLoading.dismiss();
      CZLoading.toast("Network request failed");
      return Future.error('Network request failed');
    }
  }

  static Future<T> uploadFile<T>(String url, String filePath) async {
    // 1.
    Map<String, dynamic> map = await DioUtils.getHeadersMap();
    final options = Options(
      method: "post",
      headers: map,
    );

    //
    //
    Interceptor dInter = InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      handler.next(options);
    }, onResponse:
            (res.Response<dynamic> e, ResponseInterceptorHandler handler) {
      handler.next(e);
    }, onError: (DioException e, ErrorInterceptorHandler handler) {
      handler.next(e);
    });
    List<Interceptor> inters = [dInter];

    //
    dio.interceptors.addAll(inters);
    // 2.
    try {
      final fileName = filePath.substring(filePath.lastIndexOf("/") + 1);
      final formData = form.FormData.fromMap({
        "file":
            await multipart.MultipartFile.fromFile(filePath, filename: fileName)
      });
      res.Response response =
          await dio.request(url, data: formData, options: options);
      if (response.data is String) {
        var result;
        if (response.data.contains('{')) {
          result = json.decode(response.data);
        } else {
          result = await DioUtils.responseDecrypt(response.data);
        }
        if (result != null && result["statusE8iqlh"] != null) {
          if (result["statusE8iqlh"] == 1012) {
            //
            if (LoginController.to.isHaveLoginPage == false) {
              LoginController.to.phoneStr = '';
              CZStorage.removeUserInfo();
              Get.offAll(() => LoginNewPage());
            }
            LoginController.to.isHaveLoginPage = true;
          } else if (result["statusE8iqlh"] != 1012 &&
              result["statusE8iqlh"] != 0) {
            CZLoading.toast(result["msgEsmut7"]);
          }
        }
        return result;
      } else {
        return response.data;
      }
    } on DioException catch (e) {
      CZLoading.dismiss();
      CZLoading.toast("Network request failed");
      return Future.error('Network request failed');
    }
  }

//  static void get() {
//    request(url, method: get);
//  }
//
//  static void post() {
//
//  }
}
