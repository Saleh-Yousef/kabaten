import 'package:flutter/material.dart';

import '../../localization/app_localization.dart';
import '../../locator.dart';
import '../../shared_widgets/textFields.dart';
import '../../utils/custom_state.dart';
import 'edit_profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends CustomState<EditProfileScreen, EditProfileBloc> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations translate = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          translate.translate('EditProfileScreen_EditProfile'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 27),
                  CustomTextField(
                    controller: bloc!.fullNameFieldController,
                    hintText: translate.translate('SignUpScreen_FullName'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: bloc!.dobFieldController,
                    hintText: translate.translate('SignUpScreen_DOB'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: bloc!.genderFieldController,
                    hintText: translate.translate('SignUpScreen_gender'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: bloc!.countryFieldController,
                    hintText: translate.translate('SignUpScreen_Country'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: bloc!.cityFieldController,
                    hintText: translate.translate('SignUpScreen_city'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: bloc!.bioFieldController,
                    hintText: translate.translate('SignUpScreen_bio'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: bloc!.reoleInTeamFieldController,
                    hintText: translate.translate('SignUpScreen_role_in_team'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: bloc!.nationalityFieldController,
                    hintText: translate.translate('SignUpScreen_nationality'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: const BorderSide(
                            width: 2,
                          ),
                          fixedSize: const Size(200, 50)),
                      onPressed: () async {
                        if (await bloc!.changeUserInfo()) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessDialog();
                            },
                          );
                        }
                      },
                      child: Text(
                        translate.translate('EditProfileScreen_Submit'),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
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
    // TODO: implement onStart
  }

  @override
  void onStop() {
    // TODO: implement onStop
  }
}

class SuccessDialog extends StatefulWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  _OtpVerificationDialogState createState() => _OtpVerificationDialogState();
}

class _OtpVerificationDialogState extends State<SuccessDialog> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Success'),
      actions: [
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            locator<EditProfileBloc>().bioFieldController.clear();
            locator<EditProfileBloc>().cityFieldController.clear();
            locator<EditProfileBloc>().countryFieldController.clear();
            locator<EditProfileBloc>().fullNameFieldController.clear();
            locator<EditProfileBloc>().dobFieldController.clear();
            locator<EditProfileBloc>().genderFieldController.clear();
            locator<EditProfileBloc>().nationalityFieldController.clear();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
