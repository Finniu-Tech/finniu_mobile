import 'package:finniu/domain/entities/user_all_investment_entity.dart';
import 'package:finniu/domain/entities/user_all_investment_v4_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userInfoAllInvestmentFutureProvider =
    FutureProvider.autoDispose<UserInfoAllInvestment?>((ref) async {
  try {
    final client = ref.watch(gqlClientProvider).value;

    final result = await client!.query(
      QueryOptions(
        document: gql(
          QueryRepository.userInfoAllInvestment,
        ),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    final data = result.data?['userInfoAllInvestment'];

    if (data == null) {
      return null;
    }
    UserInfoAllInvestment user = UserInfoAllInvestment.fromJson(data);

    return user;
  } catch (e) {
    print(e);
    return null;
  }
});
final userInfoAllInvestmentV4FutureProvider =
    FutureProvider.autoDispose<UserInfoAllInvestmentV4?>((ref) async {
  try {
    final client = ref.watch(gqlClientProvider).value;

    final result = await client!.query(
      QueryOptions(
        document: gql(
          QueryRepository.userInfoAllInvestmentV4,
        ),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    final data = result.data?['userInfoAllInvestment'];

    if (data == null) {
      return null;
    }
    UserInfoAllInvestmentV4 user = UserInfoAllInvestmentV4.fromJson(data);

    return user;
  } catch (e) {
    print(e);
    return null;
  }
});
