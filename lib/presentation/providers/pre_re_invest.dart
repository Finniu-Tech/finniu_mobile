import 'package:finniu/domain/entities/pre_re_invest.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getPreReInvestFutureProvider =
    FutureProvider.family.autoDispose<PreReInvest?, String>((ref, uuid) async {
  try {
    final client = ref.read(gqlClientProvider).value;
    final result = await client!.query(
      QueryOptions(
        document: gql(QueryRepository.preReinvest),
        variables: {'preInvestmentUuid': uuid},
      ),
    );
    final data = result.data;
    if (data == null) {
      return null;
    }

    final investmentDetail =
        PreReInvest.fromJson(data["reInvestmentQueries"]["preReInvestment"]);
    return investmentDetail;
  } catch (e) {
    print('Error: $e');
    return null;
  }
});
