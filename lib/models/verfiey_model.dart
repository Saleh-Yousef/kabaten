import '../utils/mixin.dart';

class VerifyPostBody implements Model {
  String? activation_code;
  VerifyPostBody(this.activation_code);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activation_code'] = this.activation_code;

    return data;
  }

  @override
  Map<String, dynamic> toDatabaseRow() {
    throw UnimplementedError();
  }
}
