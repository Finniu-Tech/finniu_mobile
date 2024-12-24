import 'package:finniu/domain/entities/re_invest_dto.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getInvestFutureProvider =
    FutureProvider.family.autoDispose<ReInvestDto?, String>((ref, uuid) async {
  try {
    final client = ref.watch(gqlClientProvider).value;
    final result = await client!.query(
      QueryOptions(
        document: gql(QueryRepository.getFundInvestmentDetail),
        variables: {'preInvestmentUuid': uuid},
      ),
    );
    final data = result.data;
    if (data == null) {
      return null;
    }

    final investmentDetail = ReInvestDto.fromJson(data["investmentDetail"]);
    return investmentDetail;
  } catch (e) {
    print('Error: $e');
    return null;
  }
});
final getInvestFutureProviderV4 = FutureProvider.family
    .autoDispose<ReInvestDtoV4?, String>((ref, uuid) async {
  try {
    final client = ref.read(gqlClientProvider).value;
    final result = await client!.query(
      QueryOptions(
        document: gql(QueryRepository.getFundInvestmentDetailV4),
        variables: {'preInvestmentUuid': uuid},
      ),
    );
    final data = result.data;
    if (data == null) {
      return null;
    }

    final investmentDetail = ReInvestDtoV4.fromJson(data["investmentDetail"]);
    return investmentDetail;
  } catch (e) {
    print('Error: $e');
    return null;
  }
});
