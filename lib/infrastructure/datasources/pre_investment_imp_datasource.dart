import 'package:finniu/domain/datasources/pre_investment_datasource.dart';
import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/models/pre_investment_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PreInvestmentDataSourceImp extends PreInvestmentDataSource {
  @override
  Future<PreInvestmentEntity> save({
    required GraphQLClient client,
    required int amount,
    required String bankAccountNumber,
    required String bankAccountTypeUuid,
    required String deadLineUuid,
    required String planUuid,
  }) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.savePreInvestment(),
        ),
        variables: {
          'amount': amount,
          'bank_account_number': bankAccountNumber,
          'bank_account_type_uuid': bankAccountTypeUuid,
          'deadline_uuid': deadLineUuid,
          'plan_uuid': planUuid,
        },
      ),
    );

    final responseGraphQL = response.data?['savePreInvestment'];

    final preInvestmentResponse =
        PreInvestmentSaveResponse.fromJson(responseGraphQL);

    return PreInvestmentEntity(
      uuid: preInvestmentResponse.savePreInvestment!.preInvestmentUuid!,
      amount: amount,
      bankAccountNumber: bankAccountNumber,
      bankAccountTypeUuid: bankAccountTypeUuid,
      deadLineUuid: deadLineUuid,
      planUuid: planUuid,
    );

    // return PreInvestmentEntity(
    //   uuid: 'uuid',
    //   amount: amount,
    //   bankAccountNumber: bankAccountNumber,
    //   bankAccountTypeUuid: bankAccountTypeUuid,
    //   deadLineUuid: deadLineUuid,
    //   planUuid: planUuid,
    // );
  }
}
