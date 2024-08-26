import 'package:finniu/infrastructure/models/graphql.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';

class SaveCorporateInvestmentInput {
  final String amount;
  final String months;
  final String currency;
  final String? coupon;
  final OriginFunds originFunds;
  final String fundUUID;

  const SaveCorporateInvestmentInput({
    required this.amount,
    required this.months,
    required this.currency,
    this.coupon,
    required this.originFunds,
    required this.fundUUID,
  });

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'deadline': months,
        'currency': currency, //nuevp sol // dolar
        'couponCode': coupon,
        'originFunds': originFunds,
        'investmentFund': fundUUID,
      };
}

class SaveCorporateInvestmentResponse {
  final bool success;
  final String? preInvestmentUUID;
  final String? contractURL;
  final List<GraphQLErrorMessage>? messages;

  const SaveCorporateInvestmentResponse({
    required this.success,
    this.preInvestmentUUID,
    this.contractURL,
    this.messages,
  });

  factory SaveCorporateInvestmentResponse.fromJson(Map<String, dynamic> json) {
    return SaveCorporateInvestmentResponse(
      success: json['success'],
      preInvestmentUUID: json['preInvestmentUuid'],
      contractURL: json['contract'],
      messages: json['messages'] != null
          ? List<GraphQLErrorMessage>.from(json['messages'].map((x) => GraphQLErrorMessage.fromJson(x)))
          : null,
    );
  }
}

class SaveCorporateReInvestmentInput {
  final String preInvestmentUUID;
  final String finalAmount;
  final String currency;
  final String deadlineUUID;
  final String? coupon;
  final OriginFunds originFounds;
  final String typeReinvestment;
  final String? bankAccountSender;

  const SaveCorporateReInvestmentInput({
    required this.preInvestmentUUID,
    required this.finalAmount,
    required this.currency,
    required this.deadlineUUID,
    this.coupon,
    required this.originFounds,
    required this.typeReinvestment,
    this.bankAccountSender,
  });
}
