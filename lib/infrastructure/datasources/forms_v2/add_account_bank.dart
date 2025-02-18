import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:finniu/infrastructure/models/bank_user_account/input_models.dart';
import 'package:finniu/infrastructure/models/bank_user_account/response_models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddAccountBankImp extends GraphQLBaseDataSource {
  AddAccountBankImp(super.client);

  Future<CreateBankAccountResponse> addAccountDataUserV2({
    required CreateBankAccountInput input,
  }) async {
    try {
      final variables = {
        'bankUUID': input.bankUUID,
        'typeAccount': input.typeAccount,
        'currency': input.currency,
        'bankAccount': input.bankAccount,
        'aliasBankAccount': input.aliasBankAccount,
        'joinAccount': input.jointAccount?.toJson(),
        'isDefault': input.isDefault,
        'isPersonalAccount': input.isPersonalAccount,
        'cci': input.cci,
      };
      final MutationOptions options = MutationOptions(
        document: gql(
          MutationRepository.createBankAccount(),
        ),
        variables: variables,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        return CreateBankAccountResponse(success: false, messages: []);
      }
      return CreateBankAccountResponse.fromJson(
          result.data!['createBankAccount']);
    } catch (e) {
      return CreateBankAccountResponse(success: false, messages: []);
    }
  }
}
