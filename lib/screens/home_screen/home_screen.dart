import 'package:flutter/material.dart';
import 'package:kabaten/shared_widgets/loadingView.dart';

import '../../constants/routs_constants.dart';
import '../../context.dart';
import '../../localization/app_localization.dart';
import '../../locator.dart';
import '../../models/users_model.dart';
import '../../utils/custom_state.dart';
import 'home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends CustomState<HomeScreen, HomeBloc> {
  @override
  void initState() {
    bloc!.scrollController.addListener(() {
      if (bloc!.scrollController.offset >= bloc!.scrollController.position.maxScrollExtent &&
          !bloc!.scrollController.position.outOfRange &&
          !bloc!.isLoading) {
        setState(() {
          bloc!.isLoading = true;
        });
        bloc!.getUsersList(2);
      }
    });
    super.initState();
  }

  bool statusOne = false;
  bool statusTwo = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations translate = AppLocalizations.of(context)!;

    return Scaffold(
      endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                    ),
                    child: Text(translate.translate('HomeScreen_Settings')),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                  ),
                  title: Text(translate.translate('HomeScreen_Profile')),
                  onTap: () {
                    Navigator.pushNamed(context, RoutesConstants.myProlifeScreen);
                  },
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.edit,
                  ),
                  title: Text(translate.translate('HomeScreen_EditProfile')),
                  onTap: () {
                    Navigator.pushNamed(context, RoutesConstants.editProfileScreen);
                  },
                ),
                const Divider(
                  color: Colors.grey,
                ),
              ],
            ),

            // ListTile(
            //   leading: const Icon(
            //     Icons.language,
            //   ),
            //   title: Text(translate.translate('HomeScreen_ChangeLanguage')),
            //   onTap: () {
            //     if (locator<AppLanguage>().appLocal.languageCode == 'ar') {
            //       locator<AppLanguage>().changeLanguage(const Locale("en"));
            //     } else {
            //       locator<AppLanguage>().changeLanguage(const Locale("ar"));
            //     }
            //     Navigator.pop(context);
            //   },
            // ),
            // const Divider(
            //   color: Colors.grey,
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: Text(translate.translate('HomeScreen_Logout')),
                onTap: () async {
                  BuildContext? cachedContext = locator<MainContext>().mainContext;
                  onLogout(context).then((value) async {
                    if (value) {
                      locator<MainContext>().setMainContext(cachedContext);
                      await Navigator.of(context).pushNamedAndRemoveUntil(RoutesConstants.initialRoute, (Route<dynamic> route) => false);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(automaticallyImplyLeading: false, backgroundColor: Colors.blueGrey, title: Text(translate.translate('Users List'))),
      body: StreamBuilder<List<User>>(
          stream: bloc!.usersStream.stream,
          builder: (context, users) {
            return users.hasData
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        controller: bloc!.scrollController,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child:
                                      // i can use the custom text field here as well with more custmization but for the time saving i created a new one
                                      SizedBox(
                                    height: 60,
                                    child: TextField(
                                      onChanged: (value) => bloc!.updateSearchResults(value),
                                      autofocus: false,
                                      keyboardAppearance: Brightness.light,
                                      style: const TextStyle(color: Color(0xff191C1F), fontSize: 14),
                                      controller: bloc!.searchFieldController,
                                      autocorrect: false,
                                      cursorColor: const Color(0xff191C1F),
                                      decoration: InputDecoration(
                                          hintText: 'Search for users',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.transparent)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(color: Colors.transparent),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(color: Colors.transparent),
                                          ),
                                          prefixIcon: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.search),
                                          ),
                                          filled: true,
                                          fillColor: const Color.fromARGB(255, 237, 237, 247)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: users.data!.length,
                              controller: ScrollController(),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesConstants.prolifeScreen,
                                      arguments: {"userID": users.data![index].id},
                                    );
                                  },
                                  child: Card(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(translate.translate('name = ${users.data![index].fullName}')),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(translate.translate('player = ${users.data![index].player}')),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(translate.translate('email = ${users.data![index].email}')),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(translate.translate('roleInTeam = ${users.data![index].roleInTeam}')),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const LoadingView();
          }),
    );
  }

  @override
  void onPause() {
    bloc!.pauseSubscription();
  }

  @override
  void onResume() {
    bloc!.resumeSubscription();
  }

  @override
  void onStart() {
    bloc!.startSubscription();
  }

  @override
  void onStop() {
    bloc!.stopSubscription();
  }
}
