import 'package:finniu/graphql/mutations.dart';
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
}
