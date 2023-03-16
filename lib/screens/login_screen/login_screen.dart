import 'package:flutter/material.dart';

import '../../constants/routs_constants.dart';
import '../../localization/app_localization.dart';
import '../../shared_widgets/textFields.dart';
import '../../utils/custom_state.dart';
import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends CustomState<LoginScreen, LoginBloc> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations translate = AppLocalizations.of(context)!;
    return StreamBuilder<String>(
        stream: bloc!.refreshPageStream.stream,
        initialData: null,
        builder: (context, loadingSnapshot) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: Text(
                translate.translate('LoginScreen_Welcom'),
                style: const TextStyle(fontSize: 30),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    translate.translate('LoginScreen_ToKeepConnecting'),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                Text(
                  translate.translate('LoginScreen_PleaseLoginWith'),
                  style: const TextStyle(fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: bloc!.signInEmailFieldController,
                        hintText: translate.translate('LoginScreen_UserName'),
                      ),
                      bloc!.errorEmailMessage == 'incorrect' ? const SizedBox(height: 0) : const SizedBox(height: 5),
                      bloc!.errorEmailMessage.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.only(left: 16, right: 16),
                              child: Text(
                                bloc!.errorEmailMessage == 'incorrect' ? '' : translate.translate(bloc!.errorEmailMessage),
                                style: const TextStyle(color: Color(0xffE74C4C)),
                              ),
                            )
                          : Container(),
                      bloc!.errorEmailMessage == 'incorrect' ? const SizedBox(height: 0) : const SizedBox(height: 11),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CustomTextField(
                          onChange: (test) {
                            setState(() {});
                          },
                          controller: bloc!.signInPasswordFieldController,
                          hintText: translate.translate('LoginScreen_Password'),
                          keyboardType: TextInputType.text,
                          obscureText: bloc!.obscurePasswordText,
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
                      bloc!.errorPasswordMessage == 'incorrect' ? const SizedBox(height: 0) : const SizedBox(height: 5),
                      bloc!.errorPasswordMessage.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.only(left: 16, right: 16),
                              child: Text(
                                bloc!.errorPasswordMessage == 'incorrect' ? '' : translate.translate(bloc!.errorPasswordMessage),
                                style: const TextStyle(color: Color(0xffE74C4C)),
                              ),
                            )
                          : Container(),
                      bloc!.errorPasswordMessage == 'incorrect' ? const SizedBox(height: 0) : const SizedBox(height: 11),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(
                        width: 2,
                      ),
                      fixedSize: const Size(200, 50)),
                  onPressed: () async {
                    if (await bloc!.onPressedLoginButton()) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(context, RoutesConstants.homeScreen, (Route<dynamic> route) => true);
                    }
                  },
                  child: Text(
                    translate.translate('LoginScreen_SIGNIN'),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesConstants.signUpScreen);
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: translate.translate('LoginScreen_DontHaveAccount'),
                          style: const TextStyle(fontSize: 15),
                        ),
                        TextSpan(
                          text: ' ${translate.translate('LoginScreen_SignUp')}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(
                              0xff0F13A4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  @override
  void onStart() {}

  @override
  void onStop() {}
}
