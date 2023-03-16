import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/mixin.dart';
import 'package:stack/stack.dart';

class HttpInterceptor extends InterceptorsWrapper {
  final Stack<RequestOptions> _stackOfRequests = Stack();
  final Stack<RequestInterceptorHandler> _stackOfHandlers = Stack();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String token = '';
    String vrfToken = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token') ?? "";
    vrfToken = prefs.getString('VRF_token') ?? "";

    options.headers.putIfAbsent("Content-Type", () => "application/json");
    options.headers.putIfAbsent("accept", () => "application/json");

    if (token.isNotEmpty && vrfToken.isEmpty) {
      options.headers.putIfAbsent("Authorization", () => "JWT $token");
    } else if (vrfToken.isNotEmpty) {
      options.headers.putIfAbsent("Authorization", () => "VRF $vrfToken");
    }

    _stackOfRequests.push(options);
    _stackOfHandlers.push(handler);

    handler.next(options);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      if (await validateResponse(response)) {
        return handler.next(response);
      }
    } catch (error) {
      handler.reject(error as DioError);
    }
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }

  Future<bool> validateResponse<T extends Model, TR>(Response response) async {
    switch (response.statusCode) {
      case 201:
      case 200:
        return true;
      case 401:
        throw DioError(error: HttpException(response.statusCode.toString()), requestOptions: response.requestOptions);
      case 403:
        throw DioError(error: HttpException(response.statusCode.toString()), requestOptions: response.requestOptions);
      case 400:
        throw DioError(error: HttpException(response.statusCode.toString()), requestOptions: response.requestOptions);

      default:
        throw DioError(error: HttpException(response.statusCode.toString()), requestOptions: response.requestOptions);
    }
  }
}
