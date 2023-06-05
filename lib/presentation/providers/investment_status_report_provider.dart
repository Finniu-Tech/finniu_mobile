import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/infrastructure/datasources/investment_history_datasource_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final investmentStatusReportFutureProvider =
    FutureProvider.autoDispose<InvestmentRentabilityResumeEntity>((ref) async {
  try {
    final client = ref.watch(gqlClientProvider).value;
    final result = await InvestmentHistoryDataSourceImp().getRentabilityReport(
      client: client!,
    );
    return result;
  } catch (e, stack) {
    return Future.error('Error: $e', stack);
  }
});

// import 'package:finniu/domain/entities/calculate_investment.dart';
// import 'package:finniu/domain/entities/plan_entities.dart';
// import 'package:finniu/infrastructure/models/calculate_investment.dart';
// import 'package:finniu/presentation/providers/calculate_investment_repository_provider.dart';
// import 'package:finniu/presentation/providers/graphql_provider.dart';
// import 'package:finniu/presentation/providers/plan_repository_provider.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final planListFutureProvider = FutureProvider<List<PlanEntity>>((ref) async {
//   try {
//     final planRepository = ref.read(planRepositoryProvider);
//     final client = ref.watch(gqlClientProvider).value;
//     final result = await planRepository.getAll(
//       client: client!,
//     );
//     return result;
//   } catch (e, stack) {
//     return Future.error('Error: $e', stack);
//   }
// });
