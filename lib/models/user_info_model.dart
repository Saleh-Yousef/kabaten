class UserInfoModel {
  String? status;
  String? messageKey;
  String? message;
  Data? data;

  UserInfoModel({status, messageKey, message, data});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageKey = json['message_key'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message_key'] = messageKey;
    data['message'] = message;
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  String? email;
  String? fullName;
  String? dob;
  String? gender;
  String? phoneNumber;
  String? country;
  String? city;
  String? bio;
  String? profilePicture;
  String? coverPhoto;
  String? nationality;
  String? roleInTeam;
  String? player;
  String? staff;
  String? followStatus;
  String? id;
  String? verifyToken;
  bool? isPrivate;
  String? userType;
  String? team;
  String? teamMemberStatus;
  TeamJoined? teamJoined;
  String? nationalityIso2;
  String? countryIso2;

  Data(
      {email,
      fullName,
      dob,
      gender,
      phoneNumber,
      country,
      city,
      bio,
      profilePicture,
      coverPhoto,
      nationality,
      roleInTeam,
      player,
      staff,
      followStatus,
      id,
      verifyToken,
      isPrivate,
      userType,
      team,
      teamMemberStatus,
      teamJoined,
      nationalityIso2,
      countryIso2});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? 'N/A';
    fullName = json['full_name'] ?? 'N/A';
    dob = json['dob'] ?? 'N/A';
    gender = json['gender'] ?? 'N/A';
    phoneNumber = json['phone_number'] ?? 'N/A';
    country = json['country'] ?? 'N/A';
    city = json['city'] ?? 'N/A';
    bio = json['bio'] ?? 'N/A';
    profilePicture = json['profile_picture'] ?? 'N/A';
    coverPhoto = json['cover_photo'] ?? 'N/A';
    nationality = json['nationality'] ?? 'N/A';
    roleInTeam = json['role_in_team'] ?? 'N/A';
    player = json['player'] ?? 'N/A';
    staff = json['staff'] ?? 'N/A';
    followStatus = json['follow_status'] ?? 'N/A';
    id = json['id'] ?? 'N/A';
    verifyToken = json['verify_token'] ?? 'N/A';
    isPrivate = json['is_private'];
    userType = json['user_type'] ?? 'N/A';
    team = json['team'] ?? 'N/A';
    teamMemberStatus = json['team_member_status'] ?? 'N/A';
    teamJoined = json['team_joined'] != null ? TeamJoined.fromJson(json['team_joined']) : null;
    nationalityIso2 = json['nationality_iso2'] ?? 'N/A';
    countryIso2 = json['country_iso2'] ?? 'N/A';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['full_name'] = fullName;
    data['dob'] = dob;
    data['gender'] = gender;
    data['phone_number'] = phoneNumber;
    data['country'] = country;
    data['city'] = city;
    data['bio'] = bio;
    data['profile_picture'] = profilePicture;
    data['cover_photo'] = coverPhoto;
    data['nationality'] = nationality;
    data['role_in_team'] = roleInTeam;
    data['player'] = player;
    data['staff'] = staff;
    data['follow_status'] = followStatus;
    data['id'] = id;
    data['verify_token'] = verifyToken;
    data['is_private'] = isPrivate;
    data['user_type'] = userType;
    data['team'] = team;
    data['team_member_status'] = teamMemberStatus;
    if (teamJoined != null) {
      data['team_joined'] = teamJoined!.toJson();
    }
    data['nationality_iso2'] = nationalityIso2;
    data['country_iso2'] = countryIso2;
    return data;
  }
}

class TeamJoined {
  String? email;
  String? kabId;
  String? name;
  String? id;
  String? estDate;
  String? coachName;
  String? staffPhoneNumber;
  String? country;
  String? city;
  String? bio;
  String? profilePicture;
  String? coverPhoto;

  TeamJoined({email, kabId, name, id, estDate, coachName, staffPhoneNumber, country, city, bio, profilePicture, coverPhoto});

  TeamJoined.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? 'N/A';
    kabId = json['kab_id'] ?? 'N/A';
    name = json['name'] ?? 'N/A';
    id = json['id'] ?? 'N/A';
    estDate = json['est_date'] ?? 'N/A';
    coachName = json['coach_name'] ?? 'N/A';
    staffPhoneNumber = json['staff_phone_number'] ?? 'N/A';
    country = json['country'] ?? 'N/A';
    city = json['city'] ?? 'N/A';
    bio = json['bio'] ?? 'N/A';
    profilePicture = json['profile_picture'] ?? 'N/A';
    coverPhoto = json['cover_photo'] ?? 'N/A';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['kab_id'] = kabId;
    data['name'] = name;
    data['id'] = id;
    data['est_date'] = estDate;
    data['coach_name'] = coachName;
    data['staff_phone_number'] = staffPhoneNumber;
    data['country'] = country;
    data['city'] = city;
    data['bio'] = bio;
    data['profile_picture'] = profilePicture;
    data['cover_photo'] = coverPhoto;
    return data;
  }
}
