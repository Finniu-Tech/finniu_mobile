class InvestmentHistoryResumeEntity {
  double totalAmount;
  int totalPlans;
  List<InvestmentHistoryEntity?> investmentsInCourse;
  List<InvestmentHistoryEntity?> investmentsFinished;
  List<InvestmentHistoryEntity?> investmentsInProcess;
  List<InvestmentHistoryEntity?> investmentsCanceled;

  InvestmentHistoryResumeEntity({
    required this.totalAmount,
    required this.totalPlans,
    required this.investmentsInCourse,
    required this.investmentsFinished,
    required this.investmentsInProcess,
    required this.investmentsCanceled,
  });
}

class InvestmentHistoryEntity {
  final String uuid;
  final String planName;
  final double totalAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final String status;

  InvestmentHistoryEntity({
    required this.uuid,
    required this.planName,
    required this.totalAmount,
    required this.status,
    this.startDate,
    this.endDate,
  });
}
