import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'localization/app_language.dart';
import 'locator.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  AppLanguage appLanguage = locator<AppLanguage>();
  await appLanguage.fetchLocale();

  runApp(App(navigatorKey, appLanguage));
  (error, stackTrace) async {
    if (error is DioError) {
      final exception = error.error;
      if (exception is HttpException) {
        final statusCode = exception.message;
        print('------------------- main exception');
        if (statusCode == '400' || statusCode == '500' || statusCode == '502') {
          print('-------------- status code = $statusCode');
        } else if (statusCode == '503') {
          print('-------------- status code = $statusCode');
        } else if (statusCode == '401' || statusCode == '403') {
          print('-------------- status code = $statusCode');
        }
      }
    } else {
      print(stackTrace.toString());
      print(error.toString());
    }
  };
}
