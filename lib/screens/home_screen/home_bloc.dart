import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kabaten/services/profile_service.dart';

import '../../locator.dart';
import '../../models/users_model.dart';
import '../../utils/bloc_life_cycle_interface.dart';
import '../../utils/mixin.dart';
import '../../utils/notifications_utility.dart';

class HomeBloc extends Bloc<ProfileService> implements BlocLifeCycleInterface {
  StreamController<List<User>> usersStream = StreamController<List<User>>();
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int pageNumber = 1;

  final TextEditingController searchFieldController = TextEditingController();
  List<User> users = [];
  List<User> searchResults = [];

  void updateSearchResults(String searchText) {
    searchResults = users.where((user) {
      return user.fullName != null && user.fullName!.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    usersStream.sink.add(searchResults);
  }

  getUsersList(int pageNumber) async {
    if (pageNumber > 1) {
      locator<NotificationsUtility>().loading(dismissAction: () {});
    }

    await service!.getUserData(pageNumber: pageNumber).then((value) => {if (value.data != null) users.addAll(value.data!)});
    pageNumber += 1;
    usersStream.sink.add(users);
    isLoading = false;
    if (pageNumber > 1) {
      locator<NotificationsUtility>().dismissToast();
    }
  }

  @override
  void clearLoadedData() {
    // TODO: implement clearLoadedData
  }

  @override
  void onAccountSwitch() {
    // TODO: implement onAccountSwitch
  }

  @override
  void pauseSubscription({List? arguments}) {
    // TODO: implement pauseSubscription
  }

  @override
  void resumeSubscription({List? arguments}) {
    // TODO: implement resumeSubscription
  }

  @override
  void startSubscription({List? arguments}) async {
    getUsersList(1);

    // TODO: implement startSubscription
  }

  @override
  void stopSubscription({List? arguments}) {
    // TODO: implement stopSubscription
  }
}
