import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final preInvestmentSaveProvider =
    FutureProvider.family<PreInvestmentEntity, PreInvestmentForm>(
        (ref, preInvestmentEntity) async {
  try {
    final preInvestmentRepository = ref.read(preInvestmentRepositoryProvider);
    final client = ref.watch(gqlClientProvider).value;
    final result = await preInvestmentRepository.save(
      client: client!,
      amount: preInvestmentEntity.amount,
      // bankAccountNumber: preInvestmentEntity.bankAccountNumber,
      bankAccountTypeUuid: preInvestmentEntity.bankAccountTypeUuid,
      deadLineUuid: preInvestmentEntity.deadLineUuid,
      planUuid: preInvestmentEntity.planUuid,
    );
    return result;
  } catch (e, stack) {
    return Future.error('Error: $e', stack);
  }
});
