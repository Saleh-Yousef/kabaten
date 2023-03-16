class SignUpModel {
  String? status;
  String? messageKey;
  String? message;
  Data? data;

  SignUpModel({this.status, this.messageKey, this.message, this.data});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageKey = json['message_key'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message_key'] = this.messageKey;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? accessToken;
  String? refreshToken;
  String? tokenType;

  Data({this.accessToken, this.refreshToken, this.tokenType});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}
