import 'package:finniu/infrastructure/models/graphql.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';

class CalculateAggroInvestmentInput {
  String uuid;
  int numberParcel;
  int numberInstallments;

  CalculateAggroInvestmentInput({
    required this.numberParcel,
    required this.numberInstallments,
    required this.uuid,
  });

  Map<String, dynamic> toJson() => {
        'parcelNumber': numberParcel,
        'numberOfInstallments': numberInstallments,
        'fundUUID': uuid,
      };
}

class CalculateAggroInvestmentResponse {
  bool success;
  double parcelMonthly;
  final List<GraphQLErrorMessage>? messages;
  CalculateAggroInvestmentResponse({required this.success, required this.parcelMonthly, this.messages});

  factory CalculateAggroInvestmentResponse.fromJson(Map<String, dynamic> json) {
    return CalculateAggroInvestmentResponse(
      success: json['success'],
      parcelMonthly: double.parse(json['parcelMonthlyInstallment'].toString()),
      messages: json['messages'] != null
          ? (json['messages'] as List).map((i) => GraphQLErrorMessage.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'parcelMonthlyInstallment': parcelMonthly,
        'messages': messages,
      };
}

class SaveAggroInvestmentInput {
  int numberParcel;
  int numberInstallments;
  OriginFunds originFunds;
  String fundUUID;

  SaveAggroInvestmentInput({
    required this.numberParcel,
    required this.numberInstallments,
    required this.originFunds,
    required this.fundUUID,
  });

  toJson() => {
        'parcelNumber': numberParcel,
        'numberOfInstallments': numberInstallments,
        'fundUUID': fundUUID,
        'originFunds': {
          "originFundsEnum": originFunds.originFundsEnum.toString().split('.').last,
          "otherText": originFunds.otherText,
        },
      };
}

class SaveAggroInvestmentResponse {
  bool success;
  final List<GraphQLErrorMessage>? messages;
  final String? uuidPreInvestment;
  SaveAggroInvestmentResponse({
    required this.success,
    this.messages,
    this.uuidPreInvestment,
  });

  factory SaveAggroInvestmentResponse.fromJson(Map<String, dynamic> json) {
    return SaveAggroInvestmentResponse(
      success: json['success'],
      messages: json['messages'] != null
          ? (json['messages'] as List).map((i) => GraphQLErrorMessage.fromJson(i)).toList()
          : null,
      uuidPreInvestment: json['agroInvestmentUuid'],
    );
  }
}
