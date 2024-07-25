import 'package:finniu/infrastructure/models/graphql.dart';

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
