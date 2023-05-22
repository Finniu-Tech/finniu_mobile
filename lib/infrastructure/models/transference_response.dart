class UserGetBoucherResponse {
  List<UserGetBoucher>? userGetBouchers;

  UserGetBoucherResponse({
    this.userGetBouchers,
  });

  factory UserGetBoucherResponse.fromJson(Map<String, dynamic> json) =>
      UserGetBoucherResponse(
        userGetBouchers: json["userGetBouchers"] == null
            ? []
            : List<UserGetBoucher>.from(json["userGetBouchers"]!
                .map((x) => UserGetBoucher.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userGetBouchers": userGetBouchers == null
            ? []
            : List<dynamic>.from(userGetBouchers!.map((x) => x.toJson())),
      };
}

class UserGetBoucher {
  String? boucherImage;
  Plan? plan;
  DateTime? dateSended;

  UserGetBoucher({
    this.boucherImage,
    this.plan,
    this.dateSended,
  });

  factory UserGetBoucher.fromJson(Map<String, dynamic> json) => UserGetBoucher(
        boucherImage: json["boucherImage"],
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
        dateSended: json["dateSended"] == null
            ? null
            : DateTime.parse(json["dateSended"]),
      );

  Map<String, dynamic> toJson() => {
        "boucherImage": boucherImage,
        "plan": plan?.toJson(),
        "dateSended":
            "${dateSended!.year.toString().padLeft(4, '0')}-${dateSended!.month.toString().padLeft(2, '0')}-${dateSended!.day.toString().padLeft(2, '0')}",
      };
}

class Plan {
  String? name;

  Plan({
    this.name,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
