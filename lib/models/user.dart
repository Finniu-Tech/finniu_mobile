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
    this.firstName,
    this.lastName,
    this.picture,
    this.phoneNumber,
    this.gender,
    this.displayName,
  });

  String? id;
  String? email;
  dynamic firstName;
  dynamic lastName;
  dynamic picture;
  dynamic phoneNumber;
  dynamic gender;
  dynamic displayName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        picture: json["picture"],
        phoneNumber: json["phoneNumber"],
        gender: json["gender"],
        displayName: json["displayName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "picture": picture,
        "phoneNumber": phoneNumber,
        "gender": gender,
        "displayName": displayName,
      };
}
