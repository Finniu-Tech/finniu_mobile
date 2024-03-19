import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InvestmentRepository {
  InvestmentRepository();

  Future<bool> userHasInvestmentInProcess({required GraphQLClient client}) async {
    final response = await client.query(
      QueryOptions(
        document: gql(
          QueryRepository.hasInvestmentInProcess,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    return response.data?['userProfile']?['haveInvestmentDraft'] ?? false;
  }

  Future<PreInvestmentForm?> getLastPreInvestment({
    required GraphQLClient client,
    required String email,
  }) async {
    final response = await client.query(
      QueryOptions(
        document: gql(QueryRepository.lastPreInvestment),
        variables: {
          'email': email,
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    print('response!!!! last pre investment $response');
    dynamic lastPreInvestmentResponse = response.data?['getLastPreInvestment'];
    if (lastPreInvestmentResponse != null) {
      return PreInvestmentForm(
        uuid: lastPreInvestmentResponse['uuidPreInvestment'],
        amount: double.parse(lastPreInvestmentResponse['amount'].toString()).round(),
        currency: lastPreInvestmentResponse['currency'],
        bankAccountTypeUuid: lastPreInvestmentResponse['uuidBank'],
        deadLineUuid: lastPreInvestmentResponse['uuidDeadline'],
        planUuid: lastPreInvestmentResponse['uuidPlan'],
        coupon: lastPreInvestmentResponse['couponCode'],
        months: int.parse(lastPreInvestmentResponse['countMonths']),
      );
    } else {
      return null;
    }
  }

  Future<bool> discardPreInvestment({
    required GraphQLClient client,
    required String preInvestmentUUID,
  }) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.discardPreInvestment(),
        ),
        variables: {
          'preInvestmentUUID': preInvestmentUUID,
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return response.data?['discardPreInvestment']['success'] ?? false;
  }
}
