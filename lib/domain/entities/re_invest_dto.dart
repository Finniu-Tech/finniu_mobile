import 'package:finniu/domain/entities/fund_entity.dart';

class ReInvestDto {
  final String uuid;
  final FundEntity? fund;
  final double amount;
  final String currency;
  final int deadline;
  final int rentabilityPercent;

  ReInvestDto({
    required this.fund,
    required this.amount,
    required this.currency,
    required this.deadline,
    required this.uuid,
    required this.rentabilityPercent,
  });
  factory ReInvestDto.fromJson(Map<String, dynamic> json) {
    return ReInvestDto(
      rentabilityPercent: _parseAmount(json['rentabilityPercent']),
      uuid: json['uuid'],
      fund: json['investmentFund'] != null
          ? FundEntity.fromJson(json['investmentFund'])
          : null,
      amount: double.parse(json['amount']),
      currency: json['currency'],
      deadline: json['deadline']['value'],
    );
  }
  static int _parseAmount(String amount) {
    try {
      double parsedDouble = double.parse(amount);
      return parsedDouble.round();
    } catch (e) {
      return 0;
    }
  }
}
