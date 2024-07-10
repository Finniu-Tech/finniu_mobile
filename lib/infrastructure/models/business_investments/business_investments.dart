class ToValidateItem {
  final String dateEnds;
  final int amount;
  ToValidateItem({
    required this.dateEnds,
    required this.amount,
  });
}

class InProgressItem {
  final String dateEnds;
  final int amount;
  InProgressItem({
    required this.dateEnds,
    required this.amount,
  });
}

class CompletedItem {
  final String dateEnds;
  final int amount;
  final bool isReInvestment;
  CompletedItem({
    required this.dateEnds,
    required this.amount,
    required this.isReInvestment,
  });
}

final List<ToValidateItem> toValidateList = [
  ToValidateItem(dateEnds: '09/07/2024', amount: 1000),
  ToValidateItem(dateEnds: '10/07/2024', amount: 2000),
  ToValidateItem(dateEnds: '11/07/2024', amount: 3000),
  ToValidateItem(dateEnds: '12/07/2024', amount: 4000),
];
final List<InProgressItem> inProgressList = [
  InProgressItem(dateEnds: '09/07/2024', amount: 1000),
  InProgressItem(dateEnds: '10/07/2024', amount: 2000),
  InProgressItem(dateEnds: '11/07/2024', amount: 3000),
  InProgressItem(dateEnds: '12/07/2024', amount: 4000),
];
final List<CompletedItem> completedList = [
  CompletedItem(
    dateEnds: '09/07/2024',
    amount: 1000,
    isReInvestment: true,
  ),
  CompletedItem(
    dateEnds: '09/07/2024',
    amount: 21000,
    isReInvestment: false,
  ),
  CompletedItem(
    dateEnds: '09/07/2024',
    amount: 3000,
    isReInvestment: true,
  ),
  CompletedItem(
    dateEnds: '09/07/2024',
    amount: 4000,
    isReInvestment: false,
  ),
  CompletedItem(
    dateEnds: '09/07/2024',
    amount: 5000,
    isReInvestment: true,
  ),
];
