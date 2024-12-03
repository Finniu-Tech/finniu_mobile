// bank_account_provider.dart
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/infrastructure/datasources/bank_user_account_datasource.dart';
import 'package:finniu/infrastructure/models/bank_user_account/input_models.dart';
import 'package:finniu/infrastructure/models/bank_user_account/response_models.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createBankAccountProvider = FutureProvider.autoDispose
    .family<CreateBankAccountResponse, CreateBankAccountInput>((ref, input) {
  final client = ref.watch(gqlClientProvider);
  final dataSource =
      BankAccountDataSource(client.value!).createBankAccount(input);
  return dataSource;
});

final bankAccountFutureProvider =
    FutureProvider.autoDispose<List<BankAccount>>((ref) async {
  final client = ref.watch(gqlClientProvider);
  final dataSource = BankAccountDataSource(client.value!);
  return await dataSource.getUserBankAccount();
});

final boolCreatedNewBankAccountProvider = StateProvider<bool>((ref) => false);
