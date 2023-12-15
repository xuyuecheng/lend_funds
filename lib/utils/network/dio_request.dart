import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart' as form;
import 'package:dio/src/multipart_file.dart' as multipart;
import 'package:dio/src/response.dart' as res;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/login/controllers/login_controller.dart';
import 'package:lend_funds/pages/login/view/login_page.dart';
import 'package:lend_funds/utils/storage/storage_utils.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';
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
      Map<String, dynamic>? params,
      Interceptor? inter}) async {
    if (kDebugMode) {
      log("请求参数params:$params");
    }
    // 1.创建单独配置
    String token = await DioUtils.getToken();
    final options = Options(
      method: method,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
        'OS': DioUtils.getPlatform,
        'Token': token,
      },
    );
    // 全局拦截器
    // 创建默认的全局拦截器
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

    // 请求单独拦截器
    if (inter != null) {
      inters.add(inter);
    }

    // 统一添加到拦截器中
    dio.interceptors.addAll(inters);
    String encryptParams = '';
    if (params != null) {
      encryptParams = await DioUtils.getEncryptParams(params!);
    }
    // 2.发送网络请求
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
          log("返回结果result:$result");
        }
        if (result != null && result['status'] != null) {
          if (result['status'] == 1012) {
            //跳转登录页面
            if (LoginController.to.isHaveLoginPage == false) {
              LoginController.to.phoneStr = '';
              CZStorage.removeUserInfo();
              Get.offAll(() => LoginPage());
            }
            LoginController.to.isHaveLoginPage = true;
          } else if (result['status'] != 1012 && result['status'] != 0) {
            CZLoading.toast(result["message"]);
          }
        }
        return result;
      } else {
        return response.data;
      }
    } on DioException catch (e) {
      CZLoading.dismiss();
      CZLoading.toast("Permintaan jaringan gagal");
      return Future.error('Permintaan jaringan gagal');
    }
  }

  static Future<T> uploadFile<T>(String url, String filePath) async {
    // 1.创建单独配置
    String token = await DioUtils.getToken();
    final options = Options(
      method: "post",
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
        'OS': DioUtils.getPlatform,
        'Token': token,
      },
    );

    // 全局拦截器
    // 创建默认的全局拦截器
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

    // 统一添加到拦截器中
    dio.interceptors.addAll(inters);
    // 2.发送网络请求
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
        if (result != null && result['status'] != null) {
          if (result['status'] == 1012) {
            //跳转登录页面
            if (LoginController.to.isHaveLoginPage == false) {
              LoginController.to.phoneStr = '';
              CZStorage.removeUserInfo();
              Get.offAll(() => LoginPage());
            }
            LoginController.to.isHaveLoginPage = true;
          } else if (result['status'] != 1012 && result['status'] != 0) {
            CZLoading.toast(result["message"]);
          }
        }
        return result;
      } else {
        return response.data;
      }
    } on DioException catch (e) {
      CZLoading.dismiss();
      CZLoading.toast("Permintaan jaringan gagal");
      return Future.error('Permintaan jaringan gagal');
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
