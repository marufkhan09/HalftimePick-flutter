import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'interceptor.dart';

class BaseApiController extends GetxController with StateMixin<dynamic> {
  //static String baseUrl = "https://therundown-therundown-v1.p.rapidapi.com/";
  //static String baseUrl = "https://halftimepick.accountta.com/api/";
  static String baseUrl = "https://halftimepick.laravel-script.com/api/";
  static String baseUrl2 =
      "https://allscores.p.rapidapi.com/api/allscores/news";

  static String downloadBaseUrl =
      "https://therundown-therundown-v1.p.rapidapi.com/";

  Dio? _dio = Dio();

  Dio? _downloadDio = Dio();

  BaseApiController() {
    BaseOptions dioOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 60000),
    );

    BaseOptions downloadDioOptions = BaseOptions(
      baseUrl: downloadBaseUrl,
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 80000),
    );

    _dio = Dio(dioOptions)
      ..interceptors.add(LoggingInterceptors(
        dio: getDio()!,
      ));

    _downloadDio = Dio(downloadDioOptions)
      ..interceptors.add(LoggingInterceptors(
        dio: getDownloadDio()!,
      ));
  }

  Dio? getDio() => _dio;

  Dio? getDownloadDio() => _downloadDio;

  String handleError(DioError error) {
    String errorDescription = "";

    switch (error.type) {
      case DioErrorType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.connectionTimeout:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.unknown:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        errorDescription =
            "Received status code: ${error.response!.statusCode}";
        break;
      case DioErrorType.sendTimeout:
        errorDescription = "Send timeout in connection with API server";
        break;
      case DioErrorType.badCertificate:
        // TODO: Handle this case.
        break;
      case DioErrorType.connectionError:
        // TODO: Handle this case.
        break;
    }
    return errorDescription;
  }
}
