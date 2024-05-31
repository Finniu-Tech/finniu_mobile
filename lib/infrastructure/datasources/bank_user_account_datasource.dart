// bank_account_datasource.dart
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/models/bank_user_account/input_models.dart';
import 'package:finniu/infrastructure/models/bank_user_account/response_models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BankAccountDataSource {
  final GraphQLClient client;

  BankAccountDataSource(this.client);

  Future<CreateBankAccountResponse> createBankAccount(CreateBankAccountInput input) async {
    final variables = {
      'bankUUID': input.bankUUID,
      'typeAccount': input.typeAccount,
      'currency': input.currency,
      'bankAccount': input.bankAccount,
      'aliasBankAccount': input.aliasBankAccount,
      'joinAccount': input.jointAccount?.toJson(),
      'isDefault': input.isDefault,
      'isPersonalAccount': input.isPersonalAccount,
    };
    final MutationOptions options = MutationOptions(
        document: gql(
          MutationRepository.createBankAccount(),
        ),
        variables: variables);

    final QueryResult result = await client.mutate(options);
    print('result create bank account: ${result}');
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return CreateBankAccountResponse.fromJson(result.data!['createBankAccount']);
  }

  Future<List<BankAccount>> getUserBankAccount() async {
    final QueryOptions options =
        QueryOptions(document: gql(QueryRepository.getUserBankAccounts), fetchPolicy: FetchPolicy.noCache);

    final QueryResult result = await client.query(options);
    if (result.hasException) {
      throw Exception('Failed to load bank accounts');
    }

    final List<dynamic> bankAccountsJson = result.data!['userBankAccountQueries']['listBankAccountUser'];
    return bankAccountsJson.map((json) => BankAccount.fromJson(json)).toList();
  }
}
