// bank_account_provider.dart
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/infrastructure/datasources/bank_user_account_datasource.dart';
import 'package:finniu/infrastructure/models/bank_user_account/input_models.dart';
import 'package:finniu/infrastructure/models/bank_user_account/response_models.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final bankAccountDataSourceProvider = Provider<BankAccountDataSource>((ref) {
  final client = ref.watch(gqlClientProvider);
  return BankAccountDataSource(client.value!);
});

final createBankAccountProvider =
    FutureProvider.autoDispose.family<CreateBankAccountResponse, CreateBankAccountInput>((ref, input) {
  final dataSource = ref.watch(bankAccountDataSourceProvider);
  return dataSource.createBankAccount(input);
});

final bankAccountFutureProvider = FutureProvider<List<BankAccount>>((ref) async {
  final dataSource = ref.read(bankAccountDataSourceProvider);
  return await dataSource.getUserBankAccount();
});
