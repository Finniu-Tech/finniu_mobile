import 'package:finniu/domain/entities/investment_history_entity.dart';
import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/infrastructure/datasources/investment_history_datasource_imp.dart';
import 'package:finniu/infrastructure/datasources/investment_history_v2_datasource.dart';
import 'package:finniu/infrastructure/models/blue_gold_investment/progress_blue_gold.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final investmentStatusReportFutureProvider = FutureProvider.autoDispose<InvestmentRentabilityReport>((ref) async {
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

final investmentHistoryReportFutureProvider = FutureProvider.autoDispose<InvestmentHistoryReport>((ref) async {
  try {
    final client = ref.watch(gqlClientProvider).value;
    final result = await InvestmentHistoryDataSourceImp().getInvestmentHistoryReport(
      client: client!,
    );
    return result;
  } catch (e, stack) {
    return Future.error('Error: $e', stack);
  }
});

final aggroInvestmentListFutureProvider = FutureProvider.autoDispose<List<AggroInvestment>>((ref) async {
  try {
    final client = ref.watch(gqlClientProvider).value;
    final result = await InvestmentHistoryV2DataSource(client!).getAggroInvestmentList();
    return result;
  } catch (e, stack) {
    return Future.error('Error: $e', stack);
  }
});
