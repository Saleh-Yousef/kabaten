import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';
import '../../models/login_model.dart';
import '../../services/authentication_service.dart';
import '../../utils/bloc_life_cycle_interface.dart';
import '../../utils/custom_toast.dart';
import '../../utils/mixin.dart';
import '../../utils/notifications_utility.dart';

class LoginBloc extends Bloc<AuthenticationService> implements BlocLifeCycleInterface {
  StreamController<String> refreshPageStream = StreamController<String>();

  final TextEditingController signInEmailFieldController = TextEditingController();
  final TextEditingController signInPasswordFieldController = TextEditingController();
  String errorEmailMessage = '';
  String errorPasswordMessage = '';
  bool obscurePasswordText = true;

  Future<bool> onPressedLoginButton() async {
    LoginModel loginModel = LoginModel();
    if (signInEmailFieldController.text.isEmpty) {
      CustomToast().showToast('Please Enter Email');
    } else if (signInPasswordFieldController.text.isEmpty) {
      CustomToast().showToast('Please Enter Password');
    } else {
      locator<NotificationsUtility>().loading(dismissAction: () {});
      await service!.loginCallAPI(email: signInEmailFieldController.text, password: signInPasswordFieldController.text).then((value) async {
        loginModel = value;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('refresh_token', loginModel.data?.refreshToken ?? "");
        prefs.setString('token', loginModel.data?.accessToken ?? "");

        locator<NotificationsUtility>().dismissToast();
      }).onError((error, stackTrace) {
        locator<NotificationsUtility>().dismissToast();
        CustomToast().showToast('Please enter correct email and password');
      });
    }

    return loginModel.status == '200';
  }

  void showHidePassword() {
    obscurePasswordText = !obscurePasswordText;
    refreshPageStream.sink.add('Refresh');
  }

  @override
  void pauseSubscription({List? arguments}) {}

  @override
  void resumeSubscription({List? arguments}) {}

  @override
  void startSubscription({List? arguments}) {}

  @override
  void stopSubscription({List? arguments}) {}

  @override
  void clearLoadedData() {}

  @override
  void onAccountSwitch() {}
}
