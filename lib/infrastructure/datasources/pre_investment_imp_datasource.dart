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
    // required String bankAccountNumber,
    required String bankAccountTypeUuid,
    required String deadLineUuid,
    required String planUuid,
  }) async {
    print('amount');
    print(amount);
    print('bankAccountTypeUuid');
    print(bankAccountTypeUuid);
    print('deadLineUuid');
    print(deadLineUuid);
    print('planUuid');
    print(planUuid);
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.savePreInvestment(),
        ),
        variables: {
          'amount': amount,
          // 'bankAccount': bankAccountNumber,
          'uuidBank': bankAccountTypeUuid,
          'uuidDeadline': deadLineUuid,
          'uuidPlan': planUuid,
        },
      ),
    );
    print('resposne data');
    print(response);
    final responseGraphQL = response.data?['savePreInvestment'];
    print('responseGraphQL');
    print(responseGraphQL);

    final preInvestmentResponse =
        PreInvestmentSaveResponse.fromJson(responseGraphQL);

    return PreInvestmentEntity(
      uuid: preInvestmentResponse.preInvestmentUuid!,
      amount: amount,
      // bankAccountNumber: bankAccountNumber,
      bankAccountTypeUuid: bankAccountTypeUuid,
      deadLineUuid: deadLineUuid,
      planUuid: planUuid,
    );
  }

  @override
  Future<bool> update({
    required GraphQLClient client,
    required String uuid,
    required bool readContract,
    required String boucherScreenShot,
  }) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.updatePreInvestment(),
        ),
        variables: {
          'uuid': uuid,
          'readContract': readContract,
          'boucher': boucherScreenShot,
        },
      ),
    );
    print('resposne data');
    print(response);
    return response.data?['updatePreInvestment']['success'];
  }
}
