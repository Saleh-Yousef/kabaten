import 'package:kabaten/models/sign_up_model.dart';

import '../constants/api_constants.dart';
import '../models/login_model.dart';
import '../models/login_post_body.dart';
import '../models/sign_up_post_body.dart';
import '../models/verfiey_model.dart';
import '../repository/http_repository.dart';
import '../utils/mixin.dart';

class AuthenticationService with Service {
  Future<LoginModel> loginCallAPI({required String email, required String password}) async {
    LoginPostBody body = LoginPostBody(email, password);

    var response = await repository!.callRequest(
      requestType: RequestType.post,
      methodName: ApiConstants.loginAPI,
      postBody: body,
    );

    return LoginModel.fromJson(response);
  }

  Future<SignUpModel> SignUpCallAPI({
    required String email,
    required String password,
    required String name,
    required String dob,
    required String gender,
    required String country,
    required String city,
    required String bio,
    required String role,
    required String nationality,
  }) async {
    SignUpPostBody body = SignUpPostBody(email, password, name, dob, gender, country, city, bio, role, nationality);

    var response = await repository!.callRequest(
      requestType: RequestType.post,
      methodName: ApiConstants.sigupAPI,
      postBody: body,
    );

    return SignUpModel.fromJson(response);
  }

  Future<SignUpModel> verifylAPI({required String otp}) async {
    VerifyPostBody body = VerifyPostBody(otp);

    var response = await repository!.callRequest(
      requestType: RequestType.post,
      methodName: ApiConstants.verifyAPI,
      postBody: body,
    );

    return SignUpModel.fromJson(response);
  }
}
