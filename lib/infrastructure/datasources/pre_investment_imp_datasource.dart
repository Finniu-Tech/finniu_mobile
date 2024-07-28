import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/models/pre_investment_response.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PreInvestmentDataSourceImp {
  Future<PreInvestmentResponseAPI> save({
    required GraphQLClient client,
    required int amount,
    // required String bankAccountNumber,
    required String deadLineUuid,
    required String planUuid,
    required String currency,
    String? coupon,
    required String? bankAccountNumber,
    required OriginFunds? originFunds,
  }) async {
    final response = await client.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.savePreInvestment(),
        ),
        variables: {
          'amount': amount,
          'uuidDeadline': deadLineUuid,
          'uuidPlan': planUuid,
          'couponCode': coupon,
          'currency': currency,
          'bankAccountSender': bankAccountNumber,
          'originFunds': originFunds,
        },
      ),
    );
    final responseGraphQL = response.data?['savePreInvestment'];

    final preInvestmentResponse = PreInvestmentSaveResponse.fromJson(responseGraphQL);

    final preInvestment = PreInvestmentEntity(
      uuid: preInvestmentResponse.preInvestmentUuid!,
      amount: amount,
      // bankAccountNumber: bankAccountNumber,
      deadLineUuid: deadLineUuid,
      planUuid: planUuid,
      coupon: coupon,
      bankAccountNumber: bankAccountNumber,
      originFunds: originFunds,
    );
    return PreInvestmentResponseAPI(
      preInvestment: preInvestment,
      success: preInvestmentResponse.success!,
      error: preInvestmentResponse.errorMessage,
    );
  }

  Future<PreInvestmentUpdateResponseAPI> update({
    required GraphQLClient client,
    required String uuid,
    required bool readContract,
    String? bankAccountSenderUUID,
    String? bankAccountReceiverUUID,
    required List<String> files,
  }) async {
    final vars = {
      'uuid': uuid,
      'readContract': readContract,
      'files': files,
      'bankAccountSenderUUID': bankAccountSenderUUID,
      'bankAccountReceiverUUID': bankAccountReceiverUUID,
    };
    try {
      final response = await client.mutate(
        MutationOptions(
          document: gql(
            MutationRepository.updatePreInvestment(),
          ),
          variables: vars,
        ),
      );

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
