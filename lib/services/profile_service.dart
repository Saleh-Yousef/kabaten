import 'dart:convert';

import '../constants/api_constants.dart';
import '../models/user_info_model.dart';
import '../models/users_model.dart';
import '../repository/http_repository.dart';
import '../utils/mixin.dart';

class ProfileService with Service {
  Future<UsersModel> getUserData({required int pageNumber}) async {
    var response = await repository!.callRequest(
      requestType: RequestType.get,
      methodName: ApiConstants.userslistAPI,
      getQueryParam: {"page": pageNumber, "page_size": 20},
    );
    return UsersModel.fromJson(response);
  }

  Future<UserInfoModel> getUsersInfo({required String userID}) async {
    var response = await repository!.callRequest(
      requestType: RequestType.get,
      methodName: '${ApiConstants.getOtherUsersProfileAPI}$userID',
    );
    return UserInfoModel.fromJson(response);
  }

  Future<UserInfoModel> getMyInfo() async {
    var response = await repository!.callRequest(
      requestType: RequestType.get,
      methodName: ApiConstants.getCurrentUserProfileAPI,
    );
    return UserInfoModel.fromJson(response);
  }

  Future<UserInfoModel> changeUserInformation({
    String? full_name,
    String? dob,
    String? gender,
    String? country,
    String? city,
    String? bio,
    String? role_in_team,
    String? nationality,
  }) async {
    Map<String, String> map = {};
    if (full_name != null && full_name.isNotEmpty) {
      map.putIfAbsent('full_name', () => full_name);
    }
    if (dob != null && dob.isNotEmpty) {
      map.putIfAbsent('dob', () => dob);
    }
    if (gender != null && gender.isNotEmpty) {
      map.putIfAbsent('gender', () => gender);
    }
    if (country != null && country.isNotEmpty) {
      map.putIfAbsent('country', () => country);
    }
    if (city != null && city.isNotEmpty) {
      map.putIfAbsent('city', () => city);
    }
    if (bio != null && bio.isNotEmpty) {
      map.putIfAbsent('bio', () => bio);
    }
    if (role_in_team != null && role_in_team.isNotEmpty) {
      map.putIfAbsent('role_in_team', () => role_in_team);
    }
    if (nationality != null && nationality.isNotEmpty) {
      map.putIfAbsent('nationality', () => nationality);
    }
    String body = json.encode(map);
    if (body.isEmpty) {
      return UserInfoModel();
    }
    print(body);
    var response = await repository!.callRequest(
      requestType: RequestType.patch,
      methodName: ApiConstants.editAccount,
      formData: body,
    );

    return UserInfoModel.fromJson(response);
  }
}
