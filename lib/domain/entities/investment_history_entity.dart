class InvestmentHistoryResumeEntity {
  double totalAmount;
  int totalPlans;
  List<InvestmentHistoryEntity>? investmentsInCourse;
  List<InvestmentHistoryEntity>? investmentsFinished;
  List<InvestmentHistoryEntity>? investmentsInProcess;
  List<InvestmentHistoryEntity>? investmentsCanceled;

  InvestmentHistoryResumeEntity({
    required this.totalAmount,
    required this.totalPlans,
    this.investmentsInCourse,
    this.investmentsFinished,
    this.investmentsInProcess,
    this.investmentsCanceled,
  });
}

class InvestmentHistoryEntity {
  final String uuid;
  final String planName;
  final double totalAmount;
  final String? deadLineName;
  final int? deadLineValue;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? rentabilityPercent;

  InvestmentHistoryEntity({
    required this.uuid,
    required this.planName,
    required this.totalAmount,
    this.startDate,
    this.endDate,
    this.deadLineName,
    this.deadLineValue,
    this.rentabilityPercent,
  });
}
