class UsersModel {
  String? status;
  String? messageKey;
  String? message;
  List<User>? data;
  Meta? meta;
  int? count;
  int? next;
  int? previous;

  UsersModel({status, messageKey, message, data, meta, count, next, previous});

  UsersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageKey = json['message_key'];
    message = json['message'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data!.add(User.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message_key'] = messageKey;
    data['message'] = message;
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    return data;
  }
}

class User {
  String? id;
  String? fullName;
  String? name;
  String? player;
  String? staff;
  String? profilePicture;
  String? roleInTeam;
  String? email;
  String? userType;
  Team? team;
  TeamJoined? teamJoined;

  User({id, fullName, name, player, staff, profilePicture, roleInTeam, email, userType, team, teamJoined});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 'N/A';
    fullName = json['full_name'] ?? 'N/A';
    name = json['name'] ?? 'N/A';
    player = json['player'] ?? 'N/A';
    staff = json['staff'] ?? 'N/A';
    profilePicture = json['profile_picture'] ?? 'N/A';
    roleInTeam = json['role_in_team'] ?? 'N/A';
    email = json['email'] ?? 'N/A';
    userType = json['user_type'] ?? 'N/A';
    team = json['team'] != null ? Team.fromJson(json['team']) : Team();
    teamJoined = json['team_joined'] != null ? TeamJoined.fromJson(json['team_joined']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['name'] = name;
    data['player'] = player;
    data['staff'] = staff;
    data['profile_picture'] = profilePicture;
    data['role_in_team'] = roleInTeam;
    data['email'] = email;
    data['user_type'] = userType;
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (teamJoined != null) {
      data['team_joined'] = teamJoined!.toJson();
    }
    return data;
  }
}

class Team {
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

  Team({email, kabId, name, id, estDate, coachName, staffPhoneNumber, country, city, bio, profilePicture, coverPhoto});

  Team.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? "N/A";
    kabId = json['kab_id'] ?? "N/A";
    name = json['name'] ?? "N/A";
    id = json['id'] ?? "N/A";
    estDate = json['est_date'] ?? "N/A";
    coachName = json['coach_name'] ?? "N/A";
    staffPhoneNumber = json['staff_phone_number'] ?? "N/A";
    country = json['country'] ?? "N/A";
    city = json['city'] ?? "N/A";
    bio = json['bio'] ?? "N/A";
    profilePicture = json['profile_picture'] ?? "N/A";
    coverPhoto = json['cover_photo'] ?? "N/A";
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
    email = json['email'] ?? "N/A";
    kabId = json['kab_id'] ?? "N/A";
    name = json['name'] ?? "N/A";
    id = json['id'] ?? "N/A";
    estDate = json['est_date'] ?? "N/A";
    coachName = json['coach_name'] ?? "N/A";
    staffPhoneNumber = json['staff_phone_number'] ?? "N/A";
    country = json['country'] ?? "N/A";
    city = json['city'] ?? "N/A";
    bio = json['bio'] ?? "N/A";
    profilePicture = json['profile_picture'] ?? "N/A";
    coverPhoto = json['cover_photo'] ?? "N/A";
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

class Meta {
  int? page;
  int? pageSize;
  int? totalRecords;
  int? totalPages;
  int? next;
  int? previous;

  Meta({page, pageSize, totalRecords, totalPages, next, previous});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'] ?? "N/A";
    pageSize = json['page_size'] ?? "N/A";
    totalRecords = json['total_records'] ?? "N/A";
    totalPages = json['total_pages'] ?? "N/A";
    next = json['next'] ?? "N/A";
    previous = json['previous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['page_size'] = pageSize;
    data['total_records'] = totalRecords;
    data['total_pages'] = totalPages;
    data['next'] = next;
    data['previous'] = previous;
    return data;
  }
}
