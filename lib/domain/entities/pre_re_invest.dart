class PreReInvest {
  String? initialAmount;
  String? rentabilityAmount;
  String? deadlineString;
  String? futureRentabilityAmount;

  PreReInvest({
    this.initialAmount,
    this.rentabilityAmount,
    this.deadlineString,
    this.futureRentabilityAmount,
  });

  factory PreReInvest.fromJson(Map<String, dynamic> json) => PreReInvest(
        initialAmount: json['initialAmount'],
        rentabilityAmount: json['rentabilityAmount'],
        deadlineString: json['deadlineString'],
        futureRentabilityAmount: json['futureRentabilityAmount'],
      );
}
