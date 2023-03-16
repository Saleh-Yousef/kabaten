import 'package:flutter/material.dart';
import 'package:kabaten/locator.dart';
import 'package:kabaten/screens/sign_up_screen/sign_up_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/routs_constants.dart';
import '../../localization/app_localization.dart';
import '../../shared_widgets/textFields.dart';
import '../../utils/custom_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends CustomState<SignUpScreen, SignUpBloc> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations translate = AppLocalizations.of(context)!;
    return StreamBuilder<String>(
        stream: bloc?.refreshPageStream.stream,
        initialData: null,
        builder: (context, loadingSnapshot) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            translate.translate('SignUpScreen_CreateAnAccount'),
                            style: const TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                        const SizedBox(height: 27),
                        CustomTextField(
                          controller: bloc!.fullNameFieldController,
                          hintText: translate.translate('SignUpScreen_FullName'),
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: bloc!.signUpEmailFieldController,
                          hintText: translate.translate('SignUpScreen_Email'),
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
                        const SizedBox(height: 12),
                        CustomTextField(
                            onChange: (test) {
                              setState(() {});
                            },
                            obscureText: bloc!.obscurePasswordText,
                            controller: bloc!.signUpPasswordFieldController,
                            hintText: translate.translate('SignUpScreen_Password'),
                            suffixIcon: SizedBox(
                              width: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: Colors.black.withOpacity(0.2),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: InkWell(
                                    onTap: () {
                                      bloc!.showHidePassword();
                                    },
                                    child: Icon(bloc!.obscurePasswordText ? Icons.visibility_off : Icons.visibility, color: Color(0xFF344054))),
                              ),
                            )),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            translate.translate('SignUpScreen_Must_be_at_least_8_characters'),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
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
                              if (await bloc!.onPressedSubmitButton()) {
                                // ignore: use_build_context_synchronously
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return OtpVerificationDialog();
                                  },
                                );
                              }
                            },
                            child: Text(
                              translate.translate('SignUpScreen_SignUp'),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "${translate.translate('SignUpScreen_Alreadyhave')} ",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: translate.translate('SignUpScreen_Login'),
                                  style: const TextStyle(
                                    color: Color(
                                      0xff0F13A4,
                                    ),
                                  ),
                                ),
                              ],
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
        });
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
  Future<void> onStart() async {
    // TODO: implement onStart
  }

  @override
  void onStop() {
    bloc!.stopSubscription();
    // TODO: implement onStop
  }
}

class OtpVerificationDialog extends StatefulWidget {
  const OtpVerificationDialog({Key? key}) : super(key: key);

  @override
  _OtpVerificationDialogState createState() => _OtpVerificationDialogState();
}

class _OtpVerificationDialogState extends State<OtpVerificationDialog> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('OTP Verification'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter OTP',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (await locator<SignUpBloc>().onVerifyPressed(_otpController.text)) {
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(context, RoutesConstants.homeScreen, (Route<dynamic> route) => true);
            }
          },
          child: const Text('Verify'),
        ),
      ],
    );
  }
}
