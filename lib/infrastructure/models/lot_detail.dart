class LotDetail {
  final String title;
  final String dayToday;
  final String harvestNumber;
  final String passedDays;
  final String missingDays;
  final double progress;
  final int investmentAmount;
  final int profitabilityAmount;

  LotDetail({
    required this.title,
    required this.dayToday,
    required this.harvestNumber,
    required this.passedDays,
    required this.missingDays,
    required this.progress,
    required this.investmentAmount,
    required this.profitabilityAmount,
  });
}
