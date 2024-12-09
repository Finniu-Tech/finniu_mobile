import 'package:finniu/domain/entities/home_v4_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeV4InvestProvider =
    FutureProvider.autoDispose<HomeUserInvest>((ref) async {
  try {
    final gqlClient = ref.watch(gqlClientProvider).value;
    if (gqlClient == null) {
      throw Exception('GraphQL client is null');
    }
    final response = await gqlClient.query(
      QueryOptions(
        document: gql(QueryRepository.getHomeInvestUser),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    final data = response.data;
    if (data == null) {
      throw Exception('Response data is null');
    }
    return HomeUserInvest.fromJson(data['userInfoAllInvestment']);
  } catch (e) {
    print('Error fetching investments: $e');
    return HomeUserInvest(
      investmentInDolares: null,
      investmentInSoles: null,
    );
  }
});
