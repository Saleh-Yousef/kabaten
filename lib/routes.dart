import 'package:flutter/material.dart';
import 'package:kabaten/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:kabaten/screens/home_screen/home_screen.dart';
import 'package:kabaten/screens/login_screen/login_screen.dart';
import 'package:kabaten/screens/my_profile_screen/my_profile_screen.dart';
import 'package:kabaten/screens/profile_screen/profile_screen.dart';
import 'package:kabaten/screens/sign_up_screen/sign_up_screen.dart';

import 'constants/routs_constants.dart';

final Map<String, Widget> routes = {
  RoutesConstants.initialRoute: const LoginScreen(),
  RoutesConstants.homeScreen: const HomeScreen(),
  RoutesConstants.signUpScreen: const SignUpScreen(),
  RoutesConstants.prolifeScreen: const ProfileScreen(),
  RoutesConstants.myProlifeScreen: const MyProfileScreen(),
  RoutesConstants.editProfileScreen: const EditProfileScreen(),
};
