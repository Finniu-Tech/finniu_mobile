class InvestmentDetailUuid {
  final String uuid;
  final String amount;
  final String rentabilityAmount;
  final String rentabilityPercent;
  final String finishDateInvestment;
  final String contract;

  InvestmentDetailUuid({
    required this.uuid,
    required this.amount,
    required this.rentabilityAmount,
    required this.rentabilityPercent,
    required this.finishDateInvestment,
    required this.contract,
  })  : assert(uuid.isNotEmpty, 'UUID cannot be null or empty'),
        assert(amount.isNotEmpty, 'Amount cannot be null or empty'),
        assert(
          rentabilityAmount.isNotEmpty,
          'Rentability amount cannot be null or empty',
        ),
        assert(
          rentabilityPercent.isNotEmpty,
          'Rentability percent cannot be null or empty',
        ),
        assert(
          finishDateInvestment.isNotEmpty,
          'Finish date investment cannot be null or empty',
        ),
        assert(contract.isNotEmpty, 'Contract cannot be null or empty');

  factory InvestmentDetailUuid.fromJson(Map<String, dynamic> json) {
    return InvestmentDetailUuid(
      uuid: json['uuid'],
      amount: json['amount'],
      rentabilityAmount: json['rentabilityAmmount'],
      rentabilityPercent: json['rentabilityPercent'],
      finishDateInvestment: json['finishDateInvestment'],
      contract: json['contract'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'amount': amount,
      'rentabilityAmmount': rentabilityAmount,
      'rentabilityPercent': rentabilityPercent,
      'finishDateInvestment': finishDateInvestment,
      'contract': contract,
    };
  }
}

class DepositBank {
  final String id;
  final String bankName;
  final String bankLogo;
  final String slug;

  DepositBank({
    required this.id,
    required this.bankName,
    required this.bankLogo,
    required this.slug,
  });

  factory DepositBank.fromJson(Map<String, dynamic> json) {
    return DepositBank(
      id: json['id'],
      bankName: json['bankName'],
      bankLogo: json['bankLogo'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bankName': bankName,
      'bankLogo': bankLogo,
      'slug': slug,
    };
  }
}
