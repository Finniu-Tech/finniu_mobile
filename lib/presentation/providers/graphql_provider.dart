import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final gqlClientProvider = FutureProvider<GraphQLClient>(
  (ref) async {
    final HttpLink httpLink = HttpLink(
      'https://www.finniu.com/api/v1/graph/finniu/',
      defaultHeaders: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    final authLink = AuthLink(
      getToken: () async {
        final String token = await ref.watch(authTokenProvider);

        return 'JWT $token';
      },
    );
    final link = authLink.concat(httpLink);

    return GraphQLClient(
      link: link,
      // cache: GraphQLCache(store: HiveStore()),
      cache: GraphQLCache(),
    );
  },
);
