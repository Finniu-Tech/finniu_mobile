class InvestmentHistoryReport {
  InvestmentHistoryResumeEntity solesHistory;
  InvestmentHistoryResumeEntity dollarsHistory;

  InvestmentHistoryReport({
    required this.solesHistory,
    required this.dollarsHistory,
  });

  // factory InvestmentHistoryReport.fromJson(Map<String, dynamic> json) {
  //   return InvestmentHistoryReport(
  //     solesHistory: InvestmentHistoryResumeEntity.fromJson(
  //       json['invesmentInSoles'][0] ?? {},
  //     ),
  //     dollarsHistory: InvestmentHistoryResumeEntity.fromJson(
  //       json['invesmentInDolares'][0] ?? {},
  //     ),
  //   );
  // }
}

class InvestmentHistoryResumeEntity {
  double totalAmount;
  int totalPlans;
  List<InvestmentHistoryEntity>? investmentsInCourse;
  List<InvestmentHistoryEntity>? investmentsPending;
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
    this.investmentsPending,
  });

  int countTotalHistory() {
    int countInCourse = this.investmentsInCourse?.length ?? 0;
    int countInvesmentsFinished = this.investmentsFinished?.length ?? 0;
    int countInvesmentsInProcess = this.investmentsInProcess?.length ?? 0;
    int countInvestmentsCanceled = this.investmentsCanceled?.length ?? 0;
    int countInvestmentsPending = this.investmentsPending?.length ?? 0;

    return countInCourse +
        countInvesmentsFinished +
        countInvesmentsInProcess +
        countInvestmentsCanceled +
        countInvestmentsPending;
  }

  // fromJson(Map<String, dynamic> json) {
  //   return InvestmentHistoryResumeEntity(
  //     totalAmount: json['totalBalanceAmmount']?.toDouble() ?? 0.0,
  //     totalPlans: json['countPlanesActive'] ?? 0,
  //   );
  // }
}

class InvestmentHistoryEntity {
  final String uuid;
  final String planName;
  final double totalAmount;
  final String? deadLineName;
  final int? deadLineValue;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? rentabilityPercent;

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
