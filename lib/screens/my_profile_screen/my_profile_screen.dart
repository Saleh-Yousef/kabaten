import 'package:flutter/material.dart';

import '../../localization/app_localization.dart';
import '../../models/user_info_model.dart';
import '../../shared_widgets/loadingView.dart';
import '../../utils/custom_state.dart';
import 'my_profile_bloc.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends CustomState<MyProfileScreen, MyProfileBloc> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations translate = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey, title: Text(translate.translate('MyProfileScreen_EditProfile'))),
      body: StreamBuilder<UserInfoModel>(
          stream: bloc!.userInfoStream.stream,
          builder: (context, userInfo) {
            return userInfo.hasData
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 16),
                                        padding: const EdgeInsets.all(5),
                                        decoration:
                                            BoxDecoration(borderRadius: BorderRadius.circular(50), color: const Color.fromARGB(255, 214, 231, 229)),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.person_2),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(translate.translate('name = ${userInfo.data?.data?.fullName}')),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(translate.translate('player = ${userInfo.data?.data?.player}')),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(translate.translate('team = ${userInfo.data?.data?.team}')),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(translate.translate('role In Team = ${userInfo.data?.data?.roleInTeam}')),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const LoadingView();
          }),
    );
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }

  @override
  void onStart() {
    bloc!.startSubscription();
    // TODO: implement onStart
  }

  @override
  void onStop() {
    // TODO: implement onStop
  }
}
