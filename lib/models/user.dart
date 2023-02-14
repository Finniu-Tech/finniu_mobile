// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

ScanUserModel scanModelFromJson(String str) =>
    ScanUserModel.fromJson(json.decode(str));

String scanModelToJson(ScanUserModel data) => json.encode(data.toJson());

class ScanUserModel {
  ScanUserModel({
    this.registerUser,
  });

  RegisterUser? registerUser;

  factory ScanUserModel.fromJson(Map<String, dynamic> json) => ScanUserModel(
        registerUser: json["registerUser"] == null
            ? null
            : RegisterUser.fromJson(json["registerUser"]),
      );

  Map<String, dynamic> toJson() => {
        "registerUser": registerUser?.toJson(),
      };
}

class RegisterUser {
  RegisterUser({
    this.success,
    this.user,
  });

  bool? success;
  User? user;

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        success: json["success"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.id,
    this.email,
    this.userProfile,
  });

  String? id;
  String? email;
  UserProfile? userProfile;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        userProfile: json["userProfile"] == null
            ? null
            : UserProfile.fromJson(json["userProfile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "userProfile": userProfile?.toJson(),
      };
}

class UserProfile {
  UserProfile({
    this.nickName,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  String? nickName;
  dynamic firstName;
  dynamic lastName;
  String? phoneNumber;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        nickName: json["nickName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "nickName": nickName,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
      };
}
