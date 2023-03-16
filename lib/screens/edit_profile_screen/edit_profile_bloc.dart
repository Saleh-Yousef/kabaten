import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:kabaten/models/user_info_model.dart';

import '../../locator.dart';
import '../../services/profile_service.dart';
import '../../utils/bloc_life_cycle_interface.dart';
import '../../utils/custom_toast.dart';
import '../../utils/mixin.dart';
import '../../utils/notifications_utility.dart';

class EditProfileBloc extends Bloc<ProfileService> implements BlocLifeCycleInterface {
  StreamController<String> refreshPageStream = StreamController<String>.broadcast();

  TextEditingController fullNameFieldController = TextEditingController();
  TextEditingController dobFieldController = TextEditingController();
  TextEditingController genderFieldController = TextEditingController();
  TextEditingController countryFieldController = TextEditingController();
  TextEditingController cityFieldController = TextEditingController();
  TextEditingController bioFieldController = TextEditingController();
  TextEditingController reoleInTeamFieldController = TextEditingController();
  TextEditingController nationalityFieldController = TextEditingController();

  Future<bool> changeUserInfo() async {
    UserInfoModel? response;
    locator<NotificationsUtility>().loading(dismissAction: () {});

    await service!
        .changeUserInformation(
      full_name: fullNameFieldController.text,
      bio: bioFieldController.text,
      city: cityFieldController.text,
      country: countryFieldController.text,
      dob: dobFieldController.text,
      gender: genderFieldController.text,
      nationality: nationalityFieldController.text,
      role_in_team: reoleInTeamFieldController.text,
    )
        .then((value) {
      response = value;
      locator<NotificationsUtility>().dismissToast();
    }).onError((error, stackTrace) {
      locator<NotificationsUtility>().dismissToast();
      CustomToast().showToast('Something went wrong');
    });

    return response?.status == '200';
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
