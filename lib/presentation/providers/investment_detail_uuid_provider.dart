import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/models/business_investments/investment_detail_by_uuid.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userInvestmentByUuidFutureProvider =
    FutureProvider.family.autoDispose<InvestmentDetailUuid?, String>((ref, uuid) async {
  try {
    final client = ref.watch(gqlClientProvider).value;
    final result = await client!.query(
      QueryOptions(
        document: gql(QueryRepository.investmentDetailByUuid),
        variables: {'preInvestmentUuid': uuid},
      ),
    );
    final data = result.data;
    if (data == null) {
      return null;
    }

    final investmentDetail = InvestmentDetailUuid.fromJson(data['investmentDetail']);
    return investmentDetail;
  } catch (e) {
    return null;
  }
});

final getMonthlyPaymentProvider = FutureProvider.family.autoDispose<List<ProfitabilityItem>, String>(
  (ref, preInvestmentUUID) async {
    try {
      final client = ref.watch(gqlClientProvider).value;
      if (client == null) {
        throw Exception('GraphQL client is null');
      }

      final result = await client.query(
        QueryOptions(
          document: gql(QueryRepository.getInvestmentMonthlyReturns),
          variables: {'preInvestmentUuid': preInvestmentUUID},
        ),
      );

      if (result.hasException) {
        throw result.exception!;
      }

      final data = result.data;
      if (data == null) {
        return [];
      }

      final paymentRentabilityList = data['investmentDetail']['paymentRentability'] as List<dynamic>?;
      if (paymentRentabilityList == null) {
        return [];
      }

      final profitabilityItems = paymentRentabilityList
          .map((item) {
            if (item is! Map<String, dynamic>) {
              print('Invalid item in paymentRentability: $item');
              return null;
            }
            return ProfitabilityItem.fromJson(item);
          })
          .whereType<ProfitabilityItem>()
          .toList();

      return profitabilityItems;
    } catch (e, _) {
      rethrow; // Re-throw the error to be caught by the FutureProvider
    }
  },
);
