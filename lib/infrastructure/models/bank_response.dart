class BankResponse {
  List<Bank>? banks;

  BankResponse({
    this.banks,
  });

  factory BankResponse.fromJson(Map<String, dynamic> json) => BankResponse(
        banks: json["banks"] == null ? [] : List<Bank>.from(json["banks"]!.map((x) => Bank.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banks": banks == null ? [] : List<dynamic>.from(banks!.map((x) => x.toJson())),
      };
}

class Bank {
  String? uuid;
  bool? isActive;
  String? bankName;
  String? bankLogo;
  String? bankImageCard;

  Bank({
    this.uuid,
    this.isActive,
    this.bankName,
    this.bankLogo,
    this.bankImageCard,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        uuid: json["uuid"],
        isActive: json["isActive"],
        bankName: json["bankName"],
        bankLogo: json["bankLogoUrl"],
        bankImageCard: json["bankImageCardUrl"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "isActive": isActive,
        "bankName": bankName,
        "bankLogoUrl": bankLogo,
        "bankImageCardUrl": bankImageCard,
      };
}
