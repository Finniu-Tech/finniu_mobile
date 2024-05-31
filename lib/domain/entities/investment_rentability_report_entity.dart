class StatusInvestmentEnum {
  static const String in_course = 'in_course';
  static const String finished = 'finished';
}

class InvestmentRentabilityReport {
  final InvestmentRentabilityResumeEntity solesRentability;
  final InvestmentRentabilityResumeEntity dollarsRentability;

  InvestmentRentabilityReport({
    required this.solesRentability,
    required this.dollarsRentability,
  });
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
  bool? reinvestmentAvailable;
  String statusInvestment; // ACTIVE
  DateTime? startDateInvestment;
  DateTime? endDateInvestment;
  double rentabilityAmount;
  double rentabilityPercent;
  List<InvestmentCouponPartnerTagEntity?>? partnerCouponTag;
  InvestmentPartnerEntity? partner;
  bool isReInvestment = false;
  bool reInvestmentDisabled = false;

  InvestmentRentabilityEntity({
    required this.uuid,
    required this.createdAt,
    required this.isActive,
    required this.amount,
    required this.deadLineUuid,
    required this.deadLineName,
    required this.deadLineValue,
    this.reinvestmentAvailable,
    required this.statusInvestment,
    this.startDateInvestment,
    this.endDateInvestment,
    required this.rentabilityAmount,
    required this.rentabilityPercent,
    this.planName,
    this.partnerCouponTag,
    this.partner,
    this.isReInvestment = false,
    this.reInvestmentDisabled = false,
  });
}

class InvestmentCouponPartnerTagEntity {
  String partnerTag;
  String hexColor;

  InvestmentCouponPartnerTagEntity({
    required this.partnerTag,
    required this.hexColor,
  });
}

class InvestmentPartnerEntity {
  String partnerName;
  String? partnerLogoUrl;
  String? partnerHexColor;
  bool activateLogo;

  InvestmentPartnerEntity({
    required this.partnerName,
    this.partnerLogoUrl,
    this.partnerHexColor,
    required this.activateLogo,
  });
}
