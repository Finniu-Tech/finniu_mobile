import 'package:graphql_flutter/graphql_flutter.dart';

abstract class ContractDataSource {
  Future<String> getContract({
    required String uuid,
    required GraphQLClient client,
  });
}
