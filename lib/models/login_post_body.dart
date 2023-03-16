import '../utils/mixin.dart';

class LoginPostBody implements Model {
  String? email;
  String? password;
  LoginPostBody(this.email, this.password);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = this.email;
    data['password'] = this.password;

    return data;
  }

  @override
  Map<String, dynamic> toDatabaseRow() {
    throw UnimplementedError();
  }
}
