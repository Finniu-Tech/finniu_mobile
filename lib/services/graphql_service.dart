import 'package:finniu/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  ValueNotifier<GraphQLClient>? _client;

  GraphQLService() {
    print('contrsutcor');
    final HttpLink httpLink = HttpLink(
      'https://finniu.com/api/v1/graph/finniu/',
    );
    print('pass http');
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $AuthTokenProvider.token',
      // OR
      // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    );
    print('pass auth');
    final Link link = authLink.concat(httpLink);
    print('pass link');

    _client = ValueNotifier(
      GraphQLClient(
        link: link,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    print('cleint!!' + _client.toString());
  }
  get client {
    return _client;
  }

  // Future<QueryResult<Object?>?> performQuery(
  //   String query, {
  //   Map<String, dynamic>? variables,
  // }) async {
  //   QueryOptions options =
  //       QueryOptions(document: gql(query), variables: variables ?? {});

  //   final result = await _client?.query(options);

  //   return result;
  // }
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
