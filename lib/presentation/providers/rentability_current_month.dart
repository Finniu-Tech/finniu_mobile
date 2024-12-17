import 'package:finniu/infrastructure/datasources/rentability_month_imp.dart';
import 'package:finniu/infrastructure/models/calendar/rentability.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rentabilityProvider = FutureProvider.autoDispose<RentabilityMonthResponse>((ref) async {
  final client = ref.watch(gqlClientProvider);
  final dataSource = RentabilityDataSource(client.value!);
  return dataSource.getRentabilityPerMonth();
});
