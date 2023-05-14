import 'package:graphql_flutter/graphql_flutter.dart';

abstract class NPSDataSource {
  Future<bool> save({
    required GraphQLClient client,
    required String question,
    required String answer,
    required String comment,
  });
}
