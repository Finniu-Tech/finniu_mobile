import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final preInvestmentSaveProvider =
    FutureProvider.family<PreInvestmentResponseAPI?, PreInvestmentForm>((ref, preInvestmentEntity) async {
  try {
    final preInvestmentRepository = ref.read(preInvestmentRepositoryProvider);
    final client = ref.watch(gqlClientProvider).value;
    final result = await preInvestmentRepository.save(
      client: client!,
      amount: preInvestmentEntity.amount,
      // bankAccountNumber: preInvestmentEntity.bankAccountNumber,
      deadLineUuid: preInvestmentEntity.deadLineUuid,
      planUuid: preInvestmentEntity.planUuid,
      coupon: preInvestmentEntity.coupon,
      currency: preInvestmentEntity.currency,
      bankAccountNumber: preInvestmentEntity.bankAccountNumber,
      originFunds: preInvestmentEntity.originFunds,
    );
    return result;
  } catch (e, stack) {
    return null;
  }
});

final userAcceptedTermsProvider = StateProvider<bool>((ref) => false);

final hasPreInvestmentProvider = StateProvider<bool>((ref) => false);

final preInvestmentVoucherImagesProvider = StateProvider<List<String>>((ref) => []);
final preInvestmentVoucherImagesPreviewProvider = StateProvider<List<String>>((ref) => []);
