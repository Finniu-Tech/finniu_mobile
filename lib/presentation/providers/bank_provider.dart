import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/presentation/providers/bank_repository_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bankFutureProvider = FutureProvider<List<BankEntity>>((ref) async {
  final bankRepository = ref.watch(bankRepositoryProvider);
  final client = ref.read(gqlClientProvider).value!;
  return bankRepository.getBanks(client: client);
});
