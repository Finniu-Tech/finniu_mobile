import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/infrastructure/models/re_investment/responde_models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReInvestmentDataSource {
  final GraphQLClient client;

  ReInvestmentDataSource(this.client);

  Future<RejectReInvestmentResult> rejectReInvestment({
    required String preInvestmentUUID,
    required String rejectMotivation,
    String? textRejected,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        MutationRepository.rejectReInvestment(),
      ),
      variables: {
        'preInvestmentUUID': preInvestmentUUID,
        'rejectMotivation': rejectMotivation,
        'textRejected': textRejected,
      },
    );

    final QueryResult result = await client.mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    // return RejectReInvestmentResult(success: false, messages: []);
    return RejectReInvestmentResult.fromJson(result.data!['rejectReInvestment']);
  }

  Future<CreateReInvestmentResponse> createReInvestment({
    required String preInvestmentUUID,
    required String finalAmount,
    required String currency,
    required String deadlineUUID,
    String? coupon,
    required OriginFunds originFounds,
    required String typeReinvestment,
    String? bankAccountSender,
  }) async {
    final variables = {
      'preInvestmentUUID': preInvestmentUUID,
      'finalAmount': num.parse(finalAmount).toInt().toString(),
      'currency': currency,
      'deadlineUUID': deadlineUUID,
      'coupon': coupon,
      'originFounds': originFounds.toJson(),
      'typeReinvestment': typeReinvestment,
      'bankAccountSender': bankAccountSender,
    };
    final MutationOptions options =
        MutationOptions(document: gql(MutationRepository.createReInvestment()), variables: variables);

    final QueryResult result = await client.mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    return CreateReInvestmentResponse.fromJson(result.data!['createReInvestment']);
  }

  Future<UpdateReInvestmentResponse> updateReInvestment({
    required String preInvestmentUUID,
    required bool userReadContract,
    List<String>? files,
    String? bankAccountSender,
    String? bankAccountReceiver,
  }) async {
    final dynamic variables = {
      'preInvestmentUUID': preInvestmentUUID,
      'userReadContract': userReadContract,
      'bankAccountSenderUUID': bankAccountSender,
      'bankAccountReceiverUUID': bankAccountReceiver,
      'files': files,
    };
    final MutationOptions options = MutationOptions(
      document: gql(MutationRepository.updateReInvestment()),
      variables: variables,
    );

    final QueryResult result = await client.mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    return UpdateReInvestmentResponse.fromJson(result.data!['updateReInvestment']);
  }

  Future<SetBankAccountUserResponse> setBankAccountReceiver({
    required String reInvestmentUUID,
    required String bankAccountReceiver,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(
        MutationRepository.setBankAccountReceiverToReinvestment(),
      ),
      variables: {
        'reInvestmentUUID': reInvestmentUUID,
        'bankAccountReceiver': bankAccountReceiver,
      },
    );
    final QueryResult result = await client.mutate(options);
    if (result.hasException) {
      throw result.exception!;
    }
    return SetBankAccountUserResponse.fromJson(result.data!['setBankAccountUser']);
  }
}
