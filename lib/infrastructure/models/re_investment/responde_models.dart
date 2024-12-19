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

class CreateReInvestmentResponse {
  final bool? success;
  final String? reInvestmentUuid;
  final String? reInvestmentContractUrl;
  final List<GraphQLErrorMessage>? messages;

  CreateReInvestmentResponse({
    required this.success,
    required this.reInvestmentUuid,
    required this.reInvestmentContractUrl,
    this.messages,
  });

  factory CreateReInvestmentResponse.fromJson(Map<String, dynamic> json) {
    return CreateReInvestmentResponse(
      success: json['success'] as bool?,
      reInvestmentUuid: json['reInvestmentUuid'] as String?,
      reInvestmentContractUrl: json['reInvestmentContractUrl'] as String?,
      messages: (json['messages'] as List?)
          ?.where((e) => e != null)
          .map((e) => GraphQLErrorMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class UpdateReInvestmentResponse {
  final bool success;
  final String? reInvestmentUuid;
  final List<GraphQLErrorMessage>? messages;

  UpdateReInvestmentResponse({
    required this.success,
    this.reInvestmentUuid,
    this.messages,
  });

  factory UpdateReInvestmentResponse.fromJson(Map<String, dynamic> json) {
    return UpdateReInvestmentResponse(
      success: json['success'] ?? false,
      reInvestmentUuid: json['reInvestmentUuid'],
      messages: (json['messages'] as List?)
          ?.where((e) => e != null)
          .map((e) => GraphQLErrorMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SetBankAccountUserResponse {
  final bool success;
  final List<GraphQLErrorMessage>? messages;

  SetBankAccountUserResponse({required this.success, this.messages});

  factory SetBankAccountUserResponse.fromJson(Map<String, dynamic> json) {
    return SetBankAccountUserResponse(
      success: json['success'],
      messages: (json['messages'] as List?)
          ?.where((e) => e != null)
          .map((e) => GraphQLErrorMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
