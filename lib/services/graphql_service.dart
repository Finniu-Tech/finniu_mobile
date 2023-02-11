import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  GraphQLClient? _client;

  GraphQLService() {
    final HttpLink httpLink = HttpLink(
      'https://finniu.com/api/v1/graph/finniu/',
    );
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
      // OR
      // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    );
    final Link link = authLink.concat(httpLink);
    ValueNotifier<GraphQLClient> _client = ValueNotifier(
      GraphQLClient(
        link: link,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
  }
  get client {
    return _client;
  }
}



// import 'package:graphql_flutter/graphql_flutter.dart';

// class GraphQLService {
//   GraphQLClient? _client;

//   GraphQLService() {
//     HttpLink link = HttpLink('https://finniu.com/api/v1/graph/finniu/');

//     _client =
//         GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore()));
//   }

//   Future<QueryResult<Object?>?> performQuery(
//     String query, {
//     Map<String, dynamic>? variables,
//   }) async {
//     QueryOptions options =
//         QueryOptions(document: gql(query), variables: variables ?? {});

//     final result = await _client?.query(options);

//     return result;
//   }

//   Future<QueryResult<Object?>?> performMutation(String query,
//       {Map<String, dynamic>? variables}) async {
//     MutationOptions options =
//         MutationOptions(document: gql(query), variables: variables ?? {});

//     final result = await _client?.mutate(options);

//     print(result);

//     return result;
//   }
// }
