import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';
import '../../models/sign_up_model.dart';
import '../../services/authentication_service.dart';
import '../../utils/bloc_life_cycle_interface.dart';
import '../../utils/custom_toast.dart';
import '../../utils/mixin.dart';
import '../../utils/notifications_utility.dart';

class SignUpBloc extends Bloc<AuthenticationService> implements BlocLifeCycleInterface {
  StreamController<String> refreshPageStream = StreamController<String>.broadcast();

  TextEditingController signUpEmailFieldController = TextEditingController();
  TextEditingController signUpPasswordFieldController = TextEditingController();
  TextEditingController fullNameFieldController = TextEditingController();
  TextEditingController dobFieldController = TextEditingController();
  TextEditingController genderFieldController = TextEditingController();
  TextEditingController countryFieldController = TextEditingController();
  TextEditingController cityFieldController = TextEditingController();
  TextEditingController bioFieldController = TextEditingController();
  TextEditingController reoleInTeamFieldController = TextEditingController();
  TextEditingController nationalityFieldController = TextEditingController();

  bool obscurePasswordText = true;

  Future onPressedSubmitButton() async {
    SignUpModel loginModel = SignUpModel();
    if (signUpEmailFieldController.text.isEmpty) {
      CustomToast().showToast('Please Enter Email');
    } else if (signUpPasswordFieldController.text.isEmpty) {
      CustomToast().showToast('Please Enter Password');
    } else if (fullNameFieldController.text.isEmpty) {
      CustomToast().showToast('Please Your Name');
    } else if (dobFieldController.text.isEmpty) {
      CustomToast().showToast('Please Enter Date of Bearth');
    } else if (genderFieldController.text.isEmpty) {
      CustomToast().showToast('Please Enter Your Gender');
    } else if (countryFieldController.text.isEmpty) {
      CustomToast().showToast('Please Enter Contry');
    } else if (cityFieldController.text.isEmpty) {
      CustomToast().showToast('Please Enter City');
    } else if (bioFieldController.text.isEmpty) {
      CustomToast().showToast('Please Enter BIO');
    } else if (reoleInTeamFieldController.text.isEmpty) {
      CustomToast().showToast('Please Enter Role in Team');
    } else if (nationalityFieldController.text.isEmpty) {
      CustomToast().showToast('Please Enter Nationality');
    } else {
      locator<NotificationsUtility>().loading(dismissAction: () {});
      await service!
          .SignUpCallAPI(
        email: signUpEmailFieldController.text,
        password: signUpPasswordFieldController.text,
        bio: bioFieldController.text,
        city: cityFieldController.text,
        country: countryFieldController.text,
        dob: dobFieldController.text,
        gender: genderFieldController.text,
        name: fullNameFieldController.text,
        nationality: nationalityFieldController.text,
        role: reoleInTeamFieldController.text,
      )
          .then((value) async {
        loginModel = value;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('refresh_token', loginModel.data?.refreshToken ?? "");
        prefs.setString('VRF_token', loginModel.data?.accessToken ?? "");

        locator<NotificationsUtility>().dismissToast();
      }).onError((error, stackTrace) {
        locator<NotificationsUtility>().dismissToast();
        CustomToast().showToast('Something Went Wrong');
      });
    }

    return loginModel.status == '201';
  }

  Future<bool> onVerifyPressed(String otp) async {
    SignUpModel loginModel = SignUpModel();
    if (otp.isEmpty) {
      CustomToast().showToast('Please Enter OTP');
    } else {
      locator<NotificationsUtility>().loading(dismissAction: () {});
      await service!.verifylAPI(otp: otp).then((value) async {
        loginModel = value;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('refresh_token', loginModel.data?.refreshToken ?? "");
        prefs.setString('token', loginModel.data?.accessToken ?? "");
        prefs.remove('VRF_token');

        locator<NotificationsUtility>().dismissToast();
      }).onError((error, stackTrace) {
        locator<NotificationsUtility>().dismissToast();
        CustomToast().showToast('Something Went Wrong');
      });
    }

    return loginModel.status == '201';
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
  void stopSubscription({List? arguments}) {
    signUpEmailFieldController.clear();
    signUpPasswordFieldController.clear();
  }

  @override
  void clearLoadedData() {}

  @override
  void onAccountSwitch() {}
}
