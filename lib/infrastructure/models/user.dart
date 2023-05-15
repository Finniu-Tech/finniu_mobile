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
    this.firstName,
    this.lastName,
    this.email,
    this.id,
    this.nickName,
    this.imageProfileUrl,
    this.imageProfile,
    this.civilStatus,
    this.distrito,
    this.documentNumber,
    this.gender,
    this.hasCompletedOnboarding,
    this.isActive,
    this.occupation,
    this.provincia,
    this.region,
    this.typeDocument,
    this.phoneNumber,
    this.uuid,
    this.password,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? id;
  String? nickName;
  dynamic civilStatus;
  dynamic distrito;
  String? documentNumber;
  dynamic gender;
  bool? hasCompletedOnboarding;
  bool? isActive;
  String? occupation;
  dynamic provincia;
  dynamic region;
  String? typeDocument;
  String? uuid;
  String? phoneNumber;
  String? password;
  String? imageProfileUrl;
  String? imageProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        id: json["id"],
        nickName: json["nickName"],
        civilStatus: json["civilStatus"],
        distrito: json["distrito"],
        documentNumber: json["documentNumber"].toString(),
        gender: json["gender"],
        hasCompletedOnboarding: json["hasCompletedOnboarding"],
        isActive: json["isActive"],
        occupation: json["occupation"],
        provincia: json["provincia"],
        region: json["region"],
        typeDocument: json["typeDocument"],
        uuid: json["uuid"],
        phoneNumber: json["phoneNumber"],
        imageProfile: json["imageProfile"],
        imageProfileUrl: json["imageProfileUrl"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "id": id,
        "nickName": nickName,
        "civilStatus": civilStatus,
        "distrito": distrito,
        "documentNumber": documentNumber,
        "gender": gender,
        "hasCompletedOnboarding": hasCompletedOnboarding,
        "isActive": isActive,
        "occupation": occupation,
        "provincia": provincia,
        "region": region,
        "typeDocument": typeDocument,
        "uuid": uuid,
        "phoneNumber": phoneNumber,
        "password": password,
        "imageProfile": imageProfile,
        "imageProfileUrl": imageProfileUrl,
      };

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? documentNumber,
    String? email,
    String? id,
    String? nickName,
    String? civilStatus,
    String? region,
    String? provincia,
    String? distrito,
    bool hasCompletedOnboarding = false,
    String? phoneNumber,
    String? password,
    String? imageProfileUrl,
    String? imageProfile,
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      id: id ?? this.id,
      nickName: nickName ?? this.nickName,
      civilStatus: civilStatus ?? this.civilStatus,
      region: region ?? this.region,
      provincia: provincia ?? this.provincia,
      distrito: distrito ?? this.distrito,
      hasCompletedOnboarding: hasCompletedOnboarding,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      imageProfileUrl: imageProfileUrl ?? this.imageProfileUrl,
      imageProfile: imageProfile ?? this.imageProfile,
      documentNumber: documentNumber ?? this.documentNumber,
    );
  }
}
