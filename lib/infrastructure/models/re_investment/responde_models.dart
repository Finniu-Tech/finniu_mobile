import 'package:finniu/infrastructure/models/graphql.dart';

class RejectReInvestmentResult {
  final bool success;
  final List<GraphQLErrorMessage>? messages;

  RejectReInvestmentResult({
    required this.success,
    required this.messages,
  });

  factory RejectReInvestmentResult.fromJson(Map<String, dynamic> json) {
    return RejectReInvestmentResult(
      success: json['success'] as bool,
      messages: json['messages'] != null
          ? (json['messages'] as List<dynamic>)
              .map((e) => GraphQLErrorMessage.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}
