import 'package:graphql_flutter/graphql_flutter.dart';

abstract class GraphQLBaseDataSource {
  final GraphQLClient client;

  GraphQLBaseDataSource(this.client);
}
