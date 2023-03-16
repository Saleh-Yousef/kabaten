import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:get_it/get_it.dart';
import 'package:kabaten/repository/http_interceptor.dart';
import 'package:kabaten/repository/http_repository.dart';
import 'package:kabaten/screens/edit_profile_screen/edit_profile_bloc.dart';
import 'package:kabaten/screens/home_screen/home_bloc.dart';
import 'package:kabaten/screens/login_screen/login_bloc.dart';
import 'package:kabaten/screens/my_profile_screen/my_profile_bloc.dart';
import 'package:kabaten/screens/profile_screen/profile_bloc.dart';
import 'package:kabaten/screens/sign_up_screen/sign_up_bloc.dart';
import 'package:kabaten/services/profile_service.dart';
import 'package:kabaten/utils/custom_notification_toast.dart';
import 'package:kabaten/utils/notifications_utility.dart';

import 'constants/api_constants.dart';
import 'context.dart';
import 'localization/app_language.dart';
import 'services/authentication_service.dart';
import 'utils/global_observalable.dart';

GetIt locator = GetIt.instance;
final HttpInterceptor? interceptor = locator<HttpInterceptor>();

Future setupLocator() async {
  locator.pushNewScope();
  locator.registerSingleton<HttpRepository>(HttpRepository());
  locator.registerSingleton<HttpInterceptor>(HttpInterceptor());
  if (locator.isRegistered<Dio>()) {
    locator.unregister<Dio>(instance: locator<Dio>());
  }
  locator.registerSingleton<Dio>(Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseURL,
      receiveDataWhenStatusError: true,
      followRedirects: false,
      validateStatus: (status) {
        return true;
      },
    ),
  )..interceptors.add(interceptor!));
  locator.registerSingleton<NotificationsUtility>(NotificationsUtility());
  locator.registerSingleton<CustomNotificationToast>(CustomNotificationToast());
  locator.registerSingleton<GlobalObservable>(GlobalObservable());

  locator.registerSingleton<AuthenticationService>(AuthenticationService());
  locator.registerSingleton<ProfileService>(ProfileService());
  locator.registerSingleton<LoginBloc>(LoginBloc());
  locator.registerSingleton<SignUpBloc>(SignUpBloc());
  locator.registerSingleton<HomeBloc>(HomeBloc());
  locator.registerSingleton<MainContext>(MainContext());
  locator.registerSingleton<AppLanguage>(AppLanguage());
  locator.registerSingleton<ProfileBloc>(ProfileBloc());
  locator.registerSingleton<MyProfileBloc>(MyProfileBloc());
  locator.registerSingleton<EditProfileBloc>(EditProfileBloc());
  locator.registerSingleton<RouteObserver<PageRoute>>(RouteObserver());
}
