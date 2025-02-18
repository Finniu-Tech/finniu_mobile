import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/models/business_investments/investment_detail_by_uuid.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getMonthlyPaymentProviderV4 =
    FutureProvider.family.autoDispose<TablePayV4, String>(
  (ref, preInvestmentUUID) async {
    try {
      final client = ref.watch(gqlClientProvider).value;
      if (client == null) {
        throw Exception('GraphQL client is null');
      }

      final result = await client.query(
        QueryOptions(
          document: gql(QueryRepository.getInvestmentMonthlyReturnsV4),
          variables: {'preInvestmentUuid': preInvestmentUUID},
          fetchPolicy: FetchPolicy.noCache,
        ),
      );
      if (result.hasException) {
        throw result.exception!;
      }

      final data = result.data;
      if (data == null) {
        throw Exception('No data returned from GraphQL query');
      }
      final tablePay = TablePayV4.fromJson(data);

      return tablePay;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  },
);
