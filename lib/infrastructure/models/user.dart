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
    this.address,
    this.percentCompleteProfile,
    this.hasCompletedTour,
    this.lastNameFather,
    this.lastNameMother,
    this.countryPrefix,
    this.documentType,
    this.houseNumber,
    this.postalCode,
    this.laborSituation,
    this.companyName,
    this.serviceTime,
  });
  dynamic documentType;
  String? firstName;
  String? lastName;
  String? email;
  String? id;
  String? nickName;
  dynamic civilStatus;
  String? distrito;
  String? documentNumber;
  String? gender;
  bool? hasCompletedOnboarding;
  bool? hasCompletedTour;
  bool? isActive;
  String? occupation;
  String? provincia;
  String? region;
  String? typeDocument;
  String? uuid;
  String? phoneNumber;
  String? password;
  String? imageProfileUrl;
  String? imageProfile;
  String? address;
  double? percentCompleteProfile;
  String? lastNameFather;
  String? lastNameMother;
  String? countryPrefix;
  String? houseNumber;
  String? postalCode;
  String? laborSituation;
  String? companyName;
  String? serviceTime;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        id: json["id"],
        nickName: json["nickName"],
        civilStatus: json["civilStatus"],
        distrito: json["distrito"]["id"],
        documentNumber: json["documentNumber"].toString() == 'null'
            ? ''
            : json["documentNumber"].toString(),
        gender: json["gender"],
        hasCompletedOnboarding: json["hasCompletedOnboarding"],
        hasCompletedTour: json["hasCompletedTour"],
        isActive: json["isActive"],
        occupation: json["occupation"],
        provincia: json["provincia"]["id"],
        region: json["region"]["id"],
        typeDocument: json["typeDocument"],
        uuid: json["uuid"],
        phoneNumber: json["phoneNumber"],
        imageProfile: json["imageProfile"],
        imageProfileUrl: json["imageProfileUrl"],
        address: json["address"],
        percentCompleteProfile: json["percentCompleteProfile"] != null
            ? double.parse(json["percentCompleteProfile"].toString())
            : 0.0,
        lastNameFather: json["lastNameFather"],
        lastNameMother: json["lastNameMother"],
        countryPrefix: json["countryPrefix"],
        documentType: json["typeDocument"],
        houseNumber: json["houseNumber"],
        postalCode: json["postalCode"],
        laborSituation: json["laborSituation"],
        companyName: json["companyName"],
        serviceTime: json["serviceTime"],
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
        "address": address,
        "percentCompleteProfile": percentCompleteProfile,
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
    String? address,
    String? occupation,
    double? percentCompleteProfile,
    bool? hasCompletedTour,
    String? lastNameFather,
    String? lastNameMother,
    String? countryPrefix,
    String? documentType,
    String? gender,
    String? houseNumber,
    String? postalCode,
    String? laborSituation,
    String? companyName,
    String? serviceTime,
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
      address: address ?? this.address,
      occupation: occupation ?? this.occupation,
      percentCompleteProfile:
          percentCompleteProfile ?? this.percentCompleteProfile,
      hasCompletedTour: hasCompletedTour ?? this.hasCompletedTour,
      lastNameFather: lastNameFather ?? this.lastNameFather,
      lastNameMother: lastNameMother ?? this.lastNameMother,
      countryPrefix: countryPrefix ?? this.countryPrefix,
      documentType: documentType ?? this.documentType,
      gender: gender ?? this.gender,
      houseNumber: houseNumber ?? this.houseNumber,
      postalCode: postalCode ?? this.postalCode,
      laborSituation: laborSituation ?? this.laborSituation,
      companyName: companyName ?? this.companyName,
      serviceTime: serviceTime ?? this.serviceTime,
    );
  }

  bool hasRequiredData() {
    if (firstName == null || firstName!.isEmpty) return false;
    if (lastName == null || lastName!.isEmpty) return false;
    return true;
  }
}
