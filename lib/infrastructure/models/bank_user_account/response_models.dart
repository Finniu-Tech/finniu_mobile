import 'package:finniu/infrastructure/models/graphql.dart';

class CreateBankAccountResponse {
  final bool success;
  final List<GraphQLErrorMessage> messages;

  CreateBankAccountResponse({
    required this.success,
    required this.messages,
  });

  factory CreateBankAccountResponse.fromJson(Map<String, dynamic> json) {
    return CreateBankAccountResponse(
      success: json['success'] as bool,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => GraphQLErrorMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
