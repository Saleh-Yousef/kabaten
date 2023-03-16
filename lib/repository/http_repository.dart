import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../constants/api_constants.dart';
import '../locator.dart';
import '../utils/mixin.dart';

enum RequestType { get, post, patch, filePost }

class HttpRepository {
  Future<dynamic> callRequest(
      {required RequestType requestType,
      required String methodName,
      Map<String, dynamic> getQueryParam = const {},
      Model? postBody,
      String contentType = Headers.jsonContentType,
      String? formData,
      var data}) async {
    late Response response;

    Dio? dioClient = locator<Dio>()
      ..options = BaseOptions(
        baseUrl: ApiConstants.baseURL,
        followRedirects: false,
        validateStatus: (status) {
          return true;
        },
      );

    (dioClient.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    switch (requestType) {
      case RequestType.get:
        response = await dioClient.get(
          methodName,
          queryParameters: getQueryParam,
          options: Options(contentType: contentType),
        );
        break;

      case RequestType.post:
        response = await dioClient.post(
          methodName,
          queryParameters: getQueryParam,
          data: postBody?.toJson(),
          options: Options(
            contentType: contentType,
          ),
        );
        break;
      case RequestType.filePost:
        response = await dioClient.post(
          'methodName',
          queryParameters: getQueryParam,
          data: data,
          options: Options(
            contentType: contentType,
          ),
        );
        break;
      case RequestType.patch:
        response = await dioClient.patch(
          methodName,
          queryParameters: getQueryParam,
          data: formData,
          options: Options(
            contentType: contentType,
          ),
        );
        break;
    }
    return response.data;
  }
}
