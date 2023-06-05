class StatusInvestmentEnum {
  static const String in_course = 'in_course';
  static const String finished = 'finished';
}

class InvestmentRentabilityResumeEntity {
  double totalAmount;
  double totalRentabilityAmount;
  int totalPlans;
  List<InvestmentRentabilityEntity>? investmentsInCourse;
  List<InvestmentRentabilityEntity>? investmentsFinished;

  InvestmentRentabilityResumeEntity({
    required this.totalAmount,
    required this.totalRentabilityAmount,
    required this.totalPlans,
    this.investmentsInCourse,
    this.investmentsFinished,
  });
}

// TODO verify statusinvestment values
class InvestmentRentabilityEntity {
  String uuid;
  DateTime createdAt;
  bool isActive;
  double amount;
  String? planName;
  String deadLineUuid;
  String deadLineName;
  int deadLineValue;
  // String? paymentTypeUuid;
  // String? paymentTypeName;
  // String? paymentTypeValue;
  // String bankAccountName;
  // String bankAccountLogo;
  // String contractUrl;
  // String boucherUrl;
  String statusInvestment; // ACTIVE
  DateTime? startDateInvestment;
  DateTime? endDateInvestment;
  double rentabilityAmount;
  double rentabilityPercent;

  InvestmentRentabilityEntity({
    required this.uuid,
    required this.createdAt,
    required this.isActive,
    required this.amount,
    required this.deadLineUuid,
    required this.deadLineName,
    required this.deadLineValue,
    // this.paymentTypeUuid,
    // this.paymentTypeName,
    // this.paymentTypeValue,
    // required this.bankAccountName,
    // required this.bankAccountLogo,
    // required this.contractUrl,
    // required this.boucherUrl,
    required this.statusInvestment,
    this.startDateInvestment,
    this.endDateInvestment,
    required this.rentabilityAmount,
    required this.rentabilityPercent,
    this.planName,
  });
}
