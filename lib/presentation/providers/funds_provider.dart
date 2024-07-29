import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/infrastructure/datasources/funds_datasource.dart';
import 'package:finniu/infrastructure/models/fund/aggro_investment_models.dart';
import 'package:finniu/infrastructure/models/fund/corporate_investment_models.dart';
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

final calculateAggroFutureProvider = FutureProvider.autoDispose
    .family<CalculateAggroInvestmentResponse, CalculateAggroInvestmentInput>((ref, input) async {
  final fundDataSource = ref.watch(fundDataSourceProvider);
  final calculateResponse = await fundDataSource.calculateAggroInvestment(input);
  return calculateResponse;
});

final saveAggroInvestmentFutureProvider =
    FutureProvider.autoDispose.family<SaveAggroInvestmentResponse, SaveAggroInvestmentInput>((ref, input) async {
  final fundDataSource = ref.watch(fundDataSourceProvider);
  final calculateResponse = await fundDataSource.saveAggroInvestment(input);
  return calculateResponse;
});

final saveCorporateInvestmentFutureProvider = FutureProvider.autoDispose
    .family<SaveCorporateInvestmentResponse, SaveCorporateInvestmentInput>((ref, input) async {
  final fundDataSource = ref.watch(fundDataSourceProvider);
  final calculateResponse = await fundDataSource.saveCorporateInvestment(input);
  return calculateResponse;
});
