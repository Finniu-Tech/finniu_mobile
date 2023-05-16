import 'package:graphql_flutter/graphql_flutter.dart';

abstract class TransferencesDataSource {
  Future<List<String>> getUserBouchers({
    required GraphQLClient client,
  });
}
