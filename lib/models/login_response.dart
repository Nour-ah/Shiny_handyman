// models/login_response.dart
import 'package:handyman_provider_flutter/models/user_data.dart';

class LoginResponse {
  UserData? userData;
  bool? isUserExist;
  String? apiToken;
  String? message;

  LoginResponse({this.userData, this.isUserExist, this.apiToken, this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    // إنشاء نسخة قابلة للتعديل من بيانات المستخدم
    Map<String, dynamic> userJson =
        Map<String, dynamic>.from(json['data']['user'] ?? {});

    // لو provider_id = null في user، حط القيمة من data
    if (userJson['provider_id'] == null &&
        json['data']['provider_id'] != null) {
      userJson['provider_id'] = json['data']['provider_id'];
    }

    return LoginResponse(
      userData: userJson.isNotEmpty ? UserData.fromJson(userJson) : null,
      apiToken: json['data']['api_token'],
      isUserExist: json['data'] != null,
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
// class LoginResponse {
//   UserData? userData;
//   List<String>? userRole;
//   String? apiToken;
//   String? profileImage;
//   int? isVerifyProvider;
//   dynamic subscription; // حسب نوع الاشتراك لو عندك موديل خاص اشتغل عليه
//   int? isSubscribe;
//   int? providerId;
//   String? message;

//   LoginResponse({
//     this.userData,
//     this.userRole,
//     this.apiToken,
//     this.profileImage,
//     this.isVerifyProvider,
//     this.subscription,
//     this.isSubscribe,
//     this.providerId,
//     this.message,
//   });

//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       userData: json['data']['user'] != null
//           ? UserData.fromJson(json['data']['user'])
//           : null,
//       userRole: json['data']['user_role'] != null
//           ? List<String>.from(json['data']['user_role'])
//           : null,
//       apiToken: json['data']['api_token'],
//       profileImage: json['data']['profile_image'],
//       isVerifyProvider: json['data']['is_verify_provider'],
//       subscription: json['data']['subscription'], // لو عندك موديل خاص تقدر تعدل
//       isSubscribe: json['data']['is_subscribe'],
//       providerId: json['data']['provider_id'],
//       message: json['message'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (userData != null) {
//       data['user'] = userData!.toJson();
//     }
//     if (userRole != null) {
//       data['user_role'] = userRole;
//     }
//     data['api_token'] = apiToken;
//     data['profile_image'] = profileImage;
//     data['is_verify_provider'] = isVerifyProvider;
//     data['subscription'] = subscription;
//     data['is_subscribe'] = isSubscribe;
//     data['provider_id'] = providerId;
//     return {'data': data};
//   }
// }

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
