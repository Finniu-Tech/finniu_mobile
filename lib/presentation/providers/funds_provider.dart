import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/infrastructure/datasources/funds_datasource.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final fundDataSourceProvider = Provider<FundDataSource>((ref) {
  final GraphQLClient client = ref.read(gqlClientProvider).value!;
  return FundDataSource(client);
});

final fundListFutureProvider = FutureProvider.autoDispose<List<FundEntity>>((ref) async {
  final fundDataSource = ref.watch(fundDataSourceProvider);

  return await fundDataSource.getFunds();
});

final benefitListFutureProvider = FutureProvider.autoDispose.family<List<FundBenefit>, String>((ref, fundUUID) async {
  final fundDataSource = ref.watch(fundDataSourceProvider);
  return await fundDataSource.getBenefits(fundUUID);
});
