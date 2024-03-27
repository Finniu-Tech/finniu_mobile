import 'package:finniu/domain/datasources/pre_investment_datasource.dart';
import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/models/pre_investment_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PreInvestmentDataSourceImp extends PreInvestmentDataSource {
  @override
  Future<PreInvestmentResponseAPI> save({
    required GraphQLClient client,
    required int amount,
    // required String bankAccountNumber,
    required String bankAccountTypeUuid,
    required String deadLineUuid,
    required String planUuid,
    required String currency,
    String? coupon,
  }) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.savePreInvestment(),
        ),
        variables: {
          'amount': amount,
          'uuidBank': bankAccountTypeUuid,
          'uuidDeadline': deadLineUuid,
          'uuidPlan': planUuid,
          'coupon': coupon,
          'currency': currency
        },
      ),
    );
    final responseGraphQL = response.data?['savePreInvestment'];

    final preInvestmentResponse = PreInvestmentSaveResponse.fromJson(responseGraphQL);

    final preInvestment = PreInvestmentEntity(
      uuid: preInvestmentResponse.preInvestmentUuid!,
      amount: amount,
      // bankAccountNumber: bankAccountNumber,
      bankAccountTypeUuid: bankAccountTypeUuid,
      deadLineUuid: deadLineUuid,
      planUuid: planUuid,
    );
    return PreInvestmentResponseAPI(
      preInvestment: preInvestment,
      success: preInvestmentResponse.success!,
      error: preInvestmentResponse.errorMessage,
    );
  }

  @override
  Future<PreInvestmentUpdateResponseAPI> update({
    required GraphQLClient client,
    required String uuid,
    required bool readContract,
    required List<String> files,
  }) async {
    try {
      final response = await client.mutate(
        MutationOptions(
          document: gql(
            MutationRepository.updatePreInvestment(),
          ),
          variables: {'uuid': uuid, 'readContract': readContract, 'files': files},
        ),
      );
      // return response.data?['updatePreinvestment']['success'];
      return PreInvestmentUpdateResponseAPI(
        success: response.data?['updatePreinvestment']['success'],
        error: response.data?['updatePreinvestment']['messages']?[0]['message'],
      );
    } catch (e) {
      return PreInvestmentUpdateResponseAPI(
        success: false,
        error: 'Error al actualizar la preinversión',
      );
    }
  }
}
