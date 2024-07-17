import 'package:finniu/main.dart';
import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:finniu/app_config.dart';

final appConfigProvider = Provider<AppConfig>((ref) => appConfig);

final gqlClientProvider = FutureProvider<GraphQLClient>(
  (ref) async {
    final appConfig = ref.watch(appConfigProvider);

    final HttpLink httpLink = HttpLink(
      appConfig.apiBaseUrl,
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
