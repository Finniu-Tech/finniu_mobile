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

class ReInvestDtoV4 {
  final String uuid;
  final String? fundUUID;
  final String? fundName;
  final double amount;
  final String currency;
  final int deadline;
  final int rentabilityPercent;

  ReInvestDtoV4({
    required this.fundUUID,
    required this.fundName,
    required this.amount,
    required this.currency,
    required this.deadline,
    required this.uuid,
    required this.rentabilityPercent,
  });
  factory ReInvestDtoV4.fromJson(Map<String, dynamic> json) {
    return ReInvestDtoV4(
      rentabilityPercent: _parseAmount(json['rentabilityPercent']),
      uuid: json['uuid'],
      fundUUID: json['investmentFund']['uuid'],
      fundName: json['investmentFund']['name'],
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
