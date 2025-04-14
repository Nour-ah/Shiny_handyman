import 'package:handyman_provider_flutter/models/user_data.dart';

class LoginResponse {
  UserData? userData;
  bool? isUserExist;
  String? apiToken;
  String? message;

  LoginResponse({this.userData, this.isUserExist, this.apiToken, this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userData: json['data']['user'] != null
          ? UserData.fromJson(json['data']['user'])
          : null,
      apiToken: json['data']['api_token'],
      isUserExist: json['data'] != null ? true : false,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['data']['user'] = this.userData!.toJson();
    }
    return data;
  }
}

class VerificationModel {
  bool? status;
  String? message;
  int? isEmailVerified;

  VerificationModel({this.status, this.message, this.isEmailVerified});

  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      status: json['status'],
      message: json['message'],
      isEmailVerified: json['is_email_verified'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['status'] = this.status;
    data['message'] = this.message;
    data['is_email_verified'] = this.isEmailVerified;
    return data;
  }
}
