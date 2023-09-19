import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as pref;
import 'package:halftimepick/utils/shared_pref.dart';

class LoggingInterceptors extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;
  final SharedPref _sharedPref = SharedPref();
  final Dio dio;

  LoggingInterceptors({required this.dio});

  Future<String> getApiKey() async {
    var key = "1e463f0494mshc165327b512b9c9p1fc774jsn5883cfefa8a8";
    return key;
  }

  Future<String> getApiHost() async {
    var host = "therundown-therundown-v1.p.rapidapi.com";
    return host;
  }

  Future<String> getlan() async {
    String lang = await _sharedPref.readString("language") ?? 'en';
    return lang.isNotEmpty ? lang : 'en';
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    await getApiKey().then((value) =>
        options.headers.addIf(value.isNotEmpty, "X-RapidAPI-Key", value));
    await getApiHost().then((value) =>
        options.headers.addIf(value.isNotEmpty, "X-RapidAPI-Host", value));

    /* await getToken().then((value) => options.headers
        .addIf(value.isNotEmpty, "Authorization", "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZGU1NmE2NWNhZjNhN2JlOTQwMWRjYjM4YzlhNWRhMWIxNDMzZjc1Njg4YTI1Y2I1NjlkNmQ1YTMyYmYyYTg0NWYwY2Y1NmNjNmIwNTNmNjAiLCJpYXQiOjE2Njc4MDE3OTIsIm5iZiI6MTY2NzgwMTc5MiwiZXhwIjoxNjk5MzM3NzkyLCJzdWIiOiIxNDczNiIsInNjb3BlcyI6W119.ooShH8jjT3ichUT3Izosjc8pLByEypNoYziIsDk6T2fWuOAcgf0dSqaY21771zDRn50xj1BSvmjisLYnfZk0L2zKfdpSb83tlF0RLi6m0ufF7d-F0X8WQ3lpuxCjJzBoP3TomYhMCR3Y5trhFJjHaynJvd1WeMwPBNOQLP5qSlzKCQqDnPCisYPsx1_9pXx_GsI_OhS5gJjoSd9DLIenB-ajWEU-vkaMoXqgIPn12LADP33P1vmcC8SWZHqxREv_Y3NGdD4mtQckZmCvNqfsd-PDUJOQ31HtjifyURzrhFoFIX0-7EtZm9HNKUHoqK6gO0wzozfRYUtKK0xISlKtKjLOqbFJJbOG_MHr3ox7gIU3oCkfiaqIVUH9xBVRCYuKy-AbFJ-hHlh4nuccbEBbD1g1L05KcPbCAG8MsecKpdZ_EW4RyU0CoezOEgunnQ-kFzZf1Zq5SigQV_0lQ0gNqejJGqvJMOF5lGX-4vNrORRXvGO4exvx0K-zl63sSEUHGItp8kwZArNzs8lTCLj0n5vpGXkGpgKSLql1y0DKpRaJD7blFzNo3xg20Riu39JKvxggPR4eCM--bB8x-d0UBKHXXl5VUY4m07lIFH-uR8NtIDZEoAFWhUpxuXbQUjs4IERRQRbJNoLTnSC3RALdcZb8g3z7PnIyp9_UgySa0_8"));
    */

    debugPrint("--> ${options.method} ${options.baseUrl}${options.path}");
    debugPrint("Content type: ${options.contentType}");
    debugPrint("QueryParams: ${options.queryParameters}");
    debugPrint("Headers: ${options.headers}");
    debugPrint("Data: ${options.data}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("<-- STATUS : ${response.statusCode}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        debugPrint(
            responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      // debugPrint(response.data.toString());
    }
    debugPrint("<-- END HTTP");
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError error, ErrorInterceptorHandler handler) async {
    debugPrint(
        "ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.baseUrl}${error.requestOptions.path}");
    // if (error.response!.statusCode == 401) {
    //   _sharedPref.remove('bearerToken');
    //   _sharedPref.remove("userID");
    //   // pref.Get.toNamed(loginPage);
    // }
    /* if (error.response!.statusCode == 401) {
      String refreshToken =
          await _sharedPref.readString("apiRefreshToken") ?? "";
      if (refreshToken.isNotEmpty) {
        Dio tokenDio = Dio();
        Options options = Options(
            method: error.requestOptions.method,
            sendTimeout: error.requestOptions.sendTimeout,
            receiveTimeout: error.requestOptions.receiveTimeout,
            extra: error.requestOptions.extra,
            headers: error.requestOptions.headers,
            responseType: error.requestOptions.responseType,
            contentType: error.requestOptions.contentType);
        tokenDio.interceptors.add(LogInterceptor(
            responseBody: true,
            requestHeader: false,
            requestBody: false,
            request: false,
            responseHeader: false));
        return await tokenDio.post(
            "https://v3stage.getalice.ai/api/accounts/refresh",
            data: {'refresh': refreshToken}).then((data) {
          //update Token
          error.requestOptions.headers["Authorization"] =
              "Token " + data.data["access"];
          _sharedPref.saveString("apiToken", data.data["access"]);
        }).catchError((e) {
          if (e is DioError) {
            if (e.response!.statusCode == 401) {
              _sharedPref.clear();
              // pref.Get.offAllNamed(LOGIN_PAGE);
            }
          }
        }).then((value) async {
          //repeat
          final response = await tokenDio.request(
              error.requestOptions.baseUrl + error.requestOptions.path,
              data: error.requestOptions.data,
              cancelToken: error.requestOptions.cancelToken,
              onReceiveProgress: error.requestOptions.onReceiveProgress,
              onSendProgress: error.requestOptions.onSendProgress,
              queryParameters: error.requestOptions.queryParameters,
              options: options);

          return handler.resolve(response);
        });
      } else {
        return super.onError(error, handler);
      }
    } else */
    return super.onError(error, handler);
  }

//other changed to unknown
  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.unknown &&
        err.error != null &&
        err.error is SocketException;
  }
}

class DioConnectivityRequestRetrier {
  final Dio dio;

  //final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    // required this.connectivity,
  });

/*  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {

    var streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        print(connectivityResult);
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          responseCompleter.complete(dio.request(
            requestOptions.baseUrl + requestOptions.path,
            cancelToken: requestOptions.cancelToken,
            data: requestOptions.data,
            onReceiveProgress: requestOptions.onReceiveProgress,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
            options: Options(
                method: requestOptions.method,
                sendTimeout: requestOptions.sendTimeout,
                receiveTimeout: requestOptions.receiveTimeout,
                extra: requestOptions.extra,
                headers: requestOptions.headers,
                responseType: requestOptions.responseType,
                contentType: requestOptions.contentType),
          ));
        }
      },
    );
    return responseCompleter.future;
  } */
}
