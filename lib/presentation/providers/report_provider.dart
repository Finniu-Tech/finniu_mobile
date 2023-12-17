import 'package:finniu/domain/entities/userProfileBalance.dart';
import 'package:finniu/infrastructure/datasources/reports_datasource_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeReportProvider = FutureProvider<UserProfileBalance>((ref) async {
  final client = ref.watch(gqlClientProvider).value;
  final response =
      await ReportDataSourceImp().getUserReportHome(client: client!);
  ref.read(userProfileBalanceNotifierProvider.notifier).updateFields(
        totalPlans: response.totalPlans,
        totalBalance: response.totalBalance,
        totalRevenue: response.totalRevenue,
      );
  return response;
});

final homeReportProviderV2 = FutureProvider<UserProfileReport>((ref) async {
  final client = ref.watch(gqlClientProvider).value;
  final response =
      await ReportDataSourceImp().getUserReportHomeV2(client: client!);
  final currency = ref.watch(isSolesStateProvider);
  ref.read(userProfileBalanceNotifierProvider.notifier).updateFields(
        totalPlans:
            response.dolarBalance.totalPlans + response.solesBalance.totalPlans,
        totalBalance: currency
            ? response.solesBalance.totalBalance
            : response.dolarBalance.totalBalance,
        totalRevenue: currency
            ? response.solesBalance.totalRevenue
            : response.dolarBalance.totalRevenue,
      );
  return response;
});

final userProfileBalanceNotifierProvider = StateNotifierProvider<
    UserProfileBalanceStateNotifierProvider, UserProfileBalance>((ref) {
  return UserProfileBalanceStateNotifierProvider(
    UserProfileBalance(
      totalPlans: 0,
      totalBalance: 0,
      totalRevenue: 0,
    ),
  );
});

class UserProfileBalanceStateNotifierProvider
    extends StateNotifier<UserProfileBalance> {
  UserProfileBalanceStateNotifierProvider(UserProfileBalance balance)
      : super(balance);
  void updateFields({
    required int totalPlans,
    required double totalBalance,
    required double totalRevenue,
  }) {
    state = state.copyWith(
      totalPlans: totalPlans,
      totalBalance: totalBalance,
      totalRevenue: totalRevenue,
    );
  }
}
