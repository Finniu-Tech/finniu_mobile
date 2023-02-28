import 'package:finniu/providers/auth_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final gqlClientProvider = FutureProvider<GraphQLClient>(
  (ref) async {
    final HttpLink httpLink = HttpLink(
      'https://finniu.com/api/v1/graph/finniu/',
    );
    // String token = ref.watch(authTokenProvider);
    print('token 2222222222222');
    // print(token);
    // final authLink = AuthLink(getToken: () => 'JWT $token');
    final authLink = AuthLink(getToken: () async {
      final String token = await ref.watch(authTokenProvider);
      print('this is my token1111');
      print('JWT $token');
      return 'JWT $token';
    });
    final link = authLink.concat(httpLink);

    print('httpLink:');
    print(link);

    return GraphQLClient(
      link: link,
      // cache: GraphQLCache(store: HiveStore()),
      cache: GraphQLCache(),
    );
  },
);
