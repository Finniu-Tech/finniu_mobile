import 'package:finniu/providers/auth_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final gqlClientProvider = FutureProvider<GraphQLClient>((ref) async {
  final HttpLink httpLink = HttpLink(
    'https://finniu.com/api/v1/graph/finniu/',
  );
  String token = ref.read(authTokenProvider);
  final authLink = AuthLink(getToken: () async => 'JWT ${token}');
  final link = authLink.concat(httpLink);

  print('httpLink:');

  return GraphQLClient(
    link: link,
    cache: GraphQLCache(store: HiveStore()),
  );
});
