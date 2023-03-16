import 'dart:async';

import '../../models/user_info_model.dart';
import '../../services/profile_service.dart';
import '../../utils/bloc_life_cycle_interface.dart';
import '../../utils/mixin.dart';

class ProfileBloc extends Bloc<ProfileService> implements BlocLifeCycleInterface {
  StreamController<UserInfoModel> userInfoStream = StreamController<UserInfoModel>.broadcast();
  String userID = '';

  @override
  void pauseSubscription({List? arguments}) {}

  @override
  void resumeSubscription({List? arguments}) {}

  @override
  void startSubscription({List? arguments}) async {
    await service!.getUsersInfo(userID: userID).then((value) => {if (value.data != null) userInfoStream.sink.add(value)});
  }

  @override
  void stopSubscription({List? arguments}) {}

  @override
  void clearLoadedData() {}

  @override
  void onAccountSwitch() {}
}
