// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel({
    this.tokenAuth,
  });

  TokenAuth? tokenAuth;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        tokenAuth: json["tokenAuth"] == null
            ? null
            : TokenAuth.fromJson(json["tokenAuth"]),
      );

  Map<String, dynamic> toJson() => {
        "tokenAuth": tokenAuth?.toJson(),
      };
}

class TokenAuth {
  TokenAuth({
    this.payload,
    this.token,
    this.refreshExpiresIn,
  });

  Payload? payload;
  String? token;
  int? refreshExpiresIn;

  factory TokenAuth.fromJson(Map<String, dynamic> json) => TokenAuth(
        payload:
            json["payload"] == null ? null : Payload.fromJson(json["payload"]),
        token: json["token"],
        refreshExpiresIn: json["refreshExpiresIn"],
      );

  Map<String, dynamic> toJson() => {
        "payload": payload?.toJson(),
        "token": token,
        "refreshExpiresIn": refreshExpiresIn,
      };
}

class Payload {
  Payload({
    this.email,
    this.exp,
    this.origIat,
  });

  String? email;
  int? exp;
  int? origIat;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        email: json["email"],
        exp: json["exp"],
        origIat: json["origIat"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "exp": exp,
        "origIat": origIat,
      };
}
