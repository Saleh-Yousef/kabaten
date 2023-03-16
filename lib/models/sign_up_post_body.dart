import '../utils/mixin.dart';

class SignUpPostBody implements Model {
  String? email;
  String? password;
  String? full_name;
  String? dob;
  String? gender;
  String? country;
  String? city;
  String? bio;
  String? role_in_team;
  String? nationality;
  SignUpPostBody(
    this.email,
    this.password,
    this.full_name,
    this.dob,
    this.gender,
    this.country,
    this.city,
    this.bio,
    this.role_in_team,
    this.nationality,
  );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = this.email;
    data['password'] = this.password;
    data['full_name'] = this.full_name;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['country'] = this.country;
    data['city'] = this.city;
    data['bio'] = this.bio;
    data['role_in_team'] = this.role_in_team;
    data['nationality'] = this.nationality;

    return data;
  }

  @override
  Map<String, dynamic> toDatabaseRow() {
    throw UnimplementedError();
  }
}
